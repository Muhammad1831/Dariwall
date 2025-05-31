import 'package:dariwall/core/constant/app_keys.dart';

class CalculateSourceTargetValueModel {
  double targetAmount;
  double targetAmountUSDT;

  CalculateSourceTargetValueModel({required this.targetAmount, required this.targetAmountUSDT});

  factory CalculateSourceTargetValueModel.fromJson(dynamic json) {
    return CalculateSourceTargetValueModel(
      targetAmount: json[AppKeys.keyTargetAmount],
      targetAmountUSDT: json[AppKeys.keyTargetAmountUSDT],
    );
  }
}

class CalculateSourceTargetValueParameterModel {
  double sourceAmount;
  String sourceCurrencyCode;
  String targetCurrencyCode;

  CalculateSourceTargetValueParameterModel({
    required this.sourceAmount,
    required this.sourceCurrencyCode,
    required this.targetCurrencyCode,
  });

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keySourceAmount: sourceAmount,
      AppKeys.keySourceCurrencyCode: sourceCurrencyCode,
      AppKeys.keyTargetCurrencyCode: targetCurrencyCode,
    };
  }
}
