import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/features/send/data/model/transfer_param_model.dart';

class TransferDataSource {
  final ApiClientService apiClientService;

  TransferDataSource({required this.apiClientService});

  Future<void> transfer({required TransferParamModel param}) async {
    await apiClientService.post(
      AppApi.transfer,
      data: param.toJson(),
    );
  }
}
