import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/create_new_wallet/data/datasource/create_wallet_datasource.dart';
import 'package:dariwall/features/create_new_wallet/domain/entity/create_wallet_entity.dart';
import 'package:dariwall/features/create_new_wallet/domain/repository/create_wallet_repository.dart';

class CreateWalletRepositoryImpl implements CreateWalletRepository {
  final CreateWalletDatasource _datasource;

  CreateWalletRepositoryImpl({required CreateWalletDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<AppException, CreateWalletEntity>> createWallet(
      String name, String referralCode) async {
    try {
      final createWalletModel = await _datasource.createWallet(name, referralCode);
      return Right(createWalletModel.toEntity());
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
