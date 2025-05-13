import 'package:equatable/equatable.dart';

class CreateWalletEntity extends Equatable {
  final String access;
  final String refresh;
  final String referralCode;
  final String? solanaWalletAddress;
  final String? email;
  final String name;
  final String? accountImage;
  final String dateJoined;
  final String? lastLogin;
  final List<String> mnemonic;

  const CreateWalletEntity({
    required this.access,
    required this.refresh,
    required this.referralCode,
    this.solanaWalletAddress,
    this.email,
    required this.name,
    this.accountImage,
    required this.dateJoined,
    this.lastLogin,
    required this.mnemonic,
  });

  @override
  List<Object?> get props => [
        access,
        refresh,
        referralCode,
        solanaWalletAddress,
        email,
        name,
        accountImage,
        dateJoined,
        lastLogin,
        mnemonic,
      ];
}
