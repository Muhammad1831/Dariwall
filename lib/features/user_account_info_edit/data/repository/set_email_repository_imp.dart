import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/user_account_info_edit/data/datasource/set_email_data_source.dart';
import 'package:dariwall/features/user_account_info_edit/domain/repository/set_email_repository.dart';

class SetEmailRepositoryImp extends SetEmailRepository {
  final SetEmailDataSource setEmailDataSource;

  SetEmailRepositoryImp({required this.setEmailDataSource});

  @override
  Future<Either<AppException, void>> setEmail(String email) async {
    try {
      await setEmailDataSource.setEmail(email);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> verifyEmail(String email, String code) async {
    try {
      await setEmailDataSource.verifyEmail(email, code);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
