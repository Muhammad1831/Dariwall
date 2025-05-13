import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/home/domain/entity/balances_entity.dart';

class CurrencyInfoModel extends CurrencyInfoEntity {
  const CurrencyInfoModel({
    required super.currencyCode,
    required super.currencyEnName,
    required super.currencyFaName,
    required super.currencyIcon,
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
