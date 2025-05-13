import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/domain/usecase/join_telegram_channel_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';

enum JoinTelegramChannelMissionStatus {
  initial,
  loading,
  success,
  error,
}

class JoinTelegramChannelMissionProvider extends ChangeNotifier {
  final JoinTelegramChannelMissionUsecase joinTelegramChannelMissionUsecase;

  JoinTelegramChannelMissionProvider({required this.joinTelegramChannelMissionUsecase});

  JoinTelegramChannelMissionStatus _status = JoinTelegramChannelMissionStatus.initial;

  JoinTelegramChannelMissionStatus get status => _status;

  Future<void> joinTelegramChannelMission() async {
    _status = JoinTelegramChannelMissionStatus.loading;
    notifyListeners();
    final result = await joinTelegramChannelMissionUsecase.call();
    result.fold(
      (l) {
        _status = JoinTelegramChannelMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) async {
        _status = JoinTelegramChannelMissionStatus.success;
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
