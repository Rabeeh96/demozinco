import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

exitBtnDialogueFunction({required BuildContext context }) {
  return showModalBottomSheet(
    isDismissible: true,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Are you sure  want to exit?",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                SizedBox(width: MediaQuery.of(context).size.width*.05,),
                TextButton(onPressed:(){
                  Navigator.of(context).pop();
                },  child: const Text("Cancel",style: TextStyle(color: Color(0xff5C4CC3)),)),

                TextButton(  onPressed: ()async {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  }

                }, child: Text("Yes",style: const TextStyle(color: Color(0xff5C4CC3)),)),
              ],
            )
        ),
      );
    },
  );
}