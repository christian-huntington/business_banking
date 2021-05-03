import 'package:clean_framework/clean_framework.dart';
import 'credit_card_view_model.dart';

class CreditCardEntity extends Entity {
  final String number;
  final String name;
  final String lastFour;
  final double balance;
  final DateTime paymentDueDate;
  final DateTime nextClosingDate;
  final double paymentMinimumValue;
  final List<CreditCardTransaction> transactions;

  CreditCardEntity({
    List<EntityFailure> errors = const [],
    String? number,
    String? name,
    String? lastFour,
    double? balance,
    DateTime? paymentDueDate,
    DateTime? nextClosingDate,
    double? paymentMinimumValue,
    List<CreditCardTransaction>? transactions,
  })  : number = number ?? '',
        name = name ?? '',
        lastFour = lastFour ?? '',
        balance = balance ?? 0.00,
        paymentDueDate = paymentDueDate ?? DateTime.fromMicrosecondsSinceEpoch(0),
        nextClosingDate = nextClosingDate ?? DateTime.fromMicrosecondsSinceEpoch(0),
        paymentMinimumValue = paymentMinimumValue ?? 0.00,
        transactions = transactions ?? List<CreditCardTransaction>.empty(growable: false),
        super(errors: errors);

  @override
  List<Object> get props => [
        errors,
        number,
        name,
        lastFour,
        balance,
        paymentDueDate,
        nextClosingDate,
        paymentMinimumValue,
        transactions,
      ];

  @override
  merge({
    errors,
    String? number,
    String? name,
    String? lastFour,
    double? balance,
    DateTime? paymentDueDate,
    DateTime? nextClosingDate,
    double? paymentMinimumValue,
    List<CreditCardTransaction>? transactions
  }) {
    return CreditCardEntity(
      errors: errors ?? this.errors,
      number: number ?? this.number,
      name: name ?? this.name,
      lastFour: lastFour ?? this.lastFour,
      balance: balance ?? this.balance,
      paymentDueDate: paymentDueDate ?? this.paymentDueDate,
      nextClosingDate: nextClosingDate ?? this.nextClosingDate,
      paymentMinimumValue: paymentMinimumValue ?? this.paymentMinimumValue,
      transactions: transactions ?? this.transactions,
    );
  }
}
