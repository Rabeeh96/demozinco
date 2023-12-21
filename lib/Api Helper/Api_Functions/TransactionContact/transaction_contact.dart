import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/transaction%20contact/CreateTranactionContactModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/transaction%20contact/DeleteTransactionContactModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/transaction%20contact/DetailTransactionContactModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/transaction%20contact/EditTransactionContactModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';


import '../../../Utilities/global/text_style.dart';
import '../../ModelClasses/transaction contact/ListTransactionContactModelClass.dart';

class TransactionContactApi{
  CreateTranactionContactModelClass createTranactionContactModelClass = CreateTranactionContactModelClass();
  DeleteTransactionContactModelClass deleteTransactionContactModelClass = DeleteTransactionContactModelClass();
  DetailTransactionContactModelClass detailTransactionContactModelClass = DetailTransactionContactModelClass();
  ListTransactionContactModelClass listTransactionContactModelClass = ListTransactionContactModelClass();
  EditTransactionContactModelClass editTransactionContactModelClass = EditTransactionContactModelClass();
  ApiClient apiClient = ApiClient();
  Future<CreateTranactionContactModelClass> createTransactionContactFunction({
    required String organisation,
    required String date,
    required String time,
    required String fromAccount,
    required String toAccount,
    required String reminderData,
    required String amount,
    required String description,
    required String transactionType,
    required bool isReminder,
  }) async {



    final String path = "finance/create-finance/";
    final body = {
      "organization":organisation,
      "date": date,
      "time": time,
      "from_account": fromAccount,
      "to_account": toAccount,
      "amount": amount,
      "description": description,
      "reminder_date": reminderData,
      "finance_type": transactionType,
      "is_reminder": isReminder
    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return CreateTranactionContactModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }



  Future<ListTransactionContactModelClass> listTransactionContactFunction({
    required String id,    required String organisation,
    required String search, required String to_date,required String from_date

  }) async {
    final String path = "finance/list-finance/";
    final body = {
      "search":search,
      "organization":organisation,
      "from_date":from_date,
      "to_date":to_date,
      'contact_id':id,
      "finance_type":2
    };

    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return ListTransactionContactModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }




  Future<DetailTransactionContactModelClass> detailTransactionContactFunction({
    required String organisation,
    required String id,

  }) async {
    final String path = "finance/details-finance/";
    final body = {
      "id":id,
      "organization":organisation
    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return DetailTransactionContactModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }





  Future<EditTransactionContactModelClass> editTransactionContactFunction({
    required String organisation,
    required String date,
    required String time,
    required String fromAccount,
    required String toAccount,
    required String amount,
    required String description,
    required String reminderData,
    required String transactionType,
    required bool isReminder,
    required String id,

  }) async {
    final String path = "finance/update-finance/";
    final body = {
      "organization":organisation,
      "date": date,
      "time": time,
      "from_account": fromAccount,
      "to_account": toAccount,
      "amount": amount,
      "reminder_date": reminderData,
      "description": description,
      "finance_type": transactionType,
      "is_reminder": isReminder,
      "id":id,

    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return EditTransactionContactModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }



  Future<DeleteTransactionContactModelClass> deleteTransactionContactFunction({
    required String organisation,
    required String id,

  }) async {
    final String path = "finance/delete-finance/";
    final body = {
      "id":id,
      "organization":organisation
    };
    Response response = await apiClient.invokeAPI( path: path, method: "POST", body: body);
    return DeleteTransactionContactModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

}