import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../ModelClasses/Userole/CreateUseroleModelClass.dart';
import '../../ModelClasses/Userole/DeleteUseroleModelClass.dart';
import '../../ModelClasses/Userole/DetailUseroleModelClass.dart';
import '../../ModelClasses/Userole/EditUseroleModelClass.dart';
import '../../ModelClasses/Userole/ListUseroleModelClass.dart';
import '../../Repository/api_client.dart';



class UseroleApi {
  CreateUseroleModelClass createUseroleModelClass = CreateUseroleModelClass();
  ListUseroleModelClass listUseroleModelClass = ListUseroleModelClass();
  DetailUseroleModelClass detailUseroleModelClass = DetailUseroleModelClass();
  EditUseroleModelClass editUseroleModelClass = EditUseroleModelClass();
  DeleteUseroleModelClass deleteUseroleModelClass = DeleteUseroleModelClass();
  ApiClient apiClient = ApiClient();

  Future<CreateUseroleModelClass> useroleCreateFunction({ required String organizationId,
    required String userTypeName,
    required String notes,
    required List permissionData}) async {
    final String path = "users/create-user_role/";
    final body = {
      "organization_id": organizationId,
      "user_type_name": userTypeName,
      "notes":notes,
      "permission_datas": permissionData
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return CreateUseroleModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ListUseroleModelClass> useroleListFunction({
    required String search,
    required int pageNo,
    required int items_per_page}) async {
    final String path = "users/list-user_role/";
    final body = {
      "search":search,
      "page_no":pageNo,
      "items_per_page":items_per_page
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ListUseroleModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));  }


  Future<DetailUseroleModelClass> useroleDetailFunction({
    required String id,
   }) async {
    final String path = "users/detail-user_role/";
    final body = {
      "id": id
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return DetailUseroleModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));  }



  Future<EditUseroleModelClass> useroleEditFunction({
    required String organisationId,
    required int userTypeId,
    required String userTypeName,
    required List permissionData
  }) async {
    final String path = "users/update-user_role/";
    final body = {
      "organization_id":organisationId,
      "user_type_id":userTypeId,
      "user_type_name":userTypeName,
      "notes":"",
      "permission_datas": permissionData
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return EditUseroleModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));  }

  Future<DeleteUseroleModelClass> useroleDeleteFunction({
    required String organisationId,
    required int userTypeId,

  }) async {
    final String path = "users/delete-user_role/";
    final body = {
      "organization_id":organisationId,
      "user_type_id":userTypeId,
      "notes":""
    };

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return DeleteUseroleModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));  }

}


/// another api function method add userole function
Future createUserole({context,
  required String organizationId,
  required String userTypeName,
  required String notes,
  required List permissionData

}) async {


  final response;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var basePath = ApiClient.basePath;
    final token = prefs.getString('token');

    String url = basePath+'users/create-user_role/';

    Map data = {
      "organization_id": organizationId,
      "user_type_name": userTypeName,
      "notes":notes,
      "permission_datas": permissionData
    };
    log("_+++++++++++++++++++++++++++data+++++++++++++++++++++++++++_$data");
    log("_______________________________url_______________________________________ $url");


    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body);



    Map n = json.decode(utf8.decode(response.bodyBytes));
    var status = n["StatusCode"];



    if(status ==6000){
      return [status,n["user_role_id"],n["message"]];
    }
    else{
      return [status,"Please try again later"];
    }



  } catch (e) {

    print(e.toString());
    return [5000,e.toString()];
  }
}