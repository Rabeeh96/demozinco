import 'package:flutter/material.dart';

import '../global/text_style.dart';

msgBtmDialogueFunction({required BuildContext context ,required String textMsg }) {
  return showModalBottomSheet(
    context: context,

    enableDrag: false,
    builder: (BuildContext context) {
      return Container(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                    width: MediaQuery.of(context).size.width*.7,
                    child: Text(textMsg,overflow:TextOverflow.fade,style: customisedStyle(context, Colors.black, FontWeight.w500, 12.0),)),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child:   Text("Okay",
                  style: customisedStyle(context, Color(0xff5728C4,), FontWeight.w600, 12.0),)

                ),
              ],
            )
        ),
      );
    },
  );
}


alreadyCreateBtmDialogueFunction({required BuildContext context ,required String textMsg,required Function() buttonOnPressed }) {
  return showModalBottomSheet(
    context: context,

    enableDrag: false,
    builder: (BuildContext context) {
      return Container(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*.72,
                    child: Text("${textMsg}\n",overflow:TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 13),)),
                TextButton(onPressed: buttonOnPressed, child: const Text("Okay",style: TextStyle(color: Color(0xff5728C4)),)),
              ],
            )
        ),
      );
    },
  );
}