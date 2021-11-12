import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/network/repository.dart';

part 'detail_state.dart';

part 'detail_mapper.dart';

class LaunchDetailCubit extends Cubit<LaunchDetailState> {
  LaunchDetailCubit({required this.repository, required this.header})
      : super(LaunchDetailState.loading(header: header)) {
    _unsubscribeStarListener =
        repository.favoritesObservable.subscribe(_onStarEvent);
  }

  final Repository repository;
  final LaunchHeaderViewModel header;

  late void Function() _unsubscribeStarListener;

  void _onStarEvent(String launchId) async {
    if (launchId == header.launchId) {
      bool isStarred = await repository.isLaunchStarred(header.launchId);
      emit(LaunchDetailState.fromState(
          state: state, header: _mapHeaderToHeader(state.header, isStarred)));
    }
  }

  Future<void> starLaunch(bool value) async {
    repository.starLaunch(header.launchId, value);
  }

  Future<void> _emitRocketView(LaunchModel launch) async {
    repository.getRocketForLaunch(launch).then((rocket) {
      if (rocket != null) {
        if (state.status == ScreenStatus.success) {
          emit(LaunchDetailState.success(
            header: state.header,
            copyState: state,
            links: state.body!.links!,
            rocket: _mapRocketToView(rocket),
          ));
        }
      }
    });
  }

  Future<void> _emitLaunchpadView(LaunchModel launch) async {
    repository.getLaunchpadForLaunch(launch).then((launchpad) {
      if (launchpad != null) {
        if (state.status == ScreenStatus.success) {
          emit(LaunchDetailState.success(
            header: state.header,
            copyState: state,
            links: state.body!.links!,
            launchpad: _mapLaunchpadToView(launchpad),
          ));
        }
      }
    });
  }

  Future<void> _emitPayloadView(LaunchModel launch) async {
    repository.getPayloadsForLaunch(launch).then((payloads) {
      if (payloads.isNotEmpty) {
        if (state.status == ScreenStatus.success) {
          emit(LaunchDetailState.success(
              header: state.header,
              copyState: state,
              links: state.body!.links!,
              payloads: _mapPayloadsToView(payloads)));
        }
      }
    });
  }

  Future<void> getLaunchDetails(String id) async {
    emit(LaunchDetailState.loading(header: state.header));

    try {
      final launch = await repository.getDetailedDataForLaunch(id);
      final links = _mapLaunchToLinkButtons(launch);

      emit(LaunchDetailState.success(header: state.header, links: links));

      // Emit async
      _emitRocketView(launch);
      _emitLaunchpadView(launch);
      _emitPayloadView(launch);
    } on Exception {
      emit(LaunchDetailState.failure(header: state.header));
    }
  }

  @override
  Future<void> close() {
    _unsubscribeStarListener();
    return super.close();
  }
}
