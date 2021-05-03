import 'package:business_banking/features/credit_card/model/credit_card_entity.dart';
import 'package:business_banking/features/credit_card/model/credit_card_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:business_banking/locator.dart';
import 'credit_card_service_adapter.dart';

class CreditCardUseCase extends UseCase {
  late final ViewModelCallback<ViewModel> _viewModelCallBack;
  CreditCardUseCase(ViewModelCallback<ViewModel> viewModelCallBack) : _viewModelCallBack = viewModelCallBack;

  Future<void> create() async {
    final scope = ExampleLocator().repository.create<CreditCardEntity>(CreditCardEntity(), _notifySubscribers);
    return ExampleLocator().repository.runServiceAdapter(scope, CreditCardServiceAdapter());
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  CreditCardViewModel buildViewModel(CreditCardEntity creditCardEntityModel) {
    return CreditCardViewModel(
      number: creditCardEntityModel.number,
      name: creditCardEntityModel.name,
      lastFour: creditCardEntityModel.lastFour,
      balance: creditCardEntityModel.balance,
      paymentDueDate: creditCardEntityModel.paymentDueDate,
      nextClosingDate: creditCardEntityModel.nextClosingDate,
      paymentMinimumValue: creditCardEntityModel.paymentMinimumValue,
      transactions: creditCardEntityModel.transactions,
    );
  }

}
