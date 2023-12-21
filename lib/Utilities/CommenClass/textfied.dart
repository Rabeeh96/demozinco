import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/text_style.dart';


class AuthTextField extends StatelessWidget {
  AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,  this.onChanged,this.labelText, required this.validator, required this.textInputAction,
    this.textInputType,this.list, required this.prefixIcon,required this.obscureText,this.keyBordType,this.suffixIcon,this.onTap, required this.readOnly,
  });

  final TextEditingController controller;
  final String hintText;
  Function(String)? onChanged;
  final String? Function(String?) validator;
  final TextInputAction textInputAction;
  TextInputType? textInputType;
  List<TextInputFormatter>? list;
  final Widget prefixIcon;
 final  bool obscureText  ;
  TextInputType? keyBordType;
  Widget? suffixIcon;
  Function()? onTap;
  final bool readOnly;
  String? labelText;


  @override
  Widget build(BuildContext context) {
    // final FontWeight textFieldFontWeight =
    // obscureText ?  FontWeight.bold:FontWeight.normal ;
    return TextFormField(

      readOnly: readOnly,
        textAlignVertical: TextAlignVertical.center,


      obscureText: obscureText,
        keyboardType: textInputType,
        onTap: onTap,


        textCapitalization: TextCapitalization.words,
        // keyboardType: TextInputType.text,
        textInputAction: textInputAction,
        onChanged:onChanged ,
        style: customisedStyle(context,
            Colors.black, FontWeight.normal, 16.0),
        inputFormatters: list,

        validator: validator ,
        controller: controller,
        autofocus: false,

        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon:prefixIcon ,
          hintText: hintText,
          labelText: labelText,
          hintStyle:  customisedStyle(context,
              Color(0xffA2A2A2), FontWeight.normal, 16.0),

          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE9E9E9),width: 1),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5346BD)),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ));
  }
}
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
        required this.controller,
        required this.hintText,  this.onChanged,this.labelText, required this.validator, required this.textInputAction,
        this.textInputType,this.list, required this.prefixIcon,required this.obscureText,this.keyBordType,this.suffixIcon,this.onTap, required this.readOnly,
      });

  final TextEditingController controller;
  final String hintText;
  Function(String)? onChanged;
  final String? Function(String?) validator;
  final TextInputAction textInputAction;
  TextInputType? textInputType;
  List<TextInputFormatter>? list;
  final Widget prefixIcon;
  final  bool obscureText  ;
  TextInputType? keyBordType;
  Widget? suffixIcon;
  Function()? onTap;
  final bool readOnly;
  String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

        textCapitalization:TextCapitalization.words ,
        inputFormatters: list,
        textInputAction: textInputAction,
        validator: validator ,
        obscureText: obscureText,
        readOnly: readOnly ,
        keyboardType: textInputType,
        onChanged: onChanged,
        onTap: onTap,
        style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        controller: controller,
        decoration: InputDecoration(


            hintText: hintText,
            hintStyle:  customisedStyle(context,
                Color(0xffA2A2A2), FontWeight.bold, 16.0),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffE9E9E9),width: 1),
            ),
            // focusedBorder: const UnderlineInputBorder(
            //   borderSide: BorderSide(color: Color(0xff5346BD)),
            // ),
            // disabledBorder: const UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.grey),
            // ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon));
  }
}