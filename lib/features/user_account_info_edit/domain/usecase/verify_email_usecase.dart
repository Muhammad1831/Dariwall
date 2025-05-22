import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/user_account_info_edit/domain/repository/set_email_repository.dart';

class VerifyEmailUsecase {
  SetEmailRepository setEmailRepository;

  VerifyEmailUsecase({required this.setEmailRepository});

  Future<Either<AppException, void>> call(String email, String code) async {
    return await setEmailRepository.verifyEmail(email, code);
  }
}
