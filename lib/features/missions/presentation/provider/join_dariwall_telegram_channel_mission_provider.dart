import 'package:flutter/foundation.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/missions/domain/usecase/join_dariwall_telegram_channel_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';

enum JoinDariwallTelegramChannelMissionStatus {
  initial,
  loading,
  success,
  error,
}

class JoinDariwallTelegramChannelMissionProvider extends ChangeNotifier {
  final JoinDariwallTelegramChannelMissionUsecase joinDariwallTelegramChannelMissionUsecase;

  JoinDariwallTelegramChannelMissionProvider(
      {required this.joinDariwallTelegramChannelMissionUsecase});

  JoinDariwallTelegramChannelMissionStatus _status =
      JoinDariwallTelegramChannelMissionStatus.initial;

  JoinDariwallTelegramChannelMissionStatus get status => _status;

  Future<void> joinDariwallTelegramChannelMission() async {
    _status = JoinDariwallTelegramChannelMissionStatus.loading;
    notifyListeners();
    final result = await joinDariwallTelegramChannelMissionUsecase.call();
    result.fold(
      (l) {
        _status = JoinDariwallTelegramChannelMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) async {
        _status = JoinDariwallTelegramChannelMissionStatus.success;
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
