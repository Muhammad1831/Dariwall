import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/global_provider/data/model/currency_price_model.dart';

class CurrencyPricesDataSource {
  final ApiClientService apiClientService;

  CurrencyPricesDataSource({required this.apiClientService});

  Future<List<CurrencyPriceModel>> getCurrencyPrices(String? currencyCode) async {
    final response = await apiClientService.get(
      AppApi.currencyPrice,
      queryParameters: {
        AppKeys.keyCode: currencyCode,
      },
    );
    return (response.data as List).map((e) => CurrencyPriceModel.fromJson(e)).toList();
  }
}
