part of 'launches_cubit.dart';

enum ListStatus { loading, success, failure }

class LaunchesState extends Equatable {
  const LaunchesState._(
      {this.status = ListStatus.loading, this.items = const <LaunchModel>[]});

  const LaunchesState.loading() : this._();

  const LaunchesState.success(List<LaunchModel> items)
      : this._(status: ListStatus.success, items: items);

  const LaunchesState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<LaunchModel> items;

  @override
  List<Object> get props => [status, items];
}
