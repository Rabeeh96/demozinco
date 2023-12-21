import 'package:cuentaguestor_edit/Utilities/global/text_style.dart';
import 'package:flutter/material.dart';

class  TextFieldDecoration{

  static InputDecoration  defaultStyle(context,
      {String labelTextStr = "", String hintTextStr = ""}){
    return  InputDecoration(

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
          BorderSide(width: 1, color: Color(0xffF3F7FC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
          BorderSide(width: 1, color: Color(0xffF3F7FC)),
        ),
        contentPadding: EdgeInsets.all(7),
        labelText: hintTextStr,
         labelStyle: TextStyleDecoration.hintTextColor(context),
        hintText: hintTextStr,
        hintStyle: TextStyleDecoration.hintTextColor(context),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xffF3F7FC));
  }

 static InputDecoration  defaultStyleWithLabel(context,
      {String labelTextStr = "", String hintTextStr = ""}){
    return  InputDecoration(

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
          BorderSide(width: 1, color: Color(0xffF3F7FC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
          BorderSide(width: 1, color: Color(0xffF3F7FC)),
        ),
        contentPadding: EdgeInsets.all(7),
        labelText: hintTextStr,
        labelStyle: TextStyleDecoration.hintTextColor(context),
        hintText: hintTextStr,
        hintStyle: TextStyleDecoration.hintTextColor(context),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xffF3F7FC));
  }


  static InputDecoration  defaultStyleWithIcon(context,
      {String labelTextStr = "", String hintTextStr = ""}){
    return  InputDecoration(

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
          BorderSide(width: 1, color: Color(0xffF3F7FC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
          BorderSide(width: 1, color: Color(0xffF3F7FC)),
        ),
        contentPadding: EdgeInsets.all(7),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        labelText: hintTextStr,
        labelStyle: TextStyleDecoration.hintTextColor(context),
        hintText: hintTextStr,
        hintStyle: TextStyleDecoration.hintTextColor(context),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xffF3F7FC));
  }

  static InputDecoration  defUnderLine(context,
      {String labelTextStr = "", String hintTextStr = ""}){
    return  InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff2BAAFC))),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff2BAAFC))),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff2BAAFC))),
        hintStyle: TextStyle(
          color: Color(0xffA1A1A1),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        hintText: hintTextStr,
        labelText: hintTextStr,
        labelStyle: TextStyleDecoration.hintTextColor(context),

        contentPadding: EdgeInsets.all(6),
        fillColor: Color(0xffF3F7FC),
        filled: true);
  }
}