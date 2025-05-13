import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/send/data/datasource/withdraw_data_source.dart';
import 'package:dariwall/features/send/domain/repository/withdraw_repository.dart';

class WithdrawRepositoryImp implements WithdrawRepository {
  final WithdrawDataSource withdrawDataSource;

  WithdrawRepositoryImp({required this.withdrawDataSource});

  @override
  Future<Either<AppException, void>> withdraw(
      {required double amount, required String currencyCode}) async {
    try {
      await withdrawDataSource.withdraw(amount: amount, currencyCode: currencyCode);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
