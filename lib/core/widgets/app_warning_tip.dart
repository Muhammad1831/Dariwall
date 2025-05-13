import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';

class AppWarningTip extends StatelessWidget {
  const AppWarningTip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColor.warningColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingSmall),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppIcons.alertCircle,
              width: AppDimens.iconSmall,
              height: AppDimens.iconSmall,
              fit: BoxFit.scaleDown,
            ),
            AppDimens.hSpaceVeryVerySmall,
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColor.warningColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
