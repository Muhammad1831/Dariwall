
abstract class BaseTransactionEntity {
  final int transactionType;
  final int status;
  final String createdAt;
  final String createdDay;
  final String updatedAt;
  final double fee;
  final String? description;

  BaseTransactionEntity({
    required this.transactionType,
    required this.status,
    required this.createdAt,
    required this.createdDay,
    required this.updatedAt,
    required this.fee,
    this.description,
  });
}
