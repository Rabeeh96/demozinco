import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../Utilities/Commen Functions/date_picker_function.dart';
import '../Utilities/Commen Functions/time_picker.dart';
import '../Utilities/global/text_style.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _selectedIndex = 0;


  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home,),
        label: 'Home'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu,),
      label: 'Menu',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.cases,),
      label: 'Protfollio',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.bell,),
      label: 'Alerts',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings,),
      label: 'Settings',


    ),
  ];
  ValueNotifier<DateTime> fromDateNotifier = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime> toDateNotifier = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime> fromTimeNotifier = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime> toTimeNotifier = ValueNotifier(DateTime.now());
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateFormat timeFormat = DateFormat.jm();
  DateFormat apiTimeFormate = DateFormat('HH:mm');
  DateFormat dateFormat = DateFormat("dd/MM/yyy");

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          color: Color(0xffF3F3F3),
          height: mHeight*.2,
          child:             Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
            //    width: mWidth*.55,
              //  color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("From",style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),),
                    SizedBox(width: mWidth*.02,),
                    ValueListenableBuilder(
                        valueListenable: fromDateNotifier,
                        builder: (BuildContext ctx, dateNewValue, _) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xffCBCBCB))

                            ),
                            width: MediaQuery.of(context).size.width * .39,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset("assets/svg/calendar2-date.svg"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      showDatePickerFunction(context, fromDateNotifier);

                                    },
                                      child: Text(dateFormat.format(dateNewValue),style:  customisedStyle(context, Colors.black, FontWeight.normal, 12.0),)),
                                  ValueListenableBuilder(
                                      valueListenable: fromTimeNotifier,
                                      builder: (BuildContext ctx, timeNotifierNewValue, _) {
                                      return GestureDetector(
                                          onTap: (){
                                            timePicker(context, fromTimeNotifier);;

                                          },
                                          child: Text(timeFormat.format(timeNotifierNewValue),style:  customisedStyle(context, Colors.grey, FontWeight.normal, 11.0),));
                                    }
                                  ),

                                ],)

                              ],
                            )


                          );
                        }),
                  ],
                ),
              ),
              Container(
               // width: mWidth*.55,
                //  color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("To",style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),),
                    SizedBox(width: mWidth*.02,),

                    ValueListenableBuilder(
                        valueListenable: toDateNotifier,
                        builder: (BuildContext ctx, dateNewValue, _) {
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color(0xffCBCBCB))

                              ),
                              width: MediaQuery.of(context).size.width * .39,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset("assets/svg/calendar2-date.svg"),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            showDatePickerFunction(context, toDateNotifier);

                                          },
                                          child: Text(dateFormat.format(dateNewValue),style:  customisedStyle(context, Colors.black, FontWeight.normal, 12.0),)),
                                      ValueListenableBuilder(
                                          valueListenable: toTimeNotifier,
                                          builder: (BuildContext ctx, timeNotifierNewValue, _) {
                                            return GestureDetector(
                                                onTap: (){
                                                  timePicker(context, toTimeNotifier);;

                                                },
                                                child: Text(timeFormat.format(timeNotifierNewValue),style:  customisedStyle(context, Colors.grey, FontWeight.normal, 11.0),));
                                          }
                                      ),

                                    ],)

                                ],
                              )


                          );
                        }),
                  ],
                ),
              ),

            ],
          ),


        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            }

            );

          },
          selectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: Colors.blue),
          unselectedIconTheme: IconThemeData(color: Colors.red),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
              color: Colors.blue
          ),

          unselectedLabelStyle:TextStyle(
              color: Colors.grey
          )
      ),
    );
  }
}
