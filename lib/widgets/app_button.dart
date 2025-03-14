import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onTap,
    this.bgColor,
    this.borderColor,
    this.borderWidth,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
      ),
      child: Material(
        color: bgColor ?? AppColor.primaryColor,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
          child: SizedBox(
            width: double.maxFinite,
            height: 40.h,
            child: Center(
              child: Text(
                text,
                style: theme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
