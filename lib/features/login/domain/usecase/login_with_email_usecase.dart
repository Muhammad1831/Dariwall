import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/login/domain/repository/login_repository.dart';

class LoginWithEmailUseCase {
  final LoginRepository _loginRepository;

  LoginWithEmailUseCase(this._loginRepository);

  Future<Either<AppException, void>> call(String email) async {
    return _loginRepository.loginWithEmail(email: email);
  }
}
