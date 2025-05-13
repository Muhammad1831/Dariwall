import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/gift_code_page/data/model/gift_code_model.dart';

abstract class GiftCodeRepository {
  Future<Either<AppException, GiftCodeModel>> sendGiftCode({required String giftCode});
  Future<Either<AppException, void>> verifyGiftCode({required String giftCode});
}
