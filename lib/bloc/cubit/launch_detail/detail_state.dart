part of 'detail_cubit.dart';

enum ScreenStatus { loading, success, failure }

class LaunchDetailState extends Equatable {
  const LaunchDetailState._(
      {this.status = ScreenStatus.loading, required this.header, this.body});

  LaunchDetailState.fromState({required LaunchDetailState state, LaunchHeaderViewModel? header}):this._(
    status: state.status,
    header: header ?? state.header,
    body: state.body
  );

  const LaunchDetailState.loading({required LaunchHeaderViewModel header})
      : this._(header: header);

  LaunchDetailState.success(
      {required LaunchHeaderViewModel header,
      required List<LinkButton> links,
      LaunchpadViewModel? launchpad,
      RocketViewModel? rocket,
      List<PayloadViewModel>? payloads,
      LaunchDetailState? copyState})
      : this._(
            status: ScreenStatus.success,
            header: header,
            body: BodyContentViewModel(
                links: links,
                launchpad: launchpad ?? copyState?.body?.launchpad,
                rocket: rocket ?? copyState?.body?.rocket,
                payloads: payloads ?? copyState?.body?.payloads));

  const LaunchDetailState.failure({required LaunchHeaderViewModel header})
      : this._(status: ScreenStatus.failure, header: header);

  final ScreenStatus status;

  final BodyContentViewModel? body;

  final LaunchHeaderViewModel header;

  @override
  List<Object> get props => [
        status,
        header,
        body?.links ?? [],
        body?.launchpad ?? {},
        body?.rocket ?? {},
        body?.payloads ?? []
      ];
}

class BodyContentViewModel {
  final List<LinkButton>? links;
  final LaunchpadViewModel? launchpad;
  final RocketViewModel? rocket;
  final List<PayloadViewModel>? payloads;

  BodyContentViewModel(
      {this.links, this.launchpad, this.rocket, this.payloads});
}

class LinkButton {
  final String link;
  final String path;

  LinkButton({required this.link, required this.path});
}

class LaunchpadViewModel {
  final String title;
  final String? imageUrl;

  LaunchpadViewModel({required this.title, this.imageUrl});
}

class RocketViewModel {
  final String title;
  final String description;
  final String? imageUrl;

  RocketViewModel(
      {required this.title, required this.description, this.imageUrl});
}

class PayloadViewModel {
  final String title;
  final String type;
  final String mass;

  PayloadViewModel(
      {required this.title, required this.type, required this.mass});
}

class LaunchHeaderViewModel {
  final String title;
  final bool starred;
  final String launchId;

  LaunchHeaderViewModel(
      {required this.title, required this.launchId, required this.starred});
}
