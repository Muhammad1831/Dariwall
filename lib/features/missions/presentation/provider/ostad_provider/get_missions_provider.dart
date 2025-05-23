import 'package:flutter/foundation.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/get_missions_usecase.dart';
import 'package:dariwall/features/missions/data/model/mission_model.dart';

enum GetMissionsState {
  initial,
  loading,
  success,
  error,
}

class GetMissionsProvider extends ChangeNotifier {
  final GetMissionsUsecase getMissionsUsecase;

  GetMissionsProvider({required this.getMissionsUsecase}) {
    getMissions();
  }

  GetMissionsState _state = GetMissionsState.initial;
  GetMissionsState get state => _state;

  List<MissionModel> _missions = [];
  List<MissionModel> get missions => _missions;

  Future<void> getMissions() async {
    _state = GetMissionsState.loading;
    notifyListeners();
    final result = await getMissionsUsecase.call();
    result.fold((l) {
      _state = GetMissionsState.error;
      notifyListeners();
    }, (r) {
      _missions = r;
      _state = GetMissionsState.success;
      notifyListeners();
    });
  }
}
