import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/utils/utils_cached_image.dart';
import 'package:dariwall/features/transactions/domain/entity/deposit_transactions_entity.dart';

class AppSwapTransactionItem extends StatelessWidget {
  const AppSwapTransactionItem({
    super.key,
    required this.myTransactions,
  });

  final DepositTransactionsEntity myTransactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.paddingSmall),
      child: Container(
        padding: EdgeInsets.all(AppDimens.paddingMedium),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                myTransactions.currencyInfo.currencyIcon != null
                    ? AppCachedImage(
                        imageUrl: myTransactions.currencyInfo.currencyIcon!,
                        height: AppDimens.iconExtraLarge,
                        width: AppDimens.iconExtraLarge,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        AppIcons.tomanIcon,
                        height: AppDimens.iconExtraLarge,
                        width: AppDimens.iconExtraLarge,
                        fit: BoxFit.contain,
                      ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SvgPicture.asset(
                    AppIcons.receiveTransaction,
                    height: AppDimens.iconMedium,
                    width: AppDimens.iconMedium,
                    fit: BoxFit.contain,
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
                    AppString.receive,
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
                    '${myTransactions.amount} ${myTransactions.currencyInfo.currencyEnName}',
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
