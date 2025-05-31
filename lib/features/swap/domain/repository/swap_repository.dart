import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/swap/data/model/swap_param_model.dart';

abstract class SwapRepository {
  Future<Either<AppException, void>> swap({required SwapParamModel param});
}
