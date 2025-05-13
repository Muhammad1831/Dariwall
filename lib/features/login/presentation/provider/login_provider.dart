import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/login/data/model/account_info_model.dart';
import 'package:dariwall/features/login/domain/usecase/check_login_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/login_with_email_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/login_with_keys_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/logout_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/verify_email_code_usecase.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';

enum LoginStatus { initial, loading, error, success, loggedIn, loggedOut }

int timeExpires = 120;

class LoginProvider with ChangeNotifier {
  final LoginWithEmailUseCase loginWithEmailUseCase;
  final LoginWithKeysUseCase loginWithKeysUseCase;
  final VerifyEmailCodeUseCase verifyEmailCodeUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckLoginUseCase checkLoginUseCase;

  LoginProvider({
    required this.loginWithEmailUseCase,
    required this.loginWithKeysUseCase,
    required this.verifyEmailCodeUseCase,
    required this.logoutUseCase,
    required this.checkLoginUseCase,
  }) {
    _checkLoginStatus();
  }

  int _remainingSeconds = timeExpires;
  Timer? _timer;

  LoginStatus _status = LoginStatus.initial;
  late AccountInfoModel _accountInfo;

  LoginStatus get status => _status;
  AccountInfoModel get accountInfo => _accountInfo;
  int get remainingSeconds => _remainingSeconds;
  bool get isLoggedIn => _status == LoginStatus.loggedIn;

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await checkLoginUseCase.call();
    if (isLoggedIn) {
      _status = LoginStatus.loggedIn;
    } else {
      _status = LoginStatus.loggedOut;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await logoutUseCase.call();
    _status = LoginStatus.loggedOut;
    notifyListeners();
  }

  Future<void> loginWithEmail({required String email}) async {
    _status = LoginStatus.loading;
    notifyListeners();

    var response = await loginWithEmailUseCase.call(email);
    response.fold(
      (error) {
        _status = LoginStatus.error;
        SnackBarService.show(
          message: error.message,
          status: SnackBarStatus.error,
        );
      },
      (success) {
        _status = LoginStatus.success;
      },
    );
    notifyListeners();
  }

  Future<void> verifyEmailCode({required String code}) async {
    _status = LoginStatus.loading;
    notifyListeners();

    var response = await verifyEmailCodeUseCase.call(code);
    response.fold(
      (error) {
        _status = LoginStatus.error;
        SnackBarService.show(
          message: error.message,
          status: SnackBarStatus.error,
        );
      },
      (success) async {
        _status = LoginStatus.loggedIn;
        _accountInfo = success;
        SnackBarService.show(
          message: AppMessage.loginSuccess,
          status: SnackBarStatus.success,
        );
        // Get user account info after successful login
        await GetIt.I<GetUserAccountInfoProvider>().getUserAccountInfo();
      },
    );
    notifyListeners();
  }

  Future<void> loginWithKeys({required List<String> keys}) async {
    _status = LoginStatus.loading;
    notifyListeners();

    var response = await loginWithKeysUseCase.call(keys);
    response.fold(
      (error) {
        _status = LoginStatus.error;
        SnackBarService.show(
          message: error.message,
          status: SnackBarStatus.error,
        );
      },
      (success) async {
        _status = LoginStatus.loggedIn;
        _accountInfo = success;
        SnackBarService.show(
          message: AppMessage.loginSuccess,
          status: SnackBarStatus.success,
        );
        // Get user account info after successful login
        await GetIt.I<GetUserAccountInfoProvider>().getUserAccountInfo();
      },
    );
    notifyListeners();
  }

  void startCountdown() {
    _remainingSeconds = timeExpires;
    stopCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        stopCountdown();
      }
    });
  }

  void stopCountdown() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopCountdown();
    super.dispose();
  }
}
