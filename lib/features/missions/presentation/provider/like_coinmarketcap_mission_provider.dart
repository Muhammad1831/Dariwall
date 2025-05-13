import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/features/missions/domain/usecase/like_coinmarketcap_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/get_missions_provider.dart';

enum LikeCoinmarketcapMissionStatus {
  initial,  
  loading,
  success,
  error,
}

class LikeCoinmarketcapMissionProvider extends ChangeNotifier {
  final LikeCoinmarketcapMissionUsecase likeCoinmarketcapMissionUsecase;

  LikeCoinmarketcapMissionProvider({required this.likeCoinmarketcapMissionUsecase});

  LikeCoinmarketcapMissionStatus _status = LikeCoinmarketcapMissionStatus.initial;

  LikeCoinmarketcapMissionStatus get status => _status;

  Future<void> likeCoinmarketcapMission({required MultipartFile imageFile}) async {
    _status = LikeCoinmarketcapMissionStatus.loading;
    notifyListeners();
    final result = await likeCoinmarketcapMissionUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = LikeCoinmarketcapMissionStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) {
        _status = LikeCoinmarketcapMissionStatus.success;
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
