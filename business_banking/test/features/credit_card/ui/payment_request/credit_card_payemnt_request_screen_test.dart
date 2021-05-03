// @dart=2.9

import 'package:business_banking/features/credit_card/model/payment_request/credit_card_payment_request_view_model.dart';
import 'package:business_banking/features/credit_card/ui/payment_request/credit_card_payment_request_actions.dart';
import 'package:business_banking/features/credit_card/ui/payment_request/credit_card_payment_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';

class CreditCardPaymentRequestActionsMock extends Mock implements CreditCardPaymentRequestActions {}

void main() {

  CreditCardPaymentRequestViewModel viewModel;
  CreditCardPaymentRequestActions actions;
  Widget testWidget;

  setUp(() {
    viewModel = CreditCardPaymentRequestViewModel(
      number: '1111222233334444',
      name: 'My Credit Card',
      lastFour: '4444',
      balance: 1234.56,
      paymentDueDate: DateTime.parse("2021-05-03"),
      nextClosingDate: DateTime.parse("2021-05-06"),
      paymentMinimumValue: 100.00,
      paymentValue: 1.23,
    );
    actions = CreditCardPaymentRequestActionsMock();
    testWidget = MaterialApp(
      home: CreditCardPaymentRequestScreen(
        viewModel: viewModel,
        actions: actions,
      ),
    );
  });

  tearDown(() {
    viewModel = null;
    actions = null;
    testWidget = null;
  });

  testWidgets('CreditCardPaymentRequestScreen initialization', (tester) async {
    await tester.pumpWidget(testWidget);
    await tester.pump(Duration(milliseconds: 500));
    expect(find.byType(CreditCardPaymentRequestScreen), findsOneWidget);

    /// name
    expect(find.text(viewModel.name), findsOneWidget);

    /// lastFour
    expect(find.text('*' + viewModel.lastFour), findsOneWidget);

    /// balance
    expect(find.text(NumberFormat.simpleCurrency().format(viewModel.balance)), findsOneWidget);

    /// pay button
    expect(find.text('Pay'), findsOneWidget);
  });

  testWidgets('CreditCardPaymentRequestScreen actions',
      (tester) async {

    await tester.pumpWidget(testWidget);
    await tester.pump(Duration(milliseconds: 500));

    /// pressPayButton
    var widget = find.byKey(Key('payButton'));
    expect(widget, findsOneWidget);
    await tester.tap(widget);
    verify(actions.pressPayButton(any, any)).called(1);

  });

}
