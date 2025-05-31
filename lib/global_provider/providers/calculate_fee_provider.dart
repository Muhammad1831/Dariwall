import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/global_provider/data/model/calculate_fee_model.dart';
import 'package:dariwall/global_provider/domain/usecase/calculate_fee_usecase.dart';
import 'package:flutter/cupertino.dart';

enum CalculateFeeStatus {
  initial,
  loading,
  success,
  error,
}

class CalculateFeeProvider extends ChangeNotifier {
  final CalculateFeeUsecase calculateFeeUsecase;

  CalculateFeeProvider({required this.calculateFeeUsecase});

  CalculateFeeStatus _status = CalculateFeeStatus.initial;
  late CalculateFeeModel _calculateFeeModel;

  CalculateFeeStatus get status => _status;
  CalculateFeeModel get calculateFeeModel => _calculateFeeModel;

  Future<void> calculateFee({required CalculateFeeParamModel param}) async {
    _status = CalculateFeeStatus.loading;
    notifyListeners();

    final response = await calculateFeeUsecase.call(param: param);

    response.fold((l) {
      _status = CalculateFeeStatus.error;
      SnackBarService.show(status: SnackBarStatus.error, message: l.message);
    }, (r) {
      _status = CalculateFeeStatus.success;
      _calculateFeeModel = r;
    });

    notifyListeners();
  }
}
