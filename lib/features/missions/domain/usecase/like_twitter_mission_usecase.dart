import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';
import 'package:dio/dio.dart';

class LikeTwitterMissionUsecase {
  final MissionsRepository _missionsRepository;

  LikeTwitterMissionUsecase(this._missionsRepository);

  Future<Either<AppException, void>> call({required MultipartFile imageFile}) async {
    return await _missionsRepository.likeTwitterMission(imageFile: imageFile);
  }
}
