import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/domain/repository/parax_missions_repository.dart';

class CheckJoinParaxTelegramChannelUsecase {
  final ParaxMissionRepository paraxMissionRepository;

  CheckJoinParaxTelegramChannelUsecase({required this.paraxMissionRepository});

  Future<Either<AppException, void>> call() async {
    return await paraxMissionRepository.checkJoinParaxTelegramChannel();
  }
}
