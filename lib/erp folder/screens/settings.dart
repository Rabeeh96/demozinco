import 'package:flutter/material.dart';

import '../utilities/Common_Function/appbar function.dart';
import '../utilities/Common_Variable/commen_variable.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,

        appBar: appBar(
        appBarTitle: 'Settings', appbarTitleTwo: 'Browse all settings'),
    body: Container(
    decoration: containerDecoration,
    padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
    height: mHeight,

    )
    );

  }
}
