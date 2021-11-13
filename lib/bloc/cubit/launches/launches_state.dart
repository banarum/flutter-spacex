part of 'launches_cubit.dart';

enum ListStatus { loading, success, failure }
enum FilterType { none, star }

class LaunchesState extends Equatable {
  const LaunchesState._(
      {this.status = ListStatus.loading,
      this.launches,
      required this.filter});

  LaunchesState.fromState({required LaunchesState state, FilterType? filter}):this._(
      status: state.status,
      launches: state.launches,
      filter: filter ?? state.filter,
  );

  const LaunchesState.loading({required FilterType filter})
      : this._(filter: filter);

  const LaunchesState.success(
      {List<LaunchItemViewState>? launches,
      required FilterType filter})
      : this._(
            status: ListStatus.success,
            launches: launches,
            filter: filter);

  const LaunchesState.failure({required FilterType filter})
      : this._(status: ListStatus.failure, filter: filter);

  final ListStatus status;
  final List<LaunchItemViewState>? launches;
  final FilterType filter;

  @override
  List<Object> get props => [status, launches.hashCode, filter];
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
