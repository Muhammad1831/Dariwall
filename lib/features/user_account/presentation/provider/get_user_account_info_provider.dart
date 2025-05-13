import 'package:flutter/foundation.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/user_account/data/model/user_account_model.dart';
import 'package:dariwall/features/user_account/domain/usecase/get_user_account_usecase.dart';

class GetUserAccountInfoProvider extends ChangeNotifier {
  final GetUserAccountInfoUsecase getUserAccountInfoUsecase;

  GetUserAccountInfoProvider({required this.getUserAccountInfoUsecase});

  UserAccountModel? _userAccountInfo;

  UserAccountModel? get userAccountInfo => _userAccountInfo;

  Future<void> getUserAccountInfo() async {
    var response = await getUserAccountInfoUsecase.call();

    response.fold(
      (left) {
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: left.message,
        );
      },
      (right) {
        _userAccountInfo = right;
        notifyListeners();
      },
    );
  }

  void reset() {
    _userAccountInfo = null;
    notifyListeners();
  }
}
