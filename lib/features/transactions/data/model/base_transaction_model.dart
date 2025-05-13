import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/transactions/data/model/deposit_transactions_model.dart';
import 'package:dariwall/features/transactions/data/model/swap_transactions_model.dart';
import 'package:dariwall/features/transactions/data/model/transfer_transactions_model.dart';
import 'package:dariwall/features/transactions/data/model/withdrawals_transactions_model.dart';
import 'package:dariwall/features/transactions/domain/entity/base_transactions_entity.dart';

class BaseTransactionModel {
  final BaseTransactionEntity myTransaction;

  BaseTransactionModel({required this.myTransaction});

  static BaseTransactionEntity fromJson(Map<String, dynamic> json) {
    final type = json[AppKeys.keyTransactionType] as int;

    switch (type) {
      case 1: // Swap
        return SwapTransactionsModel.fromJson(json);
      case 2: // Transfer
        return TransferTransactionsModel.fromJson(json);
      case 3: // Deposit
        return DepositTransactionsModel.fromJson(json);
      case 4: // Withdrawal
        return WithdrawalsTransactionsModel.fromJson(json);
      default:
        throw Exception('Unknown transaction type: $type');
    }
  }
}
