import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/model/currency_price_model.dart';

abstract class CurrencyPricesRepository {
  Future<Either<AppException, List<CurrencyPriceModel>>> getCurrencyPrices(String? currencyCode);
}
