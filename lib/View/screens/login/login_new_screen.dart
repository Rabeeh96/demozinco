import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cuentaguestor_edit/Utilities/global/text_style.dart';
import 'package:cuentaguestor_edit/View/screens/login/Forget_password/forget_password.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../Api Helper/Bloc/Settings/settings_bloc.dart';
import '../../../Api Helper/ModelClasses/Login/LoginModelClass.dart';
import '../../../Api Helper/Repository/api_client.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/variables.dart';
import '../../MainScreen/main_screen.dart';
import 'otp_screen.dart';
import 'sign_up.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  late LoginModelClass loginModelClass;
  late ProgressBar progressBar;

  bool isAccount = false;

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

  final formKey = GlobalKey<FormState>();
  var errorMsg = "";
  var useNotFound = "";
  String mail = "";
  var statusCode;


  final TextEditingController emailController = TextEditingController()..text = "";
  TextEditingController passwordController = TextEditingController()..text = "";

  // final TextEditingController emailController = TextEditingController()..text = "rabeeh@vikncodes.com";
  // TextEditingController passwordController = TextEditingController()..text = "Asd@1234";

  final ValueNotifier<bool> passwordVisible = ValueNotifier(true);

  Future<Null> login(userName, password) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
    } else {
      try {
        loadingNotifier.value = true;
        SharedPreferences preference = await SharedPreferences.getInstance();
        preference.setBool('isAccount', isAccount);
        String url = ApiClient.basePath + "users/login/";

        Map data = {
          "username": userName,
          "password": password,
        };

        print(data);
        var bdy = json.encode(data);
        var response = await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
            },
            body: bdy);

        Map n = json.decode(utf8.decode(response.bodyBytes));

        print(response.body);
        var status = n["success"];
        setState(() {
          statusCode = status;
        });
        print(url);
        print(data);

        if (status == 6000) {
          loadingNotifier.value = false;
          var responseData = n["country_details"];

          preference.setString('token', n["access_token"]);
          preference.setString('userName', n["username"]);
          preference.setString('organisation', n["organization"]);
          preference.setString('country_id', responseData["id"] ?? '');
          preference.setString('currency_symbol', responseData["currency_simbol"] ?? '');
          preference.setString('default_country', responseData["country_name"] ?? '');
          preference.setString('default_country_id', responseData["id"] ?? '');
          preference.setString('default_country_code', responseData["country_code"] ?? '');

          await SettingsApiFunction();

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ScreenMain(),
              ),
              (route) => false);

        } else if (status == 6001) {
          loadingNotifier.value = false;
          preference.setString('mail', n["user_email"]);
          final email = preference.getString("mail");
          hideProgressBar();
          var msg = n["error"];

          if (msg == "Password Incorrect") {
            setState(() {
              useNotFound = "";
              errorMsg = msg;
            });
          } else if (msg == "User not found") {
            setState(() {
              errorMsg = "";
              useNotFound = msg;
            });
          } else if (msg == "Please Verify Your Email to Login") {
            await msgBtmDialogueFunction(context: context, textMsg: msg);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OtpScreen(
                      email: email!,
                      type: 'Login',
                    )));
          } else {}

        } else {
          loadingNotifier.value = false;
          msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
        }
      } catch (e) {
        loadingNotifier.value = false;
        msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
          top: 6,
          right: 20,
          left: 20,
        ),
        height: mHeight,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                alignment: Alignment.center,
                height: mHeight / 2.5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SvgPicture.asset("assets/svg/login.svg"),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                height: mHeight * .07,
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: customisedStyle(context, Colors.black, FontWeight.w500, 27.0),
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty || val.trim().isEmpty) {
                    return 'This field is required';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                    return "Please enter a valid email address.";
                  }
                  return null;
                },
                controller: emailController,
                decoration: inputDecoration(
                    hintText: "Email Address",
                    errorMsg: statusCode == 6001 ? useNotFound : null,
                    prifixIcon: Image.asset("assets/Auth user setup/Group 42.png")),
              ),

              SizedBox(
                height: 15,
              ),
              ValueListenableBuilder(
                  valueListenable: passwordVisible,
                  builder: (BuildContext context, bool newValue, _) {
                    return TextFormField(
                      obscureText: newValue,
                      textCapitalization: TextCapitalization.words,

                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      decoration: inputDecoration(
                        hintText: "Password",
                        errorMsg: statusCode == 6001 ? errorMsg : null,
                        suffixIcon: IconButton(
                            onPressed: () {
                              passwordVisible.value = !passwordVisible.value;
                            },
                            icon: newValue
                                ? const Icon(Icons.visibility_off, color: Color(0xff2BAAFC))
                                : const Icon(Icons.remove_red_eye, color: Color(0xff2BAAFC))),
                        prifixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xffB8B8B8),
                        ),
                      ),

                      validator: (val) {
                        RegExp regex = RegExp(r'(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');
                        if (val == null || val.isEmpty || val.trim().isEmpty) {
                          return 'This field is required';
                        } else {
                          return null;
                          if (!regex.hasMatch(val)) {
                            return 'Must be 8 or more characters and contain at least\n1 number and 1 special character.';
                          } else {
                            return null;
                          }
                        }
                      },
                    );
                  }),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  height: mHeight * .1,
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.center,
                    style: customisedStyle(context, Color(0xff1479DE), FontWeight.normal, 18.0),
                  ),
                ),
              ),

              signInButton(),

              SizedBox(
                height: mHeight * .03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: mHeight / 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?  ",
                        textAlign: TextAlign.center,
                        style: customisedStyle(context, Color(0xff6D6D6D), FontWeight.normal, 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.w600, 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonPress() {
    if (formKey.currentState!.validate() == true) {


      login(emailController.text, passwordController.text);
    }
    null;
  }

  final loadingNotifier = ValueNotifier<bool>(false);

  Widget signInButton() {
    return Center(
      child: ValueListenableBuilder<bool>(
        valueListenable: loadingNotifier,
        builder: (context, isLoading, child) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                height: MediaQuery.of(context).size.height / 16,
                width: MediaQuery.of(context).size.width / 1.1,

                child: ElevatedButton(

                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1479DE)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ))),

                  onPressed: isLoading ? null : _handleButtonPress,
                  child: isLoading
                      ? null
                      :   Text(
                    "Sign in",
                    style:customisedStyle(context, Colors.white, FontWeight.normal, 17.0),
                  ),


                ),
              ),
              if (isLoading)
                Positioned.fill(
                  child: Center(
                    child: Container(
                        height: 24,
                        width: 24,
                        child: const CircularProgressIndicator(
                          color: Colors.white38,
                          strokeWidth: 2,
                        )),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
