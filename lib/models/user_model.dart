class UserModel {
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String ostadWalletAddress;
  final String telegramId;
  final String studentNumber;
  final String university;
  final bool gender;
  final String province;

  UserModel({
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.ostadWalletAddress,
    required this.telegramId,
    required this.studentNumber,
    required this.university,
    required this.gender,
    required this.province,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json['password'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      ostadWalletAddress: json['ostad_wallet_address'] ?? '',
      telegramId: json['telegram_id'] ?? '',
      studentNumber: json['student_number'] ?? '',
      university: json['university'] ?? '',
      gender: json['gender'] ?? false,
      province: json['province'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'ostad_wallet_address': ostadWalletAddress,
      'telegram_id': telegramId,
      'student_number': studentNumber,
      'university': university,
      'gender': gender,
      'province': province,
    };
  }
}