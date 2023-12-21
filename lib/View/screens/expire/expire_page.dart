
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../Api Helper/ModelClasses/Login/LoginModelClass.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../login/login_new_screen.dart';

class ExpireScreen extends StatefulWidget {
  const ExpireScreen({Key? key}) : super(key: key);

  @override
  State<ExpireScreen> createState() => _ExpireScreenState();
}

class _ExpireScreenState extends State<ExpireScreen> {
  late LoginModelClass loginModelClass;
  late ProgressBar progressBar;

  bool isAccount = false;

  @override
  void initState() {
    progressBar = ProgressBar();
    super.initState();
  }




  @override
  void dispose() {
    progressBar.hide();
    super.dispose();
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0,bottom: 15),
                  child: SvgPicture.asset("assets/svg/userExpired.svg"),
                ),
              ),
              Text(
                "Contact us",
                style: customisedStyle(context, Color(0xff5346BD), FontWeight.w500, 14.0),
                textAlign: TextAlign.center,
              ),
              Text(
                "+91 9037444800",
                style: customisedStyle(context, Colors.black, FontWeight.w400, 14.0),
                textAlign: TextAlign.center,
              ),


              ElevatedButton(

                style: ButtonStyle(

                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5346BD)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),

                onPressed: () async{
                  SharedPreferences preference = await SharedPreferences.getInstance();
                  preference.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => NewLoginScreen(),
                      ),
                          (route) => false);

                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0,right: 25.0,top: 5,bottom: 5),
                  child: Text(
                    "Okay",
                    style: customisedStyle(context, Colors.white, FontWeight.w500, 15.0),
                  ),
                ),


              ),



            ],
          ),
        ),
      ),
    );
  }



}
