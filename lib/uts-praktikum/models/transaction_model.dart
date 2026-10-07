class TransactionHistory {
  final String transactionId;
  final String productName;
  final String date;
  final double totalAmount;
  final String status;

  TransactionHistory({
    required this.transactionId,
    required this.productName,
    required this.date,
    required this.totalAmount,
    required this.status,
  });
}
