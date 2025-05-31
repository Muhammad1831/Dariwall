import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/global_provider/data/model/calculate_fee_model.dart';

class CalculateFeeDataSource {
  final ApiClientService apiClientService;

  CalculateFeeDataSource({required this.apiClientService});

  Future<CalculateFeeModel> calculateFee({required CalculateFeeParamModel param}) async {
    final response = await apiClientService.get(
      '${AppApi.calculateFee}${param.transactionType}/${param.currencyCode}/${param.amount}/',
    );

    return CalculateFeeModel.fromJson(response.data);
  }
}
