import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api Helper/Bloc/Contact/contact_bloc.dart';
import '../../Api Helper/ModelClasses/contact/ListContactModelClass.dart';
import '../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../Utilities/Commen Functions/roundoff_function.dart';
import '../../Utilities/global/text_style.dart';
import '../../Utilities/global/variables.dart';
import '../../View/screens/contacts/new_section/detail_page.dart';
import '../../View/screens/contacts/new_section/search_contact_list.dart';
import 'Bloc/pagination_contact_bloc.dart';

class ContactListWithPagination extends StatefulWidget {
  const ContactListWithPagination({super.key});

  @override
  State<ContactListWithPagination> createState() => _ContactListWithPaginationState();
}

class _ContactListWithPaginationState extends State<ContactListWithPagination> {


  @override
  void initState() {
    listContactFunction();
    PaginationContactFunction();


    super.initState();
  }

  // List bankList = [
  //   "Sbi",
  //   "federal bank",
  //   "federal bank",
  //   "federal bank",
  //   "federal bank",
  //   "federal bank",
  //   "Sbi",
  //   "Sbi",
  //
  //
  // ];

  late ListContactModelClass listContactModelClass;

  listContactFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");

      return BlocProvider.of<ContactBloc>(context).add(ListContactEvent(organisation: organizationId!, page_number: 1, page_size: 40, search: ""));
    } else {
      if (!mounted) return;

      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  transactionPage(index) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ContactDetailPageNew(
          accountName: listContactModelClass.data![index].accountName!,
          accountId: listContactModelClass.data![index].id,
          phone: listContactModelClass.data![index].phone!,
          totalPaid: listContactModelClass.data![index].totalPaid,
          totalReceived: listContactModelClass.data![index].totalReceived,
        )));

    listContactFunction();
  }
  PaginationContactFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");

      return BlocProvider.of<PaginationContactBloc>(context).add(InitialListEvent(organisation: organizationId!, search: "",));
    } else {
      if (!mounted) return;

      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }
  List<ContactPaginationModelClass> orderDetailsTable = [];
  ValueNotifier valueNotifier = ValueNotifier(2);
  late  Response response ;
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return  BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        if (state is ListContactLoading) {
          return  Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff5728C4),
              ),
            ),
          );
        }
        if (state is ListContactLoaded) {
          listContactModelClass = BlocProvider
              .of<ContactBloc>(context)
              .listContactModelClass;
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
                  Row(
                    children: [
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
                          )),
                      IconButton(onPressed: ()async{
                        final result = await Navigator
                            .of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchContactList()));
                        listContactFunction();
                      }, icon: SvgPicture.asset("assets/svg/search-normal (1).svg"))
                    ],
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child:  Container(
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
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                "Recievables",
                                style: customisedStyle(
                                    context, Color(0xff1B8407),
                                    FontWeight.normal, 12.0),
                              ),
                              Container(
                                width: mWidth,
                                child: Text(
                                  "$countryCurrencyCode ${roundStringWith(
                                      listContactModelClass
                                          .totalRecievable!)}",
                                  overflow: TextOverflow.ellipsis,
                                  style: customisedStyle(
                                      context, Colors.black,
                                      FontWeight.w500, 14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mWidth * .08,
                        ),
                        Container(color: Color(0xffE2E2E2),
                            height: mHeight * .1,
                            width: 1),
                        Container(
                          padding: EdgeInsets.only(
                              top: mHeight * .02,
                              bottom: mHeight * .02,
                              left: mWidth * .04),
                          width: mWidth * .4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                "Payables",
                                style: customisedStyle(
                                    context, Color(0xffC91010),
                                    FontWeight.normal, 12.0),
                              ),
                              Container(
                                width: mWidth,
                                child: Text(
                                  "$countryCurrencyCode ${roundStringWith(
                                      listContactModelClass
                                          .totalPayable!)}",
                                  overflow: TextOverflow.ellipsis,
                                  style: customisedStyle(
                                      context, Colors.black,
                                      FontWeight.w500, 14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                    Container(
                        color: Color(0xffF9F9F9),

                        //  color: Colors.red,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10),
                        child: listContactModelClass
                            .accountsList!.isNotEmpty ?GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listContactModelClass
                              .accountsList!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 100, // here set custom Height You Want
                          ),
                          itemBuilder: (BuildContext context,
                              int index) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: mWidth * .2,
                                      height: mHeight * .03,
                                      //  color: Colors.yellow,
                                      child: Text(
                                        listContactModelClass
                                            .accountsList![index]
                                            .accountName!,
                                        overflow: TextOverflow
                                            .ellipsis,
                                        style: customisedStyle(
                                            context,
                                            listContactModelClass
                                                .accountsList![index]
                                                .accountType != 1
                                                ? Color(0xff003D88)
                                                : Color(0xff0E7D02),
                                            FontWeight.w500,
                                            10.0),
                                      )),
                                  listContactModelClass
                                      .accountsList![index]
                                      .accountType != 1
                                      ? SvgPicture.asset(
                                      "assets/svg/bank.svg")
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
                                              listContactModelClass
                                                  .accountsList![index]
                                                  .balance!,
                                            )}",
                                        overflow: TextOverflow
                                            .ellipsis,
                                        style: customisedStyle(
                                            context, Colors.black,
                                            FontWeight.w500, 10.0),
                                      )),
                                ],
                              ),
                            );
                          },
                        ):SizedBox(
                            height: mHeight * .1,
                            child: const Center(
                                child: Text(
                                  "Accounts not found !",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )))

                    ),
                    Container(
                      color: Color(0xffF9F9F9),
                      height: 16,
                    ),
    Container(
      height: mHeight*.5,
      child: BlocBuilder<PaginationContactBloc, PaginationContactState>(
      builder: (context, state) {
      if (state is ListPaginationContactLoading) {
      return Container(
      color: Colors.white,
      child: Center(
      child: CircularProgressIndicator(
      color: Color(0xff5728C4),
      ),
      ),
      );
      }
      if (state is ListPaginationContactLoaded) {
        response = BlocProvider
            .of<PaginationContactBloc>(context)
            .response;
        print("__________________ ui response _____________________ ${response
            .body}");


        Map n = json.decode(utf8.decode(response.bodyBytes));
        var status = n["StatusCode"];
        var responseJson = n["data"];
        var count = n["count"];


        for (Map user in responseJson) {
          orderDetailsTable.add(ContactPaginationModelClass.fromJson(user));
        }

        _refreshController.loadComplete();

        return Container(

          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ValueListenableBuilder(
              valueListenable: valueNotifier,
              builder: (context, value, child) {
                return SmartRefresher(

                  enablePullDown: true,
                  enablePullUp: true,
                  onLoading: () async {
                    SharedPreferences prefs = await SharedPreferences
                        .getInstance();
                    final organizationId = prefs.getString("organisation");
                    final value = valueNotifier.value ++;
                    if (mounted) {
                      await Future.delayed(const Duration(milliseconds: 3));
                    }
                    orderDetailsTable.length != count ?
                    BlocProvider.of<PaginationContactBloc>(context).add(
                        ListContactPaginationEvent(organisation: organizationId!,
                            search: "",
                            page_number: value,
                            page_size: 5)) :

                    null;
                    _refreshController.loadComplete();
                  },
                  controller: _refreshController,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderDetailsTable.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 100, // here set custom Height You Want
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      double highestReceived = 0.00;
                      double highestPaid = 0.00;
                      double difference = 0.00;
                      String amount = '0.00';

                      // highestReceived = double.parse(listContactModelClass.data![index].totalReceived ?? '0.00');
                      // highestPaid = double.parse(listContactModelClass.data![index].totalPaid ?? '0.00');
                      // difference = (highestReceived - highestPaid).abs();
                      // amount = difference.toString();
                      //
                      // Color returnColor = Color(0xff0E7D02);
                      // if (highestPaid > highestReceived) {
                      //   returnColor = Color(0xffCC0000);
                      // } else {
                      //   returnColor = Color(0xff0E7D02);
                      // }

                      return Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: mWidth * .2,
                              height: mHeight * .03,
                              child: Text(
                                orderDetailsTable[index].accountName!,
                                overflow: TextOverflow.ellipsis,
                                style: customisedStyle(
                                    context, Colors.black, FontWeight.w500, 10.0),
                              ),
                            ),
                            CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                backgroundImage:
                                NetworkImage(
                                    'https://www.gravatar.com/avatar/?s=46&d=identicon&r=PG&f=1')
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: mWidth * .3,
                              child: Text(
                                countryCurrencyCode + "." +
                                    "${(roundStringWith(amount))}",
                                overflow: TextOverflow.ellipsis,
                                style: customisedStyle(
                                    context, Colors.black, FontWeight.w500, 10.0),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
          ),
        );
      }
      if (state is ListPaginationContactError) {
        return Center(
          child: Text(
            "Something went wrong",
            style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
          ),
        );
      }
      return SizedBox();
  },
),
    ),




            ])

            ),
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
    );
  }
}
  class ContactPaginationModelClass {
  String accountName, amount;





  ContactPaginationModelClass(
  {required this.accountName,
  required this.amount,
  });

  factory ContactPaginationModelClass.fromJson(Map<dynamic, dynamic> json) {
  return ContactPaginationModelClass(
  accountName: json['account_name'],
  amount: json['amount'] ?? "0",
  );
  }
  }
