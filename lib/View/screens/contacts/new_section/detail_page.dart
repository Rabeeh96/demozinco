import 'dart:convert';


import 'package:cuentaguestor_edit/View/screens/contacts/new_section/transaction_section.dart';
import 'package:flutter/material.dart';



import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../../Api Helper/Bloc/Contact/contact_bloc.dart';
import '../../../../Api Helper/Bloc/Transaction_contact/transaction_contact_bloc.dart';
import '../../../../Api Helper/ModelClasses/contact/DetailContactModelClass.dart';
import '../../../../Api Helper/ModelClasses/contact/delete_contactModelClass.dart';
import '../../../../Api Helper/ModelClasses/transaction contact/DeleteTransactionContactModelClass.dart';
import '../../../../Api Helper/ModelClasses/transaction contact/DetailTransactionContactModelClass.dart';
import '../../../../Api Helper/ModelClasses/transaction contact/ListTransactionContactModelClass.dart';
import '../../../../Api Helper/Repository/api_client.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';
import '../../../../Utilities/global/variables.dart';
import '../../../Export/export_to_excel.dart';
import '../../../Export/export_to_pdf.dart';
import '../../DashboardNewDesign/filter.dart';
import 'crate_contact.dart';
import 'dio_contact.dart';

class ContactDetailPageNew extends StatefulWidget {
  String? accountName;
  String? accountId;
  String? phone;
  String? totalReceived;
  String? totalPaid;

  ContactDetailPageNew({super.key, this.accountName, required this.phone, this.accountId, this.totalPaid, this.totalReceived});

  @override
  State<ContactDetailPageNew> createState() => _ContactDetailPageNewState();
}

class _ContactDetailPageNewState extends State<ContactDetailPageNew> {
  DateTime selectedDateAndTime = DateTime.now();

  DateFormat dateFormat = DateFormat("dd/MM/yyy");

  int buttonIndex = 1;

  var contactDetailList = [];

  @override
  void initState() {
    progressBar = ProgressBar();
    super.initState();

    phoneNumber = widget.phone!;
    listContactTransactionApiFunction();
  }


  returnVoucherType(type) {
    if (type == "EX" || type == "AEX") {
      return "Expense";
    } else if (type == "IC" || type == "AIC") {
      return "Income";
    } else if (type == "TEX" || type == "TIC") {
      return "Transfer";
    } else {
      return "";
    }


  }

  late ListTransactionContactModelClass listTransactionContactModelClass;

  ValueNotifier<DateTime> fromDateNotifier = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime> toDateNotifier = ValueNotifier(DateTime.now());
  ValueNotifier<bool> isDate = ValueNotifier(false);

  late ProgressBar progressBar;

  void showProgressBar() {
    progressBar.show(context);
  }

  void hideProgressBar() {
    progressBar.hide();
  }

  @override
  void dispose() {
    progressBar.hide();

    super.dispose();
  }

  var returnName = "";

  var totalReceivedAmount = "0.00";
  var totalPaidAmount = "0.00";
  var phoneNumber = "";

  List colors = [Colors.red, Colors.green];
  final DateFormat formatter = DateFormat("y-M-d");
  final DateFormat apiFormat = DateFormat('yyyy-MM-dd');

  var fromDate;
  var toDate;
  bool _isVisible = false;

  listContactTransactionApiFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      final response;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String baseUrl = ApiClient.basePath;

        var accessToken = prefs.getString('token') ?? '';
        final organizationId = prefs.getString("organisation");
        final url = baseUrl + 'finance/list-account-finance/';

        Map data = {
          "organization": organizationId,
          "from_date": fromDate,
          "to_date": toDate,
          "account_id": widget.accountId,
          "finance_type": 1,
          "is_contact": true
        };
        var body = json.encode(data);
        var response = await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $accessToken',
            },
            body: body);
        Map n = json.decode(utf8.decode(response.bodyBytes));
        var statusCode = n["StatusCode"];

        var responseJson = n["data"];
        print("____________________________________finance/list-account-finance/_________________________________________________________");
        print(response.body);
        print("_____________________________________________________________________________________________");

        if (statusCode == 6000) {
          contactDetailList.clear();
          widget.accountName = n["summary"]["account_name"];
          phoneNumber = n["summary"]["phone"]??widget.phone;
          total_received = n["contact_summary"]["total_recieved"].toString();
          total_paid = n["contact_summary"]["total_paid"].toString();

          double balance = double.parse(total_received) - double.parse(total_paid);
          if (balance > 0.0) {

            heading = "Payable";
            difference =  balance.abs();
            colorDifference = Color(0xffFF0000);

          } else if (balance < 0) {
            heading = "Receivable";
            difference =  balance.abs();
            colorDifference = Color(0xff089B17);

          } else {
            heading =  "Balanced";
            difference =  0.00;
            colorDifference = Colors.blueGrey;
          }


          hideProgressBar();
          setState(() {
            contactDetailList = responseJson;


          });
        } else {
          hideProgressBar();
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }


  var total_received = "0.00";
  var total_paid = "0.00";

  var heading = "";
  var difference = 0.00;

  Color colorDifference = Color(0xff089B17);

  deleteContactTransactionApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<TransactionContactBloc>(context).add(DeleteTransactionContactEventEvent(id: id, organisation: organizationId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  late DeleteTransactionContactModelClass deleteTransactionContactModelClass;
  late DetailTransactionContactModelClass detailTransactionContactModelClass;

  String roundFunction1(String val) {
    if (val == "") {
      val = "0.00";
    }

    double convertedTodDouble = double.parse(val);
    var number = convertedTodDouble.toStringAsFixed(2);

    return number;
  }

  deleteContactApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<ContactBloc>(context).add(DeleteContactEvent(organisationId: organizationId!, id: widget.accountId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  late DeleteContactModel deleteContactModelClass;

  listContactFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");

      return BlocProvider.of<ContactBloc>(context).add(ListContactEvent(organisation: organizationId!, page_number: 1, page_size: 30, search: ""));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  returnDifference() {

  }

  late DetailContactModelClass detailContactModelClass;

  detailContactApiFunction() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      progressBar.show(context);
      try {
        var results = await getContactDetailsDetails(context: context, portfolioID: widget.accountId);
        progressBar.hide();
        if (results[0] == 6000) {
          var data = results[1];

          final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ContactCreateNew(
                    imagePath: data["photo"] ?? '',
                    type: 'Edit',
                    countryName: data["country"]['country_name'],
                    transaction: int.parse(data["account_type"]),
                    openingBalance: roundStringWithOnlyDigit(
                      data["opening_balance"].toString(),
                    ),
                    countryID: data["country"]['id'],
                    contactName: data["account_name"],
                    organisationId: data["organization"],
                    amount: roundStringWithOnlyDigit(
                      data["opening_balance"],
                    ),
                    id: data["id"],
                    phoneNumber: data["phone"] ?? '',
                    buildingName: data["address"]["building_name"] ?? '',
                    landMark: data["address"]["land_mark"] ?? '',
                    state: data["address"]["state"] ?? '',
                    addressName: data["address"]["address_name"] ?? '',
                    pinCode: data["address"]["pin_code"] ?? '',
                  )));

          listContactTransactionApiFunction();
        } else {}
      } catch (e) {
        progressBar.hide();
      }
    });
  }

  String id = "";
  String dropDownValue = 'This Week';
  final items = [
    'This Week',
    'This Month',
    'This Year',
  ];

  dateFilter({required String dropDownValue}) {
    var fromDate = '';
    var dateTo = '';
    final DateFormat formatterDate = DateFormat('yyyy-MM-dd');
    if (dropDownValue == 'This Week') {
      int currentDay = selectedDateAndTime.weekday;
      DateTime firstDayOfWeek = selectedDateAndTime.subtract(Duration(days: currentDay - 1));
      fromDate = formatterDate.format(firstDayOfWeek);
      DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
      dateTo = formatterDate.format(lastDayOfWeek);
    } else if (dropDownValue == 'This Month') {
      var monthEnd = DateTime(selectedDateAndTime.year, selectedDateAndTime.month + 1, 0);
      var monthStart = DateTime(selectedDateAndTime.year, selectedDateAndTime.month, 1);
      fromDate = formatterDate.format(monthStart);
      dateTo = formatterDate.format(monthEnd);
    } else if (dropDownValue == 'This Year') {
      final DateFormat formatter1 = DateFormat('yyyy');
      DateTime dt = DateTime.now();
      final String formattedYear = formatter1.format(dt);
      var year = formattedYear;

      fromDate = '$year-01-01';
      dateTo = '$year-12-31';
    }

    return [fromDate, dateTo];
  }

  DateTime convertDate(String inputDate) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(inputDate);
    return date;
  }

  var dateTimePicked;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<TransactionContactBloc, TransactionContactState>(
          listener: (context, state) async {
            if (state is DetailTransactionContactLoaded) {


            }
            if (state is DetailTransactionContactError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<TransactionContactBloc, TransactionContactState>(
          listener: (context, state) {
            if (state is DeleteTransactionContactLoading) {
              const CircularProgressIndicator(
                color: Color(0xff5728C4),
              );
            }
            if (state is DeleteTransactionContactLoaded) {
              hideProgressBar();

              deleteTransactionContactModelClass = BlocProvider.of<TransactionContactBloc>(context).deleteTransactionContactModelClass;

              if (deleteTransactionContactModelClass.statusCode == 6000) {
                listContactTransactionApiFunction();
              }

              if (deleteTransactionContactModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(context: context, textMsg: deleteTransactionContactModelClass.data!);
              }
              if (deleteTransactionContactModelClass.statusCode == 6002) {
                msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
              }
            }
            if (state is DeleteTransactionContactError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<ContactBloc, ContactState>(
          listener: (context, state) {
            if (state is DeleteContactLoading) {
              const CircularProgressIndicator(
                color: Color(0xff5728C4),
              );
            }
            if (state is DeleteContactLoaded) {
              Navigator.pop(context);
              hideProgressBar();
              deleteContactModelClass = BlocProvider.of<ContactBloc>(context).deleteContactModelClass;
              if (deleteContactModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(context: context, textMsg: deleteContactModelClass.data!);
              }
              if (deleteContactModelClass.statusCode == 6002) {
                msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
              }
            }
            if (state is DeleteContactError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<ContactBloc, ContactState>(
          listener: (context, state) async {
            if (state is DetailsContactLoaded) {

              hideProgressBar();
              detailContactModelClass = BlocProvider.of<ContactBloc>(context).detailContactModelClass;


            }
            if (state is DetailsContactError) {
              hideProgressBar();
            }
          },
        ),
      ],
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height / 11,

            backgroundColor: const Color(0xffffffff),
            elevation: 0,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xff2BAAFC),
              ),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.accountName!,
                        style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 20.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    btmDialogueFunction(
                        isDismissible: true,
                        context: context,
                        textMsg: 'Are you sure delete ?',
                        fistBtnOnPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        secondBtnPressed: () async {
                          deleteContactApiFunction();
                          Navigator.of(context).pop(true);
                        },
                        secondBtnText: 'Yes');


                  },
                  icon: const Icon(
                    Icons.delete,

                    color: Color(0xff2BAAFC),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 17.0),
                child: IconButton(
                    onPressed: () async {
                      detailContactApiFunction();
                    },
                    icon: const Icon(

                      Icons.edit,
                      color: Color(0xff2BAAFC),
                    )),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 0, right: 0.0),
            child: ListView(
              children: [
                Divider(
                  color: Color(0xffE2E2E2),
                  thickness: 1,
                ),
                phoneNumber != ""
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          title: Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Phone No ", style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.normal, 14.0)),
                                    Text(
                                      phoneNumber,
                                      style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 14.0),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(

                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () async {


                                            Uri phoneno = Uri.parse('sms:$phoneNumber');
                                            if (await launchUrl(phoneno)) {
                                            } else {}
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/svg/message.svg',
                                            height: mHeight * .023,
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: ()async {
                                            Uri phoneno = Uri.parse('tel:$phoneNumber');
                                            if (await launchUrl(phoneno)) {
                                            } else {}
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/svg/phone.svg',
                                            height: mHeight * .023,
                                          ),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  tileColor: const Color(0xffF3F3F3),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Summary", style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.w600, 15.0)),
                      SizedBox(
                        height: mHeight * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Received", style: customisedStyle(context, Color(0xff9C9C9C), FontWeight.normal, 11.0)),
                                Text("${roundStringWith(total_received.toString())}",
                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Paid", style: customisedStyle(context, Color(0xff9C9C9C), FontWeight.normal, 11.0)),
                                Text("${roundStringWith(total_paid.toString())}", style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(heading, style: customisedStyle(context, colorDifference, FontWeight.normal, 11.0)),
                                Text("${roundStringWith(difference.toString())}", style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0, right: mWidth * .07),
                  height: mHeight * .08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transactions",
                        style: customisedStyle(context, Colors.black, FontWeight.w600, 18.0),
                      ),
                      fromDate != null && toDate != null
                          ? Visibility(
                              visible: _isVisible,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                    listContactTransactionApiFunction();
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: mHeight * .03,
                                    width: mWidth * .25,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffD9E5F3)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '1 Filter',
                                          style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                        ),
                                        Icon(
                                          Icons.close,
                                          color: Color(0xff2BAAFC),
                                        )
                                      ],
                                    )),
                              ),
                            )
                          : SizedBox(),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FilterForDashboardDetail()));

                          if (result != null) {
                            setState(() {
                              _isVisible = !_isVisible;
                              fromDate = result[1];
                              toDate = result[0];
                            });
                          }

                          var netWork = await checkNetwork();

                          if (netWork) {
                            if (!mounted) return;
                            listContactTransactionApiFunction();
                          } else {
                            if (!mounted) return;
                            msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                          }
                        },
                        child: SvgPicture.asset("assets/svg/filter.svg",color: Color(0xff2BAAFC),),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mHeight * .02,
                ),
                contactDetailList.isNotEmpty
                    ? Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: contactDetailList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07, bottom: 10),

                                      color: Color(0xffF8F8F8),
                                      height: mHeight * .06,
                                      width: mWidth,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            contactDetailList[index]["date"],
                                            style: customisedStyle(context, Color(0xff878787), FontWeight.normal, 16.0),
                                          ),
                                          Text(
                                            countryCurrencyCode + " " + roundStringWith(contactDetailList[index]["total"].toString()),

                                            style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                                    Container(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: contactDetailList[index]["data"].length,
                                          itemBuilder: (BuildContext context, int indexx) {
                                            var data = contactDetailList[index]["data"];

                                            return Dismissible(
                                              direction: DismissDirection.endToStart,
                                              background: Container(
                                                  color: Colors.red,
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  )),
                                              confirmDismiss: (DismissDirection direction) async {

                                                if(data[indexx]["from_account_name"] =="Opening Balance" ||data[indexx]["to_account_name"] =="Opening Balance"){
                                                  msgBtmDialogueFunction(context: context, textMsg: "You cant edit this from here");
                                                }
                                                else{
                                                  return await btmDialogueFunction(
                                                      isDismissible: true,
                                                      context: context,
                                                      textMsg: 'Are you sure delete ?',
                                                      fistBtnOnPressed: () {
                                                        Navigator.of(context).pop(false);
                                                      },
                                                      secondBtnPressed: () async {
                                                        Navigator.of(context).pop(true);
                                                        var netWork = await checkNetwork();
                                                        if (netWork) {
                                                          if (!mounted) return;

                                                          deleteTransfer(data[indexx]["id"]);
                                                        } else {


                                                          if (!mounted) return;
                                                          msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                                        }
                                                      },
                                                      secondBtnText: 'Delete');

                                                }

                                              },
                                              key: Key('item ${[index]}'),
                                              onDismissed: (direction) async {},
                                              child: Column(
                                                children: [


                                                  GestureDetector(
                                                    onTap: () async {

                                                      if(data[indexx]["from_account_name"] =="Opening Balance" ||data[indexx]["to_account_name"] =="Opening Balance"){
                                                        msgBtmDialogueFunction(context: context, textMsg: "You cant edit this from here");
                                                      }
                                                      else{
                                                        navigateToEdit(data[indexx]["id"]);
                                                      }


                                                    },
                                                    child: Container(
                                                     color:Colors.transparent,
                                                      padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07, top: 15, bottom: 15),


                                                      width: mWidth,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            returnAccountDetails(
                                                                data[indexx]["from_account_name"], data[indexx]["to_account_name"]),
                                                            style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text(
                                                                countryCurrencyCode + " " + roundStringWith(data[indexx]["amount"].toString()),
                                                                style: customisedStyle(context, returnColorVoucherType(data[indexx]["voucher_type"]),
                                                                    FontWeight.w600, 13.0),
                                                              ),
                                                              Text(
                                                                data[indexx]["description"],
                                                                style: customisedStyle(context, Color(0xff878787),
                                                                    FontWeight.normal, 11.0),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                                                ],
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    : Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 18),
                        child: Container(
                          child: Center(child: Text("No Items", style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))),
                        ),
                      ),
                SizedBox(height: mHeight * .01),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: const Color(0xffF3F7FC),
            height: MediaQuery.of(context).size.height / 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Row(
                  children: [
                    Row(
                      children: [

                        Padding(
                            padding: EdgeInsets.only(left: mWidth * .08),
                            child: PopupMenuButton<String>(
                              constraints: BoxConstraints(
                                minWidth: 2.0 * 56.0,
                                maxWidth: MediaQuery.of(context).size.width,


                              ),
                              child: Container(

                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/svg/export.svg",color: Color(0xff2BAAFC),),
                                    SizedBox(width: mWidth * .015),
                                    Text(
                                      "Export",
                                      style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                                    ),
                                  ],
                                ),
                              ),

                              itemBuilder: (BuildContext context) {
                                return [

                                  PopupMenuItem(
                                    value: 'pdf',

                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "PDF",
                                          style: customisedStyle(
                                              context,
                                              Colors.black,
                                              FontWeight.w500,
                                              13.0),
                                        ),
                                        SvgPicture.asset(
                                            "assets/svg/pdf.svg"),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'excel',
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Excel",
                                          style: customisedStyle(
                                              context,
                                              Colors.black,
                                              FontWeight.w500,
                                              13.0),
                                        ),
                                        SvgPicture.asset(
                                            "assets/svg/excel.svg"),
                                      ],
                                    ),

                                  ),

                                ];
                              },
                              onSelected: (String value) async{
                                var head = "${widget.accountName!} Report";
                                var dateDet =  fromDate == null && toDate == null ? "": "$fromDate $toDate";

                                List<List<String?>> data = [
                                  ['', '     ', '', '     '],
                                  ['', '     ', '', '     '],
                                  ['Date', 'Particular', 'Amount', 'Notes'],
                                ];

                                if(contactDetailList.isEmpty){
                                  msgBtmDialogueFunction(context: context, textMsg: "Please ensure there is data before exporting.");
                                }

                                else{



                                  for(var i =0 ;i<contactDetailList.length;i++){
                                    String symbol = "-";

                                    var detailsItem = contactDetailList[i]["data"];
                                    for(var t =0 ;t<detailsItem!.length;t++){
                                      String notes = detailsItem[t]["description"]!;


                                      String accountName = returnAccountDetails(detailsItem[t]["from_account_name"], detailsItem[t]["to_account_name"]);

                                      String value =  returnVoucherType(detailsItem[t]["voucher_type"]);
                                      String amount = roundStringWith(detailsItem[t]["amount"].toString());
                                      String check = symbol + amount;
                                      String finalAmount = value == "Expense" ? check : amount;

                                      List<String?> a =[ contactDetailList[i]["date"], accountName,finalAmount ,notes];
                                      data.add(a);
                                    }


                                  }
                                  var balance =  heading+"  "+ roundStringWith(difference.toString());
                                  if (value == 'pdf') {

                                    loadDataToReport(data: data,heading: head,date: "",type: 1,balance: balance);
                                  }

                                  else if (value == 'excel') {



                                    convertToExcel(data: data,heading: head,date: dateDet,balance: balance);



                                  }
                                  else {}



                                }

                              },
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 33.0,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(17.0), color: Colors.transparent),
                      child: ElevatedButton(
                        onPressed: () async {
                          var result = await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TransactionPageContact(
                                    contactID: widget.accountId,
                                    contactName: widget.accountName,
                                    isZakath: false,
                                    isFromNotification: false,
                                    reminderID: '',
                                    isDetail: false,
                                    financeType: "1",
                                    type: "Create",
                                    balance: "0.00",
                                    amount: "0.00",
                                    to_account_id: "",
                                    to_accountName: "",
                                    description: "",
                                    from_account_id: "",
                                    from_accountName: "",
                                    id: "",
                                    date: "",
                                    isInterest: false,
                                  )));

                          listContactTransactionApiFunction();
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                        child: Icon(
                          Icons.add,
                          color: Color(0xff2BAAFC),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  returnAccountDetails(fromAccount, toAccount) {
    if (widget.accountName == fromAccount) {
      return toAccount;
    } else {
      return fromAccount;
    }
  }


  returnColorVoucherType(type) {
    if (type == "EX" || type == "AEX") {
      return Color(0xffEC0000);
    } else if (type == "IC" || type == "AIC") {
      return Color(0xff017511);
    } else {
      return Colors.blueAccent;
    }
  }

  navigateToEdit(id) async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      showProgressBar();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String baseUrl = ApiClient.basePath;
        var accessToken = prefs.getString('token') ?? '';
        final organizationId = prefs.getString("organisation");
        var uri = "finance/details-finance/";
        final url = baseUrl + uri;

        Map data = {"id": id, "organization": organizationId};

        var body = json.encode(data);

        var response = await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $accessToken',
            },
            body: body);
        Map n = json.decode(utf8.decode(response.bodyBytes));
        var statusCode = n["StatusCode"];
        var responseJson = n["data"];



        if (statusCode == 6000) {
          hideProgressBar();




          var result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TransactionPageContact(
                    contactName: widget.accountName,
                    isZakath: false,
                isFromNotification: false,
                reminderID: '',
                    financeType: responseJson["finance_type"],
                    isDetail: false,
                    contactID: widget.accountId,
                    type: "Edit",
                    balance: "0.00",
                    isReminder:responseJson["is_reminder"]??false,
                    isReminderDate:responseJson["reminder_date"]??'2023-09-19',
                    to_account_id: responseJson["to_account"]["id"],
                    to_accountName: responseJson["to_account"]["account_name"],
                    description: responseJson["description"],
                    from_account_id: responseJson["from_account"]["id"],
                    from_accountName: responseJson["from_account"]["account_name"],
                    id: id,
                    date: responseJson["date"],
                    amount: roundStringWithVal(responseJson["amount"].toString()),
                  )));

          listContactTransactionApiFunction();

        } else {
          hideProgressBar();
        }
      } catch (e) {
        hideProgressBar();
        print(e.toString());
      }
    } else {
      hideProgressBar();
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  deleteTransfer(String transferId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'finance/delete-finance/';
      showProgressBar();

      Map data = {"organization": organizationId, "id": transferId};
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          },
          body: body);
      Map n = json.decode(utf8.decode(response.bodyBytes));
      var statusCode = n["StatusCode"];
      if (statusCode == 6000) {
        hideProgressBar();
        setState(() {
          contactDetailList.clear();
        });
        listContactTransactionApiFunction();
      } else if (statusCode == 6001) {
        hideProgressBar();
        msgBtmDialogueFunction(context: context, textMsg: n["message"] ?? '');
      } else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
    }
  }
}
