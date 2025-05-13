extension NumberFormatterExtension on String {
  String threeDigitsThree() {
    final numberStr = toString();
    
    // اگر عدد اعشاری نباشد، کل عدد را فرمت می‌کنیم
    if (!numberStr.contains('.')) {
      return _formatInteger(numberStr);
    }
    
    // عدد را به دو بخش قبل و بعد از اعشار تقسیم می‌کنیم
    final parts = numberStr.split('.');
    final integerPart = _formatInteger(parts[0]);
    final decimalPart = parts[1];
    
    // دو بخش را با نقطه به هم متصل می‌کنیم
    return '$integerPart.$decimalPart';
  }

  String _formatInteger(String integerStr) {
    final chars = integerStr.split('').reversed.toList();
    final buffer = StringBuffer();

    for (var i = 0; i < chars.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(chars[i]);
    }

    return buffer.toString().split('').reversed.join();
  }
} 
