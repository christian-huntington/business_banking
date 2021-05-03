import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:business_banking/features/credit_card/model/credit_card_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'credit_card_actions.dart';

class CreditCardScreen extends Screen {
  final CreditCardViewModel viewModel;
  final CreditCardActions actions;

  CreditCardScreen({
    required this.viewModel,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: EdgeInsets.all(5.0),
      child: Card(
        key: Key('creditCardCard'),
        color: Colors.white,
        shadowColor: Colors.grey[500],
        elevation: 3.0,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          viewModel.name,
                          key: Key('creditCardCardName'),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AutoSizeText(
                        '*' + viewModel.lastFour.toString(),
                        key: Key('creditCardCardLastFour'),
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Credit Card Balance:",
                        style: TextStyle(color: Colors.black54, fontSize: 18.0),
                      ),
                      Text(
                        NumberFormat.simpleCurrency().format(viewModel.balance),
                        key: Key('creditCardCardBalance'),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            this.actions.navigateToCreditCardDetails(context);
          },
        ),
      ),
    );
  }

}

