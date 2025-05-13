import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/gift_code_page/data/model/gift_code_model.dart';
import 'package:dariwall/features/gift_code_page/domain/usecase/send_gift_code_usecase.dart';
import 'package:dariwall/features/home/presentation/provider/my_balances_provider.dart';
import 'package:dariwall/features/transactions/presentation/provider/transactions_provider.dart';

enum SendGiftCodeStatus {
  initial,
  loading,
  error,
  success,
}

class SendGiftCodeProvider extends ChangeNotifier {
  final SendGiftCodeUsecase sendGiftCodeUsecase;

  SendGiftCodeProvider({required this.sendGiftCodeUsecase});

  GiftCodeModel? _giftCodeModel;
  SendGiftCodeStatus _status = SendGiftCodeStatus.initial;

  SendGiftCodeStatus get status => _status;
  GiftCodeModel? get giftCodeModel => _giftCodeModel;

  Future<void> sendGiftCode({required String giftCode}) async {
    _status = SendGiftCodeStatus.loading;
    notifyListeners();

    final response = await sendGiftCodeUsecase.call(giftCode: giftCode);

    response.fold(
      (l) {
        SnackBarService.show(status: SnackBarStatus.error, message: l.message);
        _status = SendGiftCodeStatus.error;
      },
      (r) async{
        _giftCodeModel = r;
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: r.giftType.description ?? AppMessage.giftCodeAppliedSuccessfully,
        );
        _status = SendGiftCodeStatus.success;
        await getIt<MyBalancesProvider>().getMyBalances();
        await getIt<TransactionsProvider>().getTransactions();
      },
    );

    notifyListeners();
  }
}
