import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/home/data/datasource/my_balances_datasource.dart';
import 'package:dariwall/features/home/data/model/my_balances_model.dart';
import 'package:dariwall/features/home/domain/repository/my_balances_repository.dart';

class MyBalancesRepositoryImp extends MyBalancesRepository {
  final MyBalancesDatasource myBalancesDatasource;

  MyBalancesRepositoryImp({required this.myBalancesDatasource});

  @override
  Future<Either<AppException, MyBalancesModel>> getMyBalances() async {
    try {
      final response = await myBalancesDatasource.getMyBalances();
      return Right(response);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
