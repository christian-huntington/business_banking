import 'package:business_banking/dependency/pdf_handler.dart';
import 'package:business_banking/features/credit_card/bloc/payment_request/credit_card_payment_request_usecase.dart';
import 'package:business_banking/features/credit_card/bloc/payment_response/credit_card_payment_response_usecase.dart';
import 'package:business_banking/features/credit_card/model/payment_request/credit_card_payment_request_view_model.dart';
import 'package:business_banking/features/credit_card/model/credit_card_view_model.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_view_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'credit_card_usecase.dart';
import 'credit_card_view_events.dart';

class CreditCardBloc extends Bloc {
  final creditCardViewEventsPipe = Pipe<CreditCardViewEvents>(canSendDuplicateData: true);

  CreditCardUseCase? _creditCardUseCase;
  final creditCardViewModelPipe = Pipe<CreditCardViewModel>();

  CreditCardPaymentRequestUseCase? _creditCardPaymentRequestUseCase;
  final creditCardPaymentRequestViewModelPipe = Pipe<CreditCardPaymentRequestViewModel>();

  CreditCardPaymentResponseUseCase? _creditCardPaymentResponseUseCase;
  final creditCardPaymentResponseViewModelPipe = Pipe<CreditCardPaymentResponseViewModel>();

  CreditCardBloc({
    CreditCardUseCase? creditCardUseCase,
    CreditCardPaymentRequestUseCase? creditCardPaymentRequestUseCase,
    CreditCardPaymentResponseUseCase? creditCardPaymentResponseUseCase,
  }) {
    creditCardViewEventsPipe.receive.listen((event) {creditCardViewEventsPipeHandler(event);});

    _creditCardUseCase = creditCardUseCase ?? CreditCardUseCase((viewModel) => creditCardViewModelPipe.send(viewModel as CreditCardViewModel));
    creditCardViewModelPipe.whenListenedDo(_creditCardUseCase!.create);

    _creditCardPaymentRequestUseCase = creditCardPaymentRequestUseCase ?? CreditCardPaymentRequestUseCase((viewModel) => creditCardPaymentRequestViewModelPipe.send(viewModel as CreditCardPaymentRequestViewModel));
    creditCardPaymentRequestViewModelPipe.whenListenedDo(_creditCardPaymentRequestUseCase!.create);

    _creditCardPaymentResponseUseCase = creditCardPaymentResponseUseCase ?? CreditCardPaymentResponseUseCase((viewModel) => creditCardPaymentResponseViewModelPipe.send(viewModel as CreditCardPaymentResponseViewModel));
    creditCardPaymentResponseViewModelPipe.whenListenedDo(_creditCardPaymentResponseUseCase!.create);
  }

  @override
  void dispose() {
    creditCardViewEventsPipe.dispose();
    creditCardViewModelPipe.dispose();
    creditCardPaymentRequestViewModelPipe.dispose();
    creditCardPaymentResponseViewModelPipe.dispose();
  }

  creditCardViewEventsPipeHandler(CreditCardViewEvents event) {
    if (event is CreditCardViewEventUpdatePaymentValue) {
      _creditCardPaymentRequestUseCase!.updatePaymentValue(event.paymentValue);
      return;
    }
  }

  String validatePaymentInformation(CreditCardPaymentRequestViewModel creditCardPaymentRequestViewModel, double paymentValue) {
    return _creditCardPaymentRequestUseCase!.validatePaymentInformation(paymentValue);
  }

  Future<PDFHandler> generatePDFPaymentConfirmation(CreditCardPaymentResponseViewModel viewModel) async {
    return _creditCardPaymentRequestUseCase!.generatePDFPaymentConfirmation(viewModel);
  }

}