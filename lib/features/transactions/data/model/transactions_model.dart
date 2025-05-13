import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/transactions/data/model/base_transaction_model.dart';
import 'package:dariwall/features/transactions/domain/entity/base_transactions_entity.dart';

class TransactionsModel {
  final String transactionDate;
  final String transactionDay;
  final List<BaseTransactionEntity> transactions;

  TransactionsModel({
    required this.transactionDate,
    required this.transactionDay,
    required this.transactions,
  });

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransactionsModel(
      transactionDate: json[AppKeys.keyTransactionDate],
      transactionDay: json[AppKeys.keyTransactionDay],
      transactions: (json[AppKeys.keyTransactions] as List)
          .map((e) => BaseTransactionModel.fromJson(e))
          .toList(),
    );
  }
}
