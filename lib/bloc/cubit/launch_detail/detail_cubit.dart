import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/network/repository.dart';

part 'detail_state.dart';

class LaunchDetailCubit extends Cubit<LaunchDetailState> {
  LaunchDetailCubit({required this.repository})
      : super(const LaunchDetailState.loading());

  final Repository repository;

  List<LinkButton> mapLaunchToLinkButtons(LaunchModel launch) {
    final List<LinkButton> links = [];

    if (launch.links.reddit?.campaign != null) {
      links.add(LinkButton(link: launch.links.reddit!.campaign!, path: "assets/images/reddit-logo.png"));
    }

    if (launch.links.wikipedia != null) {
      links.add(LinkButton(
          link: launch.links.wikipedia!, path: "assets/images/wikipedia-logo.png"));
    }

    return links;
  }

  LaunchpadViewModel? mapLaunchToLaunchpad(LaunchModel launch) {
    if (launch.launchpadData?.images.large?[0] != null) {
      return LaunchpadViewModel(title: launch.launchpadData!.locality,
          url: launch.launchpadData!.images.large![0]);
    }
    return null;
  }

  Future<void> getLaunchDetails(String id) async {
    emit(const LaunchDetailState.loading());

    LaunchModel? launch;

    if (repository.detailedLaunchesData.containsKey(id)) {
      launch = repository.detailedLaunchesData[id]!;
    } else {
      try {
        await repository.getDetailedDataForLaunch(id);
        launch = repository.detailedLaunchesData[id]!;
      } on Exception {
        emit(const LaunchDetailState.failure());
        return;
      }
    }

    final links = mapLaunchToLinkButtons(launch);
    final launchpad = mapLaunchToLaunchpad(launch);

    emit(LaunchDetailState.success(
        detailedLaunchModel: launch, links: links, launchpad: launchpad));
  }
}
