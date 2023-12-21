import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_exception.dart';


//
class ApiClient {
  //
  // static const String basePath = 'http://192.168.1.89:8005/api/v1/';
  // static const String imageBasePath = 'http://192.168.1.89:8005';

   static const String basePath = 'https://www.api.cuentagestor.com/api/v1/';
   static const String imageBasePath = 'https://www.api.cuentagestor.com';



   Future<Response> invokeAPI(
      { required String path,
        required String method,
        required Object? body}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    print(token);
    Map<String, String> headerParams = {};
    if (method == 'POST' || method == 'GET' || method == 'PATCH'|| method =="DELETE" ) {
      headerParams = {
        "authorization": "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
    }
    //
    else if(method == "POST_" ){

      headerParams = {
        "authorization": "Bearer $token",
      };

    }
    // x
    Response response;

    String url = basePath + path;
    print(url);
    print(body);
    print(token);
    // String searchurl =  basePath + 'search/movie'+'?api_key=$token'+ path;



    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;

    switch (method) {
      case "POST":
        response = await post(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "LOGIN":
        response =
        await post(Uri.parse(url), headers: headerParams, body: body);
        break;
      case "PUT":
        response = await put(Uri.parse(url), headers: headerParams, body: jsonEncode(body));
        break;
      case "PATCH":
        response = await patch(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "DELETE":
        response = await delete(Uri.parse(url), headers: headerParams,body: jsonEncode(body));
        break;
      case "DELETE_":
        response = await delete(Uri.parse(url), headers: headerParams,body: jsonEncode(body));
        break;
      case "POST_":
        response = await post(
          Uri.parse(url),
          headers: headerParams,
          body: body,
        );
        break;
      case "GET_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;

      default:
        response = await get(Uri.parse(url), headers: headerParams);
    }
    log("**************${response.body}");

    print('status of $path =>' + (response.statusCode).toString());
    if (response.statusCode >= 400) {
      // print("if)()");
      log(path +
          ' : ' +
          response.statusCode.toString() +
          ' : ' +
          response.body);

      throw ApiException(
          message: _decodeBodyBytes(response), statusCode: response.statusCode);
    }
    ;
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}