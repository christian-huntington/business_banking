// @dart=2.9

import 'package:business_banking/features/credit_card/bloc/credit_card_bloc.dart';
import 'package:business_banking/features/credit_card/bloc/credit_card_view_events.dart';
import 'package:business_banking/features/credit_card/model/credit_card_view_model.dart';
import 'package:business_banking/features/credit_card/ui/credit_card/credit_card_presenter.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class CreditCardBlocMock extends Mock implements CreditCardBloc {
  final creditCardViewEventsPipe = Pipe<CreditCardViewEvents>(canSendDuplicateData: true);
  final creditCardViewModelPipe = Pipe<CreditCardViewModel>();
}

void main() {

  CreditCardBlocMock bloc;
  CreditCardPresenter presenter;
  Widget testWidget;

  setUp(() {
    bloc = CreditCardBlocMock();
    presenter = CreditCardPresenter();
    testWidget = MaterialApp(
      home: BlocProvider<CreditCardBloc>(
        create: (_) => bloc,
        child: presenter,
      ),
    );
  });

  tearDown(() {
    bloc = null;
    testWidget = null;
  });


  testWidgets('CreditCardPresenter initialization', (tester) async {
    await tester.pumpWidget(testWidget);
    await tester.pump(Duration(milliseconds: 500));
    expect(find.byType(CreditCardPresenter), findsOneWidget);
  });


  /*
  testWidgets('CreditCardPresenter navigate to details screen', (tester) async {

    List<CreditCardTransaction> transactions = List.empty(growable: true);
    transactions.add(CreditCardTransaction(id: "1", name: "Transaction #1", date: DateTime.parse("2021-04-18"), value: 45.00));
    final viewModel = CreditCardViewModel(
      number: '1111222233334444',
      name: 'My Credit Card',
      lastFour: '4444',
      balance: 1234.56,
      paymentDueDate: DateTime.parse("2021-05-03"),
      nextClosingDate: DateTime.parse("2021-05-06"),
      paymentMinimumValue: 100.00,
      transactions: transactions,
    );

    await tester.pumpWidget(testWidget);
    await tester.pump(Duration(milliseconds: 500));
    bloc.creditCardViewModelPipe.send(viewModel);
    CreditCardViewEvents eventReceived;
    bloc.creditCardViewEventsPipe.receive.listen((event) {
      eventReceived = event;
    });
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.byKey(Key('creditCardCard')));
    await tester.pump(Duration(milliseconds: 500));
    expect(eventReceived, isA<CreditCardViewEventNavigateToDetailsScreen>());
  });
  */





}
