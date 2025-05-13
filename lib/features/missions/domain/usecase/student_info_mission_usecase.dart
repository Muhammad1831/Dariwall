import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/data/model/student_info_mission_model.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';

class StudentInfoMissionUsecase {
  final MissionsRepository missionsRepository;

  StudentInfoMissionUsecase({required this.missionsRepository});

  Future<Either<AppException, void>> call(StudentInfoMissionModel studentInfo) async {
    if (studentInfo.fullName.isEmpty) {
      return Left(AppException(message: AppMessage.fullNameIsRequired));
    }

    if (studentInfo.studentNumber.isEmpty) {
      return Left(AppException(message: AppMessage.studentNumberIsRequired));
    }

    if (studentInfo.universityName.isEmpty) {
      return Left(AppException(message: AppMessage.universityIsRequired));
    }

    if (studentInfo.phoneNumber.isEmpty) {
      return Left(AppException(message: AppMessage.phoneNumberIsRequired));
    }

    if (studentInfo.provinceCode == null) {
      return Left(AppException(message: AppMessage.provinceIsRequired));
    }

    if (studentInfo.image == null)  {
      return Left(AppException(message: AppMessage.imageIsRequired));
    }

    return await missionsRepository.studentInfoMission(studentInfo: studentInfo);
  }
}
