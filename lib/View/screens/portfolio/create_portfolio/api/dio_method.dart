import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Api Helper/Repository/api_client.dart';



Dio dio = Dio();

FormData formData = FormData();

 downloadFile(String fileUrl, String fileName) async {
  final response = await http.get(Uri.parse(fileUrl));

  if (response.statusCode == 200) {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentsDirectory.path}/$fileName';
    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;

  } else {
    return "";

  }
}
Future<String> fileFromImageUrl(imageURL,name) async {

  final response = await http.get(Uri.parse(ApiClient.imageBasePath+imageURL));

  final documentDirectory = await getApplicationDocumentsDirectory();
  final file = File(join(documentDirectory.path, name));
  file.writeAsBytesSync(response.bodyBytes);

  return file.path;
}


Future getPortfolioDetails({context,required portfolioID}) async {
  final response;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var basePath =ApiClient.basePath;
     final country_id = prefs.getString("country_id");
    final token = prefs.getString('token');
    String url = basePath+'assets/details-asset/';

    final organizationId =   prefs.getString("organisation");

    Map data = {"asset_id": portfolioID,"organization": organizationId,"country_id": country_id};
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body);



    Map n = json.decode(utf8.decode(response.bodyBytes));
    var status = n["StatusCode"];
    var responseJson = n["data"];
    log("____full data ${responseJson}");
    return [status,responseJson];
  } catch (e) {

    print(e.toString());
    return [5000,"Error"];

  }


}
Future getPortfolioIncomeAndExpenses({context,required portfolioID}) async {
  final response;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var basePath =ApiClient.basePath;

    final token = prefs.getString('token');
    String url = basePath+'assets/details-asset/';

    final organizationId =   prefs.getString("organisation");
     final country_id = prefs.getString("country_id");

    Map data = {"id": portfolioID,"organization": organizationId,"country_id": country_id};
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body);




    Map n = json.decode(utf8.decode(response.bodyBytes));
    var status = n["StatusCode"];
    var responseJson = n["data"];
    log("____full data ${responseJson}");
    return [status,responseJson];
  } catch (e) {

    print(e.toString());
    return [5000,"Error"];

  }


}




   cratePortFolio(

    {context,
      required date,
      required total_share,
      required asset_type,
      required total_value,
      required asset_name,
      required asset_details,
      required address_details,
      required CustomProperties,
      required List images,
      required documents,
      required type,
      required id,


    }) async {



  List uploadList = [];
  List uploadListDocuments = [];


  for (var i = 0; i < images.length; i++) {
    String fileName = "";
    fileName = path.basename('${images[i]}');
    uploadList.add(await MultipartFile.fromFile(images[i], filename: images[i]));
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var basePath =ApiClient.basePath;
  final organizationId =   prefs.getString("organisation");
  final token = prefs.getString('token');
  final country_id = prefs.getString("country_id");
  String url = '';

  url = basePath+'assets/create-asset/';
  if(type){
    url = basePath+'assets/update-asset/';
  }

  
  FormData formData = FormData.fromMap({
    "date": date,
    'id':id,
    "organization": organizationId,
    "total_share": total_share,
    "asset_type": asset_type,
    "total_value": total_value,
    "asset_name": asset_name,
    "country_id": country_id,
    "asset_details": jsonEncode(asset_details),
    "address": jsonEncode(address_details),
    "CustomProperties":jsonEncode(CustomProperties),
    "images":uploadList,
    "documents":uploadListDocuments,
  });

  Response ? res;
  try {
    res = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Cookie': 'csrftoken=KVitXxcngMKXnudgDznmdHDmSPNKEHmu; sessionid=ppywqfl3s81mi7nl09cjy75wv7ilgd1w'},
        )
    );


    if(res.data["StatusCode"]==6000||res.data["StatusCode"]==6001){
      return [res.data["StatusCode"],res.data["message"]];
    }
    else if (res.data["StatusCode"]==6002){
      log(res.data["error"]);
      return [res.data["StatusCode"],res.data["error"]];
    }
  }
  catch(e){

  }

  return "";


}


