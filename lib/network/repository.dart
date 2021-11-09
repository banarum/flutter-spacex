import 'package:flutter_spacex/network/api.dart';
import 'api.dart';
import 'models.dart';

class Repository {
  final SpaceXApi spaceXApi = SpaceXApi();

  List<LaunchModel>? launchesData;
  Map<String, LaunchModel> detailedLaunchesData = {};

  Future<void> refreshLaunchesData() async {
    launchesData = await _getUpcomingLaunches();
    detailedLaunchesData = {};
  }


  Future<void> getDetailedDataForLaunch(String launchId) async {
    LaunchModel detailedLaunchModel = await _getLaunchDetail(launchId);

    detailedLaunchesData[launchId] = detailedLaunchModel;
  }

  Future<List<LaunchModel>> _getUpcomingLaunches() async {
    final launchesResponse = await spaceXApi.requestUpcomingLaunches();

    return List<LaunchModel>.from(
        await Future.wait(launchesResponse.map((launch) async {
      final launchModel = LaunchModel.fromJson(launch);
      if (launchModel.rocketId != null) {
        launchModel.rocketData = await _getRocketData(launchModel.rocketId!);
      }

      return launchModel;
    })))
      ..sort((item1, item2) => item1.unixDate - item2.unixDate);
  }

  Future<LaunchModel> _getLaunchDetail(String id) async {
    final launchDetailResponse = await spaceXApi.requestLaunchDetails(id);

    final launchModel = LaunchModel.fromJson(launchDetailResponse);
    if (launchModel.rocketId != null) {
      launchModel.rocketData = await _getRocketData(launchModel.rocketId!);
    }

    if (launchModel.launchpadId != null) {
      launchModel.launchpadData = await _getLaunchpadData(launchModel.launchpadId!);
    }

    return launchModel;
  }

  Future<RocketModel> _getRocketData(String id) async =>
      RocketModel.fromJson(await spaceXApi.requestRocketData(id));

  Future<LaunchpadModel> _getLaunchpadData(String id) async =>
      LaunchpadModel.fromJson(await spaceXApi.requestLaunchpadData(id));
}
