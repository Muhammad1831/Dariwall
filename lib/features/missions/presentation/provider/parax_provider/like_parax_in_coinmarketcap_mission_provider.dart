import 'package:dariwall/features/missions/domain/usecase/parax_usecase/like_parax_in_coinmarketcap_mission_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';

enum LikeParaxInCoinmarketcapMissionStatus {
  initial,
  loading,
  success,
  error,
}

class LikeParaxInCoinmarketcapMissionProvider extends ChangeNotifier {
  final LikeParaxInCoinmarketcapMissionUsecase likeParaxInCoinmarketcapMissionUsecase;

  LikeParaxInCoinmarketcapMissionProvider({required this.likeParaxInCoinmarketcapMissionUsecase});

  LikeParaxInCoinmarketcapMissionStatus _status = LikeParaxInCoinmarketcapMissionStatus.initial;

  LikeParaxInCoinmarketcapMissionStatus get status => _status;

  Future<void> likeParaxInCoinmarketcap({required MultipartFile imageFile}) async {
    _status = LikeParaxInCoinmarketcapMissionStatus.loading;
    notifyListeners();
    final result = await likeParaxInCoinmarketcapMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = LikeParaxInCoinmarketcapMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = LikeParaxInCoinmarketcapMissionStatus.success;
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
