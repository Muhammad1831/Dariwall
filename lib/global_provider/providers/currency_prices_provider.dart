import 'package:flutter/cupertino.dart';
import 'package:dariwall/global_provider/data/model/currency_price_model.dart';
import 'package:dariwall/global_provider/domain/usecase/currency_prices_usecase.dart';

enum CurrencyPricesState {
  initial,
  loading,
  success,
  error,
}

class CurrencyPricesProvider extends ChangeNotifier {
  final CurrencyPricesUsecase currencyPricesUsecase;

  CurrencyPricesProvider({required this.currencyPricesUsecase}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrencyPrices();
    });
  }

  CurrencyPricesState _state = CurrencyPricesState.initial;
  List<CurrencyPriceModel> _currencyPrices = [];
  CurrencyPriceModel? _currencyPrice;

  CurrencyPricesState get state => _state;
  List<CurrencyPriceModel> get currencyPrices => _currencyPrices;
  CurrencyPriceModel? get currencyPrice => _currencyPrice;

  Future<void> getCurrencyPrices() async {
    _state = CurrencyPricesState.loading;
    notifyListeners();
    final result = await currencyPricesUsecase.call(null);
    result.fold(
      (l) {
        _state = CurrencyPricesState.error;
        notifyListeners();
      },
      (r) {
        _state = CurrencyPricesState.success;
        _currencyPrices = r;
        notifyListeners();
      },
    );
  }

  Future<void> getCurrencyPrice(String currencyCode) async {
    final response = await currencyPricesUsecase.call(currencyCode);

    response.fold((left) {
      return _state = CurrencyPricesState.error;
    }, (r) {
      return _currencyPrice = r.first;
    });

    notifyListeners();
  }

  void reset() {
    _currencyPrices = [];
    _currencyPrice = null;
    _state = CurrencyPricesState.initial;
    notifyListeners();
  }
}
