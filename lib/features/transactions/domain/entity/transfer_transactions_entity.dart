import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/base_transactions_entity.dart';

class TransferTransactionsEntity extends BaseTransactionEntity {
  final int sender;
  final int recipient;
  final CurrencyInfoEntity currencyInfo;
  final double amount;
  final double finalAmount;

  TransferTransactionsEntity({
    required super.transactionType,
    required super.status,
    required super.createdAt,
    required super.createdDay,
    required super.updatedAt,
    required super.fee,
    super.description,
    required this.sender,
    required this.recipient,
    required this.currencyInfo,
    required this.amount,
    required this.finalAmount,
  });
}
