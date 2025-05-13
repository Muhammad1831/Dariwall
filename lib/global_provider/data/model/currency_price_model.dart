import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/global_provider/data/model/currency_info_model.dart';

class CurrencyPriceModel {
  final CurrencyInfoModel currencyInfo;
  final double price;

  CurrencyPriceModel({required this.currencyInfo, required this.price});

  factory CurrencyPriceModel.fromJson(Map<String, dynamic> json) {
    return CurrencyPriceModel(
      currencyInfo: CurrencyInfoModel.fromJson(json[AppKeys.keyCurrencyInfo]),
      price: json[AppKeys.keyPrice],
    );
  }
}
