

import 'dart:convert';
import 'dart:developer';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Forget_password/EmailResendModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Forget_password/ForgetOtpMOdelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Forget_password/PasswordResetModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';




class ForgetPasswordApi {
  EmailResendModelClass emailResendModelClass = EmailResendModelClass();
  ForgetOtpMOdelClass forgetOtpMOdelClass = ForgetOtpMOdelClass();
  PasswordResetModelClass passwordResetModelClass = PasswordResetModelClass();
  ApiClient apiClient = ApiClient();

  Future<EmailResendModelClass> EmailResendFunction(
      {required String email}) async {
    final body = {
      "email": email
    };
    final String Path = "users/resend-email/";
    Response response = await apiClient.invokeAPI(
        path: Path, method: "LOGIN", body: body);
    log("_________________loginBody $body");
    return EmailResendModelClass.fromJson(json.decode(response.body));
  }

  Future<ForgetOtpMOdelClass> forgetOtpFunction(
      {required String email, required String otp,required String isOtp}) async {
    final body = {
      "email": email,
      "otp": otp,
      "is_otp":isOtp

    };
    final String Path = "users/user-verify/";

    Response response = await apiClient.invokeAPI(
        path: Path, method: "LOGIN", body: body);
    log("_________________Body $body");
    return ForgetOtpMOdelClass.fromJson(json.decode(response.body));
  }




  Future<PasswordResetModelClass> resetPasswordFunction(
      {required String email, required String otp,required String password1, required String password2}) async {
    final body = {
      "email":email,
      "otp":otp,
      "password1":password1,
      "password2":password2

    };
    final String Path = "users/reset-password-otp/";

    Response response = await apiClient.invokeAPI(
        path: Path, method: "LOGIN", body: body);
    log("_________________Body $body");
    return PasswordResetModelClass.fromJson(json.decode(response.body));
  }


}






