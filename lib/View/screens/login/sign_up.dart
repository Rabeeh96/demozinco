import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Api Helper/Bloc/Signup/signup_bloc.dart';
import '../../../Api Helper/ModelClasses/Sign up/SignupModelClass.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../../../Utilities/global/variables.dart';
import 'Country/default_country_new_design.dart';
import 'otp_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late ProgressBar progressBar;

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

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  var countries = [
    "India",
    "China",
    "Dubai",
  ];
  String countriesValue = 'India';
  String countryId = "";

  @override
  void initState() {
    progressBar = ProgressBar();
    super.initState();
  }

  late SignupModelClass? signupModelClass;
  final ValueNotifier<bool> passwordVisible = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordVisible = ValueNotifier(true);


  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .01,
    );
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) async {
        if (state is SignupLoaded) {
          hideProgressBar();
          signupModelClass = BlocProvider.of<SignupBloc>(context).signupModelClass!;
          if (signupModelClass!.statusCode == 6000) {
            await msgBtmDialogueFunction(
              context: context,
              textMsg: signupModelClass!.message.toString(),
            );

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OtpScreen(
                  email: signupModelClass!.email!,
                  type: 'Signup',
                )));
          } else if (signupModelClass!.statusCode == 6001) {
            msgBtmDialogueFunction(context: context, textMsg: signupModelClass!.message!);
          } else if (signupModelClass!.statusCode == 6002) {
            msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
          }
        }
        if (state is SignupError) {
          hideProgressBar();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height / 11,

            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Color(0xff2BAAFC),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
          ),
          body: Container(
            padding: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06, top: 0),
            height: mHeight,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Container(

                    alignment: Alignment.center,

                    height: mHeight * .20,

                    child: SvgPicture.asset("assets/svg/signup.svg"),
                  ),
                  Container(

                    alignment: Alignment.centerLeft,

                    height: mHeight * .1,

                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: customisedStyle(context, Colors.black, FontWeight.w500, 27.0),
                    ),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    decoration: inputDecoration(hintText: "Name", prifixIcon: Image.asset("assets/Auth user setup/Group 42.png")),
                    validator: (val) {
                      if (val == null || val.isEmpty || val.trim().isEmpty) {
                        return 'This field is required';
                      }

                      if (val.length < 6) {
                        return 'Should be 6–30 characters.';
                      }

                      return null;
                    },
                  ),
                  space,
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: inputDecoration(
                        hintText: "Email Address",
                        prifixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xffB8B8B8),
                        )),
                    validator: (val) {
                      if (val == null || val.isEmpty || val.trim().isEmpty) {
                        return 'This field is required';
                      }

                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                        return "Please enter a valid email address.";
                      }

                      return null;
                    },
                  ),
                  space,
                  TextFormField(
                    readOnly: true,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewDefaultCountryList()),
                      );
                      print(result);
                      result != null ? countryController.text = result[0] : Null;
                      result != null ? countryId = result[2] : Null;
                    },
                    textInputAction: TextInputAction.next,
                    controller: countryController,
                    decoration: inputDecoration(
                      hintText: "Country",
                      prifixIcon: Image.asset("assets/Auth user setup/my-location.png"),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ),
                    // validator: (val) {
                    //   if (val == null || val.isEmpty || val.trim().isEmpty) {
                    //     return 'This field is required';
                    //   } else if (countryId.isEmpty) {
                    //     "Please select your country";
                    //   }
                    //   return null;
                    // },
                  ),
                  space,
                  ValueListenableBuilder(
                      valueListenable: passwordVisible,
                      builder: (BuildContext context, bool newValue, _) {
                      return TextFormField(

                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: inputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                passwordVisible.value = !passwordVisible.value;
                              },
                              icon: newValue
                                  ? const Icon(Icons.visibility_off, color: Color(0xff2BAAFC))
                                  : const Icon(Icons.remove_red_eye, color: Color(0xff2BAAFC))),
                          hintText: "Password",
                          prifixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xffB8B8B8),
                          ),
                        ),
                        obscureText: newValue,
                        validator: (val) {
                          RegExp regex = RegExp(r'(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');

                          if (val == null || val.isEmpty || val.trim().isEmpty) {
                            return 'This field is required';
                          } else {
                            if (!regex.hasMatch(val)) {
                              return 'Must be 8 or more characters and contain at least\n1 number and 1 special character.';
                            } else {
                              return null;
                            }
                          }
                        },
                      );
                    }
                  ),
                  space,
                  ValueListenableBuilder(
                      valueListenable: confirmPasswordVisible,
                      builder: (BuildContext context, bool value, _) {
                      return TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        controller: confirmPasswordController,
                        decoration: inputDecoration(
                          hintText: "Confirm password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                confirmPasswordVisible.value = !confirmPasswordVisible.value;
                              },
                              icon: value
                                  ? const Icon(Icons.visibility_off, color: Color(0xff2BAAFC))
                                  : const Icon(Icons.remove_red_eye, color: Color(0xff2BAAFC))),
                          prifixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xffB8B8B8),
                          ),
                        ),
                        obscureText: value,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (passwordController.text != confirmPasswordController.text) {
                            return 'Confirmation password does not match';
                          }

                          return null;
                        },
                      );
                    }
                  ),
                  SizedBox(
                    height: mHeight * .02,
                  ),
                  Container(
                    width: mWidth,
                    color: Colors.white,
                    height: mHeight / 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "By signing up you're agreeing to our",
                          textAlign: TextAlign.center,
                          style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.normal, 14.0),
                        ),
                        Text(
                          "Terms and conditions",
                          textAlign: TextAlign.center,
                          style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.w500, 15.0),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: mHeight * .06,
                    width: mWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() == true) {
                          if(countryController.text ==""){
                            countryId = "bbcba070-4018-444c-b356-90676aa4e33a";
                          }
                          SignUpApiFunction();
                        }
                        null;
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2BAAFC)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ))),
                      child: Text(
                        'Create account',
                        style: customisedStyle(context, Colors.white, FontWeight.normal, 17.0),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: mHeight / 14,
                    // height: mHeight / 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?  ",
                          textAlign: TextAlign.center,
                          style: customisedStyle(context, Color(0xff6D6D6D), FontWeight.normal, 16.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.w600, 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mHeight * .05,
                  )
                ]),
              ),
            ),
          )),
    );
  }

  SignUpApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<SignupBloc>(context).add(FetchSignupEvent(
          firstName: nameController.text,
          email: emailController.text,
          password1: passwordController.text,
          password2: confirmPasswordController.text,
          country: countryId));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }
}
