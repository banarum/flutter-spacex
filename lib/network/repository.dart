import 'package:flutter_spacex/network/api.dart';
import 'api.dart';
import 'models.dart';


class Repository {

  final SpaceXApi spaceXApi = SpaceXApi();

  Future<List<LaunchModel>> getUpcomingLaunches() async {

    final launchesResponse = await spaceXApi.requestUpcomingLaunches();

    var launchesList = List<LaunchModel>.from(launchesResponse.map((x) => LaunchModel.fromJson(x)));

    launchesList = await Future.wait(launchesList.map((launch) async {
      if (launch.rocketId != null) {
        final rocketResponse = await spaceXApi.requestRocketData(launch.rocketId!);
        launch.rocketData = RocketModel.fromJson(rocketResponse);
      }
      return launch;
    }));

    launchesList.sort((item1, item2) => item1.unixDate - item2.unixDate);

    return launchesList;
  }
}
