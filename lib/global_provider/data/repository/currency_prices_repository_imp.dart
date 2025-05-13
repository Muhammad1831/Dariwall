import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/datasource/currency_prices_data_source.dart';
import 'package:dariwall/global_provider/data/model/currency_price_model.dart';
import 'package:dariwall/global_provider/domain/repository/currency_prices_repository.dart';

class CurrencyPricesRepositoryImp extends CurrencyPricesRepository {
  final CurrencyPricesDataSource currencyPricesDataSource;

  CurrencyPricesRepositoryImp({required this.currencyPricesDataSource});

  @override
  Future<Either<AppException, List<CurrencyPriceModel>>> getCurrencyPrices(String? currencyCode) async {
    try {
      final currencyPrices = await currencyPricesDataSource.getCurrencyPrices(currencyCode);
      return Right(currencyPrices);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
