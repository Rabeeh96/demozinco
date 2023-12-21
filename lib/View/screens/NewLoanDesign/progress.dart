import 'package:flutter/material.dart';

import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/global/text_style.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final String pendingEmi;
  final int maxNumber;
  final String totalValue;

  const ProgressIndicatorWidget({
    Key? key,
    required this.pendingEmi,
    required this.maxNumber,
    required this.totalValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var val = roundStringWithValue(pendingEmi, 0) ;
    var completedEmi = maxNumber-(int.parse(val));
    double progress = completedEmi / maxNumber;

    return Scaffold(
      body: Container(
        color: Color(0xffF3F7FC),
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(totalValue, style:customisedStyle(context, Color(0xffF95500), FontWeight.normal, 15.0)),
                Container(
                  child: Text(
                    "$completedEmi/$maxNumber",
                      style:   customisedStyle(context, Color(0xff707070), FontWeight.normal, 13.0)
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(

                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: LinearProgressIndicator(
                  color: Color(0xff3F39AF),
                   backgroundColor: Color(0xffB3CBE8),
                  value: progress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
