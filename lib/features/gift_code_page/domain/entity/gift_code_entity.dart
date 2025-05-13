import 'package:equatable/equatable.dart';
import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/gift_code_page/domain/entity/gift_type_entity.dart';

class GiftCodeEntity extends Equatable {
  final GiftTypeEntity giftType;
  final int accountId;
  final CurrencyInfoEntity currencyInfo;
  final double amount;
  final String code;

  const GiftCodeEntity({
    required this.giftType,
    required this.accountId,
    required this.currencyInfo,
    required this.amount,
    required this.code,
  });

  @override
  List<Object?> get props => [giftType, accountId, currencyInfo, amount, code];
}
