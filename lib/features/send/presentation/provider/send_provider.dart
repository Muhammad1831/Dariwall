import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/features/home/domain/entity/balances_entity.dart';
import 'package:dariwall/global_provider/providers/currency_prices_provider.dart';

class SendProvider extends ChangeNotifier {
  final CurrencyPricesProvider currencyPricesProvider;
  final BalancesEntity balance;

  SendProvider({
    required this.currencyPricesProvider,
    required this.balance,
  });

  bool _isTokenMode = true;
  String _dollarAmount = '0';
  String _tokenAmount = '0';
  // bool _isLessThan3USDT = false;

  bool get isTokenMode => _isTokenMode;
  String? get dollarAmount => _dollarAmount;
  String? get tokenAmount => _tokenAmount;
  double? get tokenPrice => currencyPricesProvider.currencyPrice?.price;
  // bool get isLessThan3USDT => _isLessThan3USDT;

  void switchMode() {
    _isTokenMode = !_isTokenMode;
    notifyListeners();
  }

  void tokenToUsdt(String value) {
    final token = double.tryParse(value) ?? 0;
    _dollarAmount = (token * (tokenPrice ?? 0)).toString();
    notifyListeners();
  }

  void usdtToToken(String value) {
    final dollar = double.tryParse(value) ?? 0;
    _tokenAmount = (dollar / (tokenPrice ?? 1)).toString();
    notifyListeners();
  }

  bool checkHaveEnoughBalance(double tokenAmount) {
    if (tokenAmount < 0) {
      SnackBarService.show(
        status: SnackBarStatus.error,
        message: AppMessage.amountMustBeGreaterThanZero,
      );
      return false;
    }

    if (_isTokenMode && tokenAmount > balance.amount) {
      SnackBarService.show(
        status: SnackBarStatus.error,
        message: AppMessage.amountIsNotEnough,
      );
      return false;
    }

    if (!_isTokenMode && tokenAmount > balance.valueUsd) {
      SnackBarService.show(
        status: SnackBarStatus.error,
        message: AppMessage.amountIsNotEnough,
      );
      return false;
    }
    return true;
  }

  void setMaxAmount() {
    if (isTokenMode) {
      _tokenAmount = balance.amount.toString();
      tokenToUsdt(balance.amount.toString());
    } else {
      _dollarAmount = balance.valueUsd.toString();
      usdtToToken(balance.valueUsd.toString());
    }
    notifyListeners();
  }

  // void checkLessThan3USDT() {
  //   final amount = double.tryParse(_dollarAmount ?? '0') ?? 0;
  //   _isLessThan3USDT = amount < 3;

  //   notifyListeners();
  // }
}
