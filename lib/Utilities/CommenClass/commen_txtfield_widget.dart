import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global/text_style.dart';

class CommenTextFieldWidget extends StatelessWidget {
  CommenTextFieldWidget({Key? key, required this.controller,
     this.validator, required this.hintText,
    required this.textInputType,this.list,this.onTap,this.suffixIcon, required this.readOnly,required this.textAlign,
    required this.textInputAction, required this.textCapitalization,this.onChanged, required this.obscureText}) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
 final TextInputType textInputType;
  List<TextInputFormatter>? list;
  void Function()? onTap;
  Widget? suffixIcon;
  final bool readOnly;
  final  TextAlign textAlign;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;

  void Function(String)? onChanged;
  final bool obscureText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: customisedStyle(context,  Color(0xff13213A), FontWeight.normal, 14.0),
      obscureText: obscureText,
      onChanged: onChanged,

        textInputAction: textInputAction,
        textAlign: textAlign,
        readOnly: readOnly,
        validator: validator,
        keyboardType: textInputType,
        inputFormatters: list,
        controller:controller,
        onTap: onTap,
        textCapitalization: textCapitalization,


        decoration:  InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                  width: 1, color: Color(0xffF3F7FC)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                  width: 1, color: Color(0xffF3F7FC)),
            ),
            labelText: hintText,
            labelStyle:customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 15.0,),
            suffixIcon:suffixIcon,
            contentPadding: EdgeInsets.all(7),
            hintText: hintText,
             hintStyle:customisedStyle(context, Color(0xff778EB8),FontWeight.normal,15.0) ,
            border: InputBorder.none,
            filled: true,
            fillColor: Color(0xffF3F7FC)));
  }
}




class BottomSheetTextfeild extends StatelessWidget {
  BottomSheetTextfeild({Key? key, required this.controller,
    this.validator, required this.hintText,
    required this.textInputType,this.list,this.onTap,this.suffixIcon, required this.readOnly,required this.textAlign,
    required this.textInputAction, required this.textCapitalization,this.onChanged, required this.obscureText}) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType textInputType;
  List<TextInputFormatter>? list;
  void Function()? onTap;
  Widget? suffixIcon;
  final bool readOnly;
  final  TextAlign textAlign;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;

  void Function(String)? onChanged;
  final bool obscureText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: customisedStyle(context,  Color(0xff13213A), FontWeight.normal, 14.0),
        obscureText: obscureText,
        onChanged: onChanged,

        textInputAction: textInputAction,
        textAlign: textAlign,
        readOnly: readOnly,
        validator: validator,
        keyboardType: textInputType,
        inputFormatters: list,
        controller:controller,
        onTap: onTap,
        textCapitalization: textCapitalization,


        decoration:  InputDecoration(

            labelText: hintText,
            labelStyle:customisedStyle(context, Color(0xff778EB8), FontWeight.normal,15.0),
            suffixIcon:suffixIcon,
            contentPadding: EdgeInsets.all(7),
            hintText: hintText,
            hintStyle:customisedStyle(context, Color(0xff778EB8),  FontWeight.normal,15.0) ,
            border: InputBorder.none,

           ));
  }
}