import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../Utilities/Commen Functions/exit_button.dart';
import '../../Utilities/global/text_style.dart';
import '../../Utilities/global/variables.dart';
import '../menu_screen.dart';
import '../payment_notification.dart';
import '../screens/DashboardNewDesign/dashboard_new_design.dart';
import '../screens/portfolio/view/new_design/portfolio_list.dart';
import '../settings.dart';


class ScreenMain extends StatefulWidget {
  ScreenMain({
    Key? key,
  }) : super(
    key: key,
  );

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  final PageController pageController = PageController(initialPage: 0);

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List page = [
    NewDashboard(),
     ScreenMenu(),
    PortfolioList(),
    PaymentNotification(),
    Settings()
  ];

  Color tabIcon1 = const Color(0xff9974EF);

  Color tabIcon2 = Colors.transparent;

  Color tabIcon3 = Colors.transparent;

  Color tabIcon4 = Colors.transparent;

  Color tabIcon5 = Colors.transparent;

  Color gradient1 = const Color(0xff2BAAFC);

  Color gradient2 = Colors.transparent;

  Color gradient3 = Colors.transparent;

  Color gradient4 = Colors.transparent;

  Color gradient5 = Colors.transparent;

  Color gradient11 = const Color(0xff2BAAFC);

  Color iconColor2 = Colors.grey;

  Color iconColor3 = Colors.grey;

  Color iconColor4 = Colors.grey;

  Color iconColor5 = Colors.grey;

  ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    if(showTabBar){
      _selectedIndexNotifier.value = index;
    }

  }

  @override
  Widget build(BuildContext context) {  final mHeight = MediaQuery.of(context).size.height;
  final mWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => exitBtnDialogueFunction(context: context),
      child: ValueListenableBuilder<int>(
          valueListenable: _selectedIndexNotifier,
          builder: (context, selectedIndex, _) {

          return Scaffold(


            bottomNavigationBar: Container(
              color: Color(0xffffffff),
              height: mHeight/12.5,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,

                items:  <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: SvgPicture.asset(
                          'assets/svg/home.svg',
                          color: _selectedIndexNotifier.value == 0 ? gradient11: Colors.grey

                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon:  Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: SvgPicture.asset(
                        'assets/svg/menu.svg',
                        height: mHeight/50,

                        color: _selectedIndexNotifier.value == 1? gradient11: Colors.grey,
                      ),
                    ),
                    label: 'Menu',
                  ),
                  BottomNavigationBarItem(
                    icon:  Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: SvgPicture.asset(
                        'assets/svg/portfolio.svg',
                        height: mHeight/50,

                        color: _selectedIndexNotifier.value == 2 ? gradient11: Colors.grey,
                      ),
                    ),
                    label: 'Portfolio',
                  ),

                  BottomNavigationBarItem(
                    icon:  Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: SvgPicture.asset(
                        'assets/svg/notification.svg',
                        height: mHeight/50,
                        color:  _selectedIndexNotifier.value == 3? gradient11: Colors.grey,
                      ),
                    ),
                    label: 'Alerts',
                  ),

                  BottomNavigationBarItem(
                    icon:       Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: SvgPicture.asset(
                        'assets/svg/settings.svg',
                        height: mHeight/50,
                        color: _selectedIndexNotifier.value == 4 ? gradient11: Colors.grey,
                      ),
                    ),
                    label: 'Settings',

                  ),

                ],

                currentIndex: _selectedIndexNotifier.value,
                showUnselectedLabels: true,
                selectedItemColor: gradient11,
                onTap: _onItemTapped,

              ),
            ),

                    body: page[selectedIndex],
                  );
        }
      ),
    );

  }

  bottomBarColor(int iconColor) {
    if (iconColor == 0) {
      tabIcon1 = const Color(0xff9974EF);
      tabIcon2 = Colors.transparent;
      tabIcon3 = Colors.transparent;
      tabIcon4 = Colors.transparent;
      tabIcon5 = Colors.transparent;
      gradient1 = const Color(0xff2BAAFC);
      gradient2 = Colors.transparent;
      gradient3 = Colors.transparent;
      gradient4 = Colors.transparent;
      gradient5 = Colors.transparent;
    } else if (iconColor == 1) {
      tabIcon1 = Colors.transparent;
      tabIcon2 = const Color(0xff9974EF);
      tabIcon3 = Colors.transparent;
      tabIcon4 = Colors.transparent;
      tabIcon5 = Colors.transparent;
      gradient2 = const Color(0xff2BAAFC);
      gradient1 = Colors.transparent;
      gradient3 = Colors.transparent;
      gradient4 = Colors.transparent;
      gradient5 = Colors.transparent;
    } else if (iconColor == 2) {
      tabIcon1 = Colors.transparent;
      tabIcon2 = Colors.transparent;
      tabIcon3 = const Color(0xff9974EF);
      tabIcon4 = Colors.transparent;
      tabIcon5 = Colors.transparent;
      gradient3 = const Color(0xff2BAAFC);
      gradient2 = Colors.transparent;
      gradient1 = Colors.transparent;
      gradient4 = Colors.transparent;
      gradient5 = Colors.transparent;
    } else if (iconColor == 3) {
      tabIcon1 = Colors.transparent;
      tabIcon2 = Colors.transparent;
      tabIcon3 = Colors.transparent;
      tabIcon4 = const Color(0xff9974EF);
      tabIcon5 = Colors.transparent;
      gradient4 = const Color(0xff2BAAFC);
      gradient2 = Colors.transparent;
      gradient3 = Colors.transparent;
      gradient1 = Colors.transparent;
      gradient5 = Colors.transparent;
    } else if (iconColor == 4) {
      tabIcon1 = Colors.transparent;
      tabIcon2 = Colors.transparent;
      tabIcon3 = Colors.transparent;
      tabIcon4 = Colors.transparent;
      tabIcon5 = const Color(0xff9974EF);
      gradient5 = const Color(0xff2BAAFC);
      gradient2 = Colors.transparent;
      gradient3 = Colors.transparent;
      gradient4 = Colors.transparent;
      gradient1 = Colors.transparent;
    }
  }

  bottomBarIconColor(int iconColor) {
    if (iconColor == 0) {
      gradient11 = Colors.white;
      iconColor2 = Colors.grey;
      iconColor3 = Colors.grey;
      iconColor4 = Colors.grey;
      iconColor5 = Colors.grey;
    } else if (iconColor == 1) {
      gradient11 = Colors.grey;
      iconColor2 = Colors.white;
      iconColor3 = Colors.grey;
      iconColor4 = Colors.grey;
      iconColor5 = Colors.grey;
    } else if (iconColor == 2) {
      gradient11 = Colors.grey;
      iconColor2 = Colors.grey;
      iconColor3 = Colors.white;
      iconColor4 = Colors.grey;
      iconColor5 = Colors.grey;
    } else if (iconColor == 3) {
      gradient11 = Colors.grey;
      iconColor2 = Colors.grey;
      iconColor3 = Colors.grey;
      iconColor4 = Colors.white;
      iconColor5 = Colors.grey;
    } else if (iconColor == 4) {
      gradient11 = Colors.grey;
      iconColor2 = Colors.grey;
      iconColor3 = Colors.grey;
      iconColor4 = Colors.grey;
      iconColor5 = Colors.white;
    }
  }
}

class TextWidget extends StatelessWidget {
  //
  const TextWidget({
    super.key,
    required this.iconColor1, required this.text,
  });

  final Color iconColor1;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: customisedStyle(context, iconColor1, FontWeight.w500, 7.7),);
  }
}


