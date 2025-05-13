import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/features/gift_code_page/data/model/gift_code_model.dart';

class GiftCodeDatasource {
  final ApiClientService apiClientService;

  GiftCodeDatasource({required this.apiClientService});

  Future<void> verifyGiftCode({required String giftCode}) async {
    await apiClientService.get(
      '${AppApi.verifyGiftCode}/$giftCode/',
    );
  }

  Future<GiftCodeModel> sendGiftCode({required String giftCode}) async {
    final response = await apiClientService.post(
      AppApi.sendGiftCode,
      data: {AppKeys.keyCode: giftCode},
    );

    return GiftCodeModel.fromJson(response.data);
  }
}
