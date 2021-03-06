import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "null";
  }

  static Future<String?> setDarkmode(bool mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("themeMode", mode).then((value) => "done");
  }

  static Future<bool> getDarkmode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("themeMode") ?? false;
  }
}
