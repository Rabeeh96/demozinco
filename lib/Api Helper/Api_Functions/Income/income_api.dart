import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Income/CreateIncomeModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Income/DeleteIncomeModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Income/DetailsIncomeModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Income/EditIncomeModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Income/ListIncomeModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';


class IncomeApi{
  ApiClient apiClient = ApiClient();
  CreateIncomeModelClass createIncomeModelClass = CreateIncomeModelClass();
  ListIncomeModelClass listIncomeModelClass = ListIncomeModelClass();
  DetailsIncomeModelClass detailsIncomeModelClass =DetailsIncomeModelClass();
  EditIncomeModelClass editIncomeModelClass = EditIncomeModelClass();
  DeleteIncomeModelClass deleteIncomeModelClass = DeleteIncomeModelClass();

  Future<CreateIncomeModelClass> CreateIncomeFunction(
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
    log("_________________ create income $body");
    return CreateIncomeModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ListIncomeModelClass> ListIncomeFunction(
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
    log("_________________ list income $body");
    return ListIncomeModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<DetailsIncomeModelClass> DetailIncomeFunction(
      {required String id,
        required String organization}) async {
    final String loginPath = "finance/details-finance/";
    final body = {
      "id": id,
      "organization": organization
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ details income $body");
    return DetailsIncomeModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }



  Future<EditIncomeModelClass> EditIncomeFunction(
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
    log("_________________ edit income $body");
    return EditIncomeModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<DeleteIncomeModelClass> DeleteIncomeFunction(
      {required String id,
        required String organization}) async {
    final String loginPath = "finance/delete-finance/";
    final body = {
      "id": id,
      "organization": organization
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "POST", body: body);
    log("_________________ delete income $body");
    return DeleteIncomeModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


}