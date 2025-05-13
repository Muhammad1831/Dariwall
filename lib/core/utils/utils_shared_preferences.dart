import 'package:dariwall/core/constant/app_shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilsSharedPreferences {
  static UtilsSharedPreferences? _instance;
  static SharedPreferences? _preferences;

  UtilsSharedPreferences._internal();

  static UtilsSharedPreferences get getInstance {
    if (_instance == null) {
      if (_preferences == null) {
        throw Exception("Shared Preferences not initialized! Call init() first.");
      }
      _instance = UtilsSharedPreferences._internal();
    }
    return _instance!;
  }

  static UtilsSharedPreferences? get instance {
    if (_instance == null) {
      if (_preferences == null) {
        return null;
      }
      _instance = UtilsSharedPreferences._internal();
    }
    return _instance!;
  }

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppSharedPreferencesKey.keyAccess, token);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppSharedPreferencesKey.keyRefresh, refreshToken);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppSharedPreferencesKey.keyAccess);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppSharedPreferencesKey.keyRefresh);
  }

  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  Future<void> clear() async {
    await _preferences?.clear();
  }
}
