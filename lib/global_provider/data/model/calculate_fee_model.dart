import 'package:dariwall/core/constant/app_keys.dart';

class CalculateFeeModel {
  String? currencyCode;
  double? amount;
  double? amountUSDT;
  double? fee;
  double? feeUSDT;
  double? finalAmount;
  double? finalAmountUSDT;

  CalculateFeeModel({
    this.currencyCode,
    this.amount,
    this.amountUSDT,
    this.fee,
    this.feeUSDT,
    this.finalAmount,
    this.finalAmountUSDT,
  });

  CalculateFeeModel.fromJson(dynamic json) {
    currencyCode = json[AppKeys.keyCurrencyCode];
    amount = json[AppKeys.keyAmount];
    amountUSDT = json[AppKeys.keyAmountUSDT];
    fee = json[AppKeys.keyFee];
    feeUSDT = json[AppKeys.keyFeeUSDT];
    finalAmount = json[AppKeys.keyFinalAmount];
    finalAmountUSDT = json[AppKeys.keyFinalAmountUSDT];
  }
}

class CalculateFeeParamModel {
  double amount;
  String currencyCode;
  String transactionType;

  CalculateFeeParamModel({
    required this.amount,
    required this.currencyCode,
    required this.transactionType,
  });

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyAmount: amount,
      AppKeys.keyCurrencyCode: currencyCode,
      AppKeys.keyTransactionType: transactionType,
    };
  }
}
