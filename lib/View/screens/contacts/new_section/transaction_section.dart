import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'package:http/http.dart' as http;

import '../../../../Api Helper/Repository/api_client.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/date_picker_function.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';
import '../../../../Utilities/global/variables.dart';

class TransactionPageContact extends StatefulWidget {
  final String type;
  bool? isInterest;
  bool? isZakath;
  String? date;
  String? balance;
  String? from_account_id;
  String? from_accountName;
  String? to_account_id;
  String? to_accountName;
  String? amount;
  String? description;
  String? financeType;
  String? id;
  String? contactName;
  String? contactID;
  bool? isReminder;
  String? isReminderDate;
  String? reminderID;
  final bool isFromNotification;
  bool? isDetail;

  TransactionPageContact({
    super.key,
    required this.type,
    this.isInterest,
    required this.isDetail,
    this.date,
    this.from_account_id,
    this.from_accountName,
    this.isReminder,
    this.isReminderDate,
    required this.to_account_id,
    required this.reminderID,
    required this.isFromNotification,
    required this.financeType,
    required this.isZakath,
    required this.to_accountName,
    required this.contactName,
    required this.contactID,
    required this.amount,
    required this.balance,
    this.description,
    this.id,
  });

  @override
  State<TransactionPageContact> createState() => _TransactionPageContactState();
}

class _TransactionPageContactState extends State<TransactionPageContact> with SingleTickerProviderStateMixin {
  var userInput = '';

  TextEditingController notesController = TextEditingController();
  String selectedAccountID = "";
  String selectedAccountName = "";
  String selectedToAccountName = "";

  DateFormat apiDateFormat = DateFormat("y-M-d");
  late TabController tabController;
  ValueNotifier<int> accountType = ValueNotifier<int>(0);
  final List<String> buttons = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '×',
    '1',
    '2',
    '3',
    '-',
    '0',
    ".",
    '⌫',
    '+',
  ];


  DateFormat dateFormat = DateFormat("dd/MM/yyy");
  ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime.now());
  TextEditingController searchController = TextEditingController();
 late ValueNotifier<DateTime> SetReminderDateNotifier ;

  late ProgressBar progressBar;
  bool isReminderSet = false;

  setReminderDatePicker(context,ValueNotifier dateNotifier) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: mWidth * .98,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(left: mWidth * .13, top: mHeight * .01),
                    child:  Center(
                      child: Text(
                        "Select Date",
                        style: GoogleFonts.poppins(textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CalendarDatePicker(
                onDateChanged: (selectedDate) {
                  dateNotifier.value = selectedDate;
                  isReminderSet = true;
                  Navigator.pop(context);
                },

                initialDate: dateNotifier.value,
                firstDate: DateTime.now().add(
                  const Duration(days: -100000000),
                ),
                lastDate: DateTime.now().add(const Duration(days: 6570)),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  returnAccountListFrom() async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';
      final country_id = prefs.getString("country_id");
      showProgressBar();
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 30,
        "search": "",
        "country_id": country_id,
        "account_type": [1, 2]
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

      if (statusCode == 6000) {
        hideProgressBar();
        setState(() {
          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountList.add(account);
            accountListShown.add(account);
            searchAccountListShown.add(account);
          }

          if (widget.type == "Create" && widget.isDetail == false) {
            selectedAccountID = accountListShown[0].id;
            selectedAccountName = accountListShown[0].account_name;
          } else {
            int indexToDelete = accountListShown.indexWhere((item) => item.id == selectedAccountID);
            AccountListModel newItem = AccountListModel(
              id: accountListShown[indexToDelete].id,
              account_name: accountListShown[indexToDelete].account_name,
              accounts_id: accountListShown[indexToDelete].accounts_id,
              opening_balance: '0.00',
              account_type: accountListShown[indexToDelete].account_type,
              amount: accountListShown[indexToDelete].amount,
            );

            accountListShown.removeAt(indexToDelete);
            accountListShown.insert(0, newItem);
            setState(() {});
          }
        });
      } else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
      print(e.toString());
    }
  }

  searchAccountListApi(searchData, setStater) async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';
      final country_id = prefs.getString("country_id");

      var type = [1, 2];

      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 20,
        "search": searchData,
        "country_id": country_id,
        "account_type": type
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

      if (statusCode == 6000) {



        searchAccountListShown.clear();
        setStater(() {
          for (Map user in responseJson) {
            searchAccountListShown.add(AccountListModel.fromJson(user));
          }
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<T> removeDuplicates<T>(List<T> list) {
    Set<T> set = Set<T>.from(list);
    return set.toList();
  }

  returnIcon(type) {
    if (type == "0") {

      return "assets/svg/amount.svg";
    } else if (type == "1") {

      return "assets/svg/amount.svg";
    } else if (type == "2") {

      return "assets/svg/bankpicture.svg";
    } else if (type == "3") {
    } else if (type == "4") {
    } else if (type == "5") {
    } else if (type == "6") {
    } else if (type == "7") {
    } else if (type == "8") {
    } else {

    }
  }

  accountBtmSheet(context, String selectedCardAccount) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStater) {
            return Container(
              color: Colors.white,
              height: mHeight * .7,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: mHeight * .02,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                              color: Color(0xff2BAAFC),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(color: const Color(0xffF6F6F6), borderRadius: BorderRadius.circular(20)),
                            height: mHeight * .06,
                            width: mWidth * .8,
                            child: Center(
                              child: TextField(
                                controller: searchController,
                                onChanged: (val) {
                                  setStater(() {
                                    searchAccountListApi(val, setStater);
                                  });
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: mHeight * .015),
                                    hintText: 'Search',
                                    helperStyle: customisedStyle(context, Color(0xff929292), FontWeight.normal, 15.0),
                                    prefixIcon: Icon(Icons.search),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mHeight * .02),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 10000, minHeight: 0),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                            itemCount: searchAccountListShown.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 40,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                   searchController.clear();
                                    AccountListModel newItem = AccountListModel(
                                      id: searchAccountListShown[index].id,
                                      account_name: searchAccountListShown[index].account_name,
                                      accounts_id: searchAccountListShown[index].accounts_id,
                                      opening_balance: '0.00',
                                      account_type: searchAccountListShown[index].account_type,
                                      amount: searchAccountListShown[index].amount,
                                    );

                                    selectedAccountID = searchAccountListShown[index].id;
                                    selectedAccountName = searchAccountListShown[index].account_name;

                                    bool exists = isItemWithIdExists(searchAccountListShown[index].id);
                                    if (exists) {
                                      int indexToDelete = accountListShown.indexWhere((item) => item.id == searchAccountListShown[index].id);
                                      accountListShown.removeAt(indexToDelete);
                                    }

                                    accountListShown.insert(0, newItem);
                                    searchAccountListShown = accountList;



                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  height: mHeight * .01,

                                  decoration: BoxDecoration(
                                      color: selectedCardAccount == searchAccountListShown[index].id ? Color(0xff2BAAFC) : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffD6E0F6))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          searchAccountListShown[index].account_name,
                                          style: customisedStyle(
                                              context,
                                              selectedCardAccount == searchAccountListShown[index].id ? Colors.white : Colors.black,
                                              FontWeight.normal,
                                              13.0),
                                        ),
                                      ),
                                      SizedBox(
                                        width: mWidth * .05,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),

                    Divider(
                      color: Color(0xffE2E2E2),
                      thickness: 1,
                    ),
                    Center(
                      child: Text(
                        'Accounts',
                        style: customisedStyle(context, Colors.black, FontWeight.normal, 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
      });
    });
  }

  bool isItemWithIdExists(String id) {
    return accountListShown.any((item) => item.id == id);
  }
  var finalAmount ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressBar = ProgressBar();


    searchAccountListShown = [];
    accountListShown = [];
    accountList = [];


    tabController = TabController(length: 2, vsync: this);
    SetReminderDateNotifier = widget.type == "Edit"?ValueNotifier(DateTime.parse(widget.isReminderDate!)) :ValueNotifier(DateTime.now());


    if (widget.type == "Edit") {
      SetReminderDateNotifier = widget.type == "Edit"?ValueNotifier(DateTime.parse(widget.isReminderDate!)) :ValueNotifier(DateTime.now());

      isReminderSet = widget.isReminder!;
      dateNotifier = ValueNotifier(DateTime.parse(widget.date!));

      notesController.text = widget.description!;
      finalAmount = widget.amount!;



      if (widget.financeType == "0") {
        accountType.value = 1;
        selectedAccountName = widget.to_accountName!;
        selectedAccountID = widget.to_account_id!;
      } else {

        selectedAccountName = widget.from_accountName!;
        selectedAccountID = widget.from_account_id!;
      }
    } else {

      selectedAccountName = widget.from_accountName!;
      selectedAccountID = widget.from_account_id!;
      dateNotifier = ValueNotifier(DateTime.now());
      notesController.text = "";
      finalAmount = "0.00";

      if(widget.isFromNotification){

        finalAmount = widget.amount!;
        if (widget.financeType == "0") {
          accountType.value = 1;
          selectedAccountName = widget.to_accountName!;
          selectedAccountID = widget.to_account_id!;
        } else {
          selectedAccountName = widget.from_accountName!;
          selectedAccountID = widget.from_account_id!;
        }
      }
    }

    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await returnAccountListFrom();
      });
    }
  }

  void handleTabTap(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: mHeight,
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    height: mHeight / 13,
                    color: Color(0xffF6F6F6),
                    child: Column(children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userInput,
                          style: const TextStyle(fontSize: 15, color: Colors.blueGrey),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 20, top: 5),
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              roundStringWith(finalAmount),
                              style: const TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              " " + countryCurrencyCode,
                              style: const TextStyle(fontSize: 12, color: Color(0xff6E88A6), fontWeight: FontWeight.normal),
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        Container(
                            width: mWidth / 1.2,
                            height: mHeight / 18,
                            child: Card(
                              elevation: 1,
                              child: TabBar(
                                controller: tabController,
                                tabs: [
                                  Tab(
                                    icon: Text(
                                      "From",
                                      style: customisedStyle(context, Colors.black, FontWeight.normal, 15.0),
                                    ),
                                  ),
                                  Tab(
                                    icon: Text(
                                      "To",
                                      style: customisedStyle(context, Colors.black, FontWeight.normal, 15.0),
                                    ),
                                  ),
                                ],
                                onTap: (index) {
                                  handleTabTap(index);

                                },
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                    color: Color(0xff2BAAFC),
                                    width: 4.0,
                                  ),
                                ),
                              ),
                            )),
                        IconButton(
                            onPressed: () {
                              if(tabController.index == 0){
                                if(accountType.value !=1){
                                  accountBtmSheet(context, selectedAccountID);
                                }

                              }
                              else{
                                if(accountType.value ==1){
                                  accountBtmSheet(context, selectedAccountID);
                                }
                              }

                            },
                            icon: SvgPicture.asset(
                              "assets/menu/search-normal.svg",
                            )),
                      ],
                    ),
                  ),
                  tabController.index == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
                          child: ValueListenableBuilder<int>(
                            valueListenable: accountType,
                            builder: (context, color, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        accountType.value = 0;
                                      });
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height / 28,
                                      width: MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                          color: accountType.value == 0 ? Color(0xff9003478) : Color(0xffE0E7F8),
                                          borderRadius: BorderRadius.circular(19)),
                                      child: Center(
                                          child: Text(
                                        "Account",
                                        style: TextStyle(color: accountType.value == 0 ? Colors.white : Color(0xff003478)),
                                      )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 5.0, left: 08.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          accountType.value = 1;
                                        });
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height / 28,

                                        width: MediaQuery.of(context).size.width / 3,
                                        decoration: BoxDecoration(
                                            color: accountType.value == 1 ? Color(0xff9003478) : Color(0xffE0E7F8),
                                            borderRadius: BorderRadius.circular(19)),
                                        child: Center(
                                            child: Text(
                                          "Contact",
                                          style: TextStyle(color: accountType.value == 1 ? Colors.white : Color(0xff003478)),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : SizedBox(),
                  tabController.index == 0
                      ? accountType.value == 0
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 15),
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: accountListShown.length > 4 ? 4 : accountListShown.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 40,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {

                                        setState(() {
                                          selectedAccountID = accountListShown[index].id;
                                          selectedAccountName = accountListShown[index].account_name;
                                        });
                                      },
                                      child: Container(
                                        height: mHeight * .01,

                                        decoration: BoxDecoration(
                                            color: selectedAccountID == accountListShown[index].id ? Color(0xff2BAAFC) : Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(color: Color(0xffD6E0F6))),
                                        child: Row(

                                          children: [
                                            SizedBox(
                                              width: mWidth * .03,
                                            ),
                                              SizedBox(
                                              width: mWidth * .03,
                                            ),
                                            Expanded(
                                              child: Text(
                                                accountListShown[index].account_name,
                                                style: customisedStyle(
                                                    context,
                                                    selectedAccountID == accountListShown[index].id ? Colors.white : Colors.black,
                                                    FontWeight.normal,
                                                    14.0),
                                              ),
                                            ),
                                            SizedBox(
                                              width: mWidth * .06,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 10000, minHeight: 0),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 40,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: mHeight * .01,

                                          decoration: BoxDecoration(
                                              color: Color(0xff2BAAFC),
                                              borderRadius: BorderRadius.circular(30),
                                              border: Border.all(color: Color(0xffD6E0F6))),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Text(
                                                  widget.contactName!,
                                                  style: customisedStyle(context, Colors.white, FontWeight.normal, 13.0),
                                                ),
                                              ),
                                              SizedBox(
                                                width: mWidth * .05,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                      :

                      /// tab 2
                      accountType.value == 1
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 15),
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: accountListShown.length > 4 ? 4 : accountListShown.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 40,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {

                                        setState(() {
                                          selectedAccountID = accountListShown[index].id;
                                          selectedAccountName = accountListShown[index].account_name;
                                        });
                                      },
                                      child: Container(
                                        height: mHeight * .01,

                                        decoration: BoxDecoration(
                                            color: selectedAccountID == accountListShown[index].id ? Color(0xff2BAAFC) : Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(color: Color(0xffD6E0F6))),
                                        child: Row(

                                          children: [
                                            SizedBox(
                                              width: mWidth * .03,
                                            ),
                                               SizedBox(
                                              width: mWidth * .03,
                                            ),
                                            Expanded(
                                              child: Text(
                                                accountListShown[index].account_name,
                                                style: customisedStyle(
                                                    context,
                                                    selectedAccountID == accountListShown[index].id ? Colors.white : Colors.black,
                                                    FontWeight.normal,
                                                    14.0),
                                              ),
                                            ),
                                            SizedBox(
                                              width: mWidth * .06,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 10000, minHeight: 0),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 40,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: mHeight * .01,

                                          decoration: BoxDecoration(
                                              color: Color(0xff2BAAFC),
                                              borderRadius: BorderRadius.circular(30),
                                              border: Border.all(color: Color(0xffD6E0F6))),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Text(
                                                  widget.contactName!,
                                                  style: customisedStyle(context, Colors.white, FontWeight.normal, 13.0),
                                                ),
                                              ),
                                              SizedBox(
                                                width: mWidth * .05,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: buttons.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,

                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {

                          if (index == 14) {
                            return RoundCustomButton(
                                padding: 17,
                                buttonTapped: () {

                                  Vibration.vibrate(duration: 15);
                                  setState(() {
                                    userInput = userInput.substring(0, userInput.length - 1);
                                    equalPressed();
                                  });
                                },
                                buttonText: buttons[index],
                                textColor: Colors.red);
                          } else {
                            return RoundCustomButton(
                                padding: 17,
                                buttonTapped: () {
                                  Vibration.vibrate(duration: 15);

                                  var currentValue = appendValue(userInput, buttons[index]);
                                  userInput = currentValue;
                                  equalPressed();
                                  setState(() {});
                                },
                                buttonText: buttons[index],
                                textColor: isOperator(buttons[index]) ? Colors.red : Colors.blueGrey);
                          }
                        }),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 15),
                          child: ValueListenableBuilder(
                              valueListenable: dateNotifier,
                              builder: (BuildContext ctx, fromDateNewValue, _) {
                                return GestureDetector(
                                  onTap: () {
                                    showDatePickerFunction(context, dateNotifier);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: mHeight * .04,
                                    width: mWidth * .35,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: Color(0xffD6E0F6))),
                                    child: Text(
                                      dateFormat.format(fromDateNewValue),
                                      style: customisedStyle(context, Colors.black, FontWeight.normal, 14.0),
                                    ),
                                  ),
                                );
                              }),
                        ),

                        Table(
                            defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width / 2),
                            border: TableBorder.all(color: Color(0xffE9E9E9), style: BorderStyle.solid, width: 1),
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  GestureDetector(

                                    onTap: () {
                                      btmSheetFunction(context);
                                    },
                                    child: Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        height: mHeight / 18,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/menu/note-edit-line.svg",
                                            ),
                                            SizedBox(
                                              width: mWidth * .02,
                                            ),
                                            Text(
                                              'Notes',
                                              style: customisedStyle(context, Colors.black, FontWeight.normal, 15.0),
                                            )
                                          ],
                                        )),
                                  )
                                ]),
                                Column(children: [
                                  ValueListenableBuilder(
                                      valueListenable: SetReminderDateNotifier,
                                      builder: (BuildContext ctx, setDateNewValue, _) {
                                        return GestureDetector(
                                          onTap: () {
                                            setReminderDatePicker(context, SetReminderDateNotifier);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: mHeight / 18,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: mWidth * .04,
                                                ),
                                                SvgPicture.asset(
                                                  "assets/menu/time.svg",
                                                ),
                                                SizedBox(
                                                  width: mWidth * .02,
                                                ),
                                                Text(
                                                  isReminderSet == false?   'Set Reminder':dateFormat.format(setDateNewValue),
                                                  style: customisedStyle(context, Colors.black, FontWeight.normal, 15.0),
                                                ),
                                                isReminderSet == true? IconButton(onPressed: (){
                                                  setState(() {
                                                    isReminderSet = false;
                                                    SetReminderDateNotifier = ValueNotifier(DateTime.now());


                                                  });
                                                }, icon: Icon(Icons.close)): SizedBox()
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                ]),
                              ]),
                            ]),
                      ],
                    ),
                  ),
                ],
              )),
              Divider(
                color: Color(0xffE2E2E2),
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset(
                          "assets/svg/cancel_icon.svg",
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedAccountName,
                        style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          var fromID;
                          var toID;

                          if (tabController.index == 0) {
                            if (accountType.value == 0) {
                              fromID = selectedAccountID;
                              toID = widget.contactID;
                            } else {
                              toID = selectedAccountID;
                              fromID = widget.contactID;
                            }
                          } else {
                            if (accountType.value == 0) {
                              fromID = selectedAccountID;
                              toID = widget.contactID;
                            } else {
                              toID = selectedAccountID;
                              fromID = widget.contactID;
                            }
                          }

                          var amount = double.parse(finalAmount);
                          if (amount > 0.0) {
                            if (fromID == "" || toID == "") {
                              msgBtmDialogueFunction(context: context, textMsg: "Select account details");
                            } else {
                              ContactTransactionFunction(fromID: fromID, toID: toID, type: fromID ==
                                  widget.contactID ? 0 : 1, isReminder: isReminderSet, date: apiDateFormat.format(SetReminderDateNotifier.value));
                            }
                          } else {
                            msgBtmDialogueFunction(context: context, textMsg: "Amount greater than zero");
                          }
                        },
                        icon: SvgPicture.asset(
                          "assets/svg/save_icon.svg",
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  findType() {


    var fromID;
    var toID;

    if (tabController.index == 0) {
      if (accountType.value == 0) {
        fromID = selectedAccountID;
        toID = widget.contactID;
      } else {
        toID = selectedAccountID;
        fromID = widget.contactID;
      }
    } else {
      if (accountType.value == 0) {
        fromID = selectedAccountID;
        toID = widget.contactID;
      } else {
        toID = selectedAccountID;
        fromID = widget.contactID;
      }
    }

  }

  final List<String> operators = ['.', '+', '-', '×', '/'];

  bool isOperator(String x) {
    if (x == '/' || x == '×' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  bool isLastCharacterValid(String input) {
    if (input.isEmpty) {
      return false;
    }

    String lastCharacter = input[input.length - 1];


    List<String> validCharacters = ['.', '+', '-', '×', '/'];

    var val = validCharacters.contains(lastCharacter);
    return val;
  }

  bool isOperators(String value) {
    return operators.contains(value);
  }

  String appendValue(String currentValue, String newValue) {
    if (currentValue.isEmpty) {

      if (!isOperators(newValue)) {
        return currentValue + newValue;
      }
      return "";
    } else if (isOperators(currentValue[currentValue.length - 1])) {
      if (!isOperators(newValue)) {
        print("_________yy__________${!isOperators(newValue)}");
        return currentValue + newValue;
      }
    } else {
      return currentValue + newValue;
    }
    return currentValue;
  }

  equalPressed() {
    try {

      bool isValid = isLastCharacterValid(userInput);

      if (isValid) {
      } else {
        String finalUserInput = userInput;
        finalUserInput = userInput.replaceAll('×', '*');
        Parser p = Parser();

        Expression exp = p.parse(finalUserInput);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        finalAmount = eval.toString();
      }
    } catch (e) {
      return finalAmount = '0.00';
    }
  }

  btmSheetFunction(context) {
    final formKey = GlobalKey<FormState>();
    final mWidth = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[


                  Container(
                    margin: EdgeInsets.all(17),
                    height: MediaQuery.of(context).size.height / 6,
                    color: Color(0xffF3F7FC),
                    child: TextFormField(
                        style: customisedStyle(context, Color(0xff13213A), FontWeight.normal, 14.0),
                        maxLines: null,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Value  ';
                          }
                          return null;
                        },
                        controller: notesController,
                        textAlign: TextAlign.start,
                        readOnly: false,
                        textInputAction: TextInputAction.newline,
                        textCapitalization: TextCapitalization.words,
                        obscureText: false,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF3F7FC),
                          filled: true,
                          hintStyle: customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 15.0),
                          contentPadding: EdgeInsets.all(7),
                          hintText: "Add a note here..",
                          border: InputBorder.none,
                        )),
                  ),

                  Divider(
                    color: Color(0xffE2E2E2),
                    thickness: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xffE31919),
                            radius: 20.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.close, color: Color(0xffE31919)),
                              radius: 18.0,
                            ),
                          ),
                        ),
                        Text(
                          'Note',
                          style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xff087A04),
                            radius: 20.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.done, color: Color(0xff087A04)),
                              radius: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  /// api function
  ContactTransactionFunction({required fromID, required toID, required type,required bool isReminder,required String date}) async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      showProgressBar();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String baseUrl = ApiClient.basePath;
        var accessToken = prefs.getString('token') ?? '';
        final organizationId = prefs.getString("organisation");
        final country_id = prefs.getString("country_id");
        var uri = "finance/create-finance/";
        if (widget.type == "Edit") {
          uri = "finance/update-finance/";
        }
        final url = baseUrl + uri;

        String inputDateTime = "${DateTime.now()}";
        DateTime dateTime = DateTime.parse(inputDateTime);
        String formattedTime = DateFormat('HH:mm').format(dateTime);


        Map data = {
          "id": widget.id,
          "organization": organizationId,
          "is_interest": false,
          "is_zakath": false,
          "date": apiDateFormat.format(dateNotifier.value),
          "time": "$formattedTime",
          "from_account": fromID,
          "to_account": toID,
          "amount": roundStringWithOnlyDigit(finalAmount),
          "description": notesController.text,
          "finance_type": type,
          "is_reminder":isReminder,
          "reminder_date": date,
          "reminder_uid": widget.reminderID,
          "country_id": country_id,
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

        if (statusCode == 6000) {
          hideProgressBar();
          Navigator.pop(context, true);
        } else {
          hideProgressBar();
        }
      } catch (e) {
        print(e.toString());
        hideProgressBar();
        print(e.toString());
      }
    } else {
      hideProgressBar();
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }
}

class RoundCustomButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
  double padding = 17;

  RoundCustomButton({Key? key, this.color, this.textColor, required this.buttonText, this.buttonTapped, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: NeuContainer(
          borderRadius: BorderRadius.circular(17),
          padding: EdgeInsets.all(0),
          child: Container(

            child: Center(
                child: Text(
              buttonText,
              style: TextStyle(color: Colors.black, fontSize: 30),
            )),
          ),
        ),
      ),
    );
  }
}

class NeuContainer extends StatefulWidget {
  final Widget? child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  NeuContainer({this.child, this.borderRadius, this.padding});

  @override
  _NeuContainerState createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(color: Colors.white, borderRadius: widget.borderRadius, border: Border.all(color: Color(0xffD6E0F6))),
        child: widget.child,
      ),
    );
  }
}

List<AccountListModel> searchAccountListShown = [];
List<AccountListModel> accountListShown = [];
List<AccountListModel> accountList = [];

class AccountListModel {
  int accounts_id;
  final String id, account_name, opening_balance, amount, account_type;

  AccountListModel({
    required this.id,
    required this.account_name,
    required this.accounts_id,
    required this.opening_balance,
    required this.account_type,
    required this.amount,
  });

  factory AccountListModel.fromJson(Map<dynamic, dynamic> json) {
    return new AccountListModel(
      id: json['id'],
      account_name: json['account_name'],
      accounts_id: json['accounts_id'],
      opening_balance: json['opening_balance'].toString(),
      account_type: json['account_type'].toString(),
      amount: json['amount'].toString(),
    );
  }
}
