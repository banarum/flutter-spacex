part of 'detail_cubit.dart';

List<PayloadViewModel> _mapPayloadsToView(List<PayloadModel> payloads) {
  return payloads
      .map((e) => PayloadViewModel(
            title: e.name,
            type: e.type,
            mass: "${e.mass ?? "???"} kg",
          ))
      .toList();
}

LaunchpadViewModel _mapLaunchpadToView(LaunchpadModel launchpad) {
  return LaunchpadViewModel(
      title: launchpad.locality, imageUrl: launchpad.images.large?[0]);
}

RocketViewModel _mapRocketToView(RocketModel rocket) {
  return RocketViewModel(
      title: rocket.name,
      imageUrl: rocket.images[0],
      description: rocket.description);
}

List<LinkButton> _mapLaunchToLinkButtons(LaunchModel launch) {
  final List<LinkButton> links = [];

  if (launch.links.reddit?.campaign != null) {
    links.add(LinkButton(
        link: launch.links.reddit!.campaign!,
        path: "assets/images/reddit-logo.png"));
  }

  if (launch.links.wikipedia != null) {
    links.add(LinkButton(
        link: launch.links.wikipedia!,
        path: "assets/images/wikipedia-logo.png"));
  }

  return links;
}

LaunchHeaderViewModel _mapHeaderToHeader(
    LaunchHeaderViewModel header, bool starred) {
  return LaunchHeaderViewModel(
      title: header.title, starred: starred, launchId: header.launchId);
}
