import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';

class JoinDariwallTelegramChannelMissionUsecase {
  final MissionsRepository missionsRepository;

  JoinDariwallTelegramChannelMissionUsecase({required this.missionsRepository});

  Future<Either<AppException, void>> call() async {
    return await missionsRepository.joinDariwallTelegramChannelMission();
  }
}
