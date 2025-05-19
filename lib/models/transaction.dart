class Transaction {
  String title;
  DateTime dateTime;
  int amount;
  TransactionType type;

  Transaction({
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.type,
  });

  static List<Transaction> transList = [
    Transaction(
      title: "Modou Ndiaye 777777777",
      dateTime: DateTime.now(),
      amount: 10000,
      type: TransactionType.reception,
    ),
    Transaction(
      title: "Mbaye Diop 787778778",
      dateTime: DateTime.now(),
      amount: 50000,
      type: TransactionType.envoi,
    ),
    Transaction(
      title: "Canal +",
      dateTime: DateTime.now(),
      amount: 15000,
      type: TransactionType.paiement,
    ),
    Transaction(
      title: "Retrait",
      dateTime: DateTime.now(),
      amount: 5000,
      type: TransactionType.retrait,
    ),
    Transaction(
      title: "Depot",
      dateTime: DateTime.now(),
      amount: 50000,
      type: TransactionType.depot,
    ),
  ];
}

enum TransactionType { retrait, depot, reception, envoi, paiement }
