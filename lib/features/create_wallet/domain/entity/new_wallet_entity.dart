import 'package:equatable/equatable.dart';

class RecoveryPhraseEntity extends Equatable {
  final String access;
  final String refresh;
  final int userId;
  final String username;
  final String phoneNumber;
  final List<String> mnemonic;

  const RecoveryPhraseEntity({
    required this.access,
    required this.refresh,
    required this.userId,
    required this.username,
    required this.phoneNumber,
    required this.mnemonic,
  });

  @override
  List<Object?> get props => [access, refresh, userId, username, phoneNumber, mnemonic];
}
