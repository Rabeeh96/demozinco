import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../ModelClasses/Reminder/ListReminderModelClass.dart';
import '../../Repository/api_client.dart';


class ReminderApi{
  ApiClient apiClient = ApiClient();
  ListReminderModelClass listReminderModelClass = ListReminderModelClass();

  Future<ListReminderModelClass> ListReminderFunction(
      {required String description,required String date,
        required String organisation,required String voucher_type,
        required String amount, required int reminder_cycle,required int master_id
      }) async {
    final String path = "reminders/list-reminders/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "organization":organisation,
      "description": description,
      "date": date,
      "voucher_type": "",
      "amount": amount,
      "country_id": country_id,
      "reminder_cycle": reminder_cycle,
      "master_id":master_id,
    };


    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);

    log("_________________ list loan  in api  $body");
    return ListReminderModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


}