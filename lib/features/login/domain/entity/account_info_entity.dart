import 'package:dariwall/core/constant/app_keys.dart';

class AccountInfoEntity {
  const AccountInfoEntity({
    this.referralCode,
    this.solanaWalletAddress,
    this.email,
    this.name,
    this.accountImage,
    this.dateJoined,
    this.lastLogin,
    // this.telegramConnectionLink,
  });

  final String? referralCode;
  final String? solanaWalletAddress;
  final String? email;
  final String? name;
  final String? accountImage;
  final String? dateJoined;
  final String? lastLogin;
  // final TelegramConnectionLink? telegramConnectionLink;
}

class TelegramConnectionLink {
  final String link;
  final bool joined;

  TelegramConnectionLink({required this.link, required this.joined});

  factory TelegramConnectionLink.fromJson(dynamic json) {
    return TelegramConnectionLink(
      link: json[AppKeys.link],
      joined: json[AppKeys.joined],
    );
  }
}
