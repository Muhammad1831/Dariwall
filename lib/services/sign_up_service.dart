import 'package:dio/dio.dart';
import 'package:ostad/constant/app_api.dart';
import 'package:ostad/constant/app_keys.dart';
import 'package:ostad/models/province_model.dart';
import 'package:ostad/models/sign_up_model.dart';
import 'package:ostad/models/university_model.dart';
import 'package:ostad/services/api_client_service.dart';
import 'package:ostad/services/error_handler_service.dart';
import 'package:ostad/utils/app_shared_preferences.dart';

class SignUpService {
  final ApiClientService _apiClient;
  final AppSharedPreferences _preferences;

  SignUpService(this._apiClient, this._preferences);

  Future<Response> register({required SignUpModel signUpModel}) async {
    try {
      final response = await _apiClient.post(
        AppApi.register,
        data: signUpModel.toJson(),
      );
      await _preferences.saveAccessToken(response.data[AppKeys.keyToken]);
      await _preferences.saveRefreshToken(response.data[AppKeys.keyRefreshToken]);

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
