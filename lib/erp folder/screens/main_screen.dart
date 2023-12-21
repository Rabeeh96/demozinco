
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dashboard.dart';
import 'menuscreen.dart';
import 'reports.dart';
import 'settings.dart';

class MainScreen extends StatelessWidget {
  MainScreen({
    Key? key,
  }) : super(
    key: key,
  );
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List page = [
    DashBoardScreen(),
    MenuScreen(),
    ReportScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final dotWidget = Container(
      height:6,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );

    return ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (BuildContext context, int newIndex, _) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {  },child: Icon(Icons.add),),


            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
              height: mHeight * .1,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: BottomNavigationBar(
                selectedFontSize: 0,
                unselectedFontSize: 0,
                key: scaffoldKey,
                currentIndex: newIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,

                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                      icon: newIndex == 0
                          ? BottomNavigationContainerWidget(
                          widget: Padding(
                            padding:  EdgeInsets.only(top: mHeight*.02,),
                            child: SvgPicture.asset(
                              "assets/erp_img/home.svg",
                                color: Colors.black
                            ),
                          ), dotWidget:     Padding(
                        padding:  EdgeInsets.only(top: mHeight*.01,),
                            child: dotWidget
                          ),)
                          :SvgPicture.asset(
                        "assets/erp_img/home.svg",
                      ),
                      label: "", ),
                  BottomNavigationBarItem(
                      backgroundColor: Colors.white,
                      icon: newIndex == 1
                          ? BottomNavigationContainerWidget(
                        widget: Container(
                          child: Padding(
                            padding:  EdgeInsets.only(top: mHeight*.015,),
                            child: SvgPicture.asset(
                                "assets/erp_img/tiled.svg",
                                color: Colors.black
                            ),
                          ),
                        ), dotWidget:     Padding(
                        padding:  EdgeInsets.only(top: mHeight*.01),
                        child: dotWidget
                      ),)
                          :Padding(
                        padding:  EdgeInsets.only(),
                            child: SvgPicture.asset(
                        "assets/erp_img/tiled.svg",
                      ),
                          ),
                    label: "", ),


                  BottomNavigationBarItem(
                      backgroundColor: Colors.white,
                      icon: newIndex == 2
                          ?   BottomNavigationContainerWidget(
                        widget: Padding(
                          padding:  EdgeInsets.only(top: mHeight*.015,),
                          child: SvgPicture.asset(
                              "assets/erp_img/activity.svg",
                              color: Colors.black
                          ),
                        ), dotWidget:     Padding(
                        padding:  EdgeInsets.only(top: mHeight*.01),
                        child: dotWidget
                      ),)
                          :Padding(
                        padding:  EdgeInsets.only(),
                            child: SvgPicture.asset(
                        "assets/erp_img/activity.svg",
                      ),
                          ),
                    label: "", ),
                  BottomNavigationBarItem(
                      backgroundColor: Colors.white,
                      icon: newIndex == 3
                          ?   BottomNavigationContainerWidget(
                        widget: Padding(
                          padding:  EdgeInsets.only(top: mHeight*.015,),
                          child: SvgPicture.asset(
                              "assets/erp_img/settings-outline.svg",
                              color: Colors.black
                          ),
                        ), dotWidget:     Padding(
                        padding:  EdgeInsets.only(top: mHeight*.01),
                          child: dotWidget
                        ),)
                          :SvgPicture.asset(
                        "assets/erp_img/settings-outline.svg",
                      ),
                    label: "", ),
                ],



                onTap: (index) async {
                  selectedIndex.value = index;

                },
              ),
            ),
            body: page[newIndex],
          );
        });
  }
}

class BottomNavigationContainerWidget extends StatelessWidget {
  BottomNavigationContainerWidget({
    super.key,
    required this.widget, required this.dotWidget,
  });

  final Widget widget;
  final Widget dotWidget;
  double size = 50.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          widget,
          dotWidget,
        ],
      ),
    );
  }
}
