import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.headerText,
    this.justIcon = false,
    this.onTap,
  });

  final String headerText;
  final VoidCallback? onTap;
  final bool justIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                headerText,
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onTap ?? () => GoRouter.of(context).pop(),
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingSmall),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: !justIcon ? AppDimens.verySmall : 0,
              children: [
                if (!justIcon)
                  Text(
                    AppString.back,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontSize: 16.sp,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                SvgPicture.asset(
                  AppIcons.arrowLeft,
                  height: AppDimens.iconLarge,
                  width: AppDimens.iconLarge,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
