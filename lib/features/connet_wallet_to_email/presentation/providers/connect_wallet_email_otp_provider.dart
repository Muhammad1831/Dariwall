import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/connet_wallet_to_email/domain/usecase/connect_wallet_email_usecase.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';

enum ConnectWalletEmailOtpStatus {
  initial,
  loading,
  success,
  error,
}

final int timeExpires = 120;

class ConnectWalletEmailOtpProvider extends ChangeNotifier {
  ConnectWalletEmailOtpProvider({required this.usecase});

  final ConnectWalletEmailUsecase usecase;

  int _remainingSeconds = timeExpires;
  int get remainingSeconds => _remainingSeconds;

  Timer? _timer;

  ConnectWalletEmailOtpStatus _status = ConnectWalletEmailOtpStatus.initial;
  ConnectWalletEmailOtpStatus get status => _status;

  @override
  void dispose() {
    stopCountdown();
    super.dispose();
  }

  Future<void> verifyEmailCode({required String email, required String code}) async {
    _status = ConnectWalletEmailOtpStatus.loading;
    notifyListeners();
    final result = await usecase.verifyEmailCode(email: email, code: code);

    result.fold(
      (l) {
        _status = ConnectWalletEmailOtpStatus.error;
        SnackBarService.show(
          message: l.message,
          status: SnackBarStatus.error,
        );
        notifyListeners();
      },
      (r) {
        _status = ConnectWalletEmailOtpStatus.success;
        getIt<LoginProvider>().loginWithEmail(email: email);
        notifyListeners();
      },
    );
  }

  void startCountdown() {
    stopCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;
      notifyListeners();
    });
  }

  void stopCountdown() {
    _timer?.cancel();
    _remainingSeconds = timeExpires;
    notifyListeners();
  }
}
