import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/swap/data/model/swap_param_model.dart';
import 'package:dariwall/features/swap/domain/repository/swap_repository.dart';

class SwapUsecase {
  SwapRepository swapRepository;

  SwapUsecase({required this.swapRepository});

  Future<Either<AppException, void>> call({required SwapParamModel param}) async {
    return await swapRepository.swap(param: param);
  }
}
