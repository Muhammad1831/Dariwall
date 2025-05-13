import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';

class JoinDiscussionGroupMissionUsecase {
  final MissionsRepository _missionsRepository;

  JoinDiscussionGroupMissionUsecase(this._missionsRepository);

  Future<Either<AppException, void>> call() async {
    return await _missionsRepository.joinDiscussionGroupMission();
  }
}
