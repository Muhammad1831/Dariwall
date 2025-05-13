import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/home/data/model/my_balances_model.dart';
import 'package:dariwall/features/home/domain/repository/my_balances_repository.dart';

class MyBalancesUsecase {
  final MyBalancesRepository myBalancesRepository;

  MyBalancesUsecase({required this.myBalancesRepository});

  Future<Either<AppException, MyBalancesModel>> call() async {
    return await myBalancesRepository.getMyBalances();
  }
}
