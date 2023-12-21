import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/New%20Design%20ModelClass/exp/DelteTransactionModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/New%20Design%20ModelClass/exp/ModelClassDetailExpense.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/New%20Design%20ModelClass/exp/ModelClassExpense.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/New%20Design%20ModelClass/exp/TransactionExpenseModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiExpense{
  ApiClient apiClient = ApiClient();


  ModelClassExpense modelClassExpense = ModelClassExpense();
  ModelClassDetailExpense modelClassDetailExpense = ModelClassDetailExpense();
  TransactionExpenseModelClass transactionExpenseModelClass = TransactionExpenseModelClass();
  DelteTransactionModelClass delteTransactionModelClass =DelteTransactionModelClass();

  Future<ModelClassExpense> overviewExpenseFunction(
      {
        required String fromDate,
        required String toDate,
        required int pageNumber,
        required int pageSize,
      }) async {
    final String loginPath = "finance/list-finance/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");

    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId!,
      "finance_type": 1,
      "from_date": fromDate,
      "to_date": toDate,
      "page_number":pageNumber,
      "country_id":country_id,
      "page_size": pageSize
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ overview expense $body");
    return ModelClassExpense.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<ModelClassDetailExpense> detailExpenseFunction(
      {
        required String accountId,
        required int pageNumber,
        required int pageSize,
        required String fromDate,
        required String toDate
      }) async {
    final String loginPath = "finance/list-account-finance/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final organizationId =   prefs.getString("organisation");
    final body = {
      "organization": organizationId,
      "account_id":accountId,
      "page_number":pageNumber,
      "page_size":pageSize,
      "from_date": fromDate,
      "country_id": country_id,
      "to_date": toDate,
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ detail expense $body");
    return ModelClassDetailExpense.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<TransactionExpenseModelClass> transactionExpenseFunction({required String fromDate,
    required String toDate}) async {
    final String loginPath = "finance/list-finance-transaction/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "finance_type":1,
      "from_date": fromDate,
      "country_id": country_id,
      "to_date": toDate,
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________  expense transaction $body");
    return TransactionExpenseModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<DelteTransactionModelClass> deleteTransactionExpenseFunction({required String id}) async {
    final String path = "finance/delete-finance/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "id":id,
      "country_id":country_id
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("_________________ dlt expense transaction $body");
    return DelteTransactionModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }






}