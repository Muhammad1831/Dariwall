import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';

abstract class ConnectWalletEmailRepository {
  Future<Either<AppException, void>> sendEmailOtp({required String email});
  Future<Either<AppException, void>> verifyEmailCode({required String email, required String code});
}
