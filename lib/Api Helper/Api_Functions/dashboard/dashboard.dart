
import 'dart:convert';
import 'dart:developer';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/dashboard/ModelClassDashboard.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardApi {
  ModelClassDashboard modelClassDashboard = ModelClassDashboard();
  ApiClient apiClient = ApiClient();
  final String path = "dashboard/details-dashboard/";

  Future<ModelClassDashboard> dashBoardFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    var country_id = prefs.getString('country_id') ;


    final body = {
      "organization": organizationId,
      "country_id":country_id
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("___________________________________dashboard  $body");
    return ModelClassDashboard.fromJson(json.decode(response.body));
  }
}