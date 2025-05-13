import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/connet_wallet_to_email/data/datasource/connect_wallet_email_datasource.dart';
import 'package:dariwall/features/connet_wallet_to_email/domain/repository/connect_wallet_email_repository.dart';

class ConnectWalletEmailRepositoryImp implements ConnectWalletEmailRepository {
  final ConnectWalletEmailDatasource datasource;

  ConnectWalletEmailRepositoryImp({required this.datasource});
  @override
  Future<Either<AppException, void>> sendEmailOtp({required String email}) async {
    try {
      await datasource.sendEmailOtp(email: email);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> verifyEmailCode(
      {required String email, required String code}) async {
    try {
      await datasource.verifyEmailCode(email: email, code: code);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
