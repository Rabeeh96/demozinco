import 'package:flutter/material.dart';


import '../utilities/Common_Function/appbar function.dart';
import '../utilities/Common_Variable/commen_variable.dart';



class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,

        appBar: appBar(
            appBarTitle: 'Menu', appbarTitleTwo: 'Browse Modules'),
        body: Container(
          decoration: containerDecoration,
          padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
          height: mHeight,

        )
    );

  }
}
