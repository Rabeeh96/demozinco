
import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ModelClasses/dashboard_detail_model/DeleteTransferList.dart';
import '../../ModelClasses/transfer_list/transfer_list_model.dart';

class TransactionListApi {
  TransactionListModelClass transactionListModelClass = TransactionListModelClass();
  ApiClient apiClient = ApiClient();



  Future<TransactionListModelClass> transferListFunction({
    required String organisationId,
    required String account_id,
    required  String fromDate,required String toDate
  }) async {
    final String path = "finance/list-account-finance/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final body = {
      "organization": organisationId,
      "account_id": account_id,
      "from_date": fromDate,
      "to_date": toDate,
      "country_id": country_id,
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return TransactionListModelClass.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<DeleteTransferList> deleteTransferListFunction({
    required String organisationId,
    required String id,
  }) async {
    final String path = "finance/delete-finance/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organisationId,
      "id": id,
      "country_id": country_id,
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return DeleteTransferList.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }
}