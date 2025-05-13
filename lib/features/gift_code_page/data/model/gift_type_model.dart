import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/gift_code_page/domain/entity/gift_type_entity.dart';

class GiftTypeModel extends GiftTypeEntity with EquatableMixin {
  GiftTypeModel({
    required super.code,
    super.description,
    super.title,
  });

  factory GiftTypeModel.fromJson(dynamic json) {
    return GiftTypeModel(
      code: json[AppKeys.keyCode],
      title: json[AppKeys.keyTitle],
      description: json[AppKeys.keyDescription],
    );
  }
}
