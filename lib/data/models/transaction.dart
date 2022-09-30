class Transaction {
  final String id;
  final String clientID;
  final String inquirerID;
  final String inquiryListID;
  final bool isCompleted;
  final double amount;
  final String? payPalID;
  final DateTime dateTimeStarted;
  final DateTime dateTimeEnded;

  Transaction(
      {required this.id,
      required this.clientID,
      required this.inquirerID,
      required this.inquiryListID,
      required this.isCompleted,
      required this.amount,
      this.payPalID,
      required this.dateTimeStarted,
      required this.dateTimeEnded});
}
