import 'package:business_banking/features/credit_card/bloc/credit_card_bloc.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'credit_card_payment_response_presenter.dart';

class CreditCardPaymentResponseWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreditCardBloc>(
      create: (_) => CreditCardBloc(),
      child: CreditCardPaymentResponsePresenter(),
    );
  }
}
