import 'package:business_banking/features/credit_card/bloc/credit_card_bloc.dart';
import 'package:business_banking/features/credit_card/model/credit_card_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../routes.dart';

class CreditCardDetailsActions {

  final CreditCardBloc bloc;
  final CreditCardViewModel viewModel;

  CreditCardDetailsActions(this.bloc, this.viewModel);

  void navigateBack(BuildContext context) async {
    CFRouterScope.of(context).popUntil(BusinessBankingRouter.hubRoute);
  }

  void pressPayButton(BuildContext context) {
    CFRouterScope.of(context).push(BusinessBankingRouter.creditCardPaymentRequestRoute);
  }

}
