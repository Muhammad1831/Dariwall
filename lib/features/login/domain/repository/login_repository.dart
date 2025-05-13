import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/login/data/model/account_info_model.dart';

abstract class LoginRepository {
  Future<Either<AppException, AccountInfoModel>> loginWithKeys({required List<String> keys});
  Future<Either<AppException, void>> loginWithEmail({required String email});
  Future<Either<AppException, AccountInfoModel>> verifyEmailCode({required String code});
}
