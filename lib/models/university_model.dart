import 'package:ostad/constant/app_keys.dart';
import 'package:ostad/models/province_model.dart';

class UniversityModel {
  final String code;
  final String name;
  final ProvinceModel province;

  UniversityModel({required this.code, required this.name, required this.province});

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      code: json[AppKeys.keyCode],
      name: json[AppKeys.keyName],
      province: ProvinceModel.fromJson(json[AppKeys.keyProvince]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyCode: code,
      AppKeys.keyName: name,
      AppKeys.keyProvince: province.toJson(),
    };
  }
}
