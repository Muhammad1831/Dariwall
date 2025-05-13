import 'package:flutter/cupertino.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/home/presentation/provider/my_balances_provider.dart';
import 'package:dariwall/features/transactions/presentation/provider/transactions_provider.dart';
import 'package:dariwall/features/send/domain/usecase/withdraw_usecase.dart';

enum WithdrawStatus {
  initial,
  loading,
  success,
  error,
}

class WithdrawProvider extends ChangeNotifier {
  final WithdrawUsecase withdrawUsecase;

  WithdrawProvider({required this.withdrawUsecase});

  WithdrawStatus _status = WithdrawStatus.initial;
  WithdrawStatus get status => _status;

  void withdraw(double amount, String currencyCode) async {
    _status = WithdrawStatus.loading;
    notifyListeners();

    final result = await withdrawUsecase.call(amount: amount, currencyCode: currencyCode);
    result.fold(
      (l) {
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
        _status = WithdrawStatus.error;
        notifyListeners();
      },
      (r) async{
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.sendSuccess,
        );
        _status = WithdrawStatus.success;
        await getIt<TransactionsProvider>().getTransactions();
        await getIt<MyBalancesProvider>().getMyBalances();
        notifyListeners();
      },
    );
  }
}
