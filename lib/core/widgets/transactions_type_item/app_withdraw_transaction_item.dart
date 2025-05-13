import 'package:dariwall/core/route/app_route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/extensions/to_short_wallet_address_extensions.dart';
import 'package:dariwall/core/utils/utils_cached_image.dart';
import 'package:dariwall/features/transactions/domain/entity/withdrawals_transactions_entity.dart';
import 'package:go_router/go_router.dart';

class AppWithdrawTransactionItem extends StatelessWidget {
  const AppWithdrawTransactionItem({
    super.key,
    required this.myTransactions,
  });

  final WithdrawalsTransactionsEntity myTransactions;

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
                        AppIcons.sendTransaction,
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
                        AppString.send,
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          myTransactions.destinationAddress != null
                              ? '${AppString.toWallet}: ${myTransactions.destinationAddress!.toShortWalletAddress()}'
                              : '',
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        myTransactions.currencyInfo.currencyEnName,
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.errorColor,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        ' ${myTransactions.amount}-',
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.errorColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
