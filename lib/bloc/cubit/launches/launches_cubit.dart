import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/network/repository.dart';

part 'launches_state.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit({required this.repository})
      : super(const LaunchesState.loading());

  final Repository repository;

  Future<void> refreshLaunches() async {
    emit(const LaunchesState.loading());

    try {
      await repository.refreshLaunchesData();
      emit(LaunchesState.success(upcomingLaunches: repository.launchesData));
    } on Exception {
      emit(const LaunchesState.failure());
    }
  }

  Future<void> getLaunchDetails(String id) async {
    if (repository.detailedLaunchesData.containsKey(id)) {
      emit(LaunchesState.success(
          detailedLaunchModel: repository.detailedLaunchesData[id]!));
    } else {
      emit(const LaunchesState.loading());

      try {
        await repository.getDetailedDataForLaunch(id);
        emit(LaunchesState.success(
            detailedLaunchModel: repository.detailedLaunchesData[id]!));
      } on Exception {
        emit(const LaunchesState.failure());
      }
    }
  }
}
