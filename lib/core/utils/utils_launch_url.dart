import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilsLaunchUrl {
  static Future<void> launchURL({
    required String url,
    bool showErrorSnackBar = true,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        if (showErrorSnackBar) {
          SnackBarService.show(
            status: SnackBarStatus.error,
            message: AppMessage.unknownError,
          );
        }
      }
    } catch (e) {
      if (showErrorSnackBar) {
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: AppMessage.unknownError,
        );
      }
    }
  }
}
