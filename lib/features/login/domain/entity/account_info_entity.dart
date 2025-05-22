class AccountInfoEntity {
  const AccountInfoEntity({
    this.referralCode,
    this.solanaWalletAddress,
    this.email,
    this.name,
    this.accountImage,
    this.dateJoined,
    this.lastLogin,
    this.telegramConnectionLink,
  });

  final String? referralCode;
  final String? solanaWalletAddress;
  final String? email;
  final String? name;
  final String? accountImage;
  final String? dateJoined;
  final String? lastLogin;
  final String? telegramConnectionLink;
}
