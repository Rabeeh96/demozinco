
import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ModelClasses/dashboard_detail_model/DashboardDEtailModel.dart';
import '../../ModelClasses/dashboard_detail_model/DeleteAccountModel.dart';

class DashBoardDetailApi {
  DashboardDEtailModel dashboardDEtailModel = DashboardDEtailModel();
  DeleteAccountModel deleteAccountModel = DeleteAccountModel();
  ApiClient apiClient = ApiClient();


  Future<DashboardDEtailModel> dashBoardDEtailFunction({
    required String organisationId,
    required String id,
  }) async {
    final String path = "accounts/details-account/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organisationId,
      "id": id,
      "country_id": country_id,
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return DashboardDEtailModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<DeleteAccountModel> deleteAccountFunction({
    required String organisationId,
    required String id,
  }) async {
    final String path = "accounts/delete-account/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "organization": organisationId,
      "id": id,
      "country_id": country_id,
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return DeleteAccountModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }
}