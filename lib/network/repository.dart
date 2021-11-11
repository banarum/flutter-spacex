import 'package:flutter_spacex/network/api.dart';
import 'api.dart';
import 'models.dart';

class Repository {
  final SpaceXApi spaceXApi = SpaceXApi();

  List<LaunchModel>? launchesData;
  Map<String, LaunchModel> detailedLaunchesData = {};
  Map<LaunchModel, RocketModel> rockets = {};

  Future<void> refreshLaunchesData() async {
    launchesData = await _getLaunches();
    launchesData?.sort((item1, item2) {
      final item1Time = DateTime.parse(item1.utcDate);
      final item2Time = DateTime.parse(item2.utcDate);

      final item1TimeDiffWithNow = item1Time.difference(DateTime.now());
      final item2TimeDiffWithNow = item2Time.difference(DateTime.now());

      if (!item1TimeDiffWithNow.isNegative && !item2TimeDiffWithNow.isNegative) {
        return -item2Time.compareTo(item1Time);
      } else if (item1TimeDiffWithNow.isNegative && item2TimeDiffWithNow.isNegative) {
        return item2Time.compareTo(item1Time);
      } else if (item1TimeDiffWithNow.isNegative) {
        return 1;
      } else {
        return -1;
      }
    });
    detailedLaunchesData = {};
    rockets = {};
  }

  Future<void> getDetailedDataForLaunch(String launchId) async {
    LaunchModel detailedLaunchModel = await _getLaunchDetail(launchId);

    detailedLaunchesData[launchId] = detailedLaunchModel;
  }

  Future<void> getRocketsForLaunches(List<LaunchModel> launches) async {
    final List<LaunchModel> launchesWithRocketId = launches.where((
        element) => element.rocketId != null).toList();
    return Future.forEach(
        launchesWithRocketId,
        ((LaunchModel element) async =>
        rockets[element] = await _getRocketData(element.rocketId!)));
  }

  Future<List<LaunchModel>> _getLaunches() async {
    final launchesResponse = await spaceXApi.requestUpcomingLaunches();

    return List<LaunchModel>.from(
        await Future.wait(launchesResponse.map((launch) async {
          final launchModel = LaunchModel.fromJson(launch);

          return launchModel;
        })));
  }

  Future<LaunchModel> _getLaunchDetail(String id) async {
    final launchDetailResponse = await spaceXApi.requestLaunchDetails(id);

    final launchModel = LaunchModel.fromJson(launchDetailResponse);
    if (launchModel.rocketId != null) {
      launchModel.rocketData = await _getRocketData(launchModel.rocketId!);
    }

    if (launchModel.launchpadId != null) {
      launchModel.launchpadData =
      await _getLaunchpadData(launchModel.launchpadId!);
    }

    return launchModel;
  }

  Future<RocketModel> _getRocketData(String id) async =>
      RocketModel.fromJson(await spaceXApi.requestRocketData(id));

  Future<LaunchpadModel> _getLaunchpadData(String id) async =>
      LaunchpadModel.fromJson(await spaceXApi.requestLaunchpadData(id));
}
