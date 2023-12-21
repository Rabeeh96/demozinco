


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../Api Helper/Repository/api_client.dart';
crateLoan(

    {context,
      required bool type,
      required loan_name,
      required date,
      required payment_type,
      required loan_amount,
      required interest,
      required duration,
      required payment_date,
      required processing_fee,
      required is_fee_include_loan,
      required is_fee_include_emi,
      required is_purchase,
      required is_existing,
      required down_payment,
      required to_account,
      required emi_data,
      required uID,

    }) async {


  SharedPreferences prefs = await SharedPreferences.getInstance();
  var basePath =ApiClient.basePath;
  final organizationId =   prefs.getString("organisation");
  final token = prefs.getString('token');
  final country_id = prefs.getString("country_id");
  String url = basePath+'loans/create-loans/';
  if(type){
    url = basePath+'loans/update-loans/';
  }

  Map data ={
    "organization":organizationId,
    "loan_name":loan_name,
    "date":date,
    "payment_type":payment_type,
    "loan_amount":loan_amount,
    "interest":interest,
    "duration":duration,
    "country_id":country_id,
    "payment_date":payment_date,
    "processing_fee":processing_fee,
    "is_fee_include_loan":is_fee_include_loan,
    "is_fee_include_emi":is_fee_include_emi,
    "is_purchase":is_purchase,
    "is_existing":is_existing,
    "down_payment":down_payment,
    "to_account":to_account,
    "emi_data":emi_data,
    "loan_uuid":uID
  };
  print(data);

   var body = json.encode(data);

  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body);




    Map n = json.decode(utf8.decode(response.bodyBytes));
    print(response.body);
    var status = n["StatusCode"];
    var responseJson = n["message"];
    return [status,responseJson];
  } catch (e) {

    print(e.toString());
    return [5000,"Error"];

  }



}
