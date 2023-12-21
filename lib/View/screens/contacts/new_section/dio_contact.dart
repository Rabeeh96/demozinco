
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../Api Helper/Repository/api_client.dart';


Dio dio = Dio();

Future<String> fileFromImageUrl(imageURL,name) async {
  final response = await http.get(Uri.parse(imageURL));

  final documentDirectory = await getApplicationDocumentsDirectory();
  final file = File(join(documentDirectory.path, name));
  file.writeAsBytesSync(response.bodyBytes);
  return file.path;
}

Future getContactDetailsDetails({context,required portfolioID}) async {
  final response;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var basePath =ApiClient.basePath;

    final token = prefs.getString('token');
    String url = basePath+'contacts/details-contact/';

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
    return [status,responseJson];
  } catch (e) {

    print(e.toString());
    return [5000,"Error"];

  }

}


crateContact(

    {context,
       required country,
      required accountName,
      required phone,
      required amount,
      required address_name,
      required building_name,
      required land_mark,
      required images,
      required state,
      required pin_code,
      required id,
      required type,


    }) async {






  var profileImage=null;
  if(images !=""){
     var fileName = path.basename('${images}');
      profileImage =await MultipartFile.fromFile(images, filename: fileName);

  }


  SharedPreferences prefs = await SharedPreferences.getInstance();
  final country_id = prefs.getString("country_id");
  var basePath =ApiClient.basePath;
  final organizationId =   prefs.getString("organisation");
  final token = prefs.getString('token');



  String url = '';

  url = basePath+'contacts/create-contact/';
  if(type){
    url = basePath+'contacts/update-contact/';
  }


  FormData formData = FormData.fromMap({
    "photo":profileImage,
    "organization": organizationId,
    "country": country,
    "account_name": accountName,
    "phone": phone,
    "amount": amount,
    "address_name": address_name,
    "building_name": building_name,
    "land_mark": land_mark,
    "state": state,
    "country_id": country_id,
    "pin_code": pin_code,
    "id": id,
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
      return [res.data["StatusCode"],res.data["data"]??res.data["errors"]];
    }
    else if (res.data["StatusCode"]==6002){

      return [res.data["StatusCode"],res.data["errors"]];
    }
  }
  catch(e){

  }


  return "";


}

