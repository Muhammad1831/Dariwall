import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/domain/repository/parax_missions_repository.dart';
import 'package:dio/dio.dart';

class FollowParaxInTwitterMissionUsecase {
  final ParaxMissionRepository paraxMissionRepository;

  FollowParaxInTwitterMissionUsecase({required this.paraxMissionRepository});

  Future<Either<AppException, void>> call({required MultipartFile imageFile}) async {
    return await paraxMissionRepository.followParaxInTwitter(imageFile: imageFile);
  }
}
