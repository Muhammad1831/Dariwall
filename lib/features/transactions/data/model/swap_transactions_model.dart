import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/transactions/data/model/currency_info_model.dart';
import 'package:dariwall/features/transactions/domain/entity/swap_transactions_entity.dart';

class SwapTransactionsModel extends SwapTransactionsEntity {
  SwapTransactionsModel({
    required super.transactionType,
    required super.status,
    required super.createdAt,
    required super.createdDay,
    required super.updatedAt,
    required super.fee,
    super.description,
    required super.sourceCurrencyInfo,
    required super.sourceAmount,
    required super.targetCurrencyInfo,
    required super.targetAmount,
    required super.finalTargetAmount,
    required super.account,
    required super.destinationAddress,
  });

  factory SwapTransactionsModel.fromJson(Map<String, dynamic> json) {
    return SwapTransactionsModel(
      transactionType: json[AppKeys.keyTransactionType],
      status: json[AppKeys.keyStatus],
      createdAt: json[AppKeys.keyCreatedAt],
      createdDay: json[AppKeys.keyCreatedDay],
      updatedAt: json[AppKeys.keyUpdatedAt],
      fee: json[AppKeys.keyFee],
      description: json[AppKeys.keyDescription],
      sourceCurrencyInfo: CurrencyInfoModel.fromJson(json[AppKeys.keySourceCurrencyInfo]),
      sourceAmount: (json[AppKeys.keySourceAmount] as num).toDouble(),
      targetCurrencyInfo: CurrencyInfoModel.fromJson(json[AppKeys.keyTargetCurrencyInfo]),
      targetAmount: (json[AppKeys.keyTargetAmount] as num).toDouble(),
      finalTargetAmount: (json[AppKeys.keyFinalTargetAmount] as num).toDouble(),
      account: json[AppKeys.keyAccount],
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
      AppKeys.keySourceCurrencyInfo: sourceCurrencyInfo.toJson(),
      AppKeys.keySourceAmount: sourceAmount,
      AppKeys.keyTargetCurrencyInfo: targetCurrencyInfo.toJson(),
      AppKeys.keyTargetAmount: targetAmount,
      AppKeys.keyFinalTargetAmount: finalTargetAmount,
      AppKeys.keyAccount: account,
    };
  }
}
