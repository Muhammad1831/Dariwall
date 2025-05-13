import 'package:equatable/equatable.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/missions/domain/entity/student_info_mission_entity.dart';

class StudentInfoMissionModel extends StudentInfoMissionEntity with EquatableMixin {
  const StudentInfoMissionModel({
    required super.studentNumber,
    required super.fullName,
    required super.provinceCode,
    required super.universityName,
    required super.phoneNumber,
    super.image,
  });

  factory StudentInfoMissionModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoMissionModel(
      studentNumber: json[AppKeys.keyStudentNumber],
      fullName: json[AppKeys.keyName],
      provinceCode: json[AppKeys.keyProvinceCode],
      universityName: json[AppKeys.keyUniversityName],
      phoneNumber: json[AppKeys.keyPhoneNumber],
      image: json[AppKeys.keyImage],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyStudentNumber: studentNumber,
      AppKeys.keyName: fullName,
      AppKeys.keyProvinceCode: provinceCode,
      AppKeys.keyUniversityName: universityName,
      AppKeys.keyPhoneNumber: phoneNumber,
      AppKeys.keyImage: image,
    };
  }

  StudentInfoMissionEntity toEntity() {
    return StudentInfoMissionEntity(
      studentNumber: studentNumber,
      fullName: fullName,
      provinceCode: provinceCode,
      universityName: universityName,
      phoneNumber: phoneNumber,
      image: image,
    );
  }
}
