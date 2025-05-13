import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/missions/domain/entity/province_entity.dart';

class ProvinceModel extends ProvinceEntity with EquatableMixin {
  const ProvinceModel({required super.code, required super.name});

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
