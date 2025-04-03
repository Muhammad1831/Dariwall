import 'package:flutter/material.dart';
import 'package:ostad/core/constant/app_dimens.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SizedBox(
        height: AppDimens.iconLarge,
        width: AppDimens.iconLarge,
        child: CircularProgressIndicator(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
