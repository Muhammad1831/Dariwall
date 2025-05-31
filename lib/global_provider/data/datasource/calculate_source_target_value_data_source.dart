import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/global_provider/data/model/calculate_source_target_value_model.dart';

class CalculateSourceTargetValueDataSource {
  final ApiClientService apiClientService;

  CalculateSourceTargetValueDataSource({required this.apiClientService});

  Future<CalculateSourceTargetValueModel> calculateSourceTargetValue(
      {required CalculateSourceTargetValueParameterModel param}) async {
    final response = await apiClientService.get(
      '${AppApi.calculateSourceTargetValue}${param.sourceCurrencyCode}/${param.sourceAmount}/${param.targetCurrencyCode}/',
    );

    return CalculateSourceTargetValueModel.fromJson(response.data);
  }
}
