import 'package:business_banking/dependency/pdf_handler.dart';
import 'package:business_banking/features/credit_card/model/credit_card_entity.dart';
import 'package:business_banking/features/credit_card/model/payment_request/credit_card_payment_request_view_model.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_entity.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:business_banking/locator.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

class CreditCardPaymentRequestUseCase extends UseCase {
  RepositoryScope? _scopeCreditCardEntity;
  RepositoryScope? _scopeCreditCardPaymentResponseEntity;
  final ViewModelCallback<ViewModel> _viewModelCallBack;
  CreditCardPaymentRequestUseCase(ViewModelCallback<ViewModel> viewModelCallBack) : _viewModelCallBack = viewModelCallBack;

  Future<void> create() async {
    _scopeCreditCardEntity = ExampleLocator().repository.create<CreditCardEntity>(CreditCardEntity(), _notifySubscribers);
    _scopeCreditCardPaymentResponseEntity = ExampleLocator().repository.create<CreditCardPaymentResponseEntity>(CreditCardPaymentResponseEntity(), _notifySubscribers);
    CreditCardEntity creditCardEntity = ExampleLocator().repository.get(_scopeCreditCardEntity!);
    updateCreditCardInfo(creditCardEntity);
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel());
  }

  CreditCardPaymentRequestViewModel buildViewModel() {
    CreditCardEntity creditCardEntity = ExampleLocator().repository.get(_scopeCreditCardEntity!);
    CreditCardPaymentResponseEntity creditCardPaymentResponseEntity = ExampleLocator().repository.get(_scopeCreditCardPaymentResponseEntity!);
    var viewModel = CreditCardPaymentRequestViewModel(
      number: creditCardEntity.number,
      name: creditCardEntity.name,
      lastFour: creditCardEntity.lastFour,
      balance: creditCardEntity.balance,
      paymentDueDate: creditCardEntity.paymentDueDate,
      nextClosingDate: creditCardEntity.nextClosingDate,
      paymentMinimumValue: creditCardEntity.paymentMinimumValue,
      paymentValue: creditCardPaymentResponseEntity.paymentValue,
    );
    return viewModel;
  }

  updateCreditCardInfo(CreditCardEntity creditCardEntity) {
    CreditCardPaymentResponseEntity creditCardPaymentResponseEntity = ExampleLocator().repository.get(_scopeCreditCardPaymentResponseEntity!);
    ExampleLocator().repository.update(
        _scopeCreditCardPaymentResponseEntity!,
        creditCardPaymentResponseEntity.merge(
            number: creditCardEntity.number,
            name: creditCardEntity.name,
            lastFour: creditCardEntity.lastFour,
        ),
    );
    ExampleLocator().repository.update(_scopeCreditCardPaymentResponseEntity!, creditCardPaymentResponseEntity.merge(paymentValue: 0.00));
    _viewModelCallBack(buildViewModel());
  }

  updatePaymentValue(double paymentValue) {
    if (_scopeCreditCardPaymentResponseEntity == null) return;
    CreditCardPaymentResponseEntity creditCardPaymentResponseEntity = ExampleLocator().repository.get(_scopeCreditCardPaymentResponseEntity!);
    ExampleLocator().repository.update(_scopeCreditCardPaymentResponseEntity!, creditCardPaymentResponseEntity.merge(paymentValue: paymentValue));
    _viewModelCallBack(buildViewModel());
  }

  String validatePaymentInformation(double paymentValue) {
    if (paymentValue <= 0.0) {
       return "Please inform the payment amount!";
    }
    return '';
  }

  Future<PDFHandler> generatePDFPaymentConfirmation(CreditCardPaymentResponseViewModel viewModel) async {
    return PDFHandler.createFromPDFFactory(PDFFactoryCreditCardPaymentConfirmation(viewModel.name, viewModel.paymentValue));
  }

}
