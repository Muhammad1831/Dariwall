import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/domain/usecase/join_discussion_group_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';

enum JoinDiscussionGroupMissionStatus {
  initial,
  loading,
  success,
  error,
}

class JoinDiscussionGroupMissionProvider extends ChangeNotifier {
  final JoinDiscussionGroupMissionUsecase joinDiscussionGroupMissionUsecase;

  JoinDiscussionGroupMissionProvider({required this.joinDiscussionGroupMissionUsecase});

  JoinDiscussionGroupMissionStatus _status = JoinDiscussionGroupMissionStatus.initial;

  JoinDiscussionGroupMissionStatus get status => _status;

  Future<void> joinDiscussionGroupMission() async {
    _status = JoinDiscussionGroupMissionStatus.loading;
    notifyListeners();
    final result = await joinDiscussionGroupMissionUsecase.call();
    result.fold(
      (l) {
        _status = JoinDiscussionGroupMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) async {
        _status = JoinDiscussionGroupMissionStatus.success;
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
