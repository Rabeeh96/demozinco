import 'package:flutter/material.dart';

import '../global/text_style.dart';

btmDialogueFunction({required BuildContext context,required String textMsg,required Function() fistBtnOnPressed ,required Function() secondBtnPressed, required String secondBtnText,required bool isDismissible }) {
  return showModalBottomSheet(
    isDismissible: isDismissible,
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
                Text(textMsg,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                SizedBox(width: MediaQuery.of(context).size.width*.05,),
                TextButton(onPressed:fistBtnOnPressed,  child:   Text("Cancel",style: customisedStyle(context, Color(0xff5728C4), FontWeight.w600, 12.0),)),
                TextButton(onPressed: secondBtnPressed, child: Text(secondBtnText,style:customisedStyle(context, Color(0xff5728C4), FontWeight.w600, 12.0),)),
              ],
            )
        ),
      );
    },
  );
}
