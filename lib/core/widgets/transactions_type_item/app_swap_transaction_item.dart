import 'package:dariwall/core/extensions/decimal_format_extension.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/features/transactions/domain/entity/swap_transactions_entity.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/utils/utils_cached_image.dart';
import 'package:go_router/go_router.dart';

class AppSwapTransactionItem extends StatelessWidget {
  const AppSwapTransactionItem({
    super.key,
    required this.myTransactions,
  });

  final SwapTransactionsEntity myTransactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.paddingSmall),
      child: Material(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
        child: InkWell(
          onTap: () {
            context.pushNamed(
              AppRouteName.detailsTransaction,
              extra: myTransactions,
            );
          },
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppDimens.iconExtraLarge,
                  width: AppDimens.iconExtraLarge,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (myTransactions.sourceCurrencyInfo.currencyIcon != null)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: AppCachedImage(
                            imageUrl: myTransactions.sourceCurrencyInfo.currencyIcon!,
                            height: AppDimens.iconVeryLarge,
                            width: AppDimens.iconVeryLarge,
                            fit: BoxFit.contain,
                          ),
                        )
                      else
                        Image.asset(
                          AppIcons.tomanIcon,
                          height: AppDimens.iconVeryLarge,
                          width: AppDimens.iconVeryLarge,
                          fit: BoxFit.contain,
                        ),
                      if (myTransactions.targetCurrencyInfo.currencyIcon != null)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: AppCachedImage(
                            imageUrl: myTransactions.targetCurrencyInfo.currencyIcon!,
                            height: AppDimens.iconVeryLarge,
                            width: AppDimens.iconVeryLarge,
                            fit: BoxFit.contain,
                          ),
                        )
                      else
                        Image.asset(
                          AppIcons.tomanIcon,
                          height: AppDimens.iconVeryLarge,
                          width: AppDimens.iconVeryLarge,
                          fit: BoxFit.contain,
                        ),
                    ],
                  ),
                ),
                AppDimens.hSpaceVerySmall,
                Expanded(
                  child: Text(
                    AppString.swap,
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                        '${myTransactions.sourceAmount.toString().formatDecimal()} ${myTransactions.sourceCurrencyInfo.currencyEnName}',
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                    Text(
                      '${myTransactions.targetAmount.toString().formatDecimal()} ${myTransactions.targetCurrencyInfo.currencyEnName}',
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: AppColor.successColor,
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
