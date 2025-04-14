import 'package:ostad/core/services/error_handler_service.dart';
import 'package:ostad/features/create_new_wallet/domain/entity/new_wallet_entity.dart';
import 'package:ostad/features/create_new_wallet/domain/repository/create_wallet_repository.dart';

class CreateWalletUsecase {
  final CreateWalletRepository createWalletRepository;

  CreateWalletUsecase({required this.createWalletRepository});

  Future<void> sendPhoneNumberAndReferralCode(String phoneNumber, String? referralCode) async {
    try {
      await createWalletRepository.sendPhoneNumberAndReferralCode(phoneNumber, referralCode);
    } on AppException {
      rethrow;
    }
  }

  Future<void> checkOtpCode(String phoneNumber) async {
    try {
      await createWalletRepository.checkOtpCode(phoneNumber);
    } on AppException {
      rethrow;
    }
  }

  Future<RecoveryPhraseEntity> setPassword(String password) async {
    try {
      return await createWalletRepository.setPassword(password);
    } on AppException {
      rethrow;
    }
  }
}
