import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/gift_code_page/data/model/gift_type_model.dart';
import 'package:dariwall/features/gift_code_page/domain/entity/gift_code_entity.dart';

class GiftCodeModel extends GiftCodeEntity with EquatableMixin {
  GiftCodeModel({
    required super.accountId,
    required super.amount,
    required super.code,
    required super.currencyInfo,
    required super.giftType,
  });

  factory GiftCodeModel.fromJson(dynamic json) {
    return GiftCodeModel(
      accountId: json[AppKeys.keyAccountId],
      amount: json[AppKeys.keyAmount],
      code: json[AppKeys.keyCode],
      currencyInfo: CurrencyInfoEntity(
        currencyCode: json[AppKeys.keyCurrencyInfo][AppKeys.keyCurrencyCode],
        currencyEnName: json[AppKeys.keyCurrencyInfo][AppKeys.keyCurrencyEnName],
        currencyFaName: json[AppKeys.keyCurrencyInfo][AppKeys.keyCurrencyFaName],
        currencyIcon: json[AppKeys.keyCurrencyInfo][AppKeys.keyCurrencyIcon],
      ),
      giftType: GiftTypeModel.fromJson(json[AppKeys.keyGiftType]),
    );
  }

  @override
  List<Object?> get props => [accountId, amount, code, currencyInfo, giftType];
}
