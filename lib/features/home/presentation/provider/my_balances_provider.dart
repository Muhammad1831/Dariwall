import 'package:flutter/material.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/home/data/model/my_balances_model.dart';
import 'package:dariwall/features/home/domain/usecase/my_balances_usecase.dart';

enum MyBalancesStatus {
  initial,
  loading,
  loaded,
  error,
}

class MyBalancesProvider extends ChangeNotifier {
  final MyBalancesUsecase myBalancesUsecase;

  MyBalancesProvider({required this.myBalancesUsecase});

  MyBalancesModel? _myBalances;
  MyBalancesStatus _status = MyBalancesStatus.initial;

  MyBalancesModel? get myBalances => _myBalances;
  MyBalancesStatus get status => _status;

  Future<void> getMyBalances() async {
    _status = MyBalancesStatus.loading;
    notifyListeners();
    final result = await myBalancesUsecase.call();
    result.fold(
      (l) {
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
        _status = MyBalancesStatus.error;
      },
      (r) {
        _myBalances = r;
        _status = MyBalancesStatus.loaded;
      },
    );
    notifyListeners();
  }

  void reset() {
    _myBalances = null;
    _status = MyBalancesStatus.initial;
    notifyListeners();
  }
}
