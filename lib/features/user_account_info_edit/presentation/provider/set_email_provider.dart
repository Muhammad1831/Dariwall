import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/user_account_info_edit/domain/usecase/set_email_usecase.dart';
import 'package:flutter/material.dart';

enum SetEmailStatus {
  initial,
  loading,
  success,
  error,
}

class SetEmailProvider extends ChangeNotifier {
  final SetEmailUsecase setEmailUsecase;

  SetEmailProvider({required this.setEmailUsecase});

  SetEmailStatus _status = SetEmailStatus.initial;
  SetEmailStatus get status => _status;

  Future<void> setEmail(String email) async {
    _status = SetEmailStatus.loading;
    notifyListeners();

    var response = await setEmailUsecase.call(email);

    response.fold(
      (left) {
        _status = SetEmailStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: left.message,
        );
        notifyListeners();
      },
      (right) {
        _status = SetEmailStatus.success;
        notifyListeners();
      },
    );
  }
}
