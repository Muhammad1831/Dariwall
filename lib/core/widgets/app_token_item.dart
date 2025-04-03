import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad/core/constant/app_dimens.dart';

class AppTokenCard extends StatelessWidget {
  const AppTokenCard({
    super.key,
    required this.tokenIcon,
    required this.tokenName,
    required this.tokenProfit,
    required this.tokenTotalNumber,
    required this.tokenTotalPrice,
  });

  final String tokenIcon;
  final String tokenName;
  final String tokenTotalNumber;
  final String tokenTotalPrice;
  final String tokenProfit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.paddingSmall),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          AppDimens.paddingMedium,
          AppDimens.paddingSmall,
          AppDimens.paddingSmall,
          AppDimens.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              tokenIcon,
              height: AppDimens.iconExtraLarge,
              width: AppDimens.iconExtraLarge,
              fit: BoxFit.contain,
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
                  tokenProfit,
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: theme.colorScheme.error,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
