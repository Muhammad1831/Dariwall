import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_string.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.headerText,
    this.onTap,
  });

  final String headerText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headerText,
          style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap ?? () => GoRouter.of(context).pop(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppString.back,
                style: theme.textTheme.headlineSmall!.copyWith(fontSize: 16.sp),
              ),
              AppDimens.hSpaceVerySmall,
              Icon(
                Icons.arrow_forward_rounded,
                color: theme.iconTheme.color,
              ),
            ],
          ),
        )
      ],
    );
  }
}
