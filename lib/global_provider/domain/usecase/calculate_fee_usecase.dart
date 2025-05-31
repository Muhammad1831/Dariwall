import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/model/calculate_fee_model.dart';
import 'package:dariwall/global_provider/domain/repository/calculate_fee_repository.dart';

class CalculateFeeUsecase {
  final CalculateFeeRepository calculateFeeRepository;

  CalculateFeeUsecase({required this.calculateFeeRepository});

  Future<Either<AppException, CalculateFeeModel>> call(
      {required CalculateFeeParamModel param}) async {
    return await calculateFeeRepository.calculateFee(param: param);
  }
}
