import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/model/calculate_source_target_value_model.dart';
import 'package:dariwall/global_provider/domain/repository/calculate_source_target_value_repository.dart';

class CalculateSourceTargetValueUsecase {
  final CalculateSourceTargetValueRepository calculateSourceTargetValueRepository;

  CalculateSourceTargetValueUsecase({required this.calculateSourceTargetValueRepository});

  Future<Either<AppException, CalculateSourceTargetValueModel>> call(
      {required CalculateSourceTargetValueParameterModel param}) async {
    return await calculateSourceTargetValueRepository.calculateSourceTargetValue(param: param);
  }
}
