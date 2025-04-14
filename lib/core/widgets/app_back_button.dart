import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_dimens.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onTap,
    this.icon,
  });

  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: onTap ?? () => context.pop(),
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: EdgeInsets.all(AppDimens.paddingSmall),
          child: Icon(
            icon ?? CupertinoIcons.chevron_right  ,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
