import 'package:business_banking/features/credit_card/api/credit_card_service.dart';
import 'package:business_banking/features/credit_card/api/payment_response/credit_card_service_response_model.dart';
import 'package:business_banking/features/credit_card/model/credit_card_entity.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

class CreditCardServiceAdapter extends ServiceAdapter<CreditCardEntity, JsonRequestModel, CreditCardServiceResponseModel, CreditCardService> {
  CreditCardServiceAdapter() : super(CreditCardService());

  @override
  CreditCardEntity createEntity(CreditCardEntity creditCardEntityModel, CreditCardServiceResponseModel responseModel) {
    return creditCardEntityModel.merge(
      number: responseModel.number,
      name: responseModel.name,
      lastFour: responseModel.lastFour,
      balance: responseModel.balance,
      paymentDueDate: responseModel.paymentDueDate,
      nextClosingDate: responseModel.nextClosingDate,
      paymentMinimumValue: responseModel.paymentMinimumValue,
      transactions: responseModel.transactions,
    ) as CreditCardEntity;
  }
}
