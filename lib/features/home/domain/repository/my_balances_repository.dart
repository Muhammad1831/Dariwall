import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/home/data/model/my_balances_model.dart';

abstract class MyBalancesRepository {
  Future<Either<AppException, MyBalancesModel>> getMyBalances();
}
