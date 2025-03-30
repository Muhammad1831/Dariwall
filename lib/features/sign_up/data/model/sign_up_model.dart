import 'package:ostad/core/constant/app_keys.dart';

class SignUpModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String ostadWalletAddress;
  final String telegramId;
  final String studentNumber;
  final String provinceCode;
  final String universityCode;
  final bool gender;
  final String password;

  SignUpModel({
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.ostadWalletAddress,
    required this.telegramId,
    required this.studentNumber,
    required this.provinceCode,
    required this.universityCode,
    required this.gender,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      firstName: json[AppKeys.keyFirstName] ?? '',
      lastName: json[AppKeys.keyLastName] ?? '',
      phoneNumber: json[AppKeys.keyPhoneNumber] ?? '',
      ostadWalletAddress: json[AppKeys.keyOstadWalletAddress] ?? '',
      telegramId: json[AppKeys.keyTelegramId] ?? '',
      studentNumber: json[AppKeys.keyStudentNumber] ?? '',
      provinceCode: json[AppKeys.keyProvinceCode] ?? '',
      universityCode: json[AppKeys.keyUniversityCode] ?? '',
      gender: json[AppKeys.keyGender],
      password: json[AppKeys.keyPassword] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyFirstName: firstName,
      AppKeys.keyLastName: lastName,
      AppKeys.keyPhoneNumber: phoneNumber,
      AppKeys.keyOstadWalletAddress: ostadWalletAddress,
      AppKeys.keyTelegramId: telegramId,
      AppKeys.keyStudentNumber: studentNumber,
      AppKeys.keyProvinceCode: provinceCode,
      AppKeys.keyUniversityCode: universityCode,
      AppKeys.keyGender: gender,
      AppKeys.keyPassword: password,
    };
  }
}
