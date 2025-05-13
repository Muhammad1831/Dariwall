import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/extensions/jalali_date_extension.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';

class UserAccountModel extends AccountInfoEntity with EquatableMixin {
  const UserAccountModel({
    required super.referralCode,
    required super.solanaWalletAddress,
    required super.email,
    required super.name,
    required super.userImage,
    super.dateJoined,
    super.lastLogin,
  });

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      referralCode: json[AppKeys.keyReferralCode],
      solanaWalletAddress: json[AppKeys.keySolanaWalletAddress],
      email: json[AppKeys.keyEmail],
      name: json[AppKeys.keyName],
      userImage: json[AppKeys.keyAccountImage],
      dateJoined: (json[AppKeys.keyDateJoined] as String).toJalaliDate(),
      lastLogin: (json[AppKeys.keyLastLogin] as String).toJalaliDate(),
    );
  }

  @override
  List<Object?> get props => [
        referralCode,
        solanaWalletAddress,
        email,
        name,
        userImage,
        dateJoined,
        lastLogin,
      ];
}
