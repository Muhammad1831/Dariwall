import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/global_entity/currency_info_entity.dart';

class CurrencyInfoModel extends CurrencyInfoEntity {
  const CurrencyInfoModel({
    required super.currencyCode,
    required super.currencyEnName,
    required super.currencyFaName,
    super.currencyIcon,
  });

  factory CurrencyInfoModel.fromJson(Map<String, dynamic> json) {
    return CurrencyInfoModel(
      currencyCode: json[AppKeys.keyCurrencyCode],
      currencyEnName: json[AppKeys.keyCurrencyEnName],
      currencyFaName: json[AppKeys.keyCurrencyFaName],
      currencyIcon: json[AppKeys.keyCurrencyIcon],
    );
  }
}
