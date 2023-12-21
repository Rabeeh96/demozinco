import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utilities/global/text_style.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final items = [
      'This Week',
      'This Month',
      'This Year',
    ];
    String dropDownValue ='This Week';
    final cardShape = RoundedRectangleBorder(
    side: BorderSide(color: Colors.white70, width: 1),
    borderRadius: BorderRadius.circular(10),
    );
    final containerDction = BoxDecoration(
      color: Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(10),



    );

    return Scaffold(
      backgroundColor: Colors.black,

      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,

           color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: size.height * .9,
                  decoration:  BoxDecoration(
                   color: Color(0xffF6F6F6),

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                        height: size.height * .23,
                        child: Column(
                          children: [
                            Container(height: size.height*.04,),
                            Container(
                              height: size.height*.08,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(""),
                                  ),
                                  title: Text("Hello, Savad Farooque!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                  subtitle: Text("Let's get back to work.",style: TextStyle(color: Colors.grey),),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert_outlined,color: Colors.white,),
                                    onPressed: (){

                                    },
                                  ),
                                )),

                            Container(
                              margin: EdgeInsets.only(top: size.height*.01),
                                height: size.height*.03,
                                width: size.width*.27,
                                decoration: BoxDecoration(
                                    color: const Color(0xff2D2D2D), borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                 padding: EdgeInsets.only(left: size.height * .03),
                                  child: DropdownButton(
                                    underline: Container(),
                                     isExpanded: true,
                                    value:dropDownValue,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Color(0xff818181),
                                        fontWeight: FontWeight.w600),
                                    icon: const SizedBox.shrink(),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items, style: GoogleFonts.poppins()),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      dropDownValue = newValue!;
                                      },
                                  ),
                                )),
                          ],
                        )

                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: size.width *.03 ,
              top: size.height /5.5,
            child: Card(
              shape: cardShape,
              child: Container(
                height: size.height * .1,
                width: size.width * .45,

                decoration: containerDction,
                child: Container(
                  margin: EdgeInsets.only(left: size.height*.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(right: size.width*.01,left: size.width*.01),
                            child: Text("Profit",style: customisedStyle(context,  Colors.black, FontWeight.bold, 13.0),),
                          ),
                          Container(

                              width: size.width * .14,
                              decoration: BoxDecoration(
                                  color: Color(0xffE5F4ED),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(

                                child: Center(
                                  child: Text(
                                    "↑24%",
                                    style: GoogleFonts.poppins(
                                      textStyle:
                                      TextStyle(color: Colors.green, fontSize: 13),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Text("\$ 2234.00",style: customisedStyle(context,  Colors.black, FontWeight.bold, 16.0),),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: size.width*.01),
                              child: Text("\$ 45.00",style: customisedStyle(context,  Colors.green, FontWeight.w500, 13.0),)),
                          Text("Than last week",style: customisedStyle(context,  Colors.grey, FontWeight.w500, 11.0),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ),
          Positioned(
            right: size.width *.03 ,
            top: size.height /5.5,

            child: Card(
              shape: cardShape,
              child: Container(
                height: size.height * .1,
                width: size.width * .45,

                decoration:containerDction,
                child: Container(
                  margin: EdgeInsets.only(left: size.height*.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(right: size.width*.01,left: size.width*.01),
                            child: Text("Expense",style: customisedStyle(context,  Colors.black, FontWeight.bold, 13.0),),
                          ),
                          Container(

                              height: size.height * .03,
                              width: size.width * .14,
                              decoration: BoxDecoration(
                                  color: Color(0xffFCE5E6),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                    "24%",
                                    style: GoogleFonts.poppins(
                                      textStyle:
                                      TextStyle(color: Colors.red, fontSize: 13),
                                    ),
                                  ))),
                        ],
                      ),
                      Text("\$ 2234.00",style: customisedStyle(context,  Colors.black, FontWeight.bold, 16.0),),
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(right: size.width*.01),
                              child: Text("-\$ 45.00",style: customisedStyle(context,  Colors.red, FontWeight.w500, 13.0),)),
                          Text("Than last week",style: customisedStyle(context,  Colors.grey, FontWeight.w500, 11.0),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              right: size.width *.03 ,
            left: size.width *.03 ,

            bottom: size.height *.345,

            child: Card(
              shape: cardShape,
              child: Container(
                height: size.height * .25,
                width: size.width * .6,

                decoration: containerDction,
              ),
            ),
          ),
          Positioned(
            left: size.width *.03 ,
            bottom: size.height *.266,
            child: Card(
              shape: cardShape,
              child: Container(
                height: size.height * .07,
                width: size.width * .45,

                decoration: containerDction,
                child: Container(
                  margin: EdgeInsets.only(left: size.height*.02),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Credit",style: customisedStyle(context,  Colors.black, FontWeight.bold, 14.0),),
                      Text("\$ 2234.00",style: customisedStyle(context,  Colors.black, FontWeight.bold, 15.0),),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: size.width *.03 ,
            bottom: size.height *.266,

            child: Card(
              shape: cardShape,
              child: Container(
                height: size.height * .07,
                width: size.width * .45,

                decoration: containerDction,
                child:Container(
                  margin: EdgeInsets.only(left: size.height*.02),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Debit",style: customisedStyle(context,  Colors.black, FontWeight.bold, 14.0),),
                      Text("\$ 2234.00",style: customisedStyle(context,  Colors.black, FontWeight.bold, 15.0),),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: size.width *.03 ,
            left: size.width *.03 ,
            bottom: size.height *.175,

            child: Card(
              shape: cardShape,
              child: Container(
                height: size.height * .08,
                width: size.width * .6,

                decoration: containerDction,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/erp_img/cashinhand.png"),
                  ),
                  title: Text("Cash in hand",style: customisedStyle(context,  Colors.black, FontWeight.bold, 15.0),),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Balance",style: customisedStyle(context,  Colors.grey, FontWeight.w500, 13.0),),
                      Text("\$ 2234.00",style: customisedStyle(context,  Colors.black, FontWeight.bold, 15.0),),

                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: size.width *.03 ,
            left: size.width *.03 ,
            bottom: size.height *.08,

            child: Card(
              shape: cardShape,
              child: Container(
                height: size.height * .08,
                width: size.width * .6,

                decoration: containerDction,
               child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,

                    backgroundImage: AssetImage("assets/erp_img/bank.png",),

                  ),
                  title: Text("Bank",style: customisedStyle(context,  Colors.black, FontWeight.bold, 15.0),),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Balance",style: customisedStyle(context,  Colors.grey, FontWeight.w500, 13.0),),
                      Text("\$ 2234.00",style: customisedStyle(context,  Colors.black, FontWeight.bold, 15.0),),

                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),

    );
  }
}
