import 'package:flutter/foundation.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/invite_friends/data/model/invite_friends_model.dart';
import 'package:dariwall/features/invite_friends/domain/usecase/invite_friends_usecase.dart';

enum InviteFriendsStatus {
  initial,
  loading,
  success,
  error,
}

class InviteFriendsProvider extends ChangeNotifier {
  final InviteFriendsUsecase usecase;

  InviteFriendsProvider({required this.usecase}) {
    fetchInviteFriends();
  }

  InviteFriendsModel? _inviteFriends;
  InviteFriendsModel? get inviteFriends => _inviteFriends;

  InviteFriendsStatus _status = InviteFriendsStatus.initial;
  InviteFriendsStatus get status => _status;

  Future<void> fetchInviteFriends() async {
    _status = InviteFriendsStatus.loading;
    notifyListeners();
    final result = await usecase.call();
    result.fold(
      (l) {
        SnackBarService.show(status: SnackBarStatus.error, message: l.message);
        _status = InviteFriendsStatus.error;
      },
      (r) {
        _inviteFriends = r;
        _status = InviteFriendsStatus.success;
      },
    );
    notifyListeners();
  }
}
