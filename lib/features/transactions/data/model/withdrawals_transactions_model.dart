import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/withdrawals_transactions_entity.dart';

class WithdrawalsTransactionsModel extends WithdrawalsTransactionsEntity {
  WithdrawalsTransactionsModel({
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
    required super.finalAmount,
    super.destinationAddress,
  });

  factory WithdrawalsTransactionsModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalsTransactionsModel(
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
      finalAmount: (json[AppKeys.keyFinalAmount] as num).toDouble(),
      destinationAddress: json[AppKeys.keyDestinationAddress],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyTransactionType: transactionType,
      AppKeys.keyStatus: status,
      AppKeys.keyCreatedAt: createdAt,
      AppKeys.keyUpdatedAt: updatedAt,
      AppKeys.keyFee: fee,
      AppKeys.keyDescription: description,
      AppKeys.keyAccount: account,
      AppKeys.keyCurrencyInfo: currencyInfo.toJson(),
      AppKeys.keyAmount: amount,
      AppKeys.keyFinalAmount: finalAmount,
    };
  }
}
