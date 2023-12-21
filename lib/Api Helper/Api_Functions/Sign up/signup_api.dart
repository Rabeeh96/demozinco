import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Sign%20up/SignupModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';

class SignupApi {

  SignupModelClass signupModelClass = SignupModelClass();
  ApiClient apiClient = ApiClient();
  final String path = "users/user-signup/";
  Future<SignupModelClass> signupFunction(
      {required String firstName, required String email ,
        required String password1,required String  password2,
        required String country
      }) async {
    final body = {
      "first_name": firstName,
      "email": email,
      "password1": password1,
      "password2": password2,
      "country":country
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "LOGIN", body: body);
    log("_________________signupBody $body");

    return SignupModelClass.fromJson(json.decode(response.body));
  }
}






