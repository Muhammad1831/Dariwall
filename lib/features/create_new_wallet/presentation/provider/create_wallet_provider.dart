import 'package:flutter/material.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/create_new_wallet/domain/entity/create_wallet_entity.dart';
import 'package:dariwall/features/create_new_wallet/domain/usecase/create_wallet_usecase.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';

enum CreateWalletStatus { initial, loading, success, error }

class CreateWalletProvider with ChangeNotifier {
  final CreateWalletUsecase createWalletUsecase;

  CreateWalletProvider({required this.createWalletUsecase});

  CreateWalletStatus _status = CreateWalletStatus.initial;
  CreateWalletEntity? _wallet;

  CreateWalletStatus get status => _status;
  CreateWalletEntity? get wallet => _wallet;

  Future<void> createWallet(String name, String referralCode) async {
    _status = CreateWalletStatus.loading;
    _wallet = null;
    notifyListeners();

    final result = await createWalletUsecase.createWallet(name, referralCode);
    result.fold(
      (left) {
        _status = CreateWalletStatus.error;
        SnackBarService.show(status: SnackBarStatus.error, message: left.message);
      },
      (right) async {
        _status = CreateWalletStatus.success;
        _wallet = right;
        await getIt<GetUserAccountInfoProvider>().getUserAccountInfo();
      },
    );
    notifyListeners();
  }
}
