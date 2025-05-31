import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/transactions/data/model/currency_info_model.dart';
import 'package:dariwall/features/transactions/domain/entity/transfer_transactions_entity.dart';

class TransferTransactionsModel extends TransferTransactionsEntity {
  TransferTransactionsModel({
    required super.transactionType,
    required super.status,
    required super.createdAt,
    required super.createdDay,
    required super.updatedAt,
    required super.fee,
    super.description,
    required super.senderAddress,
    required super.recipientAddress,
    required super.currencyInfo,
    required super.amount,
    required super.finalAmount,
  });

  factory TransferTransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransferTransactionsModel(
      transactionType: json[AppKeys.keyTransactionType],
      status: json[AppKeys.keyStatus],
      createdAt: json[AppKeys.keyCreatedAt],
      createdDay: json[AppKeys.keyCreatedDay],
      updatedAt: json[AppKeys.keyUpdatedAt],
      fee: json[AppKeys.keyFee],
      description: json[AppKeys.keyDescription],
      senderAddress: json[AppKeys.keySenderAddress],
      recipientAddress: json[AppKeys.keyRecipientAddress],
      currencyInfo: CurrencyInfoModel.fromJson(json[AppKeys.keyCurrencyInfo]),
      amount: (json[AppKeys.keyAmount] as num).toDouble(),
      finalAmount: (json[AppKeys.keyFinalAmount] as num).toDouble(),
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
      AppKeys.keySenderAddress: senderAddress,
      AppKeys.keyRecipientAddress: recipientAddress,
      AppKeys.keyCurrencyInfo: currencyInfo.toJson(),
      AppKeys.keyAmount: amount,
      AppKeys.keyFinalAmount: finalAmount,
    };
  }
}
