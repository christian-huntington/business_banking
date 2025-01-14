import 'package:business_banking/features/credit_card/api/payment_response/credit_card_payment_response_service.dart';
import 'package:business_banking/features/credit_card/api/payment_response/credit_card_payment_response_service_request_model.dart';
import 'package:business_banking/features/credit_card/api/payment_response/credit_card_payment_response_service_response_model.dart';
import 'package:business_banking/features/credit_card/model/payment_response/credit_card_payment_response_entity.dart';
import 'package:clean_framework/clean_framework.dart';


class CreditCardPaymentResponseServiceAdapter extends ServiceAdapter<CreditCardPaymentResponseEntity, CreditCardPaymentResponseServiceRequestModel, CreditCardPaymentResponseServiceResponseModel, CreditCardPaymentService> {
  CreditCardPaymentResponseServiceAdapter() : super(CreditCardPaymentService());

  @override

  CreditCardPaymentResponseServiceRequestModel createRequest(CreditCardPaymentResponseEntity entity) {
    print("CreditCardPaymentResponseServiceAdapter.createRequest entity.number = " + entity.number);
    return CreditCardPaymentResponseServiceRequestModel(number: entity.number, paymentValue: entity.paymentValue);
  }

  @override
  CreditCardPaymentResponseEntity createEntity(CreditCardPaymentResponseEntity entityModel, CreditCardPaymentResponseServiceResponseModel responseModel) {
    print("CreditCardPaymentResponseServiceAdapter.createEntity");
    return entityModel.merge(
      number: responseModel.number,
      name: responseModel.name,
      lastFour: responseModel.lastFour,
      paymentValue: responseModel.paymentValue,
      paymentStatus: responseModel.paymentStatus,
      reasonRejected: responseModel.reasonRejected,
    ) as CreditCardPaymentResponseEntity;
  }

  /*

  /*
  @override
  LoginServiceRequestModel createRequest(LoginEntity entity) {
    return LoginServiceRequestModel(
        userName: entity.userName, password: entity.password);
  }

  @override
  LoginEntity createEntity(initialEntity, responseModel) {
    return initialEntity.merge(errors: <EntityFailure>[]) as LoginEntity;
  }

   */

   */
}
