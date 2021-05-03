import 'package:clean_framework/clean_framework.dart';

class CreditCardViewModel extends ViewModel {
  final String number;
  final String name;
  final String lastFour;
  final double balance;
  final DateTime paymentDueDate;
  final DateTime nextClosingDate;
  final double paymentMinimumValue;
  final List<CreditCardTransaction> transactions;

  CreditCardViewModel({
    required this.number,
    required this.name,
    required this.lastFour,
    required this.balance,
    required this.paymentDueDate,
    required this.nextClosingDate,
    required this.paymentMinimumValue,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
        number,
        name,
        lastFour,
        balance,
        paymentDueDate,
        nextClosingDate,
        paymentMinimumValue,
        transactions,
      ];

}

class CreditCardTransaction {
  final String id;
  final String name;
  final double value;
  final DateTime date;

  CreditCardTransaction({required this.id, required this.name, required this.value, required this.date});

  CreditCardTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? '',
        value = json['value'] ?? 0.00,
        date = json['date'] == null ? DateTime.fromMicrosecondsSinceEpoch(0) : DateTime.parse(json['date']);

}
