import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/missions/domain/entity/mission_entity.dart';

class MissionModel extends MissionEntity with EquatableMixin {
  const MissionModel({
    required super.ruleCode,
    required super.title,
    required super.description,
    required super.currencyInfo,
    required super.amount,
    required super.mission,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      ruleCode: json[AppKeys.keyRuleCode],
      title: json[AppKeys.keyTitle],
      description: json[AppKeys.keyDescription],
      currencyInfo: CurrencyInfoModel.fromJson(json[AppKeys.keyCurrencyInfo]),
      amount: json[AppKeys.keyAmount],
      mission: json[AppKeys.keyMission] != null
          ? MissionStatusModel.fromJson(json[AppKeys.keyMission])
          : null,
    );
  }

  @override
  List<Object?> get props => [ruleCode, title, description, currencyInfo, amount, mission];
}

class CurrencyInfoModel extends CurrencyInfoEntity with EquatableMixin {
  const CurrencyInfoModel({
    required super.currencyCode,
    required super.currencyEnName,
    required super.currencyFaName,
    super.currencyIcon,
  });

  factory CurrencyInfoModel.fromJson(Map<String, dynamic> json) {
    return CurrencyInfoModel(
      currencyCode: json[AppKeys.keyCurrencyCode],
      currencyEnName: json[AppKeys.keyCurrencyEnName],
      currencyFaName: json[AppKeys.keyCurrencyFaName],
      currencyIcon: json[AppKeys.keyCurrencyIcon],
    );
  }

  @override
  List<Object?> get props => [currencyCode, currencyEnName, currencyFaName, currencyIcon];
}

class MissionStatusModel extends MissionStatusEntity {
  const MissionStatusModel({
    required super.statusCode,
    required super.description,
    required super.initiatedDateTime,
    required super.updatedDateTime,
  });

  factory MissionStatusModel.fromJson(Map<String, dynamic> json) {
    return MissionStatusModel(
      statusCode: json[AppKeys.keyStatusCode],
      description: json[AppKeys.keyDescription],
      initiatedDateTime: json[AppKeys.keyInitiatedDateTime],
      updatedDateTime: json[AppKeys.keyUpdatedDateTime],
    );
  }
}
