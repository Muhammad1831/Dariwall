import 'package:ostad/core/constant/app_shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static AppSharedPreferences? _instance;
  static SharedPreferences? _preferences;

  AppSharedPreferences._internal();

  static AppSharedPreferences get getInstance {
    if (_instance == null) {
      if (_preferences == null) {
        throw Exception("Shared Preferences not initialized! Call init() first.");
      }
      _instance = AppSharedPreferences._internal();
    }
    return _instance!;
  }

  static AppSharedPreferences? get instance {
    if (_instance == null) {
      if (_preferences == null) {
        return null;
      }
      _instance = AppSharedPreferences._internal();
    }
    return _instance!;
  }

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppSharedPreferencesKey.keyToken, token);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppSharedPreferencesKey.keyRefreshToken, refreshToken);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppSharedPreferencesKey.keyToken);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppSharedPreferencesKey.keyRefreshToken);
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
