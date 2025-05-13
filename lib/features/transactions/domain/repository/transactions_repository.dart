import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/transactions/data/model/transactions_model.dart';

abstract class TransactionsRepository {
  Future<Either<AppException, List<TransactionsModel>>> getTransactions();
}
