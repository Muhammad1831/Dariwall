import 'package:ostad/core/constant/app_api.dart';
import 'package:ostad/core/constant/app_keys.dart';
import 'package:ostad/core/constant/app_shared_preferences_key.dart';
import 'package:ostad/core/services/api_client_service.dart';
import 'package:ostad/core/services/error_handler_service.dart';
import 'package:ostad/core/utils/utils_shared_preferences.dart';
import 'package:ostad/features/create_new_wallet/data/model/recovery_phrase_model.dart';

class CreateWalletDatasource {
  final ApiClientService _apiClient;
  final UtilsSharedPreferences _preferences;

  CreateWalletDatasource(this._apiClient, this._preferences);

  Future<void> sendPhoneNumberAndReferralCode(String phoneNumber, String? referralCode) async {
    try {
      final response = await _apiClient.post(
        AppApi.confirmPhoneNumber1,
        data: {
          AppKeys.keyPhoneNumber: phoneNumber,
          AppKeys.keyPassword: referralCode,
        },
      );

      _preferences.setString(
        AppSharedPreferencesKey.keySecureToken,
        response.data[AppSharedPreferencesKey.keySecureToken],
      );
    } on AppException {
      rethrow;
    }
  }

  Future<void> checkOtpCode(String code) async {
    try {
      final response = await _apiClient.post(
        AppApi.confirmPhoneNumber2,
        data: {
          AppSharedPreferencesKey.keySecureToken: _preferences.getString(
            AppSharedPreferencesKey.keySecureToken,
          ),
          AppKeys.keyCode: code,
        },
      );

      _preferences.setString(
        AppSharedPreferencesKey.keySecureToken,
        response.data[AppSharedPreferencesKey.keySecureToken],
      );
    } on AppException {
      rethrow;
    }
  }

  Future<RecoveryPhraseModel> setPassword(String password) async {
    try {
      final response = await _apiClient.post(
        AppApi.setPassword,
        data: {
          AppSharedPreferencesKey.keySecureToken: _preferences.getString(
            AppSharedPreferencesKey.keySecureToken,
          ),
          AppKeys.keyPassword: password,
        },
      );

      await _preferences.saveAccessToken(response.data[AppSharedPreferencesKey.keyAccess]);
      await _preferences.saveRefreshToken(response.data[AppSharedPreferencesKey.keyRefresh]);

      return RecoveryPhraseModel.fromJson(response.data);
    } on AppException {
      rethrow;
    }
  }
}
