import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/base_transactions_entity.dart';

class WithdrawalsTransactionsEntity extends BaseTransactionEntity {
  final int account;
  final CurrencyInfoEntity currencyInfo;
  final double amount;
  final double finalAmount;
  final String? destinationAddress;
  WithdrawalsTransactionsEntity({
    required super.transactionType,
    required super.status,
    required super.createdAt,
    required super.createdDay,
    required super.updatedAt,
    required super.fee,
    super.description,
    required this.account,
    required this.currencyInfo,
    required this.amount,
    required this.finalAmount,
    this.destinationAddress,
  });
}
