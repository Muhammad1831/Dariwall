import 'package:dariwall/features/missions/domain/usecase/parax_usecase/like_parax_twitter_post_mission_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';

enum LikeParaxTwitterPostMissionStatus {
  initial,
  loading,
  success,
  error,
}

class LikeTwitterMissionProvider extends ChangeNotifier {
  final LikeParaxTwitterPostMissionUsecase likeParaxTwitterPostMissionUsecase;

  LikeTwitterMissionProvider({required this.likeParaxTwitterPostMissionUsecase});

  LikeParaxTwitterPostMissionStatus _status = LikeParaxTwitterPostMissionStatus.initial;

  LikeParaxTwitterPostMissionStatus get status => _status;

  Future<void> likeParaxTwitterPost({required MultipartFile imageFile}) async {
    _status = LikeParaxTwitterPostMissionStatus.loading;
    notifyListeners();
    final result = await likeParaxTwitterPostMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = LikeParaxTwitterPostMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = LikeParaxTwitterPostMissionStatus.success;
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
