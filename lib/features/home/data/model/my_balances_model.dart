import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/home/domain/entity/balances_entity.dart';

class MyBalancesModel extends MyBalancesEntity with EquatableMixin {
  MyBalancesModel({
    required super.balances,
    required super.totalBalance,
  });

  factory MyBalancesModel.fromJson(Map<String, dynamic> json) {
    return MyBalancesModel(
      balances: json[AppKeys.keyBalances] == null
          ? []
          : (json[AppKeys.keyBalances] as List).map((e) => BalancesModel.fromJson(e)).toList(),
      totalBalance: TotalBalanceModel.fromJson(json[AppKeys.keyTotalBalance]),
    );
  }

  @override
  List<Object?> get props => [balances, totalBalance];
}

class BalancesModel extends BalancesEntity with EquatableMixin {
  BalancesModel(
      {required super.currencyInfo,
      required super.amount,
      required super.valueUsd,
      required super.valueIrt});

  factory BalancesModel.fromJson(Map<String, dynamic> json) {
    return BalancesModel(
      currencyInfo: CurrencyInfoModel.fromJson(json[AppKeys.keyCurrencyInfo]),
      amount: json[AppKeys.keyAmount],
      valueUsd: json[AppKeys.keyValueUsd],
      valueIrt: json[AppKeys.keyValueIrt],
    );
  }

  @override
  List<Object?> get props => [currencyInfo, amount, valueUsd, valueIrt];
}

class TotalBalanceModel extends TotalBalanceEntity with EquatableMixin {
  TotalBalanceModel({required super.valueUsd, required super.valueIrt});

  factory TotalBalanceModel.fromJson(Map<String, dynamic> json) {
    return TotalBalanceModel(
      valueUsd: (json[AppKeys.keyValueUsd] as num).toDouble(),
      valueIrt: (json[AppKeys.keyValueIrt] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [valueUsd, valueIrt];
}

class CurrencyInfoModel extends CurrencyInfoEntity with EquatableMixin {
  CurrencyInfoModel({
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

  @override
  List<Object?> get props => [currencyCode, currencyEnName, currencyFaName, currencyIcon];
}
