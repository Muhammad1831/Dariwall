import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';
import 'package:dariwall/features/user_account/data/model/user_account_model.dart';

abstract class UserAccountRepository {
  Future<Either<AppException, UserAccountModel>> getUserAccountInfo();
  Future<Either<AppException, void>> changeAccountInfo(AccountInfoEntity accountInfoEntity);
}
