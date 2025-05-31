import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/global_provider/data/model/calculate_source_target_value_model.dart';
import 'package:dariwall/global_provider/domain/usecase/calculate_source_target_value_usecase.dart';
import 'package:flutter/cupertino.dart';

enum CalculateSourceTargetValueStatus {
  initial,
  loading,
  success,
  error,
}

class CalculateSourceTargetValueProvider extends ChangeNotifier {
  final CalculateSourceTargetValueUsecase calculateSourceTargetValueUsecase;

  CalculateSourceTargetValueProvider({required this.calculateSourceTargetValueUsecase});

  CalculateSourceTargetValueStatus _status = CalculateSourceTargetValueStatus.initial;
  CalculateSourceTargetValueModel? _calculateSourceTargetValueModel;

  CalculateSourceTargetValueStatus get status => _status;
  CalculateSourceTargetValueModel? get calculateSourceTargetValueModel =>
      _calculateSourceTargetValueModel;

  Future<void> calculateSourceTargetValue(
      {required CalculateSourceTargetValueParameterModel param}) async {
    _status = CalculateSourceTargetValueStatus.loading;
    notifyListeners();

    final response = await calculateSourceTargetValueUsecase.call(param: param);

    response.fold((l) {
      _status = CalculateSourceTargetValueStatus.error;
      SnackBarService.show(status: SnackBarStatus.error, message: l.message);
    }, (r) {
      _status = CalculateSourceTargetValueStatus.success;
      _calculateSourceTargetValueModel = r;
    });

    notifyListeners();
  }
}
