import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/data/model/student_info_mission_model.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/student_info_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';

enum StudentInfoMissionStatus {
  initial,
  loading,
  success,
  error,
}

class StudentInfoMissionProvider extends ChangeNotifier {
  final StudentInfoMissionUsecase studentInfoMissionUsecase;

  StudentInfoMissionProvider({required this.studentInfoMissionUsecase});

  StudentInfoMissionStatus _status = StudentInfoMissionStatus.initial;

  StudentInfoMissionStatus get status => _status;

  Future<void> studentInfoMission(StudentInfoMissionModel studentInfo) async {
    _status = StudentInfoMissionStatus.loading;
    notifyListeners();
    
    final result = await studentInfoMissionUsecase.call(studentInfo);
    
    result.fold(
      (l) {
        _status = StudentInfoMissionStatus.error;
        notifyListeners();
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = StudentInfoMissionStatus.success;
        notifyListeners();
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.missionSuccess,
        );
        getIt<GetMissionsProvider>().getMissions();
      },
    );
  }
}
