import 'package:ostad/constant/app_keys.dart';

class ProvinceModel {
  final String code;
  final String name;

  ProvinceModel({required this.code, required this.name});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      code: json[AppKeys.keyCode],
      name: json[AppKeys.keyName],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyCode: code,
      AppKeys.keyName: name,
    };
  }
}
