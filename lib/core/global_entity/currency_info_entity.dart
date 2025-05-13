import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';

class CurrencyInfoEntity extends Equatable {
  final String currencyCode;
  final String currencyEnName;
  final String currencyFaName;
  final String? currencyIcon;

  const CurrencyInfoEntity({
    required this.currencyCode,
    required this.currencyEnName,
    required this.currencyFaName,
    this.currencyIcon,
  });

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyCurrencyCode: currencyCode,
      AppKeys.keyCurrencyEnName: currencyEnName,
      AppKeys.keyCurrencyFaName: currencyFaName,
      AppKeys.keyCurrencyIcon: currencyIcon,
    };
  }

  @override
  List<Object?> get props => [currencyCode, currencyEnName, currencyFaName, currencyIcon];
}
