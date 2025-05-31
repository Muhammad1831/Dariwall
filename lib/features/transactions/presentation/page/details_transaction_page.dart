import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/enum/transactions_status_enum.dart';
import 'package:dariwall/core/enum/transactions_type_enum.dart';
import 'package:dariwall/core/extensions/decimal_format_extension.dart';
import 'package:dariwall/core/extensions/index_plus_one_extension.dart';
import 'package:dariwall/core/extensions/jalali_date_extension.dart';
import 'package:dariwall/core/extensions/to_short_wallet_address_extensions.dart';
import 'package:dariwall/core/utils/utils_cached_image.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:dariwall/features/transactions/domain/entity/base_transactions_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/deposit_transactions_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/swap_transactions_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/transfer_transactions_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/withdrawals_transactions_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsTransactionPage extends StatelessWidget {
  const DetailsTransactionPage({super.key, required this.transaction});

  final BaseTransactionEntity transaction;

  String getHeaderText() {
    if (transaction is WithdrawalsTransactionsEntity) {
      return AppString.send;
    } else if (transaction is DepositTransactionsEntity) {
      return AppString.receive;
    } else if (transaction is SwapTransactionsEntity) {
      return AppString.swap;
    } else if (transaction is TransferTransactionsEntity) {
      return AppString.transfer;
    }
    return '';
  }

  List<String> getImageUrl() {
    if (transaction is DepositTransactionsEntity) {
      return [(transaction as DepositTransactionsEntity).currencyInfo.currencyIcon!];
    }
    if (transaction is SwapTransactionsEntity) {
      return [
        (transaction as SwapTransactionsEntity).sourceCurrencyInfo.currencyIcon!,
        (transaction as SwapTransactionsEntity).targetCurrencyInfo.currencyIcon!
      ];
    }
    if (transaction is TransferTransactionsEntity) {
      return [(transaction as TransferTransactionsEntity).currencyInfo.currencyIcon!];
    }
    if (transaction is WithdrawalsTransactionsEntity) {
      return [(transaction as WithdrawalsTransactionsEntity).currencyInfo.currencyIcon!];
    }
    return [AppIcons.tomanIcon];
  }

  String? getTransactionTypeImage() {
    if (transaction is DepositTransactionsEntity) {
      return AppIcons.receiveTransaction;
    }
    if (transaction is SwapTransactionsEntity) {
      return null;
    }
    if (transaction is TransferTransactionsEntity) {
      return AppIcons.sendTransaction;
    }
    if (transaction is WithdrawalsTransactionsEntity) {
      return AppIcons.sendTransaction;
    }
    return AppIcons.tomanIcon;
  }

  String getTransactionAmount() {
    if (transaction is DepositTransactionsEntity) {
      return '${(transaction as DepositTransactionsEntity).amount.toString().formatDecimal()} ${(transaction as DepositTransactionsEntity).currencyInfo.currencyEnName}';
    }
    if (transaction is SwapTransactionsEntity) {
      return '${(transaction as SwapTransactionsEntity).sourceAmount.toString().formatDecimal()} ${(transaction as SwapTransactionsEntity).sourceCurrencyInfo.currencyEnName}';
    }
    if (transaction is TransferTransactionsEntity) {
      return '${(transaction as TransferTransactionsEntity).amount.toString().formatDecimal()} ${(transaction as TransferTransactionsEntity).currencyInfo.currencyEnName}';
    }
    if (transaction is WithdrawalsTransactionsEntity) {
      return '${(transaction as WithdrawalsTransactionsEntity).amount.toString().formatDecimal()} ${(transaction as WithdrawalsTransactionsEntity).currencyInfo.currencyEnName}';
    }
    return '';
  }

  String getTransactionStatus() {
    if (transaction.status == TransactionsStatusEnum.pending.indexPlusOne) {
      return AppString.pending;
    }
    if (transaction.status == TransactionsStatusEnum.completed.indexPlusOne) {
      return AppString.completed;
    }
    if (transaction.status == TransactionsStatusEnum.failed.indexPlusOne) {
      return AppString.failed;
    }
    if (transaction.status == TransactionsStatusEnum.reverted.indexPlusOne) {
      return AppString.reverted;
    }
    return '';
  }

  Color getTransactionStatusColor(ThemeData theme) {
    if (transaction.status == TransactionsStatusEnum.pending.indexPlusOne) {
      return AppColor.warningColor;
    }
    if (transaction.status == TransactionsStatusEnum.completed.indexPlusOne) {
      return theme.colorScheme.primary;
    }
    if (transaction.status == TransactionsStatusEnum.failed.indexPlusOne) {
      return theme.colorScheme.error;
    }
    if (transaction.status == TransactionsStatusEnum.reverted.indexPlusOne) {
      return theme.colorScheme.error;
    }
    return theme.colorScheme.onPrimary;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: AppShadowBackground(
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: Column(
              children: [
                AppHeader(headerText: getHeaderText()),
                AppDimens.vSpaceExtraLarge,
                getTransactionTypeImage() != null
                    ? Stack(
                        children: [
                          AppCachedImage(
                            imageUrl: getImageUrl().first,
                            height: size.width * 0.25,
                            width: size.width * 0.25,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              getTransactionTypeImage()!,
                              height: AppDimens.iconVeryLarge,
                              width: AppDimens.iconVeryLarge,
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        height: size.width * 0.25,
                        width: size.width * 0.25,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              bottom: 15,
                              right: 15,
                              child: AppCachedImage(
                                imageUrl: getImageUrl().first,
                                height: size.width * 0.20,
                                width: size.width * 0.20,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              bottom: -15,
                              right: -15,
                              child: AppCachedImage(
                                imageUrl: getImageUrl().last,
                                width: size.width * 0.20,
                                height: size.width * 0.20,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
                AppDimens.vSpaceLarge,
                Text(
                  getTransactionAmount(),
                  style: transaction.transactionType == TransactionsTypeEnum.deposit.indexPlusOne
                      ? theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary.withValues(alpha: 0.8),
                          fontWeight: FontWeight.bold,
                        )
                      : theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.error.withValues(alpha: 0.8),
                          fontWeight: FontWeight.bold,
                        ),
                ),
                AppDimens.vSpaceLarge,
                // date of transaction
                DetailsTransactionItem(
                  title: AppString.date,
                  value:
                      '${transaction.createdAt.toJalaliDateOnly() ?? ''} ${AppString.inHour} ${transaction.createdAt.toJalaliTimeOnly() ?? ''}',
                  borderRadiusTop: AppDimens.borderRadiusLarge,
                ),
                Divider(
                  color: theme.scaffoldBackgroundColor,
                  height: 0,
                ),
                // status of transaction
                DetailsTransactionItem(
                  title: AppString.status,
                  value: getTransactionStatus(),
                  valueColor: getTransactionStatusColor(theme),
                ),
                if (transaction.transactionType == TransactionsTypeEnum.deposit.indexPlusOne)
                  Column(
                    children: [
                      Divider(
                        color: theme.scaffoldBackgroundColor,
                        height: 0,
                      ),
                      // if is deposit show source wallet
                      DetailsTransactionItem(
                        title: AppString.receivedFrom,
                        value: (transaction as DepositTransactionsEntity)
                                .sourceAddress
                                ?.toShortWalletAddress() ??
                            AppString.dariWall,
                      ),
                    ],
                  ),
                // if is withdraw show target wallet
                if (transaction.transactionType == TransactionsTypeEnum.withdraw.indexPlusOne)
                  Column(
                    children: [
                      Divider(
                        color: theme.scaffoldBackgroundColor,
                        height: 0,
                      ),
                      DetailsTransactionItem(
                        title: AppString.sendTo,
                        value: (transaction as WithdrawalsTransactionsEntity)
                                .destinationAddress
                                ?.toShortWalletAddress() ??
                            AppString.dariWall,
                      ),
                    ],
                  ),
                Divider(
                  color: theme.scaffoldBackgroundColor,
                  height: 0,
                ),
                // fee of transaction
                DetailsTransactionItem(
                  title: AppString.fee,
                  value: transaction.fee.toString().formatDecimal(),
                  borderRadiusBottom: AppDimens.borderRadiusLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsTransactionItem extends StatelessWidget {
  const DetailsTransactionItem({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.borderRadiusTop,
    this.borderRadiusBottom,
  });

  final String title;
  final String value;
  final Color? valueColor;
  final double? borderRadiusTop;
  final double? borderRadiusBottom;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadiusTop ?? 0),
          bottom: Radius.circular(borderRadiusBottom ?? 0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.paddingLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
