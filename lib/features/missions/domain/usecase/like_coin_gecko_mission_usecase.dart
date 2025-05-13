import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';
import 'package:dio/dio.dart';

class LikeCoinGeckoMissionUsecase {
  final MissionsRepository _missionsRepository;

  LikeCoinGeckoMissionUsecase(this._missionsRepository);

  Future<Either<AppException, void>> call({required MultipartFile imageFile}) async {
    return await _missionsRepository.likeCoinGeckoMission(imageFile: imageFile);
  }
}
