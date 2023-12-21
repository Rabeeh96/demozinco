import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/New%20Design%20ModelClass/incme/IncomeTransactionModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/New%20Design%20ModelClass/incme/ModelClassDetailIncome.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/New%20Design%20ModelClass/incme/ModelClassIncome.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiIncome{
  ApiClient apiClient = ApiClient();


  ModelClassIncome modelClassIncome = ModelClassIncome();
  ModelClassDetailIncome modelClassDetailIncome = ModelClassDetailIncome();
  IncomeTransactionModelClass incomeTransactionModelClass = IncomeTransactionModelClass();
  Future<ModelClassIncome> overviewIncomeFunction(
      {
        required String fromDate,
        required String toDate,
        required int pageNumber,
        required int pageSize,
      }) async {
    final String path = "finance/list-finance/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
     final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId!,
      "finance_type": 0,
      "from_date": fromDate,
      "to_date": toDate,
      "page_number":pageNumber,
      "country_id":country_id,
      "page_size": pageSize
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("_________________ overview income $body");
    return ModelClassIncome.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<ModelClassDetailIncome> detailIncomeFunction(
      {
        required String accountId,
        required int pageNumber,
        required int pageSize,
      }) async {
    final String path = "finance/list-account-finance/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "account_id":accountId,
      "page_number":pageNumber,
      "country_id":country_id,
      "page_size":pageSize
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("_________________ detail income $body");
    return ModelClassDetailIncome.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<IncomeTransactionModelClass> transactionIncomeFunction({required String fromDate,required String toDate}) async {
    final String path = "finance/list-finance-transaction/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "finance_type":0,
      "from_date": fromDate,
      "country_id": country_id,
      "to_date": toDate
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("_________________  income transaction $body");
    return IncomeTransactionModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


}