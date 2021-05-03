import 'package:business_banking/features/credit_card/model/payment_request/credit_card_payment_request_view_model.dart';
import 'package:equatable/equatable.dart';

abstract class CreditCardViewEvents extends Equatable {}

class CreditCardViewEventUpdatePaymentValue extends CreditCardViewEvents {

  final double paymentValue;
  final CreditCardPaymentRequestViewModel viewModel;

  CreditCardViewEventUpdatePaymentValue(this.viewModel, this.paymentValue);

  @override
  List<Object?> get props => [viewModel, paymentValue];

}
