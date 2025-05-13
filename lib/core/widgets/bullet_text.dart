import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dariwall/core/constant/app_dimens.dart';

class BulletText extends StatelessWidget {
  const BulletText({
    super.key,
    required this.text,
    this.bulletColor,
    this.textStyle,
    this.bulletAlignment,
  });

  final String text;
  final Color? bulletColor;
  final TextStyle? textStyle; 
  final CrossAxisAlignment? bulletAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: bulletAlignment ?? CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 4,
          width: 4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bulletColor ?? theme.colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        AppDimens.hSpaceVerySmall,
        Expanded(
          child: Text(
            text,
            style: textStyle ??
                theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
