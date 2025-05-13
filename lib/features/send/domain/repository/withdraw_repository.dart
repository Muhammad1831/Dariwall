import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';

abstract class WithdrawRepository {
  Future<Either<AppException, void>> withdraw(
      {required double amount, required String currencyCode});
}
