import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/create_new_wallet/domain/entity/create_wallet_entity.dart';

class CreateWalletModel extends CreateWalletEntity with EquatableMixin {
  const CreateWalletModel({
    required super.access,
    required super.refresh,
    required super.referralCode,
    required super.solanaWalletAddress,
    required super.email,
    required super.name,
    required super.accountImage,
    required super.dateJoined,
    required super.mnemonic,
  });

  factory CreateWalletModel.fromJson(Map<String, dynamic> json) {
    return CreateWalletModel(
      access: json[AppKeys.keyAccess],
      refresh: json[AppKeys.keyRefresh],
      referralCode: json[AppKeys.keyAccountInfo][AppKeys.keyReferralCode],
      solanaWalletAddress: json[AppKeys.keyAccountInfo][AppKeys.keySolanaWalletAddress],
      email: json[AppKeys.keyAccountInfo][AppKeys.keyEmail],
      name: json[AppKeys.keyAccountInfo][AppKeys.keyName],
      accountImage: json[AppKeys.keyAccountInfo][AppKeys.keyAccountImage],
      dateJoined: json[AppKeys.keyAccountInfo][AppKeys.keyDateJoined],
      mnemonic: List<String>.from(json[AppKeys.keyMnemonic]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyAccess: access,
      AppKeys.keyRefresh: refresh,
      AppKeys.keyAccountInfo: {
        AppKeys.keyReferralCode: referralCode,
        AppKeys.keySolanaWalletAddress: solanaWalletAddress,
        AppKeys.keyEmail: email,
        AppKeys.keyName: name,
        AppKeys.keyAccountImage: accountImage,
        AppKeys.keyDateJoined: dateJoined,
      },
      AppKeys.keyMnemonic: mnemonic,
    };
  }

  CreateWalletEntity toEntity() {
    return CreateWalletEntity(
      access: access,
      refresh: refresh,
      referralCode: referralCode,
      solanaWalletAddress: solanaWalletAddress,
      email: email,
      name: name,
      accountImage: accountImage,
      dateJoined: dateJoined,
      mnemonic: mnemonic,
    );
  }

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
        mnemonic,
      ];
}
