import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/deposit_transactions_entity.dart';

class DepositTransactionsModel extends DepositTransactionsEntity {
  DepositTransactionsModel({
    required super.transactionType,
    required super.status,
    required super.createdAt,
    required super.createdDay,
    required super.updatedAt,
    required super.fee,
    super.description,
    required super.account,
    required super.currencyInfo,
    required super.amount,
    required super.source,
    super.sourceAddress,
  });

  factory DepositTransactionsModel.fromJson(Map<String, dynamic> json) {
    return DepositTransactionsModel(
      transactionType: json[AppKeys.keyTransactionType],
      status: json[AppKeys.keyStatus],
      createdAt: json[AppKeys.keyCreatedAt],
      createdDay: json[AppKeys.keyCreatedDay],
      updatedAt: json[AppKeys.keyUpdatedAt],
      fee: json[AppKeys.keyFee],
      description: json[AppKeys.keyDescription],
      account: json[AppKeys.keyAccount],
      currencyInfo: CurrencyInfoEntity(
        currencyCode: json[AppKeys.keyCurrencyInfo][AppKeys.keyCurrencyCode],
        currencyEnName: json[AppKeys.keyCurrencyInfo][AppKeys.keyCurrencyEnName],
        currencyFaName: json[AppKeys.keyCurrencyInfo][AppKeys.keyCurrencyFaName],
        currencyIcon: json[AppKeys.keyCurrencyInfo][AppKeys.keyCurrencyIcon],
      ),
      amount: (json[AppKeys.keyAmount] as num).toDouble(),
      source: json[AppKeys.keySource],
      sourceAddress: json[AppKeys.keySourceAddress],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyTransactionType: transactionType,
      AppKeys.keyStatus: status,
      AppKeys.keyCreatedAt: createdAt,
      AppKeys.keyCreatedDay: createdDay,
      AppKeys.keyUpdatedAt: updatedAt,
      AppKeys.keyFee: fee,
      AppKeys.keyDescription: description,
      AppKeys.keyAccount: account,
      AppKeys.keyCurrencyInfo: currencyInfo.toJson(),
      AppKeys.keyAmount: amount,
      AppKeys.keySource: source,
      AppKeys.keySourceAddress: sourceAddress,
    };
  }
}
