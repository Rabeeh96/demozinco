import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/transfer_list/transfer_list_model.dart';
import 'package:http/http.dart';


import '../../ModelClasses/transfer_list/DeleteTransferListModel.dart';
import '../../Repository/api_client.dart';

class TransferListApi {
  ApiClient apiClient = ApiClient();
  TransactionListModelClass transferListModel = TransactionListModelClass();
  DeleteTransferListModel deleteTransferListModel=DeleteTransferListModel();

  Future<TransactionListModelClass> transferListFunction({
    required String organisationId,
    required String account_id,
  }) async {
    final String path = "finance/list-account-finance/";
    final body = {
      "organization": organisationId,
      "account_id": account_id,
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return TransactionListModelClass.fromJson(
     jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<DeleteTransferListModel> deleteTransferListFunction({
    required String organisationId,
    required String account_id,
  }) async {
    final String path = "transfer/delete-transfer/";
    final body = {
      "organization": organisationId,
      "account_id": account_id,
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return DeleteTransferListModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }

}
