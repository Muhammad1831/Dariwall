import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/constant/app_shared_preferences_key.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/core/utils/utils_shared_preferences.dart';
import 'package:dariwall/features/create_new_wallet/data/model/create_wallet_model.dart';

class CreateWalletDatasource {
  final ApiClientService _apiClient;
  final UtilsSharedPreferences _preferences;

  CreateWalletDatasource(this._apiClient, this._preferences);

  Future<CreateWalletModel> createWallet(String name, String referralCode) async {
    final response = await _apiClient.post(
      AppApi.createWallet,
      data: {
        AppKeys.keyName: name,
        AppKeys.keyReferralCode: referralCode.isEmpty ? null : referralCode,
      },
    );

    _preferences.setString(
      AppSharedPreferencesKey.keyAccess,
      response.data[AppSharedPreferencesKey.keyAccess],
    );
    _preferences.setString(
      AppSharedPreferencesKey.keyRefresh,
      response.data[AppSharedPreferencesKey.keyRefresh],
    );

    return CreateWalletModel.fromJson(response.data);
  }
}
