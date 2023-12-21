


import 'package:cuentaguestor_edit/Utilities/global/text_style.dart';
import 'package:flutter/material.dart';


String countryCurrencyCode = "Rs";
String default_country_name = "India";
String default_country_id = "";
String countryShortCode = "";
int rounding_figure = 2;
String currencyFormat = "###,###,##0.";
String numberFormat2 ="0";
bool showTabBar =true;




  inputDecoration({required String hintText,required Widget prifixIcon,Widget? suffixIcon,context,String? errorMsg}){ return InputDecoration(


    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff5346BD)),
    ),
    hintText: hintText,
      hintStyle:  customisedStyle(context,
          Color(0xffA2A2A2), FontWeight.normal, 16.0),
    errorText:errorMsg ,
    suffixIcon: suffixIcon,
    prefixIcon: prifixIcon);
  }