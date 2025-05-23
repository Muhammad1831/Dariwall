import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/widgets/app_loading.dart';

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
    this.isLoading = false,
    this.textHorizontalPadding,
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
  final bool isLoading;
  final double? textHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: isLoading ? 0.6 : 1.0,
      child: Material(
        color: bgColor ?? theme.buttonTheme.colorScheme!.primary,
        borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.borderRadiusSmall),
        child: AbsorbPointer(
          absorbing: isLoading,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.borderRadiusSmall),
            ),
            child: InkWell(
              onTap: isLoading ? null : onTap,
              borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.borderRadiusSmall),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppDimens.paddingMedium),
                child: isLoading == true
                    ? const AppLoading()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: textHorizontalPadding ?? 0),
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
          ),
        ),
      ),
    );
  }
}
