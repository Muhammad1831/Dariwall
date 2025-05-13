import 'package:equatable/equatable.dart';

class MyBalancesEntity extends Equatable {
  final List<BalancesEntity>? balances;
  final TotalBalanceEntity totalBalance;

  const MyBalancesEntity({required this.balances, required this.totalBalance});

  @override
  List<Object?> get props => [balances, totalBalance];
}

class BalancesEntity extends Equatable {
  final CurrencyInfoEntity currencyInfo;
  final double amount;
  final double valueUsd;
  final double valueIrt;

  const BalancesEntity(
      {required this.currencyInfo,
      required this.amount,
      required this.valueUsd,
      required this.valueIrt});

  @override
  List<Object?> get props => [currencyInfo, amount, valueUsd, valueIrt];
}

class CurrencyInfoEntity extends Equatable {
  final String currencyCode;
  final String currencyEnName;
  final String currencyFaName;
  final String? currencyIcon;

  const CurrencyInfoEntity(
      {required this.currencyCode,
      required this.currencyEnName,
      required this.currencyFaName,
      this.currencyIcon});

  @override
  List<Object?> get props => [currencyCode, currencyEnName, currencyFaName, currencyIcon];
}

class TotalBalanceEntity extends Equatable {
  final double valueUsd;
  final double valueIrt;

  const TotalBalanceEntity({required this.valueUsd, required this.valueIrt});

  @override
  List<Object?> get props => [valueUsd, valueIrt];
}
