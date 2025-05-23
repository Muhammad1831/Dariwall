import 'package:dariwall/features/missions/data/model/province_model.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/get_province_usecase.dart';

enum GetProvinceStatus {
  initial,
  loading,
  success,
  error,
}

class GetProvineceProvider extends ChangeNotifier {
  final GetProvinceUsecase _getProvinceUsecase;

  GetProvineceProvider(this._getProvinceUsecase);

  String? _provinceCode;
  String? get provinceCode => _provinceCode;

  GetProvinceStatus _status = GetProvinceStatus.initial;
  GetProvinceStatus get status => _status;

  List<ProvinceModel> _provinces = [];
  List<ProvinceModel> get provinces => _provinces;

  void setProvinceCode(String? value) {
    _provinceCode = value;
    notifyListeners();
  }

  void reset() {
    _provinceCode = null;
    notifyListeners();
  }

  Future<void> getProvinces() async {
    _status = GetProvinceStatus.loading;
    notifyListeners();
    final result = await _getProvinceUsecase.call();
    result.fold(
      (l) {
        _status = GetProvinceStatus.error;
        _provinces = [];
      },
      (r) {
        _status = GetProvinceStatus.success;
        _provinces = r;
      },
    );
    notifyListeners();
  }
}
