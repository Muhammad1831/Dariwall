import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';

class AppDescriptionDialog extends StatelessWidget {
  const AppDescriptionDialog({
    super.key,
    required this.title,
    required this.description,
    this.verticalAccentBarColor,
  });

  final String title;
  final String description;
  final Color? verticalAccentBarColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingMedium),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalAccentBar(color: verticalAccentBarColor),
            AppDimens.hSpaceVerySmall,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalAccentBar extends StatelessWidget {
  const VerticalAccentBar({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.large,
      width: AppDimens.veryVerySmall,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? AppColor.successColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AppDimens.borderRadiusVeryLarge),
            top: Radius.circular(AppDimens.borderRadiusVeryLarge),
          ),
        ),
      ),
    );
  }
}
