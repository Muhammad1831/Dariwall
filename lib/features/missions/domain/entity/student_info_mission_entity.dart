import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class StudentInfoMissionEntity extends Equatable {
  final String studentNumber;
  final String fullName;
  final String? provinceCode;
  final String universityName;
  final String phoneNumber;
  final MultipartFile? image;

  const StudentInfoMissionEntity({
    required this.studentNumber,
    required this.fullName,
    required this.provinceCode,
    required this.universityName,
    required this.phoneNumber,
    this.image,
  });

  @override
  List<Object?> get props => [
        studentNumber,
        fullName,
        provinceCode,
        universityName,
        phoneNumber,
        image,
      ];
} 
