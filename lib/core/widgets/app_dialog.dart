import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmAction,
    this.isLoading = false,
    this.iconColor,
    this.icon,
    this.cancelAction,
    this.cancelActionTitle,
    this.confirmActionTitle,
    this.child,
    this.alignment,
  });

  final String title;
  final String content;
  final Color? iconColor;
  final IconData? icon;
  final VoidCallback confirmAction;
  final bool isLoading;
  final VoidCallback? cancelAction;
  final String? confirmActionTitle;
  final String? cancelActionTitle;
  final Widget? child;
  final CrossAxisAlignment? alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingVeryLarge),
        child: Column(
          crossAxisAlignment: alignment ?? CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // title and icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimens.verySmall,
              children: [
                Icon(
                  icon ?? CupertinoIcons.exclamationmark_circle,
                  color: iconColor ?? AppColor.errorColor,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: theme.dialogTheme.titleTextStyle,
                  ),
                ),
              ],
            ),
            AppDimens.vSpaceMedium,
            // content
            Text(
              content,
              style: theme.dialogTheme.contentTextStyle,
              textAlign: TextAlign.center,
            ),
            // child
            if (child != null)
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.paddingLarge),
                child: child!,
              ),
            AppDimens.vSpaceVeryLarge,
            // actions
            Row(
              spacing: AppDimens.small,
              children: [
                Expanded(
                  child: AppButton(
                    isLoading: isLoading,
                    text: confirmActionTitle ?? AppString.confirm,
                    onTap: confirmAction,
                  ),
                ),
                Expanded(
                  child: AppButton(
                    text: cancelActionTitle ?? AppString.cancel,
                    bgColor: Colors.transparent,
                    borderColor: theme.colorScheme.outline,
                    onTap: cancelAction ?? () => context.pop(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
