import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'models.dart';


class SpaceXApi {
  SpaceXApi._privateConstructor();

  static final SpaceXApi _instance = SpaceXApi._privateConstructor();

  static SpaceXApi get shared => _instance;

  static const String api = 'https://api.spacexdata.com/v4/';

  static const String getUpcomingLaunchesEndpoint = 'launches/upcoming';
  static const String getRocketEndpoint = 'rockets/{id}';

  Future<List<LaunchModel>> getUpcomingLaunches() async {
    const String upcomingLaunchesUrl = api + getUpcomingLaunchesEndpoint;
    const String rocketUrl = api + getRocketEndpoint;

    final launchesResponse = await http.get(Uri.parse(upcomingLaunchesUrl)).then((val) => json.decode(val.body));

    var launchesList = List<LaunchModel>.from(launchesResponse.map((x) => LaunchModel.fromJson(x)));

    launchesList = await Future.wait(launchesList.map((launch) async {
      if (launch.rocket != null) {
        final rocketResponse = await http.get(
            Uri.parse(rocketUrl.replaceFirst("{id}", launch.rocket!))).then((
            val) => json.decode(val.body));
        launch.rocketData = RocketModel.fromJson(rocketResponse);
      }
      return launch;
    }));

    return launchesList;
  }
}
