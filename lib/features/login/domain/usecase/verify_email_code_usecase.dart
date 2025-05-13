import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/login/data/model/account_info_model.dart';
import 'package:dariwall/features/login/domain/repository/login_repository.dart';

class VerifyEmailCodeUseCase {
  final LoginRepository _loginRepository;

  VerifyEmailCodeUseCase(this._loginRepository);

  Future<Either<AppException, AccountInfoModel>> call(String code) async {
    return _loginRepository.verifyEmailCode(code: code);
  }
}
