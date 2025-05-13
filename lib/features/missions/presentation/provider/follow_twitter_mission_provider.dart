import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/domain/usecase/follow_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';

enum FollowTwitterMissionStatus {
  initial,
  loading,
  success,
  error,
}

class FollowTwitterMissionProvider extends ChangeNotifier {
  final FollowTwitterMissionUsecase followTwitterMissionUsecase;

  FollowTwitterMissionProvider({required this.followTwitterMissionUsecase});

  FollowTwitterMissionStatus _status = FollowTwitterMissionStatus.initial;

  FollowTwitterMissionStatus get status => _status;

  Future<void> followTwitterMission({required MultipartFile imageFile}) async {
    _status = FollowTwitterMissionStatus.loading;
    notifyListeners();
    final result = await followTwitterMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = FollowTwitterMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = FollowTwitterMissionStatus.success;
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.missionSuccess,
        );
        getIt<GetMissionsProvider>().getMissions();
      },
    );
    notifyListeners();
  }
}
