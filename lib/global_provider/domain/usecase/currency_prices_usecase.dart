import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/model/currency_price_model.dart';
import 'package:dariwall/global_provider/domain/repository/currency_prices_repository.dart';

class CurrencyPricesUsecase {
  final CurrencyPricesRepository currencyPricesRepository;

  CurrencyPricesUsecase({required this.currencyPricesRepository});

  Future<Either<AppException, List<CurrencyPriceModel>>> call(String? currencyCode) async {
    return await currencyPricesRepository.getCurrencyPrices(currencyCode);
  }
}
