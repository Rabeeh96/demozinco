import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Api Helper/Bloc/Forget_Password/forget_password_bloc.dart';
import '../../../../Api Helper/ModelClasses/Forget_password/PasswordResetModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';
import '../../../../Utilities/global/variables.dart';
import '../login_new_screen.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key, required this.mail, required this.otp}) : super(key: key);

  final String mail;
  final String otp;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

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
  late   PasswordResetModelClass passwordResetModelClass ;



  @override
  void initState() {
    // TODO: implement initState
    progressBar = ProgressBar();
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
  listener: (context, state)async {
    if (state is ResetPasswordLoaded) {
      hideProgressBar();
      passwordResetModelClass = BlocProvider.of<ForgetPasswordBloc>(context).passwordResetModelClass;


      if (passwordResetModelClass.statusCode == 6000) {
        await  msgBtmDialogueFunction(
            context: context,
            textMsg: passwordResetModelClass.message.toString(),);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewLoginScreen()));


    } if (passwordResetModelClass.statusCode == 6001) {
    msgBtmDialogueFunction(context: context, textMsg: passwordResetModelClass.message!);


    }





  }
    if (state is ResetPasswordError){
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
      body:  Container(
        height: mHeight,
        padding: EdgeInsets.all(20),

        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(

                  alignment: Alignment.center,
                  height: mHeight * .25,

                  child: Image.asset("assets/Auth user setup/Group 1168@2x.png")
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: mHeight * .18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reset",
                        textAlign: TextAlign.center,
                        style: customisedStyle(
                            context, Colors.black, FontWeight.w500, 27.0),
                      ),
                      Text(
                        "Password.",
                        textAlign: TextAlign.center,
                        style: customisedStyle(
                            context, Colors.black, FontWeight.w500, 27.0),
                      ),
                      Text(
                        "Enter your new password",
                        textAlign: TextAlign.center,
                        style: customisedStyle(
                            context, Color(0xffA2A2A2), FontWeight.normal, 14.0),
                      ),
                    ],
                  ),
                ),


                TextFormField(
                  textCapitalization: TextCapitalization.words,

                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: inputDecoration(hintText: "Password",
                    prifixIcon:  Icon(Icons.lock_outline,color: Color(0xffB8B8B8),),),
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
                ),



        SizedBox(height: mHeight*.01,),

                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmPasswordController,
                  decoration: inputDecoration(hintText: "Confirm password",
                    prifixIcon:  Icon(Icons.lock_outline,color: Color(0xffB8B8B8),),),
                  validator: (val) {
                    if (val == null || val.isEmpty || val.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (passwordController.text != confirmPasswordController.text) {
                      return 'Confirmation password does not match';
                    }

                    return null;
                  },
                ),

                SizedBox(height: mHeight*.05,),
                Container(
                  height: mHeight * .08,
                  width: mWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() == true) {
                        RestPasswordApiFunction();

                      }

                      null;
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2BAAFC)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            )
                        )
                    ),
                    child: Text(
                      'Reset password',
                      style: customisedStyle(
                          context, Colors.white, FontWeight.normal, 17.0),
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
  RestPasswordApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<ForgetPasswordBloc>(context).
      add(FetchResetPasswordEvent(email: widget.mail, otp:widget.otp, password1: passwordController.text, password2: confirmPasswordController.text));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }
}
