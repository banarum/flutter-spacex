import 'dart:convert';
import 'package:http/http.dart';

class SpaceXApi {
  static const String api = 'https://api.spacexdata.com/v4/';

  static const String getUpcomingLaunchesEndpoint = 'launches';
  static const String getLaunchEndpoint = 'launches/{id}';
  static const String getRocketEndpoint = 'rockets/{id}';
  static const String getLaunchpadEndpoint = 'launchpads/{id}';
  static const String getPayloadsEndpoint = 'payloads/{id}';

  Client client = Client();

  Future<List<dynamic>> requestUpcomingLaunches() {
    const String url = api + getUpcomingLaunchesEndpoint;

    return client.get(Uri.parse(url)).then((val) => json.decode(val.body));
  }

  Future<Map<String, dynamic>> requestRocketData(String rocketId) {
    final String url = api + getRocketEndpoint.replaceFirst("{id}", rocketId);

    return client.get(Uri.parse(url)).then((val) => json.decode(val.body));
  }

  Future<Map<String, dynamic>> requestLaunchDetails(String launchId) {
    final String url = api + getLaunchEndpoint.replaceFirst("{id}", launchId);

    return client.get(Uri.parse(url)).then((val) => json.decode(val.body));
  }

  Future<Map<String, dynamic>> requestLaunchpadData(String launchpadId) {
    final String url = api + getLaunchpadEndpoint.replaceFirst("{id}", launchpadId);

    return client.get(Uri.parse(url)).then((val) => json.decode(val.body));
  }

  Future<Map<String, dynamic>> requestPayloadData(String payloadId) {
    final String url = api + getPayloadsEndpoint.replaceFirst("{id}", payloadId);

    return client.get(Uri.parse(url)).then((val) => json.decode(val.body));
  }
}
