import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:dariwall/features/user_account_info_edit/domain/usecase/verify_email_usecase.dart';
import 'package:flutter/material.dart';

enum VerifyEmailStatus {
  initial,
  loading,
  success,
  error,
}

class VerifyEmailProvider extends ChangeNotifier {
  VerifyEmailUsecase verifyEmailUsecase;

  VerifyEmailProvider({required this.verifyEmailUsecase});

  VerifyEmailStatus _status = VerifyEmailStatus.initial;
  VerifyEmailStatus get status => _status;

  Future<void> verifyEmail(String email, String code) async {
    _status = VerifyEmailStatus.loading;
    notifyListeners();

    var response = await verifyEmailUsecase.call(email, code);

    response.fold(
      (left) {
        _status = VerifyEmailStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: left.message,
        );
        notifyListeners();
      },
      (right) async {
        _status = VerifyEmailStatus.success;
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.userEmailChangedSuccessfully,
        );
        await getIt<GetUserAccountInfoProvider>().getUserAccountInfo();
        notifyListeners();
      },
    );
  }
}
