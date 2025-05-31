import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/datasource/calculate_source_target_value_data_source.dart';
import 'package:dariwall/global_provider/data/model/calculate_source_target_value_model.dart';
import 'package:dariwall/global_provider/domain/repository/calculate_source_target_value_repository.dart';

class CalculateSourceTargetValueRepositoryImp extends CalculateSourceTargetValueRepository {
  final CalculateSourceTargetValueDataSource calculateSourceTargetValueDataSource;

  CalculateSourceTargetValueRepositoryImp({required this.calculateSourceTargetValueDataSource});

  @override
  Future<Either<AppException, CalculateSourceTargetValueModel>> calculateSourceTargetValue(
      {required CalculateSourceTargetValueParameterModel param}) async {
    try {
      final response =
          await calculateSourceTargetValueDataSource.calculateSourceTargetValue(param: param);
      return Right(response);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
