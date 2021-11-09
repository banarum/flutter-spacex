part of 'launches_cubit.dart';

enum ListStatus { loading, success, failure }

class LaunchesState extends Equatable {
  const LaunchesState._(
      {this.status = ListStatus.loading,
      this.upcomingLaunches,
      this.detailedLaunchModel});

  const LaunchesState.loading() : this._();

  const LaunchesState.success(
      {List<LaunchModel>? upcomingLaunches, LaunchModel? detailedLaunchModel})
      : this._(
            status: ListStatus.success,
            upcomingLaunches: upcomingLaunches,
            detailedLaunchModel: detailedLaunchModel);

  const LaunchesState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<LaunchModel>? upcomingLaunches;
  final LaunchModel? detailedLaunchModel;

  @override
  List<Object> get props => [status];
}
