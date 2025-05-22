import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';

abstract class SetEmailRepository {
  Future<Either<AppException, void>> setEmail(String email);
  Future<Either<AppException, void>> verifyEmail(String email, String code);
}
