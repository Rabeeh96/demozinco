import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/CreateAccountModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/DeleteAccountModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/DetailAccountModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/ListAccountModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../ModelClasses/Settings/Account/EditAccountModelClass.dart';

class AccountApi{
  ApiClient apiClient = ApiClient();
  CreateAccountModelClass createAccountModelClass = CreateAccountModelClass();
  ListAccountModelClass listAccountModelClass = ListAccountModelClass();
  DeleteAccountModelClass deleteAccountModelClass = DeleteAccountModelClass();
  DetailAccountModelClass detailAccountModelClass = DetailAccountModelClass();
  EditAccountModelClass editAccountModelClass = EditAccountModelClass();
  Future<CreateAccountModelClass> accountCreateFunction({
    required String accountName,
    required String openingBalance,
    required String organisation,
    required String country,
    required int account_type,
    required String as_on_date,

  }) async {
    final String path = "accounts/create-account/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final body = {
      "account_name":accountName,
      "opening_balance":openingBalance,
      "organization":organisation,
      "country":country,
      "account_type":account_type,
      "as_on_date":as_on_date,
      "country_id":country_id,

    };
    //

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return CreateAccountModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ListAccountModelClass> accountListFunction({
    required String organisation,
    required int page_number,
    required int page_size,
    required String search,
    required dynamic type,
    required String country,
  }) async {
    final String path = "accounts/list-account/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organisation,
      "type": null ,
      "page_number":page_number,
      "page_size":page_size ,
      "search":search,
      "country":country,
      "country_id":country_id,
      "account_type":type

    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ListAccountModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));;
  }

  Future<DeleteAccountModelClass> accountDeleteFunction({
    required String id,
    required String organisation,
  }) async {
    final String path = "accounts/delete-account/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "id": id,
      "country_id": country_id,
      "organization": organisation
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return DeleteAccountModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<DetailAccountModelClass> accountDetailFunction({
    required String id,
    required String organisation,
  }) async {
    final String path = "accounts/details-account/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "id": id,
      "country_id": country_id,
      "organization": organisation
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return DetailAccountModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<EditAccountModelClass> editAccountFunction({
    required String id,
    required String organisation,
    required String accountName,
    required String openingBalance,
    required String country,
    required String date,
    required String accountType,
  }) async {
    final String path = "accounts/update-account/";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final body = {
      "id": id,
      "account_name": accountName,
      "opening_balance": openingBalance,
      "as_on_date": date,
      "account_type":accountType,
      "country": country,
      "country_id": country_id,
      "organization": organisation
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return EditAccountModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


}