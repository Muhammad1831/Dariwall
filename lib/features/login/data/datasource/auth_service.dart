import 'package:dio/dio.dart';
import 'package:ostad/core/constant/app_api.dart';
import 'package:ostad/core/constant/app_keys.dart';
import 'package:ostad/core/constant/app_shared_preferences_key.dart';
import 'package:ostad/core/services/api_client_service.dart';
import 'package:ostad/core/services/error_handler_service.dart';
import 'package:ostad/core/utils/app_shared_preferences.dart';

class AuthService {
  final ApiClientService _apiClient;
  final AppSharedPreferences _preferences;

  AuthService(this._apiClient, this._preferences);

  Future<Response> login({required String phoneNumber, required String password}) async {
    try {
      final response = await _apiClient.post(
        AppApi.login,
        data: {
          AppKeys.keyPhoneNumber: phoneNumber,
          AppKeys.keyPassword: password,
        },
      );
      await _preferences.saveAccessToken(response.data[AppSharedPreferencesKey.keyToken]);
      await _preferences.saveRefreshToken(response.data[AppSharedPreferencesKey.keyRefreshToken]);

      return response;
    } on AppException {
      rethrow;
    }
  }

  Future<bool> logout() async {
    try {
      await _preferences.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _preferences.getAccessToken();
    return token != null;
  }
}
