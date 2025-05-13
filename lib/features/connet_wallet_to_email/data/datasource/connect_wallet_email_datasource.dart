import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/services/api_client_service.dart';

class ConnectWalletEmailDatasource {
  final ApiClientService apiClientService;

  ConnectWalletEmailDatasource({required this.apiClientService});
  Future<void> sendEmailOtp({required String email}) async {
    await apiClientService.post(
      AppApi.sendEmailOtp,
      data: {AppKeys.keyEmail: email},
    );
  }

  Future<void> verifyEmailCode({required String email, required String code}) async {
    await apiClientService.post(
      AppApi.verifyEmailOtp,
      data: {
        AppKeys.keyEmail: email,
        AppKeys.keyCode: code,
      },
    );
  }
}
