import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:dariwall/features/transactions/domain/entity/swap_transactions_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/transfer_transactions_entity.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/enum/transactions_type_enum.dart';
import 'package:dariwall/core/extensions/index_plus_one_extension.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
import 'package:dariwall/core/widgets/app_refresh_header.dart';
import 'package:dariwall/core/widgets/transactions_type_item/app_deposit_transaction_item.dart';
import 'package:dariwall/core/widgets/transactions_type_item/app_swap_transaction_item.dart';
import 'package:dariwall/core/widgets/transactions_type_item/app_transfer_transaction_item.dart';
import 'package:dariwall/core/widgets/transactions_type_item/app_withdraw_transaction_item.dart';
import 'package:dariwall/features/transactions/domain/entity/deposit_transactions_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/withdrawals_transactions_entity.dart';
import 'package:dariwall/features/transactions/presentation/provider/transactions_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<TransactionsProvider>(context, listen: false).getTransactions());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShadowBackground(
      child: Padding(
        padding: EdgeInsets.only(
          right: AppDimens.paddingMedium,
          top: AppDimens.paddingLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.transactions, style: theme.textTheme.displaySmall),
            AppDimens.vSpaceLarge,
            // task list
            Expanded(
              child: Selector<TransactionsProvider, TransactionsStatus>(
                selector: (context, myTransactionsProvider) => myTransactionsProvider.status,
                builder: (context, value, child) {
                  final provider = context.read<TransactionsProvider>();
                  if (provider.status == TransactionsStatus.loading) {
                    return AppLoading();
                  }
                  if (provider.mytransactions.isEmpty) {
                    return AppRefresher(
                      refreshController: refreshController,
                      onRefresh: () async {
                        await provider.getTransactions();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              AppImages.noTransactions,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Text(
                            AppString.noTransactions,
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return AppRefresher(
                    refreshController: refreshController,
                    onRefresh: () async {
                      await provider.getTransactions();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.paddingMedium,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: provider.mytransactions.length,
                        itemBuilder: (context, transactionsInSameDateIndex) {
                          return Column(
                            children: [
                              AppDimens.vSpaceMedium,
                              Row(
                                spacing: AppDimens.verySmall,
                                children: [
                                  Text(
                                    provider
                                        .mytransactions[transactionsInSameDateIndex].transactionDay,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    provider.mytransactions[transactionsInSameDateIndex]
                                        .transactionDate,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  Expanded(
                                    child: Divider(),
                                  )
                                ],
                              ),
                              AppDimens.vSpaceSmall,
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: provider.mytransactions[transactionsInSameDateIndex]
                                    .transactions.length,
                                itemBuilder: (context, index) {
                                  // withdraw
                                  if (TransactionsTypeEnum.withdraw.indexPlusOne ==
                                      provider.mytransactions[transactionsInSameDateIndex]
                                          .transactions[index].transactionType) {
                                    return AppWithdrawTransactionItem(
                                      myTransactions: provider
                                          .mytransactions[transactionsInSameDateIndex]
                                          .transactions[index] as WithdrawalsTransactionsEntity,
                                    );
                                  }
                                  // deposit
                                  else if (TransactionsTypeEnum.deposit.indexPlusOne ==
                                      provider.mytransactions[transactionsInSameDateIndex]
                                          .transactions[index].transactionType) {
                                    return AppDepositTransactionItem(
                                      myTransactions: provider
                                          .mytransactions[transactionsInSameDateIndex]
                                          .transactions[index] as DepositTransactionsEntity,
                                    );
                                  }
                                  // swap
                                  else if (TransactionsTypeEnum.swap.indexPlusOne ==
                                      provider.mytransactions[transactionsInSameDateIndex]
                                          .transactions[index].transactionType) {
                                    return AppSwapTransactionItem(
                                      myTransactions: provider
                                          .mytransactions[transactionsInSameDateIndex]
                                          .transactions[index] as SwapTransactionsEntity,
                                    );
                                  }
                                  // transfer
                                  else if (TransactionsTypeEnum.transfer.indexPlusOne ==
                                      provider.mytransactions[transactionsInSameDateIndex]
                                          .transactions[index].transactionType) {
                                    return AppTransferTransactionItem(
                                      myTransactions: provider
                                          .mytransactions[transactionsInSameDateIndex]
                                          .transactions[index] as TransferTransactionsEntity,
                                    );
                                  }
                                  return null;
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
