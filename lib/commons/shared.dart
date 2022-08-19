import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static set<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (T) {
      case String:
        prefs.setString(key, value as String);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
      case List<String>:
        prefs.setStringList(key, value as List<String>);
        break;
    }
  }

  static Future<T> get<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    late T res;
    switch (T) {
      case String:
        res = prefs.getString(key) as T;
        break;
      case int:
        res = prefs.getInt(key) as T;
        break;
      case bool:
        res = prefs.getBool(key) as T;
        break;
      case double:
        res = prefs.getDouble(key) as T;
        break;
      case List<String>:
        res = prefs.getStringList(key) as T;
        break;
    }

    return res;
  }
}
