import 'package:dariwall/core/constant/app_keys.dart';

class SwapParamModel {
  String sourceCurrencyCode;
  String targetCurrencyCode;
  double amount;

  SwapParamModel({
    required this.amount,
    required this.sourceCurrencyCode,
    required this.targetCurrencyCode,
  });

  factory SwapParamModel.fromJson(dynamic json) {
    return SwapParamModel(
      amount: json[AppKeys.keyAmount],
      sourceCurrencyCode: json[AppKeys.keySourceCurrencyCode],
      targetCurrencyCode: json[AppKeys.keyTargetCurrencyCode],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keySourceCurrencyCode: sourceCurrencyCode,
      AppKeys.keyTargetCurrencyCode: targetCurrencyCode,
      AppKeys.keyAmount: amount,
    };
  }
}
