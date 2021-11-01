import 'dart:convert';
import 'package:http/http.dart' as http;

class SpaceXApi {
  static const String api = 'https://api.spacexdata.com/v4/';

  static const String getUpcomingLaunchesEndpoint = 'launches/upcoming';
  static const String getRocketEndpoint = 'rockets/{id}';

  Future<List<dynamic>> requestUpcomingLaunches() {
    const String url = api + getUpcomingLaunchesEndpoint;

    return http.get(Uri.parse(url)).then((val) => json.decode(val.body));
  }

  Future<Map<String, dynamic>> requestRocketData(String rocketId) {
    final String url = api + getRocketEndpoint.replaceFirst("{id}", rocketId);

    return http.get(Uri.parse(url)).then((val) => json.decode(val.body));
  }
}
