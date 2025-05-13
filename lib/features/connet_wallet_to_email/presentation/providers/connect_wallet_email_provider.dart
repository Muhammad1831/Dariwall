import 'package:flutter/foundation.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/connet_wallet_to_email/domain/usecase/connect_wallet_email_usecase.dart';

enum ConnectWalletEmailStatus {
  initial,
  loading,
  success,
  error,
}

class ConnectWalletEmailProvider extends ChangeNotifier {
  final ConnectWalletEmailUsecase usecase;

  ConnectWalletEmailProvider({required this.usecase});

  ConnectWalletEmailStatus _status = ConnectWalletEmailStatus.initial;
  ConnectWalletEmailStatus get status => _status;

  Future<void> sendEmailOtp({required String email}) async {
    _status = ConnectWalletEmailStatus.loading;
    notifyListeners();
    final result = await usecase.sendEmailOtp(email: email);

    result.fold(
      (l) {
        _status = ConnectWalletEmailStatus.error;
        SnackBarService.show(
          message: l.message,
          status: SnackBarStatus.error,
        );
        notifyListeners();
      },
      (r) {
        _status = ConnectWalletEmailStatus.success;
        notifyListeners();
      },
    );
  }
}
