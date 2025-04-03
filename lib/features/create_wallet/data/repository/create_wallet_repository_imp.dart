import 'package:ostad/core/services/error_handler_service.dart';
import 'package:ostad/features/create_wallet/data/datasource/create_wallet_datasource.dart';
import 'package:ostad/features/create_wallet/data/model/recovery_phrase_model.dart';
import 'package:ostad/features/create_wallet/domain/entity/new_wallet_entity.dart';
import 'package:ostad/features/create_wallet/domain/repository/create_wallet_repository.dart';

class CreateWalletRepositoryImpl implements CreateWalletRepository {
  final CreateWalletDatasource _datasource;

  CreateWalletRepositoryImpl({required CreateWalletDatasource datasource})
      : _datasource = datasource;

  @override
  Future<void> sendPhoneNumberAndReferralCode(String phoneNumber, String? referralCode) async {
    try {
      await _datasource.sendPhoneNumberAndReferralCode(phoneNumber, referralCode);
    } on AppException {
      rethrow;
    }
  }

  @override
  Future<void> checkOtpCode(String code) async {
    try {
      await _datasource.checkOtpCode(code);
    } on AppException {
      rethrow;
    }
  }

  @override
  Future<RecoveryPhraseEntity> setPassword(String password) async {
    try {
      RecoveryPhraseModel recoveryPhrase = await _datasource.setPassword(password);
      return recoveryPhrase.toEntity();
    } on AppException {
      rethrow;
    }
  }
}
