import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/ChangFirstNameModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/ChangeEmailModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/ChangeIsIntrestModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/ChangeIsZakathModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/ChangeNotificationModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/multipartfile_api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../ModelClasses/Settings/ChangePasswordModelClass.dart';
import '../../ModelClasses/Settings/ChangeProfilePhotoModelClass.dart';
import '../../ModelClasses/Settings/changeRoundimgModelClass.dart';
import '../../Repository/api_client.dart';

class ProfileApi{
  MultiPartFileApiClient multiPartFileApiClient = MultiPartFileApiClient();
  ChangePasswordModelClass changePasswordModelClass = ChangePasswordModelClass();
  ChangFirstNameModelClass changFirstNameModelClass = ChangFirstNameModelClass();
  ChangeEmailModelClass changeEmailModelClass =  ChangeEmailModelClass();
  ChangeNotificationModelClass notificationModelClass = ChangeNotificationModelClass();
  ChangeIsZakathModelClass changeIsZakathModelClass = ChangeIsZakathModelClass();
  ChangeIsIntrestModelClass changeIsIntrestModelClass = ChangeIsIntrestModelClass();
  ChangeProfilePhotoModelClass changeProfilePhotoModelClass = ChangeProfilePhotoModelClass();
  ChangeRoundimgModelClass changeRoundimgModelClass =ChangeRoundimgModelClass();
  ApiClient apiClient = ApiClient();
  final String path = "settings/change-settings/";
  Future<ChangePasswordModelClass> changePasswordFunction({required String userName,required String currentPassword,required String newPassword}) async {
    final String passwordPath = "users/change-password/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final body = {
      "username":userName,
      "country_id":country_id,
      "current_password":currentPassword,
      "new_password":newPassword
    };
    log("_______________api fn change passwrd__________________$body");
    Response response = await apiClient.invokeAPI(
        path: passwordPath, method: "POST", body: body);
    return ChangePasswordModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ChangFirstNameModelClass> changeFirstNameFunction({required String organisation,required String firstName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "organization":organisation,
      "country_id":country_id,
      "type":"first_name",
      "value":firstName
    };
    log("_______________api fn change first name __________________$body");
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ChangFirstNameModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ChangeEmailModelClass> changeEmailFunction({required String organisation,required String email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final body = {
      "organization":organisation,
      "type":"email",
      "country_id":country_id,
      "value":email
    };
    log("_______________api fn change email__________________$body");
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ChangeEmailModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ChangeNotificationModelClass> changeIsNotificationFunction({required String organisation,required bool IsNotification}) async {
    final body = {
      "organization":organisation,
      "type": "is_reminder",
      "value": IsNotification
    };
    log("_______________api fn change isNotification__________________$body");
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ChangeNotificationModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<ChangeIsZakathModelClass> changeIsZakathFunction({required String organisation,required bool isZakath}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "organization":organisation,
      "country_id":country_id,
      "type": "is_zakath",
      "value": isZakath
    };
    log("_______________api fn change isZakath__________________$body");
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ChangeIsZakathModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ChangeIsIntrestModelClass> changeIsIntrestFunction({required String organisation,required bool IsInterest}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final body = {
      "organization":organisation,
      "country_id":country_id,
      "type": "is_interest",
      "value": IsInterest
    };
    log("_______________api fn change IsInterest__________________$body");
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ChangeIsIntrestModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ChangeProfilePhotoModelClass> editProfilePicFunction({
  required File filePath,
    required String organisation
  }) async {
    String path = 'settings/change-settings/';


    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final   map = {
      "organization":organisation,
      "country_id":country_id!,
      "type": "photo",
      "value": filePath.path
    };

    log("_________________profile edit pic api $map");
    Response response = await multiPartFileApiClient.invokeApi(filepath: filePath, path: path, method: "POST", body: map);
    return ChangeProfilePhotoModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<ChangeRoundimgModelClass> changeRoundingFunction({required String organisation,required String value}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");

    final body = {
      "country_id":country_id,
      "organization":organisation,
      "type": "rounding",
      "value": value
    };
    log("_______________api fn change rounding__________________$body");
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ChangeRoundimgModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
}