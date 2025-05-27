import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static SharedPreferences? preferences;

  static createSharedPref() {
    SharedPreferences.getInstance()
        .then((pref) => StorageUtil.preferences = pref);
  }

  static setData(String key, dynamic value) async {
    if (StorageUtil.preferences != null && value != null) {
      if (value is String) {
        await StorageUtil.preferences!.setString(key, value);
      } else if (value is int) {
        await StorageUtil.preferences!.setInt(key, value);
      } else if (value is double) {
        await StorageUtil.preferences!.setDouble(key, value);
      } else if (value is bool) {
        await StorageUtil.preferences!.setBool(key, value);
      } else {
        await StorageUtil.preferences!.setString(key, value);
      }
    }
  }

  static Future<dynamic> getData(String key) async {
    if (StorageUtil.preferences == null) {
      return null;
    } else {
      return StorageUtil.preferences!.get(key);
    }
  }

  static void clearData() {
    if (StorageUtil.preferences == null) {
      SharedPreferences.getInstance().then((value) {
        value.clear();
      });
    } else {
      StorageUtil.preferences!.clear();
    }
  }
}
