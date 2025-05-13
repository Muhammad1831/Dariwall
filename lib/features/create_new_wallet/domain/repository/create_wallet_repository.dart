import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/create_new_wallet/domain/entity/create_wallet_entity.dart';

abstract class CreateWalletRepository {
  Future<Either<AppException, CreateWalletEntity>> createWallet(String name, String referralCode);
}
