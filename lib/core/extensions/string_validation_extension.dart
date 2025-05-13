extension StringValidationExtension on String {
  bool isValidEmail() {
    return RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    ).hasMatch(this);
  }

  bool isValidIranianPhoneNumber() {
    return RegExp(
      r'^(\+98|0)?9\d{9}$',
    ).hasMatch(this);
  }
} 
