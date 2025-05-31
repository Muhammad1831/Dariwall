import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/send/data/model/transfer_param_model.dart';

abstract class TransferRepository {
  Future<Either<AppException, void>> transfer({required TransferParamModel param});
}
