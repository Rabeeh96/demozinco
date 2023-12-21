import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../Api Helper/Bloc/DashBoard/dash_board_bloc.dart';
import '../../../Api Helper/Bloc/Settings/settings_bloc.dart';
import '../../../Api Helper/ModelClasses/Login/LoginModelClass.dart';
import '../../../Api Helper/Repository/api_client.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../../MainScreen/main_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController()..text = "rabeeh";
  TextEditingController passwordController = TextEditingController()..text = "vikncodes";
    bool isAccount = false;

  bool isChecked = false;
  final ValueNotifier<bool> passwordVisible = ValueNotifier(true);
  final ValueNotifier<bool> isCheck = ValueNotifier(false);
  late LoginModelClass loginModelClass;
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
    progressBar.hide();
    super.dispose();
  }

  dashBoardApiFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<DashBoardBloc>(context).add(FetchDashBoardEvent());
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  SettingsApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<SettingsBloc>(context).add(FetchSettingsDetailEvent());
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  Future<Null> login(userName, password) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
    } else {
      try {
        SharedPreferences preference = await SharedPreferences.getInstance();
        String url = ApiClient.basePath + "users/login";

        Map data = {
          "username": userName,
          "password": password,
        };

        var bdy = json.encode(data);

        var response = await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
            },
            body: bdy);

        Map n = json.decode(utf8.decode(response.bodyBytes));


        var status = n["success"];

        if (status == 6000) {
          var responseData = n["data"];


          hideProgressBar();
          preference.setString('token', responseData["access"]);
          preference.setString('userName', responseData["username"]);
          preference.setString('organisation', n["organization"]);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ScreenMain(),
              ),
                  (route) => false);
          dashBoardApiFunction();
          SettingsApiFunction();

        } else if (status == 6001) {
          hideProgressBar();
          var msg = n["error"];
          msgBtmDialogueFunction(context: context, textMsg: msg);

        } else {
          hideProgressBar();
          msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
        }
      } catch (e) {
        hideProgressBar();
        msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 2,
            child: Form(
              key: _formKey,
              child: ListView(children: [
                Text(
                  "Sign in",
                  style: customisedStyle(context, Colors.black, FontWeight.w700, 25.0),
                ),
                Text(
                  "to your account",
                  style: customisedStyle(context, Colors.black, FontWeight.w700, 15.0),
                ),
                SizedBox(
                  height: mHeight * .03,
                ),
                TextFormFieldWidget(
                  userNameController: userNameController,
                  hintText: "User name",
                  image: "assets/svg/userName.svg",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: mHeight * .02,
                ),
                ValueListenableBuilder(
                    valueListenable: passwordVisible,
                    builder: (BuildContext context, bool newValue, _) {
                      return TextFormFieldWidget(
                        textInputAction: TextInputAction.done,
                        userNameController: passwordController,
                        hintText: "Password",
                        image: "assets/svg/password.svg",
                        suffixIcon: IconButton(
                            onPressed: () {
                              passwordVisible.value = !passwordVisible.value;
                            },
                            icon: newValue
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: const Color(0xff5346BD),
                                  )
                                : const Icon(
                                    Icons.remove_red_eye,
                                    color: const Color(0xff5346BD),
                                  )),
                        obscureText: newValue,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      );
                    }),
                SizedBox(
                  height: mHeight * .03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: mWidth * .035,
                    ),
                    ValueListenableBuilder(
                        valueListenable: isCheck,
                        builder: (BuildContext context, bool newCheckValue, _) {
                          return Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height / 34,
                              width: MediaQuery.of(context).size.width / 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xff5346BD), width: 1),
                                shape: BoxShape.circle,
                              ),
                              child: Checkbox(
                                checkColor: const Color(0xff5346BD),
                                activeColor: Colors.transparent,
                                fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                value: newCheckValue,
                                onChanged: (value) {
                                  isCheck.value = !isCheck.value;
                                },
                              ));
                        }),
                    SizedBox(
                      width: mWidth * .03,
                    ),
                    Text(
                      "Keep me Logged in",
                      style: customisedStyle(context, Colors.black, FontWeight.normal, 13.0),
                    )
                  ],
                ),
                SizedBox(
                  height: mHeight * .03,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff2BAAFC),
                    ),
                    child: Text(
                      'SIGN IN',
                      style: customisedStyle(context, Color(0xffFFFFFF), FontWeight.w200, 15.0),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() == true) {


                        login(userNameController.text, passwordController.text);
                       }
                      null;
                    },
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }


}

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      required this.userNameController,
      required this.hintText,
      required this.image,
      this.suffixIcon,
      required this.obscureText,
      required this.validator,
      required this.textInputAction});

  final TextEditingController userNameController;
  final String hintText;
  final String image;
  final bool obscureText;
  final String? Function(String?) validator;
  Widget? suffixIcon;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;
    return TextFormField(
        style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.normal)),
        textInputAction: textInputAction,
        validator: validator,
        controller: userNameController,
        readOnly: false,
        obscureText: obscureText,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
            ),
            contentPadding: const EdgeInsets.all(7),
            suffixIcon: suffixIcon,

            hintText: hintText,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                image,
                fit: BoxFit.scaleDown,
              ),
            ),
            hintStyle: TextStyleDecoration.hintTextColor(context),
            border: InputBorder.none,
            filled: true,
            fillColor: const Color(0xffF3F7FC)));
  }
}
