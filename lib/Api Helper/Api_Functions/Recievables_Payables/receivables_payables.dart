import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../ModelClasses/dashboard/PayableReceivableModelClass.dart';

class RecievablePayableApi{
  PayableReceivableModelClass payableReceivableModelClass =PayableReceivableModelClass();
  ApiClient apiClient = ApiClient();
  Future<PayableReceivableModelClass> PayableReceivableListFunction({required String filter}) async {
    final String path = "dashboard/list-payable_receivable/";

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
    log("___________________________________ receivable or payable list $body");
    return PayableReceivableModelClass.fromJson(json.decode(response.body));
  }

}