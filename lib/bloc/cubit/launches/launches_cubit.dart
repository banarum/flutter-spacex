import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/network/repository.dart';

part 'launches_state.dart';

part 'launches_mapper.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit({required this.repository})
      : super(const LaunchesState.loading(filter: FilterType.none)) {
    _unsubscribeStarListener =
        repository.favoritesObservable.subscribe(_onStarEvent);
  }

  final Repository repository;
  StreamSubscription<void>? _tickerSubscription;

  late void Function() _unsubscribeStarListener;

  void _onStarEvent(String launchId) async {
    if (state.status == ListStatus.success) {
      final newValue = await repository.isLaunchStarred(launchId);
      emit(LaunchesState.success(
          launches: state.launches!.map((e) {
            if (e.launchId == launchId) {
              e.starred = newValue;
            }
            return e;
          }).toList(),
          filter: state.filter));
    }
  }

  Future<void> _renderLaunches(Iterable<LaunchModel> launches) async {
    await repository.getRocketForLaunch(launches.first);
    HashMap<LaunchModel, RocketModel?> rockets = HashMap();
    HashMap<LaunchModel, bool> stars = HashMap();

    // Needs synchronised loading so caching can do it's job
    for (var launch in launches) {
      rockets[launch] = await repository.getRocketForLaunch(launch);
      stars[launch] = await repository.isLaunchStarred(launch.id);
    }

    final launchViews = launches
        .map((launch) => _mapLaunchToView(
            rocket: rockets[launch],
            launch: launch,
            now: DateTime.now(),
            starred: stars[launch]!))
        .toList();

    emit(LaunchesState.success(launches: launchViews, filter: state.filter));
  }

  Future<Iterable<LaunchModel>> _getFilteredLaunches(
      {required Iterable<LaunchModel> source, int? size}) async {
    Iterable<LaunchModel> filteredLaunches = source;

    if (state.filter == FilterType.star) {
      HashMap<LaunchModel, bool> starred = HashMap();

      for (var element in filteredLaunches) {
        starred[element] = await repository.isLaunchStarred(element.id);
      }

      filteredLaunches = filteredLaunches.where((element) => starred[element]!);
    }

    if (size != null) {
      filteredLaunches = filteredLaunches.take(size);
    }

    return filteredLaunches;
  }

  Future<void> setFilter(FilterType filter) async {
    if (state.status == ListStatus.success) {
      emit(LaunchesState.fromState(state: state, filter: filter));
      final launches =
          await _getFilteredLaunches(source: repository.launchesData!);
      _renderLaunches(launches);
    }
  }

  Stream<void> _tick() {
    return Stream.periodic(const Duration(seconds: 1))
        .takeWhile((element) => true);
  }

  Future<void> refreshLaunches() async {
    emit(LaunchesState.loading(filter: state.filter));

    try {
      await repository.refreshLaunchesData();

      await _renderLaunches(
          await _getFilteredLaunches(source: repository.launchesData!));
    } on Exception {
      emit(LaunchesState.failure(filter: state.filter));
    }
  }

  void onTick() {
    if (state.status == ListStatus.success && state.launches!.isNotEmpty) {
      emit(LaunchesState.success(
          launches: _mapViewToViewWithTime(
              views: state.launches!, now: DateTime.now()),
          filter: state.filter));
    }
  }

  Future<void> startTicker() async {
    _tickerSubscription?.cancel();

    _tickerSubscription = _tick().listen((_) => onTick());
  }

  Future<void> stopTicker() async {
    _tickerSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _unsubscribeStarListener();
    _tickerSubscription?.cancel();
    return super.close();
  }
}
