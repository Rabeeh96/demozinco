import 'dart:convert';
import 'dart:developer';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/property/DeletePropertyModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/property/EditPropertyModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/property/PropertCreateModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PropertyAssetApi{
  ApiClient apiClient = ApiClient();
  PropertCreateModelClass propertCreateModelClass = PropertCreateModelClass();
  DeletePropertyModelClass deletePropertyModelClass = DeletePropertyModelClass();
  EditPropertyModelClass editPropertyModelClass = EditPropertyModelClass();
  Future<PropertCreateModelClass> createPropertyAssetFunction({
    required String assetMasterId,
    required String propertyName,
    required String value,

  }) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final country_id = prefs.getString("country_id");
    final String path = "assets/add-property/";
    final body = {
      "organization": organizationId,
      "asset_master_id": assetMasterId,
      "property_name":propertyName,
      "country_id":country_id,
      "property_value":value

    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    log("_________________  api body print $body");

    return PropertCreateModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<DeletePropertyModelClass> deletePropertyAssetFunction({

    required String property_id,
  }) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final String path = "assets/delete-property/";
    final country_id = prefs.getString("country_id");
    final body = {
      "country_id": country_id,
      "organization": organizationId,
      "property_id":property_id

    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    log("_________________  api body print $body");

    return DeletePropertyModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<EditPropertyModelClass> editStockAssetFunction({

    required String property_name,
    required String property_value,
    required String property_id,

  }) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final String path = "assets/edit-property/";
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organizationId,
      "property_name":property_name,
      "property_value":property_value,
      "country_id":country_id,
      "property_id":property_id

    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    log("_________________api property edit print $body");

    return EditPropertyModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


}