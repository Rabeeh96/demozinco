import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:video_player/video_player.dart';

import '../../../Api Helper/Bloc/Settings/settings_bloc.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/global/variables.dart';
import '../../MainScreen/main_screen.dart';
import '../login/login_new_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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

  Future<void> getSaveDate(context) async {
    final prefs = await SharedPreferences.getInstance();
    final organisation = prefs.getString("organisation");

    countryCurrencyCode = prefs.getString('currency_symbol')??'RS';
    rounding_figure = prefs.getInt('rounding_value')??2;
    currencyFormat = prefs.getString('currencyFormat')??'###,###,##0.';
    default_country_name = prefs.getString('default_country')??"India";
    if (prefs.getString('token') != null && organisation != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => ScreenMain(),
          ),
              (route) => false);

      SettingsApiFunction();
    } else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => NewLoginScreen()), (route) => false);
    }
  }


  @override
  void initState() {
    super.initState();
    splashFunc();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:  Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/png/splash_icon.png",height: 150,width: 150,)
        ),
      ),
    );
  }
  late VideoPlayerController _controller;
  Future splashFunc() async {

    _controller = VideoPlayerController.asset('assets/video/video.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    Future.delayed(Duration(seconds: 3), () {
      _controller.pause();
      getSaveDate(context);
    });


  }
}
