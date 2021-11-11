part of 'detail_cubit.dart';

enum ScreenStatus { loading, success, failure }

class LaunchDetailState extends Equatable {
  const LaunchDetailState._(
      {this.status = ScreenStatus.loading,
      this.detailedLaunchModel,
      this.links,
      this.launchpad});

  const LaunchDetailState.loading() : this._();

  const LaunchDetailState.success(
      {required LaunchModel detailedLaunchModel,
      required List<LinkButton> links,
      LaunchpadViewModel? launchpad})
      : this._(
            status: ScreenStatus.success,
            detailedLaunchModel: detailedLaunchModel,
            links: links,
            launchpad: launchpad);

  const LaunchDetailState.failure() : this._(status: ScreenStatus.failure);

  final ScreenStatus status;
  final LaunchModel? detailedLaunchModel;
  final List<LinkButton>? links;
  final LaunchpadViewModel? launchpad;

  @override
  List<Object> get props =>
      [status, detailedLaunchModel ?? {}, links ?? [], launchpad ?? {}];
}

class LinkButton {
  final String link;
  final String path;

  LinkButton({required this.link, required this.path});
}

class LaunchpadViewModel {
  final String title;
  final String url;

  LaunchpadViewModel({required this.title, required this.url});
}
