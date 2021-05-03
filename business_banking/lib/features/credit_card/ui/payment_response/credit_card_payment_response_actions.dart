import 'package:business_banking/dependency/pdf_handler.dart';
import 'package:business_banking/features/credit_card/bloc/credit_card_bloc.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import '../../../../routes.dart';

class CreditCardPaymentResponseActions {

  final CreditCardBloc bloc;
  final CreditCardPaymentResponseViewModel viewModel;

  CreditCardPaymentResponseActions(this.bloc, this.viewModel);

  void navigateBack(BuildContext context) {
     CFRouterScope.of(context).popUntil(BusinessBankingRouter.creditCardDetailsRoute);
  }

  void sharePDFPaymentConfirmation(BuildContext context) async {
    PDFHandler pdf = await bloc.generatePDFPaymentConfirmation(viewModel);
    pdf.share('payment-confirmation.pdf');
  }

}
