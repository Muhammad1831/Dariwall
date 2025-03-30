import 'package:flutter/foundation.dart';
import 'package:ostad/features/sign_up/data/model/province_model.dart';
import 'package:ostad/features/sign_up/data/model/university_model.dart';
import 'package:ostad/features/sign_up/presentation/page/sign_up_page.dart';
import 'package:ostad/features/sign_up/data/datasource/sign_up_service.dart';

class SignUpProvider with ChangeNotifier {
  final SignUpService _signUpService;

  List<ProvinceModel> _provinces = [];
  List<UniversityModel> _universities = [];

  String _selectedProvinceCode = '';
  String _selectedUniversityCode = '';

  final Step _step = Step.information;

  SignUpProvider(this._signUpService) {
    getProvinces();
  }

  List<ProvinceModel> get provinces => _provinces;
  List<UniversityModel> get universities => _universities;
  String get selectedProvinceCode => _selectedProvinceCode;
  String get selectedUniversityCode => _selectedUniversityCode;

  Step get step => _step;

  set selectedProvinceCode(String code) {
    _selectedProvinceCode = code;
    if (code.isNotEmpty) {
      getUniversities(code);
    }
    notifyListeners();
  }

  set selectedUniversityCode(String code) {
    _selectedUniversityCode = code;
    notifyListeners();
  }

  Future<void> getProvinces() async {
    _provinces = [];
    notifyListeners();

    try {
      final data = await _signUpService.getProvinces();
      _provinces = data;
    } catch (e) {
      debugPrint('error: $e');
      _provinces = [];
    }

    notifyListeners();
  }

  Future<void> getUniversities(String provinceCode) async {
    _universities = [];
    notifyListeners();

    try {
      final data = await _signUpService.getUniversities(provinceCode: provinceCode);
      _universities = data;
    } catch (e) {
      _universities = [];
    }

    notifyListeners();
  }
}
