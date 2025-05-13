import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';
import 'package:dariwall/features/user_account/data/datasource/user_account_data_source.dart';
import 'package:dariwall/features/user_account/data/model/change_account_info_model.dart';
import 'package:dariwall/features/user_account/data/model/user_account_model.dart';
import 'package:dariwall/features/user_account/domain/repository/user_account_repository.dart';

class UserAccountRepositoryImp implements UserAccountRepository {
  final UserAccountDataSource userAccountDataSource;

  UserAccountRepositoryImp({required this.userAccountDataSource});

  @override
  Future<Either<AppException, UserAccountModel>> getUserAccountInfo() async {
    try {
      final userAccount = await userAccountDataSource.getUserAccountInfo();
      return Right(userAccount);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> changeAccountInfo(AccountInfoEntity accountInfoEntity) async {
    try {
      await userAccountDataSource.changeAccountInfo(
        ChangeAccountInfoModel.fromEntity(accountInfoEntity),
      );
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
