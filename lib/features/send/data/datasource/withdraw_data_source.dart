import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/services/api_client_service.dart';

class WithdrawDataSource {
  final ApiClientService apiClientService;

  WithdrawDataSource({required this.apiClientService});

  Future<void> withdraw({
    required double amount,
    required String currencyCode,
    required String? destinationAddress,
  }) async {
    await apiClientService.post(
      AppApi.send,
      data: {
        AppKeys.keyAmount: amount,
        AppKeys.keyCurrencyCode: currencyCode,
        AppKeys.destinationAddress: destinationAddress,
      },
    );
  }
}
