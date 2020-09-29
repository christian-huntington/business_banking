import 'package:clean_framework/clean_framework.dart';
import 'package:business_banking/features/mortgage_accounts/bloc/mortgage_accounts_bloc.dart';
import 'package:business_banking/features/mortgage_accounts/model/mortgage_accounts_view_model.dart';
import 'package:mockito/mockito.dart';

class MortgageAccountsBlocMock extends Fake implements MortgageAccountsBloc {
  Pipe<MortgageAccountsViewModel> mortgageAccountsViewModelPipe = Pipe<MortgageAccountsViewModel>();

  MortgageAccountsBlocMock() {
    mortgageAccountsViewModelPipe.onListen(() {
      mortgageAccountsViewModelPipe.send(MortgageAccountsViewModel(
          name: 'Employee Checking',
          lastFour: '6542',
          balance: 3545.54
        ));
    });
  }

  @override
  void dispose() {}
}