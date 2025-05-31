import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/send/data/model/transfer_param_model.dart';
import 'package:dariwall/features/send/domain/usecase/transfer_usecase.dart';
import 'package:flutter/material.dart';

enum TransferStatus { initial, loading, success, error }

class TransferProvider extends ChangeNotifier {
  final TransferUsecase transferUsecase;

  TransferProvider({required this.transferUsecase});

  TransferStatus _status = TransferStatus.initial;

  TransferStatus get status => _status;

  Future<void> transfer({required TransferParamModel param}) async {
    _status = TransferStatus.loading;
    notifyListeners();

    final response = await transferUsecase.call(param: param);

    response.fold(
      (left) {
        SnackBarService.show(status: SnackBarStatus.error, message: left.message);
        _status = TransferStatus.error;
      },
      (right) {
        SnackBarService.show(status: SnackBarStatus.success, message: AppMessage.transferSuccess);
        _status = TransferStatus.success;
      },
    );
    notifyListeners();
  }
}
