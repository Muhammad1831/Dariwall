import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';

enum SnackBarType { success, error, warning, info }

class AppSnackBar extends StatelessWidget {
  final String message;

  const AppSnackBar({
    super.key,
    required this.message,
  });

  static void show(
    BuildContext context, {
    required String message,
    int duration = 2,
    required Color iconBackgroundColor,
    required IconData icon,
  }) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + AppDimens.paddingLarge,
        left: AppDimens.paddingLarge,
        right: AppDimens.paddingLarge,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 40.r,
            decoration: BoxDecoration(
              color: Theme.of(context).snackBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40.r,
                  height: 40.r,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(AppDimens.borderRadiusSmall),
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                    child: Text(
                      message,
                      style: Theme.of(context).snackBarTheme.contentTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(Duration(seconds: duration), () {
      overlayEntry.remove();
    });
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
  }) {
    show(
      context,
      message: message,
      iconBackgroundColor: AppColor.successColor,
      icon: Icons.check,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
  }) {
    show(
      context,
      message: message,
      iconBackgroundColor: AppColor.errorColor,
      icon: Icons.close,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
  }) {
    show(
      context,
      message: message,
      iconBackgroundColor: AppColor.secondaryColor,
      icon: Icons.warning,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
