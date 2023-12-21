import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../global/text_style.dart';

class MenuItemsWidget extends StatelessWidget {
  const MenuItemsWidget({
    super.key,
    required this.mHeight,
    required this.mWidth,
    required this.context, required this.image, required this.menuItemName,required this.menuTitleOnTap,
    required this.menuAddButtonOnTap,

  });

  final double mHeight;
  final double mWidth;
  final BuildContext context;
  final String image;
  final String menuItemName;
  final Function() menuTitleOnTap;
  final Function() menuAddButtonOnTap;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: mHeight*.01,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: menuTitleOnTap,
              child: SvgPicture.asset(
                image,
              ),
            ),
           // SizedBox(width: mWidth*.1,),
            GestureDetector(
              onTap: menuTitleOnTap,
              child: Container(
                alignment: Alignment.centerLeft,

                height: mHeight*.05,
                width: mWidth*.48,
                color: Colors.white,
                child: Text(
                  menuItemName,
                  style: customisedStyle(context,  Color(0xff13213A), FontWeight.w500, 15.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: menuAddButtonOnTap,
              child: Container(
                alignment: Alignment.centerRight,
                width: mWidth*.10,
                 height: mHeight*.05,
                color: Colors.white,
                child: SvgPicture.asset("assets/menu/plus-circle-line.svg"),),
            )


          ],
        ),
        SizedBox(height: mHeight*.02,),
        Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .9),
      ],
    );













  //     ListTile(
  //       leading: SvgPicture.asset(
  //         image,
  //
  //       ),
  //       title: GestureDetector(
  //         onTap: menuTitleOnTap,
  //         child:  Text(
  //           menuItemName,
  //           style: customisedStyle(context,  Color(0xff13213A), FontWeight.w500, 15.0),
  //         ),
  //       ),
  //       trailing: Container(
  //         alignment: Alignment.centerRight,
  // width: mWidth*.35,
  //        // height: mHeight*.05,
  //         color: Colors.white,
  //         child: GestureDetector(
  //           onTap: menuAddButtonOnTap,
  //           child: SvgPicture.asset("assets/menu/plus-circle-line.svg"),
  //         ),
  //       ));
  }
}