import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Transaction/CreateTransactionModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Transaction/DeleteTransactionModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Transaction/DetailTransactionModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Transaction/EditTransactiomModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';


import '../../ModelClasses/Transaction/ListTransactionModelClass.dart';

class TransactionApi {
  CreateTransactionModelClass createTransactionModelClass = CreateTransactionModelClass();
  DetailTransactionModelClass detailTransactionModelClass =DetailTransactionModelClass();
  ListTransactionModelClass listTransactionModelClass = ListTransactionModelClass();
  EditTransactiomModelClass editTransactiomModelClass = EditTransactiomModelClass();
  DeleteTransactionModelClass deleteTransactionModelClass = DeleteTransactionModelClass();
  ApiClient apiClient = ApiClient();


  Future<CreateTransactionModelClass> createTransactionFunction({
    required String organisation,
    required String date,
    required String time,
    required String fromAccount,
    required String fromCountry,
    required String fromAmount,
    required String toAccount,
    required String toCountry,
    required String toAmount,
    required String description,

}) async {
    final String path = "transfer/create-transfer/";
    final body = {
      "organization": organisation,
      "date": date,
      "time": time,
      "from_account": fromAccount,
      "from_country": fromCountry ,
      "from_amount": fromAmount,
      "to_account": toAccount,
      "to_country": toCountry,
      "to_amount": toAmount ,
      "description": description

    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return CreateTransactionModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }



  Future<ListTransactionModelClass> ListTransactionFunction(
  { required String organisationId,required String search}
      ) async {
    final String path = "transfer/list-transfer/";
    final body = {
      "organization": organisationId,
      "search": search
    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return ListTransactionModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<DetailTransactionModelClass> DetailTransactionFunction({
    required String id,
    required String organisation
}) async {
    final String path = "transfer/details-transfer/";
    final body = {
      "id": id,
      "organization": organisation,

    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return DetailTransactionModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }



  Future<EditTransactiomModelClass> EditTransactionFunction({
    required String organisation,
    required String date,
    required String time,
    required String fromAccount,
    required String fromCountry,
    required String fromAmount,
    required String toAccount,
    required String toCountry,
    required String toAmount,
    required String description,
    required String id,

}) async {
    final String path = "transfer/update-transfer/";
    final body = {
      "organization": organisation,
      "date": date,
      "time": time,
      "from_account": fromAccount,
      "from_country": fromCountry ,
      "from_amount": fromAmount,
      "to_account": toAccount,
      "to_country": toCountry,
      "to_amount": toAmount ,
      "description": description,
      "id":id

    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return EditTransactiomModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<DeleteTransactionModelClass> DeleteTransactionFunction({
    required String id,
    required String organisation
}) async {
    final String path = "transfer/delete-transfer/";
    final body = {
      "id": id,
      "organization": organisation,
    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return DeleteTransactionModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
}