import 'package:business_banking/features/credit_card/bloc/credit_card_bloc.dart';
import 'package:business_banking/features/credit_card/model/payment_request/credit_card_payment_request_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'credit_card_payment_request_actions.dart';
import 'credit_card_payment_request_screen.dart';

class CreditCardPaymentRequestPresenter extends Presenter<CreditCardBloc, CreditCardPaymentRequestViewModel, CreditCardPaymentRequestScreen> {
  @override
  Stream<CreditCardPaymentRequestViewModel> getViewModelStream(CreditCardBloc bloc) {
    return bloc.creditCardPaymentRequestViewModelPipe.receive;
  }

  @override
  CreditCardPaymentRequestScreen buildScreen(BuildContext context, CreditCardBloc bloc, CreditCardPaymentRequestViewModel viewModel) {
    return CreditCardPaymentRequestScreen(
      viewModel: viewModel,
      actions: CreditCardPaymentRequestActions(bloc, viewModel),
    );
  }

}
