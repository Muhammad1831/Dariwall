import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/comment_on_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';

enum CommentOnTwitterMissionStatus {
  initial,
  loading,
  success,
  error,
}

class CommentOnTwitterMissionProvider extends ChangeNotifier {
  final CommentOnTwitterMissionUsecase commentOnTwitterMissionUsecase;

  CommentOnTwitterMissionProvider({required this.commentOnTwitterMissionUsecase});

  CommentOnTwitterMissionStatus _status = CommentOnTwitterMissionStatus.initial;

  CommentOnTwitterMissionStatus get status => _status;

  Future<void> commentOnTwitterMission({required MultipartFile imageFile}) async {
    _status = CommentOnTwitterMissionStatus.loading;
    notifyListeners();
    final result = await commentOnTwitterMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = CommentOnTwitterMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) async {
        _status = CommentOnTwitterMissionStatus.success;
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.missionSuccess,
        );
        await getIt<GetMissionsProvider>().getMissions();
      },
    );
    notifyListeners();
  }
}
