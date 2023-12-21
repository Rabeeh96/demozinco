import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Login/LoginModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';




class LoginApi {
  LoginModelClass loginModelClass = LoginModelClass();
  ApiClient apiClient = ApiClient();
  final String loginPath = "users/login/";
  Future<LoginModelClass> loginFunction(
      {required String username, required String password}) async {
    final body = {
      "username": username,
      "password": password,
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "LOGIN", body: body);
    log("_________________loginBody $body");
    return LoginModelClass.fromJson(json.decode(response.body));
  }
}






