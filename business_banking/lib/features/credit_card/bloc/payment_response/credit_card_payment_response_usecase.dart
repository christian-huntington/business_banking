import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_entity.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:business_banking/locator.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'credit_card_payment_response_service_adapter.dart';

class CreditCardPaymentResponseUseCase extends UseCase {
  RepositoryScope? _scopePaymentResponse;
  final ViewModelCallback<ViewModel> _viewModelCallBack;
  CreditCardPaymentResponseUseCase(ViewModelCallback<ViewModel> viewModelCallBack) : _viewModelCallBack = viewModelCallBack;

  Future<void> create() async {
    _scopePaymentResponse = ExampleLocator().repository.create<CreditCardPaymentResponseEntity>(CreditCardPaymentResponseEntity(), _notifySubscribers);
    await ExampleLocator().repository.runServiceAdapter(_scopePaymentResponse!, CreditCardPaymentResponseServiceAdapter());
    sendViewModelToSubscribers();
  }

  void sendViewModelToSubscribers() {
    CreditCardPaymentResponseEntity creditCardPaymentResponseEntity = ExampleLocator().repository.get(_scopePaymentResponse!);
    _notifySubscribers(creditCardPaymentResponseEntity);
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  CreditCardPaymentResponseViewModel buildViewModel(CreditCardPaymentResponseEntity creditCardPaymentResponseEntity) {
    if (creditCardPaymentResponseEntity.errors.length > 0)
      return buildViewModelStatusError(creditCardPaymentResponseEntity) ;
    else
      return buildViewModelStatusOK(creditCardPaymentResponseEntity) ;
  }

  CreditCardPaymentResponseViewModel buildViewModelStatusOK(CreditCardPaymentResponseEntity creditCardPaymentResponseEntity) {
    return CreditCardPaymentResponseViewModel(
      number: creditCardPaymentResponseEntity.number,
      name: creditCardPaymentResponseEntity.name,
      lastFour: creditCardPaymentResponseEntity.lastFour,
      paymentValue: creditCardPaymentResponseEntity.paymentValue,
      paymentStatus: creditCardPaymentResponseEntity.paymentStatus,
      reasonRejected: creditCardPaymentResponseEntity.reasonRejected,
    );
  }

  CreditCardPaymentResponseViewModel buildViewModelStatusError(CreditCardPaymentResponseEntity creditCardPaymentResponseEntity) {
    return CreditCardPaymentResponseViewModel(
      number: creditCardPaymentResponseEntity.number,
      name: creditCardPaymentResponseEntity.name,
      lastFour: creditCardPaymentResponseEntity.lastFour,
      paymentValue: creditCardPaymentResponseEntity.paymentValue,
      paymentStatus: 'Error',
      reasonRejected: 'Error: ' + creditCardPaymentResponseEntity.errors[0].toString(),
    );
  }

}
