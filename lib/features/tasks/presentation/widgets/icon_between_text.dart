
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_string.dart';

class IconBetweenText extends StatelessWidget {
  const IconBetweenText({
    super.key,
    required this.startText,
    required this.endText,
    required this.icon,
    this.bulletColor,
  });

  final String startText;
  final String endText;
  final String icon;
  final Color? bulletColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          height: 4,
          width: 4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bulletColor ?? theme.colorScheme.outline,
              shape: BoxShape.circle,
            ),
          ),
        ),
        AppDimens.hSpaceVerySmall,
        Expanded(
          child: Text.rich(
            TextSpan(
              style: theme.textTheme.labelMedium,
              children: [
                TextSpan(text: startText),
                TextSpan(text: AppString.startParantse),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SvgPicture.asset(
                    icon,
                    height: AppDimens.iconSmall,
                    width: AppDimens.iconSmall,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                TextSpan(text: AppString.endParantse),
                TextSpan(text: endText),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
