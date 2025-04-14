import 'package:ostad/features/create_new_wallet/domain/entity/new_wallet_entity.dart';

abstract class CreateWalletRepository {
  Future<void> sendPhoneNumberAndReferralCode(String phoneNumber, String? referralCode);
  Future<void> checkOtpCode(String phoneNumber);
  Future<RecoveryPhraseEntity> setPassword(String password);
}
