import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';

class AppTransactionItem extends StatelessWidget {
  const AppTransactionItem({super.key, required this.tokenIcon});

  final String tokenIcon;

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
            Stack(
              children: [
                SvgPicture.asset(
                  tokenIcon,
                  height: AppDimens.iconExtraLarge,
                  width: AppDimens.iconExtraLarge,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SvgPicture.asset(
                    AppIcons.receiveTransaction,
                  ),
                )
              ],
            ),
            AppDimens.hSpaceVerySmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: AppDimens.verySmall,
                children: [
                  Text(
                    'دریافت',
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'از کیف پول: FdpI...g9wQ',
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
                    '+0.012 OSTAD',
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.successColor,
                    ),
                  ),
                ),
                Text(
                  '-0.012 SOL',
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
