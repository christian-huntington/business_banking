import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/credit_card_view_model.dart';
import 'credit_card_details_actions.dart';

class CreditCardDetailsScreen extends Screen {
  final CreditCardViewModel viewModel;
  final CreditCardDetailsActions actions;

  CreditCardDetailsScreen({
    required this.viewModel,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      key: Key("payButton"),
                      onPressed: () {
                          actions.pressPayButton(context);
                      },
                      child: Text('Pay', style: TextStyle(fontSize: 20.0))),
                ],
              ),

              const SizedBox(height: 10.0),
              Divider(
                thickness: 1.0,
                color: Colors.black38,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Recent Transactions', style: TextStyle(fontSize: 15.0)),
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(viewModel.transactions[index].name,
                                style: TextStyle(fontSize: 15.0)),
                            Text(
                                NumberFormat.simpleCurrency().format(
                                    viewModel.transactions[index].value),
                                style: TextStyle(fontSize: 15.0))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                DateFormat.MMMd()
                                    .format(viewModel.transactions[index].date),
                                style: TextStyle(fontSize: 15.0))
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Divider(
                          thickness: 0.2,
                          color: Colors.black38,
                        ),
                        const SizedBox(height: 5.0),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
