import 'package:dariwall/features/missions/domain/usecase/parax_usecase/retweet_parax_twitter_post_mission_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';

enum RetweetParaxTwitterPostMissionStatus {
  initial,
  loading,
  success,
  error,
}

class RetweetParaxTwitterPostMissionProvider extends ChangeNotifier {
  final RetweetParaxTwitterPostMissionUsecase retweetParaxTwitterPostMissionUsecase;

  RetweetParaxTwitterPostMissionProvider({required this.retweetParaxTwitterPostMissionUsecase});

  RetweetParaxTwitterPostMissionStatus _status = RetweetParaxTwitterPostMissionStatus.initial;

  RetweetParaxTwitterPostMissionStatus get status => _status;

  Future<void> retweetParaxTwitterPost({required MultipartFile imageFile}) async {
    _status = RetweetParaxTwitterPostMissionStatus.loading;
    notifyListeners();
    final result = await retweetParaxTwitterPostMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = RetweetParaxTwitterPostMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = RetweetParaxTwitterPostMissionStatus.success;
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
