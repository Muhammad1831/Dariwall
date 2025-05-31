extension StringExtensions on String {
  String formatDecimal({int maxDigits = 5}) {
    if (!contains('.')) return this;

    final parts = split('.');
    var integerPart = parts[0];
    var decimalPart = parts[1];

    // حذف صفرهای انتهایی
    decimalPart = decimalPart.replaceAll(RegExp(r'0*$'), '');

    // محدود کردن به حداکثر رقم اعشار
    if (decimalPart.length > maxDigits) {
      decimalPart = decimalPart.substring(0, maxDigits);
      decimalPart = decimalPart.replaceAll(RegExp(r'0*$'), '');
    }

    return decimalPart.isEmpty ? integerPart : '$integerPart.$decimalPart';
  }
}
