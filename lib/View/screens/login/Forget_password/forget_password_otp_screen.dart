import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Forget_Password/forget_password_bloc.dart';
import '../../../../Api Helper/ModelClasses/Forget_password/EmailResendModelClass.dart';
import '../../../../Api Helper/ModelClasses/Forget_password/ForgetOtpMOdelClass.dart';
import '../../../../Api Helper/ModelClasses/otp/OtpModelclass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';
import 'reset_password.dart';

class ForgetPasswordOtpScreen extends StatefulWidget {
  const ForgetPasswordOtpScreen({Key? key, required this.email}) : super(key: key);
  final String email;


  @override
  State<ForgetPasswordOtpScreen> createState() => _ForgetPasswordOtpScreenState();
}

class _ForgetPasswordOtpScreenState extends State<ForgetPasswordOtpScreen> {

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
  OtpFieldController otpController = OtpFieldController();
  final formKey = GlobalKey<FormState>();
  static const int _otpLength = 6;
  EmailResendApiFunction() async {
    var netWork = await checkNetwork();




    if (netWork) {
      if (!mounted) return;
       showProgressBar();
      return BlocProvider.of<ForgetPasswordBloc>(context).
      add(FetchEmailResendEvent(email: widget.email));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }
  late EmailResendModelClass emailResendModelClass;




  void _onOtpValidated(String code) {
    bool isValid = code.length == _otpLength;
    if (isValid) {
      _submitOTPForVerification(code);
    } else {
    }
  }

  void _submitOTPForVerification(String otp) {
  }
  @override
  void initState() {
    progressBar = ProgressBar();
    emaill();
    super.initState();
  }
  late  OtpModelclass otpModelclass;
  String email = "";
  emaill()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     final mail  = prefs.getString("emailForgetPassword")!;
     setState(() {
       email = mail;

     });

  }
  late ForgetOtpMOdelClass forgetOtpMOdelClass ;
  String invalid = "";




  String   enteredOtp = "";
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(listeners: [
        BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
            listener: (context, state)async {



        if (state is ForgetOtpLoaded) {
        hideProgressBar();
        forgetOtpMOdelClass = BlocProvider.of<ForgetPasswordBloc>(context).forgetOtpMOdelClass;


        if (forgetOtpMOdelClass.statusCode == 6000) {
        await  msgBtmDialogueFunction(
        context: context,
        textMsg: forgetOtpMOdelClass.message.toString(),);


        Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResetPassword(mail: forgetOtpMOdelClass.email!, otp: enteredOtp)));


        }   if (forgetOtpMOdelClass.statusCode == 6001) {
          setState(() {
            invalid = forgetOtpMOdelClass.message!;
          });
        }





        }
        if (state is ForgetOtpError){
          hideProgressBar();

        }
        },
        ),
    BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
    listener: (context, state) async {
    if (state is EmailResendLoaded) {
    hideProgressBar();
    emailResendModelClass = BlocProvider.of<ForgetPasswordBloc>(context).emailResendModelClass;

    if (emailResendModelClass.statusCode == 6000) {
    await msgBtmDialogueFunction(
    context: context,
    textMsg: emailResendModelClass.message.toString(),
    );



    }
    if (emailResendModelClass.statusCode == 6001) {
    msgBtmDialogueFunction(context: context, textMsg: emailResendModelClass.message!);
    }
    }
    if (state is EmailResendError){
      hideProgressBar();

    }
    },
    )
    ],
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
          padding: EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(

                  alignment: Alignment.center,
                  height: mHeight * .25,

                  child: SvgPicture.asset("assets/Auth user setup/Group 1167.svg"),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: mHeight * .18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter OTP",
                        textAlign: TextAlign.center,
                        style: customisedStyle(
                            context, Colors.black, FontWeight.w500, 27.0),
                      ),

                      Text(
                        "Please enter the OTP send to",
                        textAlign: TextAlign.center,
                        style: customisedStyle(
                            context, Color(0xff2BAAFC), FontWeight.normal, 16.0),
                      ),
                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: customisedStyle(
                            context, Color(0xff2BAAFC), FontWeight.normal, 16.0),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Text(
                          "Change",
                          textAlign: TextAlign.center,
                          style: customisedStyle(
                              context, Color(0xff055588), FontWeight.w500, 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: mHeight*.1,
                  child: OTPTextField(

                    controller: otpController,
                    length: _otpLength,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 20,
                    fieldStyle: FieldStyle.underline,
                    outlineBorderRadius: 15,
                    style: TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      _onOtpValidated(pin);



                      setState(() {
                        enteredOtp = pin;
                      });
                    },
                    onCompleted: (pin) {
                      setState(() {
                      });
                    },

                  ),
                ),
                SizedBox(height: 3),
                Text(invalid,style: customisedStyle(context, Colors.red, FontWeight.normal, 12.0),) ,

                TextButton(onPressed: (){
                  EmailResendApiFunction();
                }, child:  Text(
                  "Resent",
                  textAlign: TextAlign.center,
                  style: customisedStyle(
                      context, Color(0xff2BAAFC), FontWeight.normal, 16.0),
                ),),



                SizedBox(height: mHeight*.01,),
                Container(
                  height: mHeight * .08,
                  width: mWidth,
                  child: ElevatedButton(
                    onPressed: () {

                      if(enteredOtp.isEmpty  ){
                        msgBtmDialogueFunction(context: context, textMsg: "Please Enter Otp");


                      }else if(enteredOtp.length < _otpLength){
                        msgBtmDialogueFunction(context: context, textMsg: "Please fill all filed");
                      }else{
                        otpController.clear();

                        otpApiFunction();

                      }





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
                      'Continue',
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
    );
  }
  otpApiFunction() async {
    var netWork = await checkNetwork();


    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<ForgetPasswordBloc>(context).
      add(FetchForgetOtpEvent(email: email, otp:enteredOtp, isOtp: 'True'));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }
}
