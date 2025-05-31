import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/model/calculate_source_target_value_model.dart';

abstract class CalculateSourceTargetValueRepository {
  Future<Either<AppException, CalculateSourceTargetValueModel>> calculateSourceTargetValue(
      {required CalculateSourceTargetValueParameterModel param});
}
