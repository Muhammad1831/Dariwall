class AccountInfoEntity {
  const AccountInfoEntity({
    this.referralCode,
    this.solanaWalletAddress,
    this.email,
    this.name,
    this.userImage,
    this.dateJoined,
    this.lastLogin,
  });

  final String? referralCode;
  final String? solanaWalletAddress;
  final String? email;
  final String? name;
  final String? userImage;
  final String? dateJoined;
  final String? lastLogin;
}
