import 'dart:convert';
import 'dart:developer';


import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/dashboard/ZakathOrInterestDetailListModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/dashboard/ZakathorInterestListModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ZakathInterestApi{

  ZakathorInterestListModelClass zakathorInterestListModelClass = ZakathorInterestListModelClass();
  ZakathOrInterestDetailListModelClass zakathOrInterestDetailListModelClass = ZakathOrInterestDetailListModelClass();
  ApiClient apiClient = ApiClient();

  Future<ZakathorInterestListModelClass> zakathInterestListFunction({required String filter}) async {
    final String path = "dashboard/list-zakat/";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final organizationId =   prefs.getString("organisation");
    final body = {
      "organization": organizationId,
       "filter":filter,
       "country_id":country_id
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("___________________________________ interest or zakath list $body");
    return ZakathorInterestListModelClass.fromJson(json.decode(response.body));
  }
  Future<ZakathOrInterestDetailListModelClass> DetailZakathInterestListFunction({required String filter,
    required String accountId,
    required String fromDate,
    required String toDate,
  }) async {
    final String path = "dashboard/details-zakat/";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");

    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "account_id": accountId,
      "filter":filter,
      "from_date":fromDate ,
      "country_id":country_id ,
      "to_date":toDate

    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("___________________________________ interest or zakath detail list  $body");
    return ZakathOrInterestDetailListModelClass.fromJson(json.decode(response.body));
  }

}