extension StringExtension on String {
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

extension NumberFormatter on int {
  String toPersianNumber() {
    final numberStr = toString();
    final chars = numberStr.split('').reversed.toList();
    final buffer = StringBuffer();

    for (var i = 0; i < chars.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write('،');
      }
      buffer.write(chars[i]);
    }

    return buffer.toString().split('').reversed.join();
  }
}

extension IntExtension on int {
  String get formattedTime {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
