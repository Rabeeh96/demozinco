import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api Helper/Bloc/Contact/contact_bloc.dart';
import '../Api Helper/ModelClasses/contact/ListContactModelClass.dart';
import '../Api Helper/Repository/api_client.dart';
import '../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../Utilities/Commen Functions/internet_connection_checker.dart';
import '../Utilities/Commen Functions/roundoff_function.dart';
import '../Utilities/global/text_style.dart';
import '../Utilities/global/variables.dart';

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    listContactFunction();

    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  List bankList = [
    "Sbi",
    "federal bank",
    "federal bank",
    "federal bank",
    "federal bank",
    "federal bank",
    "Sbi",
    "Sbi",
  ];

  late ListContactModelClass listContactModelClass;

  listContactFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");

      return BlocProvider.of<ContactBloc>(context).add(ListContactEvent(
          organisation: organizationId!,
          page_number: 1,
          page_size: 30,
          search: ""));
    } else {
      if (!mounted) return;

      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    const pageCount = 2;

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                            style: customisedStyle(context, Color(0xff1B8407),
                                FontWeight.normal, 12.0),
                          ),
                          Container(
                            width: mWidth,
                            child: Text(
                              "$countryCurrencyCode ${roundStringWith("400000000")}",
                              overflow: TextOverflow.ellipsis,
                              style: customisedStyle(
                                  context, Colors.black, FontWeight.w500, 14.0),
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
                            style: customisedStyle(context, Color(0xffC91010),
                                FontWeight.normal, 12.0),
                          ),
                          Container(
                            width: mWidth,
                            child: Text(
                              "$countryCurrencyCode ${roundStringWith("40000000000")}",
                              overflow: TextOverflow.ellipsis,
                              style: customisedStyle(
                                  context, Colors.black, FontWeight.w500, 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: mHeight * .03,
                color: Color(0xffF9F9F9),
              ),
              Container(
                color: Color(0xffF9F9F9),
                height: mHeight * .35,
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
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 8,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            mainAxisExtent:
                                100, // here set custom Height You Want
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
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
                                            bankList[index] == "Sbi"
                                                ? Color(0xff003D88)
                                                : Color(0xff0E7D02),
                                            FontWeight.w500,
                                            10.0),
                                      )),
                                  bankList[index] == "Sbi"
                                      ? SvgPicture.asset("assets/svg/bank.svg")
                                      : SvgPicture.asset(
                                          "assets/svg/wallet.svg"),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      // color: Colors.blue,
                                      width: mWidth * .3,
                                      //height: mHeight * .03,
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
                            );
                          },
                        ));
                  }),
                ),
              ),
              Container(
                color: Color(0xffF9F9F9),
                child: PageViewDotIndicator(
                  currentItem: selectedPage,
                  count: pageCount,
                  unselectedColor: Colors.black26,
                  selectedColor: Colors.blue,
                  duration: const Duration(milliseconds: 200),
                  boxShape: BoxShape.circle,
                  onItemClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              Container(
                color: Color(0xffF9F9F9),
                height: 16,
              ),
              Container(
                  height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
              Container(
                height: mHeight * .03,
                color: Colors.white,
              ),
              BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {
                  if (state is ListContactLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff5728C4),
                      ),
                    );
                  }

                  if (state is ListContactLoaded) {
                    listContactModelClass =
                        BlocProvider.of<ContactBloc>(context)
                            .listContactModelClass;
                    return Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listContactModelClass.data!.length + 1,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            mainAxisExtent:
                                100, // here set custom Height You Want
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (listContactModelClass.data!.isEmpty ||
                                listContactModelClass.data!.length == index) {
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
                                        //  padding: const EdgeInsets.only(24),
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
                                            listContactModelClass
                                                .data![index].accountName!,
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(
                                                context,
                                                Colors.black,
                                                FontWeight.w500,
                                                10.0),
                                          )),
                                      CircleAvatar(
                                        backgroundColor: Colors.grey[300],
                                        backgroundImage: listContactModelClass
                                                    .data![index].photo ==
                                                ''
                                            ? const NetworkImage(
                                                'https://www.gravatar.com/avatar/?s=46&d=identicon&r=PG&f=1')
                                            : NetworkImage(
                                                "${ApiClient.imageBasePath}${listContactModelClass.data![index].photo}"),
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
                                                  listContactModelClass
                                                          .data![index]
                                                          .totalReceived ??
                                                      '0.00',
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
                        ));
                  }
                  if (state is ListContactError) {
                    return Center(
                        child: Text(
                      "Something went wrong",
                      style: customisedStyle(
                          context, Colors.black, FontWeight.w500, 13.0),
                    ));
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
