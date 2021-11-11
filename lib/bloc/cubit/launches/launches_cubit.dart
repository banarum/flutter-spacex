import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/network/repository.dart';

part 'launches_state.dart';

part 'launches_mapper.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit({required this.repository})
      : super(const LaunchesState.loading());

  static const launchesPerLoad = 10;

  final Repository repository;
  StreamSubscription<void>? _tickerSubscription;

  Stream<void> _tick() {
    return Stream.periodic(const Duration(seconds: 1))
        .takeWhile((element) => true);
  }

  Future<void> _getRocketsForLaunches(List<LaunchModel> launches) async {
    await repository.getRocketsForLaunches(launches
        .where((element) => !repository.rockets.containsKey(element))
        .toList());
  }

  Future<void> lazyLoadMoreLaunches() async {
    if (state.isLazyLoading ||
        state.status != ListStatus.success ||
        state.launches!.length >= repository.launchesData!.length) return;

    emit(LaunchesState.success(launches: state.launches, isLazyLoading: true));

    try {
      final chosenLaunches = repository.launchesData!
          .take(state.launches!.length + launchesPerLoad)
          .toList();
      await _getRocketsForLaunches(chosenLaunches);
      final launchViews = _mapLaunchesToView(
          rockets: repository.rockets,
          launches: chosenLaunches,
          now: DateTime.now());

      emit(LaunchesState.success(launches: launchViews));

      // ignore: empty_catches
    } on Exception {}
  }

  Future<void> refreshLaunches() async {
    emit(const LaunchesState.loading());

    try {
      await repository.refreshLaunchesData();

      final chosenLaunches =
          repository.launchesData!.take(launchesPerLoad).toList();
      await _getRocketsForLaunches(chosenLaunches);
      final launchViews = _mapLaunchesToView(
          rockets: repository.rockets,
          launches: chosenLaunches,
          now: DateTime.now());

      emit(LaunchesState.success(launches: launchViews));
    } on Exception {
      emit(const LaunchesState.failure());
    }
  }

  void onTick() {
    if (state.status == ListStatus.success && state.launches!.isNotEmpty) {
      emit(LaunchesState.success(
          launches: _mapViewToViewWithTime(
              views: state.launches!, now: DateTime.now()),
          isLazyLoading: state.isLazyLoading));
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
    _tickerSubscription?.cancel();
    return super.close();
  }
}
