

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences cacheHepler;
  static int() async {
    cacheHepler = await SharedPreferences.getInstance();
  }

  static Future<bool> setBoolen(
      {required String key, required bool value}) async {
    return await cacheHepler.setBool(key, value);
  }

  static dynamic getCached({required String key}) {
    return cacheHepler.get(key);
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await cacheHepler.setString(key, value);
    }  else if (value is bool) {
      return await cacheHepler.setBool(key, value);
    } else if (value is double) {
      return await cacheHepler.setDouble(key, value);
    } else {
      return false;
    }
  }
}
