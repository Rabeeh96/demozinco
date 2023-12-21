

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget appBar(
    {required String appBarTitle,
          required String appbarTitleTwo,
      List<Widget>? actions,
      bool? automaticallyImplyLeading, Widget? leading}) {
  return AppBar(
      toolbarHeight: 100,
      backgroundColor:Colors.black ,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      leading: leading,
      iconTheme: const IconThemeData(
        color: Colors.black,),

      elevation: 0,
      title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appBarTitle,
            style:GoogleFonts.poppins(textStyle: const  TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 21),),),
              Text(
                    appbarTitleTwo,
                    style:GoogleFonts.poppins(textStyle: const  TextStyle(
                        color: Colors.grey, fontSize: 15),),),
        ],
      ),
      actions: actions);
}