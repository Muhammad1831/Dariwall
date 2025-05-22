import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';

class AccountInfoModel extends AccountInfoEntity with EquatableMixin {
  const AccountInfoModel({
    required super.referralCode,
    required super.solanaWalletAddress,
    required super.email,
    required super.name,
    required super.accountImage,
    required super.telegramConnectionLink,
    // required super.dateJoined,
    // required super.lastLogin,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    return AccountInfoModel(
      referralCode: json[AppKeys.keyReferralCode],
      solanaWalletAddress: json[AppKeys.keySolanaWalletAddress],
      email: json[AppKeys.keyEmail],
      name: json[AppKeys.keyName],
      accountImage: json[AppKeys.keyAccountImage],
      telegramConnectionLink: json[AppKeys.keyTelegramConnectionLink],
      //TODO: add dateJoined and lastLogin
      // dateJoined: DateTime.parse(json[AppKeys.keyDateJoined]),
      // lastLogin: DateTime.parse(json[AppKeys.keyLastLogin]),
    );
  }

  AccountInfoEntity toEntity() {
    return AccountInfoEntity(
      referralCode: referralCode,
      solanaWalletAddress: solanaWalletAddress,
      email: email,
      name: name,
      accountImage: accountImage,
      telegramConnectionLink: telegramConnectionLink,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyReferralCode: referralCode,
      AppKeys.keySolanaWalletAddress: solanaWalletAddress,
      AppKeys.keyEmail: email,
      AppKeys.keyName: name,
      AppKeys.keyAccountImage: accountImage,
      AppKeys.keyTelegramConnectionLink: telegramConnectionLink,
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
      accountImage: accountImage ?? accountImage,
      telegramConnectionLink: telegramConnectionLink ?? telegramConnectionLink,
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
        accountImage,
        dateJoined,
        lastLogin,
      ];
}
