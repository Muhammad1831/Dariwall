import 'package:dariwall/features/missions/domain/usecase/parax_usecase/follow_parax_in_twitter_mission_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';

enum FollowParaxInTwitterMissionStatus {
  initial,
  loading,
  success,
  error,
}

class FollowParaxInTwitterMissionProvider extends ChangeNotifier {
  final FollowParaxInTwitterMissionUsecase followParaxInTwitterMissionUsecase;

  FollowParaxInTwitterMissionProvider({required this.followParaxInTwitterMissionUsecase});

  FollowParaxInTwitterMissionStatus _status = FollowParaxInTwitterMissionStatus.initial;

  FollowParaxInTwitterMissionStatus get status => _status;

  Future<void> followParaxInTwitter({required MultipartFile imageFile}) async {
    _status = FollowParaxInTwitterMissionStatus.loading;
    notifyListeners();
    final result = await followParaxInTwitterMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = FollowParaxInTwitterMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = FollowParaxInTwitterMissionStatus.success;
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
