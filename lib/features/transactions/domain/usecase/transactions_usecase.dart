import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/transactions/data/model/transactions_model.dart';
import 'package:dariwall/features/transactions/domain/repository/transactions_repository.dart';

class TransactionsUsecase {
  final TransactionsRepository myTransactionsRepository;

  TransactionsUsecase({required this.myTransactionsRepository});

  Future<Either<AppException, List<TransactionsModel>>> call() async {
    return await myTransactionsRepository.getTransactions();
  }
}
