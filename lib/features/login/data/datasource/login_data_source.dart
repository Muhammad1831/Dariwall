import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/constant/app_shared_preferences_key.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/core/utils/utils_shared_preferences.dart';
import 'package:dariwall/features/login/data/model/account_info_model.dart';

class LoginDataSource {
  final ApiClientService _apiClient;
  final UtilsSharedPreferences _preferences;

  LoginDataSource(this._apiClient, this._preferences);

  Future<AccountInfoModel> loginWithKeys({required List<String> keys}) async {
    final response = await _apiClient.post(
      AppApi.obtainPair,
      data: {AppKeys.keyMnemonic: keys},
    );
    await _preferences.saveAccessToken(response.data[AppSharedPreferencesKey.keyAccess]);
    await _preferences.saveRefreshToken(response.data[AppSharedPreferencesKey.keyRefresh]);

    return AccountInfoModel.fromJson(response.data[AppKeys.keyAccountInfo]);
  }

  Future loginWithEmail({required String email}) async {
    final response = await _apiClient.post(
      AppApi.sendEmail,
      data: {AppKeys.keyEmail: email},
    );

    await _preferences.setString(
      AppSharedPreferencesKey.keySecureToken,
      response.data[AppSharedPreferencesKey.keySecureToken],
    );
  }

  Future<AccountInfoModel> verifyEmailCode({required String code}) async {
    final response = await _apiClient.post(
      AppApi.verifyCode,
      data: {
        AppSharedPreferencesKey.keySecureToken:
            _preferences.getString(AppSharedPreferencesKey.keySecureToken),
        AppKeys.keyCode: code,
      },
    );

    await _preferences.saveAccessToken(response.data[AppSharedPreferencesKey.keyAccess]);
    await _preferences.saveRefreshToken(response.data[AppSharedPreferencesKey.keyRefresh]);

    return AccountInfoModel.fromJson(response.data[AppKeys.keyAccountInfo]);
  }
}
