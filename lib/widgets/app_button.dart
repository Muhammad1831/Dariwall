import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onTap,
    this.bgColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.textColor,
    this.icon,
    this.iconColor,
    this.iconSize,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Color? textColor;
  final String? icon;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.borderRadiusSmall),
      ),
      child: Material(
        color: bgColor ?? AppColor.primaryColor,
        borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.borderRadiusSmall),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.borderRadiusSmall),
          child: SizedBox(
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: icon != null ? AppDimens.verySmall : 0,
              children: [
                if (icon != null)
                  SvgPicture.asset(
                    icon!,
                    height: iconSize ?? AppDimens.iconLarge,
                    width: iconSize ?? AppDimens.iconLarge,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      iconColor ?? theme.colorScheme.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                Text(
                  text,
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor ?? theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
