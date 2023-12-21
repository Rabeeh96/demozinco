import 'dart:convert';
import 'dart:developer';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/AssetDeleteModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/ListAssetModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../ModelClasses/asset new modelclsses/AssetDetailModelClass.dart';
import '../../ModelClasses/asset new modelclsses/TransactionAssetModelClass.dart';


class AssetApi {
  ApiClient apiClient = ApiClient();
  ListAssetModelClass listAssetModelClass = ListAssetModelClass();
  AssetDeleteModelClass assetDeleteModelClass = AssetDeleteModelClass();
  DetailAssetModelClass detailAssetModelClass =DetailAssetModelClass();
  TransactionAssetModelClass transactionAssetModelClass = TransactionAssetModelClass();
  Future<ListAssetModelClass> ListAssetFunction({
    required String organization,
    required String search,
    required int pageNumber,
    required int page_size,
  }) async {
    final String path = "assets/list-asset/";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organization,
      "search":search,"page_number": pageNumber, "page_size": page_size, "country_id": country_id
    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    log("_________________ list assets $body");

    return ListAssetModelClass.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<AssetDeleteModelClass> DeleteAssetFunction({
    required String organization,
    required String id,
  }) async {
    final String path = "assets/delete-asset/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "id": id,
      "country_id": country_id,
      "organization": organization
    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return AssetDeleteModelClass.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<DetailAssetModelClass> detailAssetFunction({
    required String id,
  }) async {
    final String path = "assets/view-asset/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
     final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "country_id": country_id,
      "asset_id": id,
      "filter_by": 0
    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return DetailAssetModelClass.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<TransactionAssetModelClass> transactionAssetFunction({
    required int masterId,
    required String fromDate,
    required String toDate,
  }) async {
    final String path = "finance/list-finance-transaction/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final organizationId =   prefs.getString("organisation");
    final body = {
      "organization": organizationId,
      "finance_type": 2,
      "is_asset":true,
      "country_id":country_id,
      "asset_master_id":masterId,
      "from_date": fromDate,
      "to_date": toDate
    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return TransactionAssetModelClass.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }


}
