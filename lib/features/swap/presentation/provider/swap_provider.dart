import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/home/domain/entity/balances_entity.dart';
import 'package:dariwall/features/home/presentation/provider/my_balances_provider.dart';
import 'package:dariwall/features/swap/data/model/swap_param_model.dart';
import 'package:dariwall/features/swap/domain/usecase/swap_usecase.dart';
import 'package:flutter/material.dart';

enum SwapStatus { initial, loading, success, error }

class SwapProvider extends ChangeNotifier {
  final SwapUsecase swapUsecase;

  SwapProvider({required this.swapUsecase});

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  SwapStatus _status = SwapStatus.initial;
  BalancesEntity? _fromToken;
  BalancesEntity? _toToken;

  SwapStatus get status => _status;
  BalancesEntity? get toToken => _toToken;
  BalancesEntity? get fromToken => _fromToken;

  TextEditingController get fromController => _fromController;
  TextEditingController get toController => _toController;

  Future<void> swap({required SwapParamModel param}) async {
    _status = SwapStatus.loading;
    notifyListeners();

    final response = await swapUsecase.call(param: param);

    response.fold(
      (left) {
        _status = SwapStatus.error;
        SnackBarService.show(status: SnackBarStatus.error, message: left.message);
      },
      (right) async {
        _status = SwapStatus.success;
        SnackBarService.show(
            status: SnackBarStatus.success, message: AppMessage.swapDoneSuccessfuly);
        await getIt<MyBalancesProvider>().getMyBalances();
      },
    );
    notifyListeners();
  }

  void selectedFromToken(BalancesEntity fromToken) {
    _fromToken = fromToken;
    notifyListeners();
  }

  void selectedToToken(BalancesEntity toToken) {
    _toToken = toToken;
    notifyListeners();
  }
}
