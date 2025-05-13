import 'package:flutter/material.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/gift_code_page/domain/usecase/verify_gift_code_usecase.dart';

enum VerifyGiftCodeStatus {
  initial,
  loading,
  error,
  success,
}

class VerifyGiftCodeProvider extends ChangeNotifier {
  final VerifyGiftCodeUsecase verifyGiftCodeUsecase;

  VerifyGiftCodeProvider({required this.verifyGiftCodeUsecase});

  VerifyGiftCodeStatus _status = VerifyGiftCodeStatus.initial;

  VerifyGiftCodeStatus get status => _status;

  Future<void> verifyGiftCode({required String giftCode}) async {
    _status = VerifyGiftCodeStatus.loading;
    notifyListeners();

    final response = await verifyGiftCodeUsecase.call(giftCode: giftCode);

    response.fold(
      (l) {
        SnackBarService.show(status: SnackBarStatus.error, message: l.message);
        _status = VerifyGiftCodeStatus.error;
      },
      (r) {
        _status = VerifyGiftCodeStatus.success;
      },
    );

    notifyListeners();
  }
}
