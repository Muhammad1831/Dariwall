import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';
import 'package:dariwall/features/user_account/domain/usecase/change_user_account_usecase.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';

enum SolanaAddressWalletStatus {
  initial,
  loading,
  success,
  error,
}

class SolanaAddressWalletProvider extends ChangeNotifier {
  final ChangeUserAccountUsecase changeUserAccountUsecase;

  SolanaAddressWalletProvider({required this.changeUserAccountUsecase});

  SolanaAddressWalletStatus _status = SolanaAddressWalletStatus.initial;

  SolanaAddressWalletStatus get status => _status;

  Future<void> changeSolanaAddressWallet(String solanaAddressWallet) async {
    _status = SolanaAddressWalletStatus.loading;
    notifyListeners();

    final response = await changeUserAccountUsecase.call(AccountInfoEntity(
      solanaWalletAddress: solanaAddressWallet,
      name: null,
      userImage: null,
    ));

    response.fold(
      (l) {
        SnackBarService.show(status: SnackBarStatus.error, message: l.message);
        _status = SolanaAddressWalletStatus.error;
        notifyListeners();
      },
      (r) async {
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.solanaAddressWalletChangedSuccessfully,
        );
        _status = SolanaAddressWalletStatus.success;
        notifyListeners();
        await getIt<GetUserAccountInfoProvider>().getUserAccountInfo();
      },
    );
  }
}
