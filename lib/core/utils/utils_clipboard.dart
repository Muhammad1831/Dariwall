import 'package:flutter/services.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';

class UtilsClipboard {
  static Future<void> copyToClipboard({
    required String text,
    required String successMessage,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    SnackBarService.show(
      status: SnackBarStatus.success,
      message: successMessage,
    );
  }
}
