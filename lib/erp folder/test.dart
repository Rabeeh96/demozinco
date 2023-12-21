import 'package:cuentaguestor_edit/erp%20folder/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'screens/dashboard.dart';
import 'screens/menuscreen.dart';
import 'screens/reports.dart';
import 'screens/settings.dart';


class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  int pageIndex = 0;

  final pages = [
    DashBoardScreen(),
    MenuScreen(),
    ReportScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {

    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(


        padding:  EdgeInsets.only(top: mHeight*.095,),
        child: Container(
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {  },child: Icon(Icons.add),),
        ),
      ),
      backgroundColor: const Color(0xffC4DFCB),

      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

   buildMyNavBar(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final dotWidget = Container(
      height:6,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    ); final dotWidgett = Container(
      height:6,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
    final ValueNotifier<int> selectedIndex = ValueNotifier(0);


    return ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (BuildContext context, int newIndex, _) {
        return Container(
          height: mHeight * .1,
          decoration: const BoxDecoration(
           color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  selectedIndex.value = 0;

                },
                icon:  newIndex == 0
                    ? BottomNavigationContainerWidget(
                  widget: Container(
                    padding:  EdgeInsets.only(top: mHeight*.0,),

                    child: SvgPicture.asset(
                        "assets/erp_img/home.svg",
                        color: Colors.black
                    ),
                  ), dotWidget:     Padding(
                    padding:  EdgeInsets.only(top: mHeight*.01,),
                    child: dotWidget
                ),)
                    : Column(
                      children: [

                        SvgPicture.asset(
                  "assets/erp_img/home.svg",
                ),
                        Padding(
                            padding:  EdgeInsets.only(top: mHeight*.01,),
                            child: dotWidgett
                        ),
                      ],
                    ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: mWidth*.2),
                child: IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    selectedIndex.value = 1;

                  },
                  icon: newIndex == 1
                      ?  BottomNavigationContainerWidget(
                    widget: Container(
                      child: SvgPicture.asset(
                          "assets/erp_img/tiled.svg",
                          color: Colors.black
                      ),
                    ), dotWidget:     Padding(
                      padding:  EdgeInsets.only(top: mHeight*.01),
                      child: dotWidget
                  ),)
                      : Column(
                    children: [

                      SvgPicture.asset(
                        "assets/erp_img/tiled.svg",
                      ),
                      Padding(
                          padding:  EdgeInsets.only(top: mHeight*.01,),
                          child: dotWidgett
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  selectedIndex.value = 2;

                },
                icon: newIndex == 2
                    ?  BottomNavigationContainerWidget(
                  widget: Padding(
                    padding:  EdgeInsets.only(top: mHeight*.0,),
                    child: SvgPicture.asset(
                        "assets/erp_img/activity.svg",
                        color: Colors.black
                    ),
                  ), dotWidget:     Padding(
                    padding:  EdgeInsets.only(top: mHeight*.01),
                    child: dotWidget
                ),)
                    : Column(
                  children: [

                    SvgPicture.asset(
                      "assets/erp_img/activity.svg",
                    ),
                    Padding(
                        padding:  EdgeInsets.only(top: mHeight*.01,),
                        child: dotWidgett
                    ),
                  ],
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  selectedIndex.value = 3;

                },
                icon: newIndex == 3
                    ? BottomNavigationContainerWidget(
                  widget: Padding(
                    padding:  EdgeInsets.only(top: mHeight*.0,),
                    child: SvgPicture.asset(
                        "assets/erp_img/settings-outline.svg",
                        color: Colors.black
                    ),
                  ), dotWidget:     Padding(
                    padding:  EdgeInsets.only(top: mHeight*.01),
                    child: dotWidget
                ),)
                    : Column(
                  children: [

                    SvgPicture.asset(
                      "assets/erp_img/settings-outline.svg",
                    ),
                    Padding(
                        padding:  EdgeInsets.only(top: mHeight*.01,),
                        child: dotWidgett
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
