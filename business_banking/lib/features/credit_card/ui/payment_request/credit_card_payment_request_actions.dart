import 'package:business_banking/features/credit_card/bloc/credit_card_bloc.dart';
import 'package:business_banking/features/credit_card/bloc/credit_card_view_events.dart';
import 'package:business_banking/features/credit_card/model/payment_request/credit_card_payment_request_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../routes.dart';

class CreditCardPaymentRequestActions {

  final CreditCardBloc bloc;
  final CreditCardPaymentRequestViewModel viewModel;

  CreditCardPaymentRequestActions(this.bloc, this.viewModel);

  void navigateBack(BuildContext context) {
    CFRouterScope.of(context).popUntil(BusinessBankingRouter.creditCardDetailsRoute);
  }

  void pressPayButton(BuildContext context, double paymentValue) {
    String message = bloc.validatePaymentInformation(viewModel, paymentValue);
    if (message.length > 0) {
      _showDialog(context, "Invalid Information!", message, () {
        Navigator.of(context).pop();
      });
      return;
    } else {
      CFRouterScope.of(context).push(BusinessBankingRouter.creditCardPaymentResponseRoute);
    }
  }

  void onUpdatePaymentValue(BuildContext context, double paymentValue) {
    var event = CreditCardViewEventUpdatePaymentValue(this.viewModel, paymentValue);
    bloc.creditCardViewEventsPipe.send(event);
  }

  void _showDialog(BuildContext context, String title, String message, Function onPressedOK) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              onPressedOK();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

}
