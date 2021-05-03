import 'package:business_banking/features/credit_card/api/payment_response/credit_card_payment_response_service.dart';
import 'package:business_banking/features/credit_card/api/payment_response/credit_card_payment_response_service_request_model.dart';
import 'package:business_banking/features/credit_card/api/payment_response/credit_card_payment_response_service_response_model.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_entity.dart';
import 'package:clean_framework/clean_framework.dart';


class CreditCardPaymentResponseServiceAdapter extends ServiceAdapter<CreditCardPaymentResponseEntity, CreditCardPaymentResponseServiceRequestModel, CreditCardPaymentResponseServiceResponseModel, CreditCardPaymentService> {
  CreditCardPaymentResponseServiceAdapter() : super(CreditCardPaymentService());

  @override

  CreditCardPaymentResponseServiceRequestModel createRequest(CreditCardPaymentResponseEntity entity) {
    return CreditCardPaymentResponseServiceRequestModel(number: entity.number, paymentValue: entity.paymentValue);
  }

  @override
  CreditCardPaymentResponseEntity createEntity(CreditCardPaymentResponseEntity entityModel, CreditCardPaymentResponseServiceResponseModel responseModel) {
    return entityModel.merge(
      number: responseModel.number,
      name: responseModel.name,
      lastFour: responseModel.lastFour,
      paymentValue: responseModel.paymentValue,
      paymentStatus: responseModel.paymentStatus,
      reasonRejected: responseModel.reasonRejected,
    ) as CreditCardPaymentResponseEntity;
  }

}
