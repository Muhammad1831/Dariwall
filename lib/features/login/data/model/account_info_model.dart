import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';

class AccountInfoModel extends AccountInfoEntity with EquatableMixin {
  const AccountInfoModel({
    required super.referralCode,
    required super.solanaWalletAddress,
    required super.email,
    required super.name,
    required super.userImage,
    // required super.dateJoined,
    // required super.lastLogin,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    return AccountInfoModel(
      referralCode: json[AppKeys.keyReferralCode],
      solanaWalletAddress: json[AppKeys.keySolanaWalletAddress],
      email: json[AppKeys.keyEmail],
      name: json[AppKeys.keyName],
      userImage: json[AppKeys.keyAccountImage],
      //TODO: add dateJoined and lastLogin
      // dateJoined: DateTime.parse(json[AppKeys.keyDateJoined]),
      // lastLogin: DateTime.parse(json[AppKeys.keyLastLogin]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyReferralCode: referralCode,
      AppKeys.keySolanaWalletAddress: solanaWalletAddress,
      AppKeys.keyEmail: email,
      AppKeys.keyName: name,
      AppKeys.keyAccountImage: userImage,
      // AppKeys.keyDateJoined: dateJoined.toIso8601String(),
      // AppKeys.keyLastLogin: lastLogin.toIso8601String(),
    };
  }

  AccountInfoModel copyWith({
    String? referralCode,
    String? solanaWalletAddress,
    String? email,
    String? name,
    String? userImage,
    DateTime? dateJoined,
    DateTime? lastLogin,
  }) {
    return AccountInfoModel(
      referralCode: referralCode ?? this.referralCode,
      solanaWalletAddress: solanaWalletAddress ?? this.solanaWalletAddress,
      email: email ?? this.email,
      name: name ?? this.name,
      userImage: userImage ?? this.userImage,
      // dateJoined: dateJoined ?? this.dateJoined,
      // lastLogin: lastLogin ?? this.lastLogin,D
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
