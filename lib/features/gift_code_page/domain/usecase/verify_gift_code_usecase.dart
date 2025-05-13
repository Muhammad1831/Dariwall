import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/gift_code_page/domain/repository/gift_code_repository.dart';

class VerifyGiftCodeUsecase {
  final GiftCodeRepository giftCodeRepository;

  VerifyGiftCodeUsecase({required this.giftCodeRepository});

  Future<Either<AppException, void>> call({required String giftCode}) async {
    return await giftCodeRepository.verifyGiftCode(giftCode: giftCode);
  }
}
