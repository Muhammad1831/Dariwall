import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/gift_code_page/data/model/gift_code_model.dart';
import 'package:dariwall/features/gift_code_page/domain/repository/gift_code_repository.dart';

class SendGiftCodeUsecase {
  final GiftCodeRepository repository;

  SendGiftCodeUsecase({required this.repository});

  Future<Either<AppException, GiftCodeModel>> call({required String giftCode}) async {
    return await repository.sendGiftCode(giftCode: giftCode);
  }
}
