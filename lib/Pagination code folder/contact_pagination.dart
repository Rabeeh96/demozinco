import 'dart:convert';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/contact/ListContactModelClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api Helper/Bloc/Contact/contact_bloc.dart';
import '../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../Utilities/Commen Functions/internet_connection_checker.dart';
import '../Utilities/Commen Functions/roundoff_function.dart';
import '../Utilities/global/text_style.dart';
import '../Utilities/global/variables.dart';
import '../View/screens/contacts/new_section/detail_page.dart';
import 'api/Bloc/pagination_contact_bloc.dart';


class PaginationContact extends StatefulWidget {
  const PaginationContact({Key? key}) : super(key: key);

  @override
  State<PaginationContact> createState() => _PaginationContactState();
}

class _PaginationContactState extends State<PaginationContact> {

  listContactFunction() async {
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

  late ListContactModelClass listContactModelClass;

  apiFunction() async {
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

  List<ContactPaginationModelClass> orderDetailsTable = [];
  ValueNotifier valueNotifier = ValueNotifier(2);
  late  Response response ;
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  @override
  void initState() {
    listContactFunction();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<PaginationContactBloc, PaginationContactState>(
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
          response = BlocProvider.of<PaginationContactBloc>(context).response;


          Map n = json.decode(utf8.decode(response.bodyBytes));
          var status = n["StatusCode"];
          var responseJson = n["data"];
          var count =n["count"];


          for (Map user in responseJson) {
            orderDetailsTable.add(ContactPaginationModelClass.fromJson(user));

          }

          _refreshController.loadComplete();


          return Scaffold(
            // ... Your Scaffold and AppBar code here ...

            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  height: mHeight*.8,
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: ValueListenableBuilder(
                      valueListenable: valueNotifier,
                      builder: (context, value, child) {
                      return SmartRefresher(

                        enablePullDown: true,
                        enablePullUp: true,
                        onLoading: ()async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          final organizationId = prefs.getString("organisation");
                          final value = valueNotifier.value ++;
                          if(mounted) {
                            await Future.delayed(const Duration(milliseconds: 3));
                          }
                          orderDetailsTable.length != count ?
                           BlocProvider.of<PaginationContactBloc>(context).add(ListContactPaginationEvent(organisation: organizationId!, search: "", page_number: value,
                             page_size: 5)):

                          null;
                          _refreshController.loadComplete();},
                        controller: _refreshController,
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:orderDetailsTable.length ,
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
                                      style: customisedStyle(context, Colors.black, FontWeight.w500, 10.0),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage:
                                        NetworkImage('https://www.gravatar.com/avatar/?s=46&d=identicon&r=PG&f=1')
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: mWidth * .3,
                                    child: Text(
                                      countryCurrencyCode + "." + "${(roundStringWith(amount))}",
                                      overflow: TextOverflow.ellipsis,
                                      style: customisedStyle(context, Colors.black, FontWeight.w500, 10.0),
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
                ),
              ],
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

