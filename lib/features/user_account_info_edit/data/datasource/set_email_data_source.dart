import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/services/api_client_service.dart';

class SetEmailDataSource {
  final ApiClientService apiClientService;

  SetEmailDataSource({required this.apiClientService});

  Future<void> setEmail(String email) async {
    await apiClientService.post(
      AppApi.setEmail,
      data: {AppKeys.keyEmail: email},
    );
  }

  Future<void> verifyEmail(String email, String code) async {
    await apiClientService.post(
      AppApi.verifyEmail,
      data: {AppKeys.keyEmail: email, AppKeys.keyCode: code},
    );
  }
}