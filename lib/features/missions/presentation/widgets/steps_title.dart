import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';

class StepsTitle extends StatelessWidget {
  const StepsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppDimens.verySmall,
      children: [
        SvgPicture.asset(
          AppIcons.layer,
          height: AppDimens.iconSmall,
          width: AppDimens.iconSmall,
          fit: BoxFit.scaleDown,
        ),
        Text(
          AppString.steps,
          style: theme.textTheme.bodyMedium,
        )
      ],
    );
  }
}
