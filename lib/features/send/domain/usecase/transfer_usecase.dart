import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/send/data/model/transfer_param_model.dart';
import 'package:dariwall/features/send/domain/repository/transfer_repository.dart';

class TransferUsecase {
  final TransferRepository transferRepository;

  TransferUsecase({required this.transferRepository});

  Future<Either<AppException, void>> call({required TransferParamModel param}) async {
    return await transferRepository.transfer(param: param);
  }
}
