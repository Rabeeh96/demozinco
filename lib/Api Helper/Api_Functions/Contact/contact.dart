import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/contact/CreateContactModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/contact/DetailContactModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/contact/EditContactModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/contact/ListContactModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/contact/delete_contactModelClass.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../Repository/api_client.dart';

class ContactApi {
  ApiClient apiClient = ApiClient();
  ListContactModelClass listContactModelClass = ListContactModelClass();
  CreateContacModelClass createContactModelClass = CreateContacModelClass();
  EditContactModelClass editContactModelClass = EditContactModelClass();
  DeleteContactModel deleteContactModelClass = DeleteContactModel();
  DetailContactModelClass detailContactModelClass = DetailContactModelClass();
  Future<CreateContacModelClass> contactCreateFunction({
    required String organisation,
    required String country,
    required String accountName,

    required String amount,
    required String address_name,
    required String building_name,
    required String land_mark,
    required String state,
    required String pin_code,
    required String phone,
  }) async {
    final String path = "contacts/create-contact/";
    final body = {
      "organization": organisation,
      "country": country,
      "account_name": accountName,
      "phone": phone,
       "amount": amount,
      "address_name": address_name,
      "building_name": building_name,
      "land_mark": land_mark,
      "state": state,
      "pin_code": pin_code
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return CreateContacModelClass.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));

  }

  Future<ListContactModelClass> contacttListFunction(
      {required String organisation,
        required int page_number,
        required int page_size,
        required String search}) async {
    final String path = "contacts/list-contact/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final body = {
      "organization": organisation,
      "page_number": page_number,
      "page_size": page_size,
      "country_id": country_id,
      "search": search
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return ListContactModelClass.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }



  Future<EditContactModelClass> contactEditFunction(
      {required String organisation,
        required String country,
        required String accountName,
            required String phone,
        required String amount,
        required String address_name,
        required String building_name,
        required String land_mark,
        required String id,
        required String state,
        required String pin_code}) async {
    final String path = "contacts/update-contact/";
    final body = {
      "organization": organisation,
      "country": country,
      "account_name": accountName,
       "phone":phone,
      "amount": amount,
      "address_name": address_name,
      "building_name": building_name,
      "land_mark": land_mark,
      "state": state,
      "pin_code": pin_code,
      "id": id,
    };

    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return EditContactModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<DeleteContactModel> contactDeleteFunction({
    required String organisationId,
    required String id,
  }) async {
    final String path = "contacts/delete-contact/";
    final body = {
      "organization": organisationId,
      "id": id,
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return DeleteContactModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<DetailContactModelClass> contactDetailFunction({
    required String organisationId,
    required String id,
  }) async {
    final String path = "contacts/details-contact/";
    final body = {
      "organization": organisationId,
      "id": id,
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return DetailContactModelClass.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }

}
