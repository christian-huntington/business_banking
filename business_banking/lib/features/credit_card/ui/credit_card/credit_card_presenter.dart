import 'package:business_banking/features/credit_card/bloc/credit_card_bloc.dart';
import 'package:business_banking/features/credit_card/model/credit_card_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'credit_card_actions.dart';
import 'credit_card_screen.dart';

class CreditCardPresenter extends Presenter<CreditCardBloc,
    CreditCardViewModel, CreditCardScreen> {
  @override
  Stream<CreditCardViewModel> getViewModelStream(CreditCardBloc bloc) {
    return bloc.creditCardViewModelPipe.receive;
  }

  @override
  CreditCardScreen buildScreen(BuildContext context, CreditCardBloc bloc,
      CreditCardViewModel viewModel) {
    return CreditCardScreen(
      viewModel: viewModel,
      actions: CreditCardActions(bloc),
    );
  }

}
