import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/user_account/data/model/user_account_model.dart';
import 'package:dariwall/features/user_account/domain/repository/user_account_repository.dart';

class GetUserAccountInfoUsecase {
  final UserAccountRepository userAccountRepository;

  GetUserAccountInfoUsecase({required this.userAccountRepository});

  Future<Either<AppException, UserAccountModel>> call() async {
    return userAccountRepository.getUserAccountInfo();
  }
}
