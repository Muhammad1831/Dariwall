import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/send/domain/repository/withdraw_repository.dart';

class WithdrawUsecase {
  final WithdrawRepository withdrawRepository;

  WithdrawUsecase({required this.withdrawRepository});

  Future<Either<AppException, void>> call(
      {required double amount,
      required String currencyCode,
      required String? destinationAddress}) async {
    return await withdrawRepository.withdraw(
        amount: amount, currencyCode: currencyCode, destinationAddress: destinationAddress);
  }
}
