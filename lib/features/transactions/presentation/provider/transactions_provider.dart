import 'package:flutter/material.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/transactions/data/model/transactions_model.dart';
import 'package:dariwall/features/transactions/domain/usecase/transactions_usecase.dart';

enum TransactionsStatus { initial, loading, success, error }

class TransactionsProvider extends ChangeNotifier {
  final TransactionsUsecase myTransactionsUsecase;

  TransactionsProvider({required this.myTransactionsUsecase});

  TransactionsStatus _status = TransactionsStatus.initial;
  List<TransactionsModel> _myTransactions = [];

  TransactionsStatus get status => _status;
  List<TransactionsModel> get mytransactions => _myTransactions;

  Future<void> getTransactions() async {
    _status = TransactionsStatus.loading;
    notifyListeners();

    final result = await myTransactionsUsecase.call();

    result.fold((l) {
      SnackBarService.show(status: SnackBarStatus.error, message: l.message);
      _status = TransactionsStatus.error;
    }, (r) {
      _myTransactions = r;
      _status = TransactionsStatus.success;
    });

    notifyListeners();
  }

  void reset() {
    _myTransactions = [];
    _status = TransactionsStatus.initial;
    notifyListeners();
  }
}
