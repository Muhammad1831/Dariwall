import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/global_provider/data/datasource/calculate_fee_data_source.dart';
import 'package:dariwall/global_provider/data/model/calculate_fee_model.dart';
import 'package:dariwall/global_provider/domain/repository/calculate_fee_repository.dart';

class CalculateFeeRepositoryImp extends CalculateFeeRepository {
  final CalculateFeeDataSource calculateFeeDataSource;

  CalculateFeeRepositoryImp({required this.calculateFeeDataSource});

  @override
  Future<Either<AppException, CalculateFeeModel>> calculateFee({required CalculateFeeParamModel param}) async {
    try {
      final response = await calculateFeeDataSource.calculateFee(param: param);
      return Right(response);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
