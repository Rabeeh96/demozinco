import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import '../Utilities/Commen Functions/roundoff_function.dart';
import '../Utilities/global/text_style.dart';
import '../Utilities/global/variables.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  List bankList = [
    "Sbi",
    "federal bank",
    "federal bank",
    "federal bank",
    "federal bank",
    "federal bank",
    "Sbi",
    "Sbi",
    "Sbi",
    "Sbi",
  ];
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const pageCount = 5;

    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .02,
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Color(0xff2BAAFC),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 1,
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contacts',
                style: customisedStyle(
                    context, Color(0xff13213A), FontWeight.w500, 21.0),
              ),
              Container(
                  alignment: Alignment.center,
                  height: mHeight * .05,
                  width: mWidth * .3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffF3F7FC)),
                  child: Text(
                    default_country_name + "-" + countryShortCode,
                    style: customisedStyle(
                        context, Color(0xff0073D8), FontWeight.w500, 14.0),
                  ))
            ],
          ),
        ),
        body: Container(
            height: mHeight,
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  // shrinkWrap: true,
                  // physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      height: mHeight * .1,
                      decoration: BoxDecoration(
                          color: Color(0xffF9F9F9),
                          border: Border.all(
                            color: Color(0xffE2E2E2),
                          )),
                      child: Row(
                        children: [
                          Container(
                            width: mWidth * .4,
                            padding: EdgeInsets.only(
                                left: mWidth * .04,
                                top: mHeight * .02,
                                bottom: mHeight * .02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Recievables",
                                  style: customisedStyle(
                                      context,
                                      Color(0xff1B8407),
                                      FontWeight.normal,
                                      12.0),
                                ),
                                Container(
                                  width: mWidth,
                                  child: Text(
                                    "$countryCurrencyCode ${roundStringWith("400000000")}",
                                    overflow: TextOverflow.ellipsis,
                                    style: customisedStyle(context,
                                        Colors.black, FontWeight.w500, 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: mWidth * .08,
                          ),
                          Container(
                              color: Color(0xffE2E2E2),
                              height: mHeight * .1,
                              width: 1),
                          Container(
                            padding: EdgeInsets.only(
                                top: mHeight * .02,
                                bottom: mHeight * .02,
                                left: mWidth * .04),
                            width: mWidth * .4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payables",
                                  style: customisedStyle(
                                      context,
                                      Color(0xffC91010),
                                      FontWeight.normal,
                                      12.0),
                                ),
                                Container(
                                  width: mWidth,
                                  child: Text(
                                    "$countryCurrencyCode ${roundStringWith("40000000000")}",
                                    overflow: TextOverflow.ellipsis,
                                    style: customisedStyle(context,
                                        Colors.black, FontWeight.w500, 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            selectedPage = page;
                          });
                        },
                        children: List.generate(pageCount, (index) {
                          return Container(
                              //  color: Colors.red,
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5,
                                  mainAxisExtent:
                                      100, // here set custom Height You Want
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              alignment: Alignment.center,
                                              width: mWidth * .2,
                                              height: mHeight * .03,
                                              child: Text(
                                                bankList[index],
                                                overflow: TextOverflow.ellipsis,
                                                style: customisedStyle(
                                                    context,
                                                    bankList[index] == "Sbi"
                                                        ? Color(0xff003D88)
                                                        : Color(0xff0E7D02),
                                                    FontWeight.w500,
                                                    10.0),
                                              )),
                                          bankList[index] == "Sbi"
                                              ? SvgPicture.asset(
                                                  "assets/svg/bank.svg")
                                              : SvgPicture.asset(
                                                  "assets/svg/wallet.svg"),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              width: mWidth * .3,
                                              child: Text(
                                                countryCurrencyCode +
                                                    "." +
                                                    "${roundStringWith(
                                                      "400000",
                                                    )}",
                                                overflow: TextOverflow.ellipsis,
                                                style: customisedStyle(
                                                    context,
                                                    Colors.black,
                                                    FontWeight.w500,
                                                    10.0),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ));
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: PageViewDotIndicator(
                        currentItem: selectedPage,
                        count: pageCount,
                        unselectedColor: Colors.black26,
                        selectedColor: Colors.blue,
                        duration: const Duration(milliseconds: 200),
                        boxShape: BoxShape.rectangle,
                        onItemClicked: (index) {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        height: 1,
                        color: Color(0xffE2E2E2),
                        width: mWidth * .99),
                    Container(
                      height: mHeight * .03,
                      color: Colors.white,
                    ),
                    Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bankList.length + 1,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            mainAxisExtent:
                                100, // here set custom Height You Want
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (bankList.isEmpty || bankList.length == index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: mHeight / 50,
                                ),
                                child: Center(
                                  child: Container(
                                    // color: Colors.redAccent,
                                    height: mHeight / 18,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffF9F9F9),

                                        shape: const CircleBorder(),
                                      ),
                                      onPressed: () async {

                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: mWidth * .2,
                                          height: mHeight * .03,
                                          //  color: Colors.yellow,
                                          child: Text(
                                            bankList[index],
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(
                                                context,
                                                Colors.black,
                                                FontWeight.w500,
                                                10.0),
                                          )),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://www.google.com/url?sa=i&url=https%3A%2F%2Ffreeicons.io%2Fessential-web-2%2Fuser-ciecle-round-account-person-icon-40275&psig=AOvVaw3DmZrK1S_pkZjHh8lwJ6uO&ust=1692359119966000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCKjj7ZTP44ADFQAAAAAdAAAAABAE"),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          width: mWidth * .3,
                                          child: Text(
                                            countryCurrencyCode +
                                                "." +
                                                "${roundStringWith(
                                                  "400000",
                                                )}",
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(
                                                context,
                                                bankList[index] == "Sbi"
                                                    ? Color(0xffCC0000)
                                                    : Color(0xff0E7D02),
                                                FontWeight.w500,
                                                10.0),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ))
                  ],
                ))));
  }
}
