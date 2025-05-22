import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/create_new_wallet/domain/entity/create_wallet_entity.dart';
import 'package:dariwall/features/create_new_wallet/domain/repository/create_wallet_repository.dart';

class CreateWalletUsecase {
  final CreateWalletRepository createWalletRepository;

  CreateWalletUsecase({required this.createWalletRepository});

  Future<Either<AppException, CreateWalletEntity>> createWallet(
      String name, String? referralCode) async {
    if (name.isEmpty) {
      return Left(AppException(message: AppMessage.userNameIsRequired));
    }
    return await createWalletRepository.createWallet(name, referralCode);
  }
}
