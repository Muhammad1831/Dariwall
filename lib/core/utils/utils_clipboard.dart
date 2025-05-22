import 'package:flutter/services.dart';

class UtilsClipboard {
  static Future<void> copyToClipboard({
    required String text,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
