import 'package:flutter/foundation.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';
import 'package:dariwall/features/user_account/domain/usecase/change_user_account_usecase.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';

enum UserAccountNameStatus {
  initial,
  loading,
  success,
  error,
}

class ChangeUserAccountNameProvider extends ChangeNotifier {
  final ChangeUserAccountUsecase changeUserAccountUsecase;

  ChangeUserAccountNameProvider({required this.changeUserAccountUsecase});

  UserAccountNameStatus _status = UserAccountNameStatus.initial;
  UserAccountNameStatus get status => _status;

  Future<void> changeUserName(String userName) async {
    _status = UserAccountNameStatus.loading;
    notifyListeners();

    final response = await changeUserAccountUsecase.call(AccountInfoEntity(name: userName));

    response.fold(
      (l) {
        _status = UserAccountNameStatus.error;
        SnackBarService.show(status: SnackBarStatus.error, message: l.message);
      },
      (r) async {
        _status = UserAccountNameStatus.success;
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.userNameChangedSuccessfully,
        );
        await getIt<GetUserAccountInfoProvider>().getUserAccountInfo();
      },
    );
    notifyListeners();
  }
}
