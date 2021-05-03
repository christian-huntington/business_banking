import 'package:business_banking/features/credit_card/bloc/credit_card_bloc.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'credit_card_payment_response_actions.dart';
import 'credit_card_payment_response_screen.dart';

class CreditCardPaymentResponsePresenter extends Presenter<CreditCardBloc, CreditCardPaymentResponseViewModel, CreditCardPaymentResponseScreen> {
  @override
  Stream<CreditCardPaymentResponseViewModel> getViewModelStream(CreditCardBloc bloc) {
    return bloc.creditCardPaymentResponseViewModelPipe.receive;
  }

  @override
  CreditCardPaymentResponseScreen buildScreen(BuildContext context, CreditCardBloc bloc, CreditCardPaymentResponseViewModel viewModel) {
    return CreditCardPaymentResponseScreen(
      viewModel: viewModel,
      actions: CreditCardPaymentResponseActions(bloc, viewModel),
    );
  }

}
