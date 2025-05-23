import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/data/model/province_model.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';

class GetProvinceUsecase {
  final MissionsRepository missionsRepository;

  GetProvinceUsecase({required this.missionsRepository});

  Future<Either<AppException, List<ProvinceModel>>> call() async {
    return await missionsRepository.getProvinces();
  }
}
