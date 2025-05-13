import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/base_transactions_entity.dart';

class SwapTransactionsEntity extends BaseTransactionEntity {
  final CurrencyInfoEntity sourceCurrencyInfo;
  final double sourceAmount;
  final CurrencyInfoEntity targetCurrencyInfo;
  final double targetAmount;
  final double finalTargetAmount;
  final int account;
  final String destinationAddress;

  SwapTransactionsEntity({
    required super.transactionType,
    required super.status,
    required super.createdAt,
    required super.createdDay,
    required super.updatedAt,
    required super.fee,
    super.description,
    required this.sourceCurrencyInfo,
    required this.sourceAmount,
    required this.targetCurrencyInfo,
    required this.targetAmount,
    required this.finalTargetAmount,
    required this.account,
    required this.destinationAddress,
  });
}
