import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';

enum SnackBarStatus { success, error, warning }

class SnackBarService {
  static BuildContext? _rootContext;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void init(BuildContext context) {
    _rootContext = context;
  }

  static void show({
    required SnackBarStatus status,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (message.isEmpty) return;

    final context = _rootContext ?? navigatorKey.currentState?.overlay?.context;
    if (context == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).padding.top + AppDimens.paddingLarge,
          left: AppDimens.paddingLarge,
          right: AppDimens.paddingLarge,
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).snackBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _getIconBackgroundColor(status),
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(AppDimens.borderRadiusSmall),
                        ),
                      ),
                      child: Icon(
                        _getIcon(status),
                        color: Theme.of(context).iconTheme.color,
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
      Future.delayed(duration, () => overlayEntry.remove());
    });
  }

  static Color _getIconBackgroundColor(SnackBarStatus status) {
    switch (status) {
      case SnackBarStatus.success:
        return AppColor.successColor;
      case SnackBarStatus.error:
        return AppColor.errorColor;
      case SnackBarStatus.warning:
        return AppColor.warningColor;
    }
  }

  static IconData _getIcon(SnackBarStatus status) {
    switch (status) {
      case SnackBarStatus.success:
        return Icons.check;
      case SnackBarStatus.error:
        return Icons.close;
      case SnackBarStatus.warning:
        return Icons.warning_amber_rounded;
    }
  }
}
