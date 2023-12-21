import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class MultiPartFileApiClient {
  static const String basePath ="https://www.api.zinco.vikncodes.com/api/v1/";

  Future<http.Response> invokeApi({
    required  File? filepath,
    required String path,
    required String method,
     String? firstName,
     String? userName,
     String? email,
     String? passwordOne,
     String? passwordTwo,
     String? phone,
     String? userTypeId,
     String? organization_id,

    required Map<String, String>? body,
    bool isFiles = true,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('token');
    Map<String, String> headerParams = {
      "authorization": "Bearer $jwt",
      "content-type": "multipart/form-data"};
    var request = http.MultipartRequest(method, Uri.parse(basePath + path));
    request.headers.addAll(headerParams);
    request.files.add(await http.MultipartFile.fromPath('Photo', filepath!.path));
    // request.fields.addAll(
    //     {
    //       "username":userName!,
    //       "email":email!,
    //       "password1":passwordOne!,
    //       "password2":passwordTwo!,
    //       "phone":phone!,
    //       "user_type_id":userTypeId!,
    //       "first_name":firstName!,
    //       "organization_id":organization_id!
    //
    //     });
    body != null ? request.fields.addAll(body) : null;

    http.StreamedResponse res = await request.send();
    http.Response responsed = await http.Response.fromStream(res);
    final responseData = json.decode(responsed.body);

    if (res.statusCode == 200) {
    } else {
    }
    return responsed;
  }
}
