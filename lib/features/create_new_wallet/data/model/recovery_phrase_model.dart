import 'package:equatable/equatable.dart';
import 'package:ostad/core/constant/app_keys.dart';
import 'package:ostad/features/create_new_wallet/domain/entity/new_wallet_entity.dart';

class RecoveryPhraseModel extends Equatable {
  final String access;
  final String refresh;
  final int userId;
  final String username;
  final String phoneNumber;
  final List<String> mnemonic;

  const RecoveryPhraseModel({
    required this.access,
    required this.refresh,
    required this.userId,
    required this.username,
    required this.phoneNumber,
    required this.mnemonic,
  });

  factory RecoveryPhraseModel.fromJson(Map<String, dynamic> json) {
    return RecoveryPhraseModel(
      access: json[AppKeys.keyAccess],
      refresh: json[AppKeys.keyRefresh],
      userId: json[AppKeys.keyUserId],
      username: json[AppKeys.keyUsername],
      phoneNumber: json[AppKeys.keyPhoneNumber],
      mnemonic: List<String>.from(json[AppKeys.keyMnemonic]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyAccess: access,
      AppKeys.keyRefresh: refresh,
      AppKeys.keyUserId: userId,
      AppKeys.keyUsername: username,
      AppKeys.keyPhoneNumber: phoneNumber,
      AppKeys.keyMnemonic: mnemonic,
    };
  }

  RecoveryPhraseEntity toEntity() {
    return RecoveryPhraseEntity(
      access: access,
      refresh: refresh,
      userId: userId,
      username: username,
      phoneNumber: phoneNumber,
      mnemonic: mnemonic,
    );
  }

  @override
  List<Object?> get props => [access, refresh, userId, username, phoneNumber, mnemonic];
}
