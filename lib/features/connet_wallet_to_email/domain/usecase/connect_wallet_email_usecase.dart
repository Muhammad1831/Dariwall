import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/connet_wallet_to_email/domain/repository/connect_wallet_email_repository.dart';

class ConnectWalletEmailUsecase {
  final ConnectWalletEmailRepository repository;

  ConnectWalletEmailUsecase({required this.repository});

  Future<Either<AppException, void>> sendEmailOtp({required String email}) async {
    if (email.isEmpty) {
      return Left(AppException(message: AppMessage.emailIsRequired));
    }
    return await repository.sendEmailOtp(email: email);
  }

  Future<Either<AppException, void>> verifyEmailCode(
      {required String email, required String code}) async {
    return await repository.verifyEmailCode(email: email, code: code);
  }
}
