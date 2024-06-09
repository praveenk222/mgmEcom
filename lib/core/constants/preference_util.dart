
import 'dart:convert';

import 'package:getxpoc/screens/authendication_pages/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static SharedPreferences _prefsInstance;
  static bool _initCalled = false;

  static void init() async {
    _initCalled = true;
    _prefsInstance = await _prefs;
  }

  static void disposePref() {
    _prefs = null;
    _prefsInstance = null;
  }

  static bool isKeyValid(String key) {
    return _prefsInstance.containsKey(key);
  }



  static Future<bool> clearAllData() async {
    if (_prefsInstance == null) {}
    final instance = await _prefs;
    return instance.clear();
  }

  static LoginModel getUserData(String keyProfile) {
    if (_prefsInstance == null) {
      return null;
    }
    return LoginModel.fromJson(
        json.decode(_prefsInstance.getString(keyProfile) ?? ''));
  }

  static Future<bool> saveUserData(
      String keyUserProfile, LoginModel loginModel) async {
    final instance = await _prefs;
    var profile = json.encode(loginModel);
    return instance.setString(keyUserProfile, profile);
  }


}