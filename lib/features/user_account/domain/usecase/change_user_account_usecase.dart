import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';
import 'package:dariwall/features/user_account/domain/repository/user_account_repository.dart';

class ChangeUserAccountUsecase {
  final UserAccountRepository userAccountRepository;

  ChangeUserAccountUsecase({required this.userAccountRepository});

  Future<Either<AppException, void>> call(AccountInfoEntity accountInfoEntity) async {
    return userAccountRepository.changeAccountInfo(accountInfoEntity);
  }
}
