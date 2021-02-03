import 'package:business_banking/features/side_cash/get_side_cash/api/get_side_cash_request_model.dart';
import 'package:business_banking/features/side_cash/get_side_cash/api/get_side_cash_response_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:business_banking/locator.dart';

class GetSideCashService
    extends EitherService<GetSideCashRequestModel, GetSideCashResponseModel> {
  GetSideCashService()
      : super(
          method: RestMethod.post,
          restApi: ExampleLocator().api,
          path: 'get-side-cash',
        );

  @override
  GetSideCashResponseModel parseResponse(Map<String, dynamic> json) {
    return GetSideCashResponseModel.fromJson(json);
  }
}