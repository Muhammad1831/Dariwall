import 'package:dariwall/core/widgets/app_gradient_border_box.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/utils/utils_cached_image.dart';

class AppTokenItem extends StatelessWidget {
  const AppTokenItem({
    super.key,
    required this.tokenIcon,
    required this.tokenName,
    this.tokenProfit,
    required this.tokenTotalNumber,
    required this.tokenTotalPrice,
    this.onTap,
  });

  final String tokenIcon;
  final String tokenName;
  final String tokenTotalNumber;
  final String tokenTotalPrice;
  final String? tokenProfit;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
        child: AppGradientBorderBox(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
          gradient: AppColor.strokeGradient,
          child: Container(
            padding: EdgeInsets.all(AppDimens.paddingMedium),
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: AppColor.glassBoxColors,
              //   begin: Alignment.centerLeft,
              //   end: Alignment.centerRight,
              // ),
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
              border: Border.all(
                color: AppColor.strokeColor,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: AppDimens.iconExtraLarge,
                  width: AppDimens.iconExtraLarge,
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.paddingVerySmall),
                    child: AppCachedImage(
                      imageUrl: tokenIcon,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                AppDimens.hSpaceVerySmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimens.verySmall,
                    children: [
                      Text(
                        tokenName,
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          tokenTotalNumber,
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimens.verySmall,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        tokenTotalPrice,
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      tokenProfit ?? '',
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
