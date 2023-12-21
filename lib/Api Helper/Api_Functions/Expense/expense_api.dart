import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Expense/DeleteExpenseModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Expense/ExpenseDetailModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Expense/ExpenseEditModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Expense/ListExpenseModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';


import '../../ModelClasses/Expense/ExpenseCreateModelClass.dart';

class ExpenseApi{
  ApiClient apiClient = ApiClient();
  ExpenseCreateModelClass expenseCreateModelClass = ExpenseCreateModelClass();
  ListExpenseModelClass listExpenseModelClass = ListExpenseModelClass();
  ExpenseDetailModelClass expenseDetailModelClass =  ExpenseDetailModelClass();
  ExpenseEditModelClass expenseEditModelClass = ExpenseEditModelClass();
  DeleteExpenseModelClass deleteExpenseModelClass = DeleteExpenseModelClass();
  Future<ExpenseCreateModelClass> CreateExpenseFunction(
      {
        required  bool isInterest,
        required  bool is_zakath,
        required String date,
        required String time,
        required String organization,
        required String from_account,
        required String to_account,
        required String amount,
        required String description,
        required int finance_type,
      }) async {
    final String loginPath = "finance/create-finance/";
    final body = {
      "is_interest":isInterest,
      "is_zakath":is_zakath,
      "date":date,
      "time":time,
      "organization":organization,
      "from_account": from_account,
      "to_account":to_account,
      "amount":amount,
      "description":description,
      "finance_type":finance_type
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ create expense $body");
    return ExpenseCreateModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ListExpenseModelClass> ListExpenseFunction(
      {required String search,
        required String organization,
        required int financeType
      }) async {
    final String loginPath = "finance/list-finance/";
    final body = {
      "search":search,
      "organization": organization,
      "finance_type": financeType
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ list expense $body");
    return ListExpenseModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<ExpenseDetailModelClass> DetailExpenseFunction(
      {required String id,
        required String organization}) async {
    final String loginPath = "finance/details-finance/";
    final body = {
      "id": id,
      "organization": organization
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ details expense $body");
    return ExpenseDetailModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }



  Future<ExpenseEditModelClass> EditExpenseFunction(
      {
        required  bool isInterest,
        required  bool is_zakath,
        required String date,
        required String time,
        required String organization,
        required String from_account,
        required String to_account,
        required String amount,
        required String description,
        required String id,
        required int finance_type,
      }) async {
    final String loginPath = "finance/update-finance/";
    final body = {
      "is_interest":isInterest,
      "is_zakath":is_zakath,
      "date":date,
      "time":time,
      "organization":organization,
      "from_account": from_account,
      "to_account":to_account,
      "amount":amount,
      "description":description,
      "finance_type":finance_type,
      "id": id
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ edit expense $body");
    return ExpenseEditModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<DeleteExpenseModelClass> DeleteExpenseFunction(
      {required String id,
        required String organization}) async {
    final String loginPath = "finance/delete-finance/";
    final body = {
      "id": id,
      "organization": organization
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ delete expense $body");
    return DeleteExpenseModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }



}