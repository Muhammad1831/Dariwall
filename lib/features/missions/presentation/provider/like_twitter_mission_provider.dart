import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/domain/usecase/like_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';

enum LikeTwitterMissionStatus {
  initial,
  loading,
  success,
  error,
}

class LikeTwitterMissionProvider extends ChangeNotifier {
  final LikeTwitterMissionUsecase likeTwitterMissionUsecase;

  LikeTwitterMissionProvider({required this.likeTwitterMissionUsecase});

  LikeTwitterMissionStatus _status = LikeTwitterMissionStatus.initial;

  LikeTwitterMissionStatus get status => _status;

  Future<void> likeTwitterMission({required MultipartFile imageFile}) async {
    _status = LikeTwitterMissionStatus.loading;
    notifyListeners();
    final result = await likeTwitterMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = LikeTwitterMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = LikeTwitterMissionStatus.success;
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
