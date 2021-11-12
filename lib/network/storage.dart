import 'package:shared_preferences/shared_preferences.dart';

const String launchPrefix = "launch_";

class Storage {

  SharedPreferences? prefs;

  Future<bool> isStarred(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(launchPrefix + id) ?? false;
  }

  Future<void> setStarred(String id, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(launchPrefix + id, value);
  }

}
