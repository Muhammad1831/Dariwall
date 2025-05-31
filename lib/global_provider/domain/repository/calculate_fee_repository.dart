import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/model/calculate_fee_model.dart';

abstract class CalculateFeeRepository {
  Future<Either<AppException, CalculateFeeModel>> calculateFee(
      {required CalculateFeeParamModel param});
}
