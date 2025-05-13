import 'package:equatable/equatable.dart';
import 'package:dariwall/core/global_entity/currency_info_entity.dart';

class MissionEntity extends Equatable {
  final int ruleCode;
  final String title;
  final String description;
  final CurrencyInfoEntity currencyInfo;
  final double amount;
  final MissionStatusEntity? mission;

  const MissionEntity({
    required this.ruleCode,
    required this.title,
    required this.description,
    required this.currencyInfo,
    required this.amount,
    this.mission,
  });

  @override
  List<Object?> get props => [ruleCode, title, description, currencyInfo, amount, mission];
}

class MissionStatusEntity extends Equatable {
  final int? statusCode;
  final String? description;
  final String? initiatedDateTime;
  final String? updatedDateTime;

  const MissionStatusEntity({
    this.statusCode,
    this.description,
    this.initiatedDateTime,
    this.updatedDateTime,
  });

  @override
  List<Object?> get props => [statusCode, description, initiatedDateTime, updatedDateTime];
}
