import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ostad/constant/app_dimens.dart';

class BulletText extends StatelessWidget {
  const BulletText({
    super.key,
    required this.text,
    this.bulletColor,
    this.textStyle,
  });

  final String text;
  final Color? bulletColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,  // Align to top
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h),  // Adjust bullet position
          child: SizedBox(
            height: 4.r,
            width: 4.r,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: bulletColor ?? theme.colorScheme.outline,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        AppDimens.hSpaceVerySmall,
        Expanded(  // Allow text to wrap
          child: Text(
            text,
            style: textStyle ?? theme.textTheme.labelSmall,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
} 