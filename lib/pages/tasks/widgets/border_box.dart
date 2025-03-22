import 'package:flutter/material.dart';
import 'package:ostad/constant/app_dimens.dart';

class BorderBox extends StatelessWidget {
  const BorderBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.surface),
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingSmall),
        child: child,
      ),
    );
  }
}
