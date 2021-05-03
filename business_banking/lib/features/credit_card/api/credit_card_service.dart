import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:business_banking/locator.dart';

import 'payment_response/credit_card_service_response_model.dart';

class CreditCardService extends EitherService<JsonRequestModel, CreditCardServiceResponseModel> {
  CreditCardService()
      : super(
          method: RestMethod.get,
          restApi: ExampleLocator().api,
          path: 'credit-card',
        );

  @override
  CreditCardServiceResponseModel parseResponse(Map<String, dynamic> jsonResponse) {
    return CreditCardServiceResponseModel.fromJson(jsonResponse);
  }
}
