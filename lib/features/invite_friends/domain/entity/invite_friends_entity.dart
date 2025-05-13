import 'package:equatable/equatable.dart';

class InviteFriendsEntity extends Equatable {
  final List<InvitedAccountEntity> invitedAccounts;
  final int count;
  final int successfulCount;
  final dynamic nextInviteRewardUSDT;
  final dynamic totalReward;

  const InviteFriendsEntity({
    required this.invitedAccounts,
    required this.count,
    required this.successfulCount,
    required this.nextInviteRewardUSDT,
    required this.totalReward,
  });

  @override
  List<Object?> get props => [invitedAccounts, count, nextInviteRewardUSDT, totalReward];
}

class InvitedAccountEntity extends Equatable {
  final String name;
  final String dateJoined;

  const InvitedAccountEntity({
    required this.name,
    required this.dateJoined,
  });

  @override
  List<Object?> get props => [name, dateJoined];
}
