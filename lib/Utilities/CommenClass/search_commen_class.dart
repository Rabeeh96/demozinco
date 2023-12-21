import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFieldWidget extends StatelessWidget {
  SearchFieldWidget({
    super.key,
    required this.mHeight, required this.hintText, required this.controller,this.onChanged, required this.autoFocus}) ;
  final double mHeight;
  final String hintText;
  final TextEditingController controller;
  final bool autoFocus;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(

            margin: EdgeInsets.only( left: mWidth * .01, right: mWidth * .01,),
            padding: EdgeInsets.only(
                left: mWidth * .02,top: mHeight*.01,bottom: mHeight*.01),
            height: mHeight*.055,
            decoration:   BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(10),),

       // margin: EdgeInsets.only( left: mWidth * .01, right: mWidth * .01,),
       //  padding: EdgeInsets.only(
       //      left: mWidth * .01,top: mHeight*.01,bottom: mHeight*.01),
       //  height: mHeight*.055,
       //  width: mWidth*.99,
       //  decoration:   BoxDecoration(
       //    color: const Color(0xffF3F7FC),
       //    borderRadius: BorderRadius.circular(10),),
        child: TextFormField(
          autofocus: autoFocus,
          textCapitalization: TextCapitalization.words,
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.normal)),

          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle:   GoogleFonts.poppins(textStyle: const TextStyle(color: Color(0xff929292))),
              contentPadding: const EdgeInsets.only(left: 10.0,bottom: 10),
              border: InputBorder.none),));

  }
}