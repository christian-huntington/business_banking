import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'credit_card_payment_response_actions.dart';

class CreditCardPaymentResponseScreen extends Screen {
  final CreditCardPaymentResponseViewModel viewModel;
  final CreditCardPaymentResponseActions actions;

  CreditCardPaymentResponseScreen({
    required this.viewModel,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: GestureDetector(
            child: Icon(
              Icons.chevron_left,
              size: 40.0,
            ),
            onTap: () {
              this.actions.navigateBack(context);
            },
            key: Key('backButton'),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                viewModel.name,
                key: Key('titleName'),
              ),
              Text(
                '*' + viewModel.lastFour,
                key: Key('titleLastFour'),
              )
            ],
          ),
        ),
        body: (viewModel.paymentStatus == 'Successful')
            ? CreditCardPaymentResponseSuccess(viewModel: viewModel, actions: actions)
            : (viewModel.paymentStatus == 'Rejected')
                ? CreditCardPaymentResponseRejected(viewModel: viewModel, actions: actions)
                : (viewModel.paymentStatus == 'Processing')
                    ? CreditCardPaymentResponseProcessing(viewModel: viewModel, actions: actions)
                    : (viewModel.paymentStatus == 'Error')
                      ? CreditCardPaymentResponseError(viewModel: viewModel, actions: actions)
                      : CreditCardPaymentResponseNone(viewModel: viewModel, actions: actions));
  }


}

class CreditCardPaymentResponseSuccess extends StatelessWidget {
  final CreditCardPaymentResponseViewModel viewModel;
  final CreditCardPaymentResponseActions actions;

  CreditCardPaymentResponseSuccess({
    required this.viewModel,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Payment Value'),
            Text(NumberFormat.simpleCurrency().format(viewModel.paymentValue), style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w200)),
            const SizedBox(height: 40.0),
            Divider(thickness: 1.0, color: Colors.black38),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Payment Successful', style: TextStyle(fontSize: 15.0)),
              ],
            ),
            const SizedBox(height: 10.0),
            Divider(thickness: 1.0, color: Colors.black38),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    key: Key("shareButton"),
                    onPressed: () {
                      actions.sharePDFPaymentConfirmation(context);
                    },
                    child: Text('Share', style: TextStyle(fontSize: 20.0))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardPaymentResponseRejected extends StatelessWidget {
  final CreditCardPaymentResponseViewModel viewModel;
  final CreditCardPaymentResponseActions actions;

  CreditCardPaymentResponseRejected({
    required this.viewModel,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Divider(thickness: 1.0, color: Colors.black38),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Payment Rejected', style: TextStyle(fontSize: 15.0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(viewModel.reasonRejected, style: TextStyle(fontSize: 15.0)),
              ],
            ),
            const SizedBox(height: 10.0),
            Divider(thickness: 1.0, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

class CreditCardPaymentResponseProcessing extends StatelessWidget {
  final CreditCardPaymentResponseViewModel viewModel;
  final CreditCardPaymentResponseActions actions;

  CreditCardPaymentResponseProcessing({
    required this.viewModel,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Divider(thickness: 1.0, color: Colors.black38),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Processing payment...', style: TextStyle(fontSize: 15.0)),
              ],
            ),
            const SizedBox(height: 10.0),
            Divider(thickness: 1.0, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

class CreditCardPaymentResponseError extends StatelessWidget {
  final CreditCardPaymentResponseViewModel viewModel;
  final CreditCardPaymentResponseActions actions;

  CreditCardPaymentResponseError({
    required this.viewModel,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Divider(thickness: 1.0, color: Colors.black38),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error while processing payment', style: TextStyle(fontSize: 15.0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(viewModel.reasonRejected, style: TextStyle(fontSize: 15.0)),
              ],
            ),
            const SizedBox(height: 10.0),
            Divider(thickness: 1.0, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

class CreditCardPaymentResponseNone extends StatelessWidget {
  final CreditCardPaymentResponseViewModel viewModel;
  final CreditCardPaymentResponseActions actions;

  CreditCardPaymentResponseNone({
    required this.viewModel,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Divider(thickness: 1.0, color: Colors.black38),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No payment being processed. Try again.', style: TextStyle(fontSize: 15.0)),
              ],
            ),
            const SizedBox(height: 10.0),
            Divider(thickness: 1.0, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
