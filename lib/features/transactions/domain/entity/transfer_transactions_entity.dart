import 'package:dariwall/core/global_entity/currency_info_entity.dart';
import 'package:dariwall/features/transactions/domain/entity/base_transactions_entity.dart';

class TransferTransactionsEntity extends BaseTransactionEntity {
  final String senderAddress;
  final String recipientAddress;
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
    required this.senderAddress,
    required this.recipientAddress,
    required this.currencyInfo,
    required this.amount,
    required this.finalAmount,
  });
}
