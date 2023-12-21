import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/SettingsModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsApi {
  SettingsModelClass settingsModelClass = SettingsModelClass();
  ApiClient apiClient = ApiClient();
  final String loginPath = "settings/details-settings/";
  Future<SettingsModelClass> settingsDetailFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final country_id = prefs.getString("country_id");

    final body = {
      "organization": organizationId,
      "country_id": country_id,

    };
    Response response = await apiClient.invokeAPI(path: loginPath, method: "POST", body: body);
    return SettingsModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
}