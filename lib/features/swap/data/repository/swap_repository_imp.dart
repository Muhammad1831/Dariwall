import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/swap/data/datasource/swap_data_source.dart';
import 'package:dariwall/features/swap/data/model/swap_param_model.dart';
import 'package:dariwall/features/swap/domain/repository/swap_repository.dart';

class SwapRepositoryImp extends SwapRepository {
  final SwapDataSource swapDataSource;

  SwapRepositoryImp({required this.swapDataSource});

  @override
  Future<Either<AppException, void>> swap({required SwapParamModel param}) async {
    try {
      await swapDataSource.swap(param: param);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
