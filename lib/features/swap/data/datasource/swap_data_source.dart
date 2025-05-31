import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/features/swap/data/model/swap_param_model.dart';

class SwapDataSource {
  final ApiClientService apiClientService;

  SwapDataSource({required this.apiClientService});

  Future<void> swap({required SwapParamModel param}) async {
    await apiClientService.post(
      AppApi.swap,
      data: param.toJson(),
    );
  }
}
