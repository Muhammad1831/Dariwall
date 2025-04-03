import 'package:dio/dio.dart';
import 'package:ostad/core/constant/app_api.dart';
import 'package:ostad/core/constant/app_keys.dart';
import 'package:ostad/core/constant/app_shared_preferences_key.dart';
import 'package:ostad/features/sign_up/data/model/province_model.dart';
import 'package:ostad/features/sign_up/data/model/sign_up_model.dart';
import 'package:ostad/features/sign_up/data/model/university_model.dart';
import 'package:ostad/core/services/api_client_service.dart';
import 'package:ostad/core/services/error_handler_service.dart';
import 'package:ostad/core/utils/utils_shared_preferences.dart';

class SignUpService {
  final ApiClientService _apiClient;
  final UtilsSharedPreferences _preferences;

  SignUpService(this._apiClient, this._preferences);

  Future<Response> register({required SignUpModel signUpModel}) async {
    try {
      final response = await _apiClient.post(
        AppApi.register,
        data: signUpModel.toJson(),
      );
      await _preferences.saveAccessToken(response.data[AppSharedPreferencesKey.keyAccess]);
      await _preferences.saveRefreshToken(response.data[AppSharedPreferencesKey.keyRefresh]);

      return response;
    } on AppException {
      rethrow;
    }
  }

  Future<List<UniversityModel>> getUniversities({required String provinceCode}) async {
    final response = await _apiClient.get(
      AppApi.universities,
      queryParameters: {
        AppKeys.keyProvinceCode: provinceCode,
      },
    );
    return (response.data as List).map((e) => UniversityModel.fromJson(e)).toList();
  }

  Future<List<ProvinceModel>> getProvinces() async {
    final response = await _apiClient.get(
      AppApi.provinces,
    );
    return (response.data as List).map((e) => ProvinceModel.fromJson(e)).toList();
  }
}
