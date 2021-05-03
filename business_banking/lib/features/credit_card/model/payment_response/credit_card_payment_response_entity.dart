import 'package:clean_framework/clean_framework.dart';

class CreditCardPaymentResponseEntity extends Entity {
  final String number;
  final String name;
  final String lastFour;
  final double paymentValue;
  final String paymentStatus;
  final String reasonRejected;

  CreditCardPaymentResponseEntity({
    List<EntityFailure> errors = const [],
    String? number,
    String? name,
    String? lastFour,
    double? paymentValue,
    String? paymentStatus,
    String? reasonRejected
  })  : number = number ?? '',
        name = name ?? '',
        lastFour = lastFour ?? '',
        paymentValue = paymentValue ?? 0.00,
        paymentStatus = paymentStatus ?? "Processing",
        reasonRejected = reasonRejected ?? "",
        super(errors: errors);

  @override
  List<Object> get props => [
        errors,
        number,
        name,
        lastFour,
        paymentValue,
        paymentStatus,
        reasonRejected,
      ];

  @override
  merge({
    errors,
    String? number,
    String? name,
    String? lastFour,
    double? paymentValue,
    String? paymentStatus,
    String? reasonRejected,
  }) {
    return CreditCardPaymentResponseEntity(
      errors: errors ?? this.errors,
      number: number ?? this.number,
      name: name ?? this.name,
      lastFour: lastFour ?? this.lastFour,
      paymentValue: paymentValue ?? this.paymentValue,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      reasonRejected: reasonRejected ?? this.reasonRejected,
    );
  }
}
