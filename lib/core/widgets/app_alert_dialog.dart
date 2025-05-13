import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_button.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmAction,
    this.iconColor,
    this.cancelAction,
    this.cancelActionTitle,
    this.confirmActionTitle,
  });

  final String title;
  final String content;
  final Color? iconColor;
  final VoidCallback confirmAction;
  final VoidCallback? cancelAction;
  final String? confirmActionTitle;
  final String? cancelActionTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingVeryLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimens.verySmall,
              children: [
                Icon(
                  CupertinoIcons.exclamationmark_circle,
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
            Text(
              content,
              style: theme.dialogTheme.contentTextStyle,
              textAlign: TextAlign.center,
            ),
            AppDimens.vSpaceVeryLarge,
            Row(
              spacing: AppDimens.small,
              children: [
                Expanded(
                  child: AppButton(
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
