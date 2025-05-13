import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/transactions/data/datasource/transactions_data_source.dart';
import 'package:dariwall/features/transactions/data/model/transactions_model.dart';
import 'package:dariwall/features/transactions/domain/repository/transactions_repository.dart';

class TransactionsRepositoryImp extends TransactionsRepository {
  final TransactionsDataSource dataSource;

  TransactionsRepositoryImp({required this.dataSource});

  @override
  Future<Either<AppException, List<TransactionsModel>>> getTransactions() async {
    try {
      final myTransactions = await dataSource.getTransactions();
      return Right(myTransactions);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
