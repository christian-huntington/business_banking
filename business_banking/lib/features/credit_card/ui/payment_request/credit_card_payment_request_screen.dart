import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:business_banking/features/credit_card/model/payment_request/credit_card_payment_request_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'credit_card_payment_request_actions.dart';

class CreditCardPaymentRequestScreen extends Screen {
  final CreditCardPaymentRequestViewModel viewModel;
  final CreditCardPaymentRequestActions actions;

  CreditCardPaymentRequestScreen({
    required this.viewModel,
    required this.actions,
  });

  final _form = GlobalKey<FormState>();

  final _paymentValueTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setPaymentValueTextEditingControllerValue(viewModel.paymentValue);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Balance'),
              Text(
                NumberFormat.simpleCurrency().format(viewModel.balance),
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w200),
                key: Key('bigBalance'),
              ),
              const SizedBox(height: 40.0),

              /// Payment Due Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Due Date:', style: TextStyle(fontSize: 15.0)),
                  Text(DateFormat.MMMd().format(viewModel.paymentDueDate),
                      style: TextStyle(fontSize: 15.0))
                ],
              ),
              const SizedBox(height: 10.0),

              /// Next Closing Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Next Closing Date:', style: TextStyle(fontSize: 15.0)),
                  Text(DateFormat.MMMd().format(viewModel.nextClosingDate),
                      style: TextStyle(fontSize: 15.0))
                ],
              ),
              const SizedBox(height: 10.0),

              /// Payment Minimum Value
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Minimum Value:',
                      style: TextStyle(fontSize: 15.0)),
                  Text(
                      NumberFormat.simpleCurrency()
                          .format(viewModel.paymentMinimumValue),
                      style: TextStyle(fontSize: 15.0))
                ],
              ),
              const SizedBox(height: 10.0),
              Divider(
                thickness: 1.0,
                color: Colors.black38,
              ),

              const SizedBox(height: 10.0),

              Form(
                  key: _form,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          controller: _paymentValueTextEditingController, //viewModel.paymentValueTextEditingController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.attach_money_outlined),
                              suffixStyle: TextStyle(color: Colors.orangeAccent),
                              labelText: 'Payment Amount',
                          ),
                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                          textInputAction: TextInputAction.done,
                          onChanged: (val) {
                            onPaymentValueChange(context, val);
                          },
                          onSaved: (val) {
                            onPaymentValueSaved(context);
                          },
                        ),
                      ),
                    ],
                  )),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      key: Key("payButton"),
                      onPressed: () {
                        _form.currentState!.save();
                         actions.pressPayButton(context, _getPaymentValue());
                      },
                      child: Text('Pay', style: TextStyle(fontSize: 20.0))),
                ],
              ),

              const SizedBox(height: 10.0),
              Divider(
                thickness: 1.0,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getPaymentValue() {
    try {
      String stringValue = formatNumericString(_paymentValueTextEditingController.text);
      double paymentValue = double.parse(stringValue);
      return paymentValue;
    } catch (error) {
      return 0.0;
    }
  }

  void onPaymentValueChange(BuildContext context, String val) {
    String stringValue = formatNumericString(val);
    try {
      double paymentValue = double.parse(stringValue);
      setPaymentValueTextEditingControllerValue(paymentValue);
    } catch (error) {
      setPaymentValueTextEditingControllerValue(0);
    }
  }

  void onPaymentValueSaved(BuildContext context) {
    try {
      double paymentValue = double.parse(_paymentValueTextEditingController.text);
      actions.onUpdatePaymentValue(context, paymentValue);
    } catch (error) {
      actions.onUpdatePaymentValue(context, 0);
    }
  }

  void setPaymentValueTextEditingControllerValue(double paymentValue) {
    _paymentValueTextEditingController.text = NumberFormat.simpleCurrency().format(paymentValue).replaceAll('\$','');
    _paymentValueTextEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _paymentValueTextEditingController.text.length));
  }

  String formatNumericString(String value) {
    value = value.replaceAll(RegExp('[^0-9]'), '');
    value = value.padLeft(3, '0');
    value = value.substring(0, value.length-2) + '.' + value.substring(value.length-2);
    while (value.startsWith('0')) value = value.substring(1);
    if (value.startsWith('.')) value = '0' + value;
    return value;
  }

}
