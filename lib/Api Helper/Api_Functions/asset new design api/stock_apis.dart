import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/Stock/CreateStockModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/Stock/DeleteStockModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/Stock/EditStockModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StockAssetApi{
  ApiClient apiClient = ApiClient();
  CreateStockModelClass createStockModelClass = CreateStockModelClass();
  DeleteStockModelClass deleteStockModelClass = DeleteStockModelClass();
  EditStockModelClass editStockModelClass = EditStockModelClass();
  Future<CreateStockModelClass> createStockAssetFunction({
    required String assetId,
    required String share,
    required String value,
    required bool preOwn,
    required String asOnDate,
    required String accountId,
  }) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final String path = "assets/add-stock/";
    final country_id = prefs.getString("country_id");

    final body = {
      "organization": organizationId,
      "asset_id": assetId,
      "share":share,
      "value":value,
      "pre_owned":preOwn,
      "as_on_date":asOnDate,
      "country_id":country_id,
      "account_id":accountId

    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    log("_________________  api body print $body");

    return CreateStockModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<DeleteStockModelClass> deleteStockAssetFunction({

    required String assetDetailId,
  }) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final String path = "assets/delete-stock/";
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "country_id": country_id,
      "asset_detail_id":assetDetailId

    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    log("_________________  api body print $body");

    return DeleteStockModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<EditStockModelClass> editStockAssetFunction({

    required String assetId,
    required String share,
    required String Value,
    required bool pre_owned,
    required String as_on_date,
    required String account_id,
    required String asset_detail_id,
  }) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final String path = "assets/edit-stock/";
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "asset_id": assetId,
      "country_id": country_id,
      "share":share,
      "value":Value,
      "pre_owned":pre_owned,
      "as_on_date":as_on_date,
      "account_id":account_id,
      "asset_detail_id":asset_detail_id
      //


    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    log("_________________api stock edit print $body");

    return EditStockModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


}