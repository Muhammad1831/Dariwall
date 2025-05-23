import 'package:dariwall/features/missions/domain/usecase/parax_usecase/check_join_parax_telegram_channel_usecase.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';

enum CheckJoinParaxTelegramChannelStatus {
  initial,
  loading,
  success,
  error,
}

class CheckJoinParaxTelegramChannelProvider extends ChangeNotifier {
  final CheckJoinParaxTelegramChannelUsecase checkJoinParaxTelegramChannelUsecase;

  CheckJoinParaxTelegramChannelProvider({required this.checkJoinParaxTelegramChannelUsecase});

  CheckJoinParaxTelegramChannelStatus _status = CheckJoinParaxTelegramChannelStatus.initial;

  CheckJoinParaxTelegramChannelStatus get status => _status;

  Future<void> checkJoinParaxTelegramChannel() async {
    _status = CheckJoinParaxTelegramChannelStatus.loading;
    notifyListeners();
    final result = await checkJoinParaxTelegramChannelUsecase.call();
    result.fold(
      (l) {
        _status = CheckJoinParaxTelegramChannelStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) async {
        _status = CheckJoinParaxTelegramChannelStatus.success;
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
