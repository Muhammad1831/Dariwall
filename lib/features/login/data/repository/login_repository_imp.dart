import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/login/data/datasource/login_data_source.dart';
import 'package:dariwall/features/login/data/model/account_info_model.dart';
import 'package:dariwall/features/login/domain/repository/login_repository.dart';

class LoginRepositoryImp extends LoginRepository {
  final LoginDataSource _dataSource;

  LoginRepositoryImp(this._dataSource);

  @override
  Future<Either<AppException, AccountInfoModel>> loginWithKeys({required List<String> keys}) async {
    try {
      final result = await _dataSource.loginWithKeys(keys: keys);
      return Right(result);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> loginWithEmail({required String email}) async {
    try {
      await _dataSource.loginWithEmail(email: email);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, AccountInfoModel>> verifyEmailCode({required String code}) async {
    try {
      final result = await _dataSource.verifyEmailCode(code: code);
      return Right(result);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
