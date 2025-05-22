import 'package:dariwall/core/constant/app_shared_preferences_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilsSharedPreferences {
  static UtilsSharedPreferences? _instance;
  static SharedPreferences? _preferences;

  UtilsSharedPreferences._();

  static Future<UtilsSharedPreferences> getInstance() async {
    _instance ??= UtilsSharedPreferences._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<void> setAccessToken(String token) async {
    debugPrint('setAccessToken : $token');
    await _preferences?.setString(AppSharedPreferencesKey.keyAccess, token);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    debugPrint('setRefreshToken : $refreshToken');
    await _preferences?.setString(AppSharedPreferencesKey.keyRefresh, refreshToken);
  }

  String? getAccessToken() {
    debugPrint('getAccessToken : ${_preferences?.getString(AppSharedPreferencesKey.keyAccess)}');
    return _preferences?.getString(AppSharedPreferencesKey.keyAccess);
  }

  String? getRefreshToken() {
    debugPrint('getRefreshToken : ${_preferences?.getString(AppSharedPreferencesKey.keyRefresh)}');
    return _preferences?.getString(AppSharedPreferencesKey.keyRefresh);
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
    debugPrint('----------------- clearToken ----------------');
    await _preferences?.clear();
  }
}
