import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPref;

  static init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPref.setString(key, value);
    }
    if (value is bool) {
      return await sharedPref.setBool(key, value);
    }
    if (value is int) {
      return await sharedPref.setInt(key, value);
    }
    if (value is double) {
      return await sharedPref.setDouble(key, value);
    }
    else {
      return await sharedPref.setStringList(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPref.get(key);
  }

  static List<String>? getListData({
    required String key
  }) {
    return sharedPref.getStringList(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPref.remove(key);
  }
}