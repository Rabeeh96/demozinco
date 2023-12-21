import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api Helper/Bloc/DashBoard/dash_board_bloc.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/global/text_style.dart';
import '../../../Utilities/global/variables.dart';
import '../DashboardNewDesign/dashboard_new_design.dart';
import '../login/Country/new_setup_acnt_country.dart';

class SetUpAccountScreen extends StatefulWidget {
  const SetUpAccountScreen({Key? key}) : super(key: key);

  @override
  State<SetUpAccountScreen> createState() => _SetUpAccountScreenState();
}

class _SetUpAccountScreenState extends State<SetUpAccountScreen> {

  var zakath;

  String dropdownvalue = 'India - INR';
  String country = "India - INR";
  dashBoardApiFunction() async {
    var netWork = await checkNetwork();
    final prefs = await SharedPreferences.getInstance();
    zakath = prefs.getBool("is_zakath");
    countryCurrencyCode = prefs.getString('currency_symbol') ?? 'RS';

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<DashBoardBloc>(context).add(FetchDashBoardEvent());
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 11,

        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewSetupAccountCountry()));
                result != null ? country = result[0] : Null;
                dashBoardApiFunction();
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: mHeight * .05,
                width: mWidth * .35,
                decoration: BoxDecoration(
                  color: Color(0XFFF3F7FC),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: mWidth * .26,
                      child: Text(
                        country,
                        overflow: TextOverflow.ellipsis,
                        style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 13.0),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 14,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: mHeight * .09,
        ),
        Container(
          alignment: Alignment.center,
          height: mHeight * .3,
          child: SvgPicture.asset("assets/menu/Group 1372.svg"),
        ),
        Container(
          alignment: Alignment.center,
          height: mHeight * .07,
          child: SvgPicture.asset("assets/menu/Hello!.svg"),
        ),
        Container(
          alignment: Alignment.center,
          height: mHeight * .04,
          child: SvgPicture.asset("assets/menu/Let's get you started.svg"),
        ),
        Container(
          alignment: Alignment.center,
          height: mHeight * .1,
          child: Text(
            "Create an cash/bank account for\n this country to continue.",
            textAlign: TextAlign.center,
            style: customisedStyle(context, Color(0xff585858), FontWeight.normal, 15.0),
          ),
        ),
        Container(
          width: mWidth * .5,
          child: ElevatedButton(
            onPressed: () {
              btmSheetFunction( context: context, type: 'Create',);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5346BD)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.add),
                Text(
                  'Add an account',
                  style: customisedStyle(context, Colors.white, FontWeight.normal, 14.0),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
