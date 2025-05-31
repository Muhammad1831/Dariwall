import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/send/data/datasource/transfer_data_source.dart';
import 'package:dariwall/features/send/data/model/transfer_param_model.dart';
import 'package:dariwall/features/send/domain/repository/transfer_repository.dart';

class TransferRepositoryImp extends TransferRepository {
  final TransferDataSource transferDataSource;

  TransferRepositoryImp({required this.transferDataSource});

  @override
  Future<Either<AppException, void>> transfer({required TransferParamModel param}) async {
    try {
      await transferDataSource.transfer(param: param);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
