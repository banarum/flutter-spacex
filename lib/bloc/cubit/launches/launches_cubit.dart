import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/network/repository.dart';

part 'launches_state.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit({required this.repository}):
      super(const LaunchesState.loading());

  final Repository repository;

  Future<void> refreshLaunches() async {
    emit(const LaunchesState.loading());

    try {
      final items = await repository.getUpcomingLaunches();
      emit(LaunchesState.success(items));
    } on Exception {
      emit(const LaunchesState.failure());
    }
  }
}