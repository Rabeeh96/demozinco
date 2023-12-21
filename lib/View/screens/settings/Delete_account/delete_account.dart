
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:cuentaguestor_edit/View/screens/login/login_new_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Api Helper/Bloc/Delt User/delete_user_bloc.dart';
import '../../../../Api Helper/ModelClasses/User/DeleteUserModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class DeleteAccount extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<DeleteAccount> {
  late ProgressBar progressBar;

  @override
  void initState() {
    progressBar = ProgressBar();
    super.initState();
  }

  void showProgressBar() {
    progressBar.show(context);
  }

  void hideProgressBar() {
    progressBar.hide();
  }

  @override
  void dispose() {
    hideProgressBar();
    super.dispose();
  }


  final formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              //   mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 74,),
                  Container(
                    alignment: Alignment.center,
                    height: 250,
                    child: SvgPicture.asset("assets/svg/delete_account.svg"),
                    // child: AspectRatio(aspectRatio: 1/2,child:SvgPicture.asset("assets/svg/delete_acc.svg") ,)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "Delete\nAccount.",
                      style: customisedStyle(context, Colors.black, FontWeight.w500, 27.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text("We're sorry to see you leave,\nPlease enter your password.",
                        style: customisedStyle(context, Color(0xffA2A2A2), FontWeight.normal, 16.0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 17, //height of button
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim().isEmpty) {
                            return 'This field is required';
                          } else {
                            return null;
                          }
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        controller: passwordController,

                        style: TextStyle(),
                        obscureText: true,
                        decoration: InputDecoration(
                          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffA2A2A2))),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffA2A2A2))),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffA2A2A2))),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xffA2A2A2),
                          ),
                          // fillColor: Styles.darkTextField,
                          hintStyle: TextStyle(color: Color(0xffA2A2A2)),
                          hintText: "Password",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13.0)),
                      height: MediaQuery.of(context).size.height / 18, //height of button
                      width: MediaQuery.of(context).size.width / 1,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xffD24E57),
                        ),
                        child: Text(
                          'Delete Account',
                          style: customisedStyle(context, Color(0xffffffff), FontWeight.normal, 17.0),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate() == true) {
                            btmDialogueFunction(
                                isDismissible: true,
                                context: context,
                                textMsg: 'Are you sure delete ?',
                                fistBtnOnPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                secondBtnPressed: () async {
                                  Navigator.of(context).pop(true);
                                  var netWork = await checkNetwork();
                                  if (netWork) {
                                    if (!mounted) return;

                                    deleteAccount(passWord: passwordController.text);


                                  } else {
                                    if (!mounted) return;
                                    msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                  }
                                },
                                secondBtnText: 'Delete');
                          }
                        },
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8, right: 8),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     child: Text('Your account will be permanently Deleted\nafter 15 days.',
                  //         style: customisedStyle(context, Color(0xffD85757), FontWeight.normal, 14.0), textAlign: TextAlign.center),
                  //   ),
                  // )
                ]),
          ),
        ));
  }

  deleteAccount({required String passWord}) async {
    print("_______________________________________!");
    var netWork = await checkNetwork();

    if (netWork) {
      print("_______________________________________!");
      if (!mounted) return;
      showProgressBar();

      print("_______________________________________!");
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String baseUrl = ApiClient.basePath;
        var accessToken = prefs.getString('token') ?? '';
        final organizationId = prefs.getString("organisation");
        final country_id = prefs.getString("country_id");
        var uri = "users/user-delete/";
        print("_______________________________________!");
        final url = baseUrl + uri;

        Map data = {
          "organization": organizationId,
          "country_id":country_id,
          "password":passWord
        };

        print(data);
        var body = json.encode(data);

        var response = await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $accessToken',
            },
            body: body);
        Map n = json.decode(utf8.decode(response.bodyBytes));
        print(response.body);
        var statusCode = n["StatusCode"];


        if (statusCode == 6000) {
          hideProgressBar();
          SharedPreferences preference = await SharedPreferences.getInstance();
          preference.clear();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => NewLoginScreen(),
              ),
                  (route) => false);

          // Navigator.pop(context,true);

        }
        else{


          var msg = n["message"];
          msgBtmDialogueFunction(context: context, textMsg: msg);

          print("_______________________________________123");
          hideProgressBar();
        }
      } catch (e) {

        msgBtmDialogueFunction(context: context, textMsg: e.toString());
        hideProgressBar();

      }

    }
    else {

      hideProgressBar();
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }



}
