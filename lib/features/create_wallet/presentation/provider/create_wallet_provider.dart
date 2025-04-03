import 'package:flutter/material.dart';
import 'package:ostad/features/create_wallet/domain/entity/new_wallet_entity.dart';
import 'package:ostad/features/create_wallet/domain/usecase/create_wallet_usecase.dart';
import 'dart:async';

enum CreateWalletState { initial, gettingOtp, checkingOtp, settingPassword, success, error }

enum CreateWalletStep { basicInfo, validation, password }

int timeExpires = 120;

class CreateWalletProvider with ChangeNotifier {
  final CreateWalletUsecase createWalletUsecase;

  // recovery phrase
  RecoveryPhraseEntity? _recoveryPhrase;

  // step and state
  CreateWalletStep _currentStepIndex = CreateWalletStep.basicInfo;
  CreateWalletState _state = CreateWalletState.initial;
  String? _errorMessage;

  // basic info
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController referrerCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  // enter with finger print
  bool _enterWithFingerPrint = false;

  // validation
  bool _isAcceptTerms = false;
  bool _isPasswordMatch = false;

  // timer
  int _remainingSeconds = timeExpires;
  Timer? _timer;

  CreateWalletProvider({required this.createWalletUsecase});

  // getters
  CreateWalletState get state => _state;
  String? get errorMessage => _errorMessage;
  RecoveryPhraseEntity? get recoveryPhrase => _recoveryPhrase;
  int get remainingSeconds => _remainingSeconds;
  CreateWalletStep get currentStepIndex => _currentStepIndex;
  bool get enterWithFingerPrint => _enterWithFingerPrint;
  bool get isAcceptTerms => _isAcceptTerms;
  bool get isPasswordMatch => _isPasswordMatch;

  void updateEnterWithFingerPrint(bool value) {
    _enterWithFingerPrint = value;
    notifyListeners();
  }

  void updateAcceptTerms(bool value) {
    _isAcceptTerms = value;
    notifyListeners();
  }

  void updateIsPasswordMatch() {
    _isPasswordMatch = passwordController.text == repeatPasswordController.text;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStepIndex.index < CreateWalletStep.values.length - 1) {
      _currentStepIndex = CreateWalletStep.values[_currentStepIndex.index + 1];
      notifyListeners();
    }
  }

  void previousStep() {
    stopCountdown();
    _currentStepIndex = CreateWalletStep.basicInfo;
    notifyListeners();
  }

  void _setState(CreateWalletState state) {
    _state = state;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setState(CreateWalletState.error);
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
    phoneNumberController.dispose();
    referrerCodeController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  Future<void> sendPhoneNumberAndReferralCode() async {
    _setState(CreateWalletState.gettingOtp);
    try {
      await createWalletUsecase.sendPhoneNumberAndReferralCode(
        phoneNumberController.text,
        referrerCodeController.text,
      );
      _setState(CreateWalletState.success);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> checkOtpCode(String code) async {
    _setState(CreateWalletState.checkingOtp);
    try {
      await createWalletUsecase.checkOtpCode(code);
      _setState(CreateWalletState.success);
      stopCountdown();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> setPassword() async {
    _setState(CreateWalletState.settingPassword);
    try {
      _recoveryPhrase = await createWalletUsecase.setPassword(passwordController.text);
      _setState(CreateWalletState.success);
    } catch (e) {
      _setError(e.toString());
    }
  }
}
