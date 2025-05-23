import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/domain/repository/parax_missions_repository.dart';
import 'package:dio/dio.dart';

class LikeParaxInCoinmarketcapMissionUsecase {
  final ParaxMissionRepository paraxMissionRepository;

  LikeParaxInCoinmarketcapMissionUsecase({required this.paraxMissionRepository});

  Future<Either<AppException, void>> call({required MultipartFile imageFile}) async {
    return await paraxMissionRepository.likeParaxInCoinmarketcap(imageFile: imageFile);
  }
}
