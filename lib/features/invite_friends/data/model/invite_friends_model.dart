import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/invite_friends/domain/entity/invite_friends_entity.dart';

class InviteFriendsModel extends InviteFriendsEntity {
  const InviteFriendsModel({
    required super.invitedAccounts,
    required super.count,
    required super.successfulCount,
    required super.nextInviteRewardUSDT,
    required super.totalReward,
  });

  factory InviteFriendsModel.fromJson(Map<String, dynamic> json) {
    return InviteFriendsModel(
      invitedAccounts: json[AppKeys.keyInvitedAccounts] == null
          ? []
          : (json[AppKeys.keyInvitedAccounts] as List)
              .map((e) => InvitedAccountModel.fromJson(e))
              .toList(),
      count: json[AppKeys.keyCount],
      successfulCount: json[AppKeys.keySuccessfulCount],
      nextInviteRewardUSDT: json[AppKeys.keyNextInviteRewardUSDT],
      totalReward: json[AppKeys.keyTotalReward],
    );
  }
}

class InvitedAccountModel extends InvitedAccountEntity {
  const InvitedAccountModel({
    required super.name,
    required super.dateJoined,
  });

  factory InvitedAccountModel.fromJson(Map<String, dynamic> json) {
    return InvitedAccountModel(
      name: json[AppKeys.keyName],
      dateJoined: json[AppKeys.keyDateJoined],
    );
  }
}
