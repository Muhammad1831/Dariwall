import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';

class GetMissionsUsecase {
  final MissionsRepository missionsRepository;

  GetMissionsUsecase({required this.missionsRepository});

  Future<Either<AppException, List<MissionModel>>> call() async {
    return await missionsRepository.getMissions();
  }
}
