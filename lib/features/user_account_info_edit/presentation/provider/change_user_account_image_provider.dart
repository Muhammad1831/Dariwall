import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';
import 'package:dariwall/features/user_account/domain/usecase/change_user_account_usecase.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';

enum UserAccountImageStatus {
  initial,
  loading,
  success,
  error,
}

class UserAccountInfoEditProvider extends ChangeNotifier {
  final ChangeUserAccountUsecase changeUserAccountUsecase;

  UserAccountImageStatus _state = UserAccountImageStatus.initial;

  UserAccountImageStatus get state => _state;
  UserAccountInfoEditProvider({required this.changeUserAccountUsecase});

  Future<void> changeUserImage(String image) async {
    _state = UserAccountImageStatus.loading;
    notifyListeners();

    final response = await changeUserAccountUsecase.call(AccountInfoEntity(accountImage: image));

    response.fold(
      (l) {
        _state = UserAccountImageStatus.error;
        SnackBarService.show(status: SnackBarStatus.error, message: l.message);
      },
      (r) async {
        _state = UserAccountImageStatus.success;
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.userImageChangedSuccessfully,
        );
        await getIt<GetUserAccountInfoProvider>().getUserAccountInfo();
      },
    );
    notifyListeners();
  }
}
