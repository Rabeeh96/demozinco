import 'dart:convert';


import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/User/DeleteUserModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/User/DetailUserModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/User/EditUserModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/User/ListUserModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/profilepic_upload_api_client.dart';
import 'package:http/http.dart';


import '../../ModelClasses/User/UserCreateModelClass.dart';

class UserApi{
  ApiClient apiClient = ApiClient();
  UserCreateModelClass userCreateModelClass = UserCreateModelClass();
  ListUserModelClass listUserModelClass = ListUserModelClass();
  DetailUserModelClass detailUserModelClass = DetailUserModelClass();
  EditUserModelClass editUserModelClass = EditUserModelClass();
  DeleteUserModelClass deleteUserModelClass = DeleteUserModelClass();
  MultiPartFileApiClientProfile multiPartFileApiClientProfile  = MultiPartFileApiClientProfile();

  Future<UserCreateModelClass> useroleCreateFunction({
    required String filePath,
    required String firstName,
    required String userName,
    required String email,
    required String passwordOne,
    required String passwordTwo,
    required String phone,
    required String userTypeId,
    required String organization_id,
  }) async {
    final String path = "users/user-signup/";
    final body = {
      "Photo": filePath,
      "username": userName,
      "email": email,
      "password1": passwordOne,
      "password2": passwordTwo,
      "phone": phone,
      "user_type_id": userTypeId,
      "first_name": firstName,
      "organization_id": organization_id,
    };

    Response response = await multiPartFileApiClientProfile.invokeApi(
      path: path,
      method: "POST",
      body: body,
      filepath: filePath,
    );
    return UserCreateModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<ListUserModelClass> useroleListFunction({
    required String search,

  }) async {
    final String path = "users/user-list/";
    final body = {
      "search":search
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ListUserModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<DetailUserModelClass> useroleDetailFunction({
    required int id,
  }) async {
    final String path = "users/user-detail/";
    final body = {
      "id":id
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return DetailUserModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<EditUserModelClass> useroleEditFunction({
    required String filePath,
    required String firstName,
    required String userName,
    required String email,
    required String passwordOne,
    required String passwordTwo,
    required String phone,
    required String userTypeId,
    required String organization_id,
    required String id,
  }) async {
    final String path = "users/user-update/";
    final body = {
      "Photo": filePath,
      "username":userName,
      "email":email,
      "password1":passwordOne,
      "password2":passwordTwo,
      "phone":phone,
      "user_type_id":userTypeId,
      "first_name":firstName,
      "organization_id":organization_id,
      "id":id
    };


    Response response = await multiPartFileApiClientProfile.invokeApi(
      path: path,
      method: "POST",
      body: body,
      filepath: filePath,
    );
    return EditUserModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<DeleteUserModelClass> useroleDeleteFunction({
    required int id,
  }) async {
    final String path = "users/user-delete/";
    final body = {
      "id":id
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return DeleteUserModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
}