import 'package:dariwall/core/constant/app_keys.dart';

class TransferParamModel {
  String? recipientAddress;
  String currencyCode;
  double amount;

  TransferParamModel(
      {required this.amount, required this.currencyCode, required this.recipientAddress});

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyAmount: amount,
      AppKeys.keyCurrencyCode: currencyCode,
      AppKeys.keyRecipientAddress: recipientAddress,
    };
  }
}
