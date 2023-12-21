import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
DateTime dateTime =DateTime.now();


late ValueNotifier<String> dateNotifier ;

showDatePickerFunction(context,ValueNotifier dateNotifier) {
  final mHeight = MediaQuery.of(context).size.height;
  final mWidth = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: mWidth * .98,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  EdgeInsets.only(left: mWidth * .13, top: mHeight * .01),
                  child:  Center(
                    child: Text(
                      "Select Date",
                      style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CalendarDatePicker(
              onDateChanged: (selectedDate) {
                dateNotifier.value = selectedDate;
                Navigator.pop(context);
              },
              initialDate: DateTime.now(),
              firstDate: DateTime.now().add(
                const Duration(days: -100000000),
              ),
              lastDate: DateTime.now().add(const Duration(days: 6570)),
            ),
          ],
        ),
      ),
    ),
  );
}
showDatePickerIndexFunction(context,ValueNotifier dateNotifier,index) {
  final mHeight = MediaQuery.of(context).size.height;
  final mWidth = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: mWidth * .98,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  EdgeInsets.only(left: mWidth * .13, top: mHeight * .01),
                  child:  Center(
                    child: Text(
                      "Select Date",
                      style: GoogleFonts.poppins(textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CalendarDatePicker(
              onDateChanged: (selectedDate) {
                dateNotifier.value = selectedDate;
                Navigator.pop(context);
              },
              initialDate: DateTime.now(),
              firstDate: DateTime.now().add(
                const Duration(days: -100000000),
              ),
              lastDate: DateTime.now().add(const Duration(days: 6570)),
            ),
          ],
        ),
      ),
    ),
  );
}