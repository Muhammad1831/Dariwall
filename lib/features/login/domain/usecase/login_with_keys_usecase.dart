import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/login/data/model/account_info_model.dart';
import 'package:dariwall/features/login/domain/repository/login_repository.dart';

class LoginWithKeysUseCase {
  final LoginRepository _loginRepository;

  LoginWithKeysUseCase(this._loginRepository);

  Future<Either<AppException, AccountInfoModel>> call(List<String> keys) async {
    return _loginRepository.loginWithKeys(keys: keys);
  }
}
