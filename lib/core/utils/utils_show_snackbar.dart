import 'package:flutter/material.dart';
import 'package:dariwall/core/widgets/app_snack_bar.dart';

enum Status {
  success,
  error,
  warning,
}

class UtilsShowSnackbar {
  static final UtilsShowSnackbar _instance = UtilsShowSnackbar._internal();

  factory UtilsShowSnackbar() => _instance;

  UtilsShowSnackbar._internal();

  static void show({
    required BuildContext context,
    required Status status,
    required String message,
  }) {
    if (message.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (status) {
        case Status.success:
          AppSnackBar.showSuccess(context, message: message);
          break;
        case Status.error:
          AppSnackBar.showError(context, message: message);
          break;
        case Status.warning:
          AppSnackBar.showWarning(context, message: message);
          break;
      }
    });
  }
}
