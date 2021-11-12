part of 'launches_cubit.dart';

enum ListStatus { loading, success, failure }

class LaunchesState extends Equatable {
  const LaunchesState._(
      {this.status = ListStatus.loading,
      this.launches,
      this.isLazyLoading = false});

  const LaunchesState.loading() : this._();

  const LaunchesState.success(
      {List<LaunchItemViewState>? launches, bool isLazyLoading = false})
      : this._(
            status: ListStatus.success,
            launches: launches,
            isLazyLoading: isLazyLoading);

  const LaunchesState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<LaunchItemViewState>? launches;
  final bool isLazyLoading;

  @override
  List<Object> get props => [status, launches.hashCode, isLazyLoading];
}

class LaunchItemViewState {
  String timeLabel;
  final String title;
  final String rocketName;
  final String launchId;
  final DateTime timeValue;
  final String? patchUrl;
  bool starred;

  LaunchItemViewState(
      {required this.timeLabel,
      required this.title,
      required this.rocketName,
      required this.launchId,
      required this.timeValue,
      required this.starred,
      this.patchUrl});
}
