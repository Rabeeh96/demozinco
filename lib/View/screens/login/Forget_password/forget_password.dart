import 'package:cuentaguestor_edit/Utilities/Commen%20Functions/bottomsheet_fucntion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Forget_Password/forget_password_bloc.dart';
import '../../../../Api Helper/ModelClasses/Forget_password/EmailResendModelClass.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/CommenClass/textfied.dart';
import '../../../../Utilities/global/text_style.dart';
import 'forget_password_otp_screen.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    progressBar = ProgressBar();
  }

  late EmailResendModelClass emailResendModelClass;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) async {
        if (state is EmailResendLoaded) {
          hideProgressBar();
          emailResendModelClass = BlocProvider.of<ForgetPasswordBloc>(context).emailResendModelClass;

          if (emailResendModelClass.statusCode == 6000) {
            await msgBtmDialogueFunction(
              context: context,
              textMsg: emailResendModelClass.message.toString(),
            );

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ForgetPasswordOtpScreen(
                          email: emailController.text,
                        )));


          }

          if (emailResendModelClass.statusCode == 6001) {
            msgBtmDialogueFunction(context: context, textMsg: emailResendModelClass.message!);
          }
        }
        if (state is EmailResendError){
          hideProgressBar();

        }
      },
      child: Scaffold(
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
        backgroundColor: Colors.white,
        body: Container(
          height: mHeight,
          padding: EdgeInsets.only(right: 20, left: 20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: mHeight / 7,
                  ),
                  Container(

                    alignment: Alignment.center,
                    height: mHeight * .25,

                    child: SvgPicture.asset("assets/svg/forgot.svg"),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: mHeight * .13,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Forgot",
                          textAlign: TextAlign.center,
                          style: customisedStyle(context, Colors.black, FontWeight.w500, 27.0),
                        ),
                        Text(
                          "Password?",
                          textAlign: TextAlign.center,
                          style: customisedStyle(context, Colors.black, FontWeight.w500, 27.0),
                        ),
                        Text(
                          "Don't worry, please enter your email address.",
                          textAlign: TextAlign.center,
                          style: customisedStyle(context, Color(0xffA2A2A2), FontWeight.normal, 14.0),
                        ),
                      ],
                    ),
                  ),
                  AuthTextField(
                      readOnly: false,
                      controller: emailController,
                      keyBordType: TextInputType.emailAddress,
                      obscureText: false,
                      hintText: 'Email Address',
                      validator: (val) {
                        if (val == null || val.isEmpty || val.trim().isEmpty) {
                          return 'This field is required';
                        }

                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                          return "Please enter a valid email address.";
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      prefixIcon: Image.asset("assets/Auth user setup/email-line.png")),
                  SizedBox(
                    height: mHeight * .05,
                  ),
                  Container(
                    height: mHeight * .06,
                    width: mWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() == true) {
                          EmailResendApiFunction();
                        }

                        null;
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2BAAFC)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ))),
                      child: Text(
                        'Continue',
                        style: customisedStyle(context, Colors.white, FontWeight.normal, 17.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  EmailResendApiFunction() async {
    var netWork = await checkNetwork();
    final preference = await SharedPreferences.getInstance();
    preference.setString('emailForgetPassword', emailController.text);

    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<ForgetPasswordBloc>(context).add(FetchEmailResendEvent(email: emailController.text));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }
}
