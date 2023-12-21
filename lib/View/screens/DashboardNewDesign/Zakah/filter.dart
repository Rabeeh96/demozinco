import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../Utilities/Commen Functions/date_picker_function.dart';
import '../../../../Utilities/global/text_style.dart';


class ZakahFilter extends StatefulWidget {
  const ZakahFilter({Key? key}) : super(key: key);

  @override
  State<ZakahFilter> createState() => _ZakahFilterState();
}

class _ZakahFilterState extends State<ZakahFilter> {
  ValueNotifier<DateTime> fromDateNotifier = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime> toDateNotifier = ValueNotifier(DateTime.now());
  DateFormat dateFormat = DateFormat("dd/MM/yyy");
  DateFormat apiDateFormat = DateFormat("y-M-d");




  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp,color: Color(0xff2BAAFC),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: MediaQuery.of(context).size.height / 11,

        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text("Filter",style: customisedStyle(
            context, Colors.black,
            FontWeight.w600, 21.0),),



      ),
      body: Container(

        height: mHeight,
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Divider(
              color: Color(0xffE2E2E2),
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),

              child: Text(
                "Date",
                style: GoogleFonts.poppins(
                  textStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: mHeight*.01,),
            Container(
              padding: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xffA1A1A1)),
                          )),
                      ValueListenableBuilder(
                          valueListenable: fromDateNotifier,
                          builder: (BuildContext ctx, fromDateNewValue, _) {

                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  minimumSize: const Size(150, 40),
                                ),
                                onPressed: () {
                                  showDatePickerFunction(context, fromDateNotifier);
                                },
                                child: Text(
                                  dateFormat.format(fromDateNewValue),
                                  style: const TextStyle(color: Colors.white),
                                ));
                          }),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("To",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xffA1A1A1)),
                          )),
                      ValueListenableBuilder(
                          valueListenable: toDateNotifier,
                          builder: (BuildContext ctx, toDateNewValue, _) {

                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  minimumSize: const Size(150, 40),
                                ),
                                onPressed: () {
                                  showDatePickerFunction(context, toDateNotifier);
                                },
                                child: Text(
                                  dateFormat.format(toDateNewValue),
                                  style: const TextStyle(color: Colors.white),
                                ));
                          }),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: mHeight*.01,),


          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, [apiDateFormat.format(fromDateNotifier.value), apiDateFormat.format(toDateNotifier.value),],);
        },
        backgroundColor: Color(0xff2BAAFC),
        child: const Icon(Icons.search,color: Colors.white,),
      ),
    );
  }
}
