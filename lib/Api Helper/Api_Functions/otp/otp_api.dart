import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';


import '../../ModelClasses/otp/OtpModelclass.dart';
import '../../Repository/api_client.dart';



class OtpApi {
  OtpModelclass otpModelclass = OtpModelclass();
  ApiClient apiClient = ApiClient();
  final String loginPath = "users/user-verify/";
  Future<OtpModelclass> otpFunction(
      {required String email, required String otp}) async {
    final body = {
      "email": email,
      "otp": otp,
    };
    Response response = await apiClient.invokeAPI(
        path: loginPath, method: "LOGIN", body: body);
    log("_________________loginBody $body");
    return OtpModelclass.fromJson(json.decode(response.body));
  }
}






