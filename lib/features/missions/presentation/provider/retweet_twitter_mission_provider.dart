import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/domain/usecase/retweet_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';

enum RetweetTwitterMissionStatus {
  initial,
  loading,
  success,
  error,
}

class RetweetTwitterMissionProvider extends ChangeNotifier {
  final RetweetTwitterMissionUsecase retweetTwitterMissionUsecase;

  RetweetTwitterMissionProvider({required this.retweetTwitterMissionUsecase});

  RetweetTwitterMissionStatus _status = RetweetTwitterMissionStatus.initial;

  RetweetTwitterMissionStatus get status => _status;

  Future<void> retweetTwitterMission({required MultipartFile imageFile}) async {
    _status = RetweetTwitterMissionStatus.loading;
    notifyListeners();
    final result = await retweetTwitterMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = RetweetTwitterMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = RetweetTwitterMissionStatus.success;
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
