import 'package:flutter/material.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_transaction_item.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        right: AppDimens.paddingMedium,
        top: AppDimens.paddingLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppString.transactions, style: theme.textTheme.displaySmall),
          AppDimens.vSpaceLarge,
          Row(
            spacing: AppDimens.verySmall,
            children: [
              Text(
                'شنبه، 1404/02/03',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Expanded(
                child: Divider(),
              )
            ],
          ),
          AppDimens.vSpaceSmall,
          // task list
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.paddingMedium,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return AppTransactionItem(
                    tokenIcon: AppIcons.solana,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
