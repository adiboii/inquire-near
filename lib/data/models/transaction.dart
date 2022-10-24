class INTransaction {
  late String? id;
  final String clientID;
  final String inquirerID;
  final String inquiryListID;
  final bool isCompleted;
  final double amount;
  final String payPalID;
  final DateTime dateTimeStarted;
  late DateTime? dateTimeEnded;

  INTransaction(
      {this.id,
      required this.clientID,
      required this.inquirerID,
      required this.inquiryListID,
      required this.isCompleted,
      required this.amount,
      required this.payPalID,
      required this.dateTimeStarted,
      this.dateTimeEnded});

  INTransaction.fromJson(Map<String, dynamic> json)
      : clientID = json['clientID'],
        inquirerID = json['inquirerID'],
        inquiryListID = json['inquiryListID'],
        isCompleted = json['isCompleted'],
        amount = json['amount'],
        payPalID = json['payPalID'],
        dateTimeStarted = json['dateTimeStarted'];
}
