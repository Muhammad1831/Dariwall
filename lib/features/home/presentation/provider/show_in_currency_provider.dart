import 'package:flutter/material.dart';
import 'package:dariwall/features/home/presentation/page/home_page.dart';

class ShowInCurrencyProvider extends ChangeNotifier {
  ShowInCurrency _showInCurrency = ShowInCurrency.toman;
  ShowInCurrency get showInCurrency => _showInCurrency;

  void setCurrency(ShowInCurrency value) {
    _showInCurrency = value;
    notifyListeners();
  }
}
