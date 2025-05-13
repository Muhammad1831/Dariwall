import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/gift_code_page/data/datasource/gift_code_data_source.dart';
import 'package:dariwall/features/gift_code_page/data/model/gift_code_model.dart';
import 'package:dariwall/features/gift_code_page/domain/repository/gift_code_repository.dart';

class GiftCodeRepositoryImp implements GiftCodeRepository {
  final GiftCodeDatasource datasource;

  GiftCodeRepositoryImp({required this.datasource});

  @override
  Future<Either<AppException, GiftCodeModel>> sendGiftCode({required String giftCode}) async {
    try {
      final response = await datasource.sendGiftCode(giftCode: giftCode);
      return Right(response);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> verifyGiftCode({required String giftCode}) async {
    try {
      await datasource.verifyGiftCode(giftCode: giftCode);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
