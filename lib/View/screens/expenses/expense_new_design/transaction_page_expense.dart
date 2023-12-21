import 'dart:convert';

import 'package:cuentaguestor_edit/Utilities/global/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class TransactionPageExpense extends StatefulWidget {

  final String type;
  bool? isInterest;
  bool? zakath;
  String? date;
  String? balance;
  String? from_account_id;
  String? from_accountName;
  String? to_account_id;
  String? to_accountName;
  String? amount;
  String? description;
  String? id;
  String? transactionType;
  int? assetMasterID;
  bool? isDetail,isAsset,fromAccounts;
  final bool isReminder;
  final  String isReminderDate;
  String? reminderID;

  final bool isFromNotification;


  TransactionPageExpense(
      {super.key,
        required this.isReminder,
        required this.isReminderDate,
        required this.type,
        this.isInterest,
        required this.isDetail,
        required this.transactionType,
        required this.reminderID,
        required this.isFromNotification,
        required this.zakath,
        this.date,
        this.fromAccounts,
        this.from_account_id,
        this.from_accountName,
        required  this.to_account_id,
        required  this.assetMasterID,
        required  this.to_accountName,
        required  this.amount,
        required this.balance,
        required this.isAsset,
        this.description,
        this.id, });

  @override
  State<TransactionPageExpense> createState() => _TransactionPageExpenseState();
}

class _TransactionPageExpenseState extends State<TransactionPageExpense> with SingleTickerProviderStateMixin {
  var userInput = '';
  var finalAmount ;  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  String selectedFromAccountID = "";
  String selectedToAccountID = "";
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

  String selectedFromAccountName = "";
  String selectedToAccountName = "";
  ValueNotifier<bool> markAsInterest = ValueNotifier(false);
  ValueNotifier<bool> markAsZakah = ValueNotifier(false);
  late TabController tabController;

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
  ValueNotifier<DateTime> fromDateNotifier = ValueNotifier(DateTime.now());
  TextEditingController searchController = TextEditingController();
  DateFormat apiDateFormat = DateFormat("y-M-d");
  TextEditingController notesController = TextEditingController();
  late ValueNotifier<DateTime> SetReminderDateNotifier ;

  bool zakath = false;
bool isIntrest = false;
  returnAccountListFrom() async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      zakath = prefs.getBool("is_zakath")??false;
      isIntrest = prefs.getBool("is_intrest")??false;
       var accessToken = prefs.getString('token') ?? '';
       final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';


      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 30,
        "search": "",
        "country": "",
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
        setState(() {
          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountListFrom.add(account);
            accountListShownFrom.add(account);
            searchAccountListShownFrom.add(account);
          }



          if (widget.type == "Create") {

            if(widget.transactionType == "1"){

                selectedFromAccountID = widget.from_account_id!;
                selectedFromAccountName= widget.from_accountName!;



            }
            else {
              selectedFromAccountID = accountListShownFrom[0].id;
              selectedFromAccountName= accountListShownFrom[0].account_name;
            }


          }



            int indexToDelete = accountListShownFrom.indexWhere((item) => item.id == selectedFromAccountID);

            AccountListModel newItem = AccountListModel(
              id: accountListShownFrom[indexToDelete].id,
              account_name: accountListShownFrom[indexToDelete].account_name,
              accounts_id: accountListShownFrom[indexToDelete].accounts_id,
              opening_balance: '0.00',
              account_type: accountListShownFrom[indexToDelete].account_type,
              amount: accountListShownFrom[indexToDelete].amount,
            );

            accountListShownFrom.removeAt(indexToDelete);
            accountListShownFrom.insert(0, newItem);



        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
  returnAccountListTo() async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';

      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 30,
        "search": "",
        "country": "",
        "account_type": [4]
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
        setState(() {
          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountListTo.add(account);
            accountListShownTo.add(account);
            searchAccountListShownTo.add(account);
          }


          if (widget.type == "Create") {
            if(widget.transactionType == "1"||widget.transactionType == "2"){
              selectedToAccountID = accountListShownTo[0].id;
              selectedToAccountName= accountListShownTo[0].account_name;
            }

          else{

            selectedToAccountID = widget.to_account_id!;
            selectedToAccountName=widget.to_accountName!;
            }
          }

           int indexToDelete = accountListShownTo.indexWhere((item) => item.id == selectedToAccountID);
            AccountListModel newItem = AccountListModel(
              id: accountListShownTo[indexToDelete].id,
              account_name: accountListShownTo[indexToDelete].account_name,
              accounts_id: accountListShownTo[indexToDelete].accounts_id,
              opening_balance: '0.00',
              account_type: accountListShownTo[indexToDelete].account_type,
              amount: accountListShownTo[indexToDelete].amount,
            );

            accountListShownTo.removeAt(indexToDelete);
            accountListShownTo.insert(0, newItem);

            setState(() {

            });

        });
      }
    } catch (e) {
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


      var type = [1,2];
      if(tabController.index !=0){
        type = [4];
      }
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 20,
        "search": searchData,
        "country": "",
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

        if(tabController.index ==0){
          searchAccountListShownFrom.clear();
          setStater(() {
            for (Map user in responseJson) {
              searchAccountListShownFrom.add(AccountListModel.fromJson(user));
            }
          });
        }
        else{
          searchAccountListShownTo.clear();
        setStater(() {
          for (Map user in responseJson) {
            searchAccountListShownTo.add(AccountListModel.fromJson(user));
          }
        });
        }

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
                            scrollDirection: Axis.vertical,
                         physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:tabController.index==0? searchAccountListShownFrom.length:searchAccountListShownTo.length,
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
                                  if(tabController.index==0){
                                    AccountListModel newItem = AccountListModel(
                                      id: searchAccountListShownFrom[index].id,
                                      account_name: searchAccountListShownFrom[index].account_name,
                                      accounts_id: searchAccountListShownFrom[index].accounts_id,
                                      opening_balance: searchAccountListShownFrom[index].id,
                                      account_type: searchAccountListShownFrom[index].account_type,
                                      amount: searchAccountListShownFrom[index].amount,
                                    );

                                    selectedFromAccountID = searchAccountListShownFrom[index].id;
                                    selectedFromAccountName = searchAccountListShownFrom[index].account_name;

                                    bool exists = isItemWithIdExists(searchAccountListShownFrom[index].id);
                                    if (exists) {
                                      int indexToDelete = accountListShownFrom.indexWhere((item) => item.id == searchAccountListShownFrom[index].id);
                                      accountListShownFrom.removeAt(indexToDelete);
                                    }
                                    accountListShownFrom.insert(0, newItem);

                                    searchAccountListShownFrom = accountListFrom;
                                  }
                                  else{
                                    AccountListModel newItem = AccountListModel(
                                      id: searchAccountListShownTo[index].id,
                                      account_name: searchAccountListShownTo[index].account_name,
                                      accounts_id: searchAccountListShownTo[index].accounts_id,
                                      opening_balance: searchAccountListShownTo[index].id,
                                      account_type: searchAccountListShownTo[index].account_type,
                                      amount: searchAccountListShownTo[index].amount,
                                    );

                                    selectedToAccountID = searchAccountListShownTo[index].id;
                                    selectedToAccountName = searchAccountListShownTo[index].account_name;

                                    bool exists = isItemWithIdExists(searchAccountListShownTo[index].id);
                                    if (exists) {
                                      int indexToDelete = accountListShownTo.indexWhere((item) => item.id == searchAccountListShownTo[index].id);
                                      accountListShownTo.removeAt(indexToDelete);
                                    }
                                    accountListShownTo.insert(0, newItem);
                                    searchAccountListShownTo = accountListTo;
                                  }

                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  height: mHeight * .01,

                                  decoration: BoxDecoration(
                                      color:tabController.index ==0? selectedCardAccount == searchAccountListShownFrom[index].id ? Color(0xff2BAAFC) : Colors.white:
                                      selectedCardAccount == searchAccountListShownTo[index].id ? Color(0xff2BAAFC) : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffD6E0F6))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          tabController.index ==0? searchAccountListShownFrom[index].account_name:searchAccountListShownTo[index].account_name,
                                          style: customisedStyle(
                                              context,
                                              tabController.index ==0?  selectedCardAccount == searchAccountListShownFrom[index].id ? Colors.white : Colors.black:
                                              selectedCardAccount == searchAccountListShownTo[index].id ? Colors.white : Colors.black,
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
    if(tabController.index ==0)
  {
    return accountListShownFrom.any((item) => item.id == id);
  }
   else{
      return accountListShownTo.any((item) => item.id == id);
    }
  }

  @override
  void initState() {
    super.initState();


    progressBar = ProgressBar();
    SetReminderDateNotifier = widget.type == "Edit"?ValueNotifier(DateTime.parse(widget.isReminderDate)) :ValueNotifier(DateTime.now());


    searchAccountListShownFrom = [];
    accountListShownFrom = [];
    accountListFrom = [];
    searchAccountListShownTo = [];
    accountListShownTo = [];
    accountListTo = [];

    tabController = TabController(length: 2, vsync: this);

    if (widget.type == "Edit") {
      SetReminderDateNotifier = widget.type == "Edit"?ValueNotifier(DateTime.parse(widget.isReminderDate)) :ValueNotifier(DateTime.now());

      isReminderSet = widget.isReminder;
      fromDateNotifier = ValueNotifier(DateTime.parse(widget.date!));
      selectedToAccountName = widget.to_accountName!;
      notesController.text = widget.description!;
      markAsInterest = ValueNotifier(widget.isInterest!);
      finalAmount = widget.amount!;
      selectedFromAccountName = widget.from_accountName!;
      selectedFromAccountID = widget.from_account_id!;
      selectedToAccountID = widget.to_account_id!;
      markAsZakah = ValueNotifier(widget.zakath!);
    } else {

      selectedToAccountID  = widget.to_account_id!;
      selectedToAccountName   = widget.to_accountName!;
      fromDateNotifier = ValueNotifier(DateTime.now());
      notesController.text = "";
      markAsInterest = ValueNotifier(widget.isInterest!);
      markAsZakah = ValueNotifier(widget.zakath!);
      finalAmount = "0.00";
    }

    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await returnAccountListFrom();
        await returnAccountListTo();
      });
    }

  }



  void handleTabTap(int index) {
    setState(() {

    });
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
                                " "+ countryCurrencyCode,
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
                                  onTap: handleTabTap,
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      color: Color(0xff2BAAFC),
                                      width: 4.0, // Set the thickness of the underline
                                    ),
                                  ),
                                ),
                              )),
                          IconButton(
                              onPressed: () {
                                accountBtmSheet(context, tabController.index ==0?selectedFromAccountID:selectedToAccountID);
                              },
                              icon: SvgPicture.asset(
                                "assets/menu/search-normal.svg",
                              )),
                        ],
                      ),
                    ),
                    tabController.index ==0?
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 15),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: accountListShownFrom.length > 4 ? 4 : accountListShownFrom.length,
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
                                  selectedFromAccountID = accountListShownFrom[index].id;
                                  selectedFromAccountName= accountListShownFrom[index].account_name;

                                });
                              },
                              child: Container(
                                height: mHeight * .01,

                                decoration: BoxDecoration(
                                    color: selectedFromAccountID == accountListShownFrom[index].id ? Color(0xff2BAAFC) : Colors.white,
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
                                        accountListShownFrom[index].account_name,
                                        style: customisedStyle(context,
                                            selectedFromAccountID == accountListShownFrom[index].id ? Colors.white : Colors.black, FontWeight.normal, 14.0),
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
                    ):
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 15),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: accountListShownTo.length > 4 ? 4 : accountListShownTo.length,
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
                                  selectedToAccountID = accountListShownTo[index].id;
                                  selectedToAccountName= accountListShownTo[index].account_name;
                                });
                              },
                              child: Container(
                                height: mHeight * .01,

                                decoration: BoxDecoration(
                                    color: selectedToAccountID == accountListShownTo[index].id ? Color(0xff2BAAFC) : Colors.white,
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
                                        accountListShownTo[index].account_name,
                                        style: customisedStyle(context,
                                            selectedToAccountID == accountListShownTo[index].id ? Colors.white : Colors.black, FontWeight.normal, 14.0),
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
                                    setState(() {

                                    });
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
                                valueListenable: fromDateNotifier,
                                builder: (BuildContext ctx, fromDateNewValue, _) {
                                  return GestureDetector(
                                    onTap: () {
                                      showDatePickerFunction(context, fromDateNotifier);
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
                          if(isIntrest == true && zakath == false)

                             Column(
                               children: [
                                 Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),

                                 Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            ValueListenableBuilder(
                            valueListenable: markAsInterest,
                            builder: (BuildContext context, bool newCheckValue, _) {
                            return Container(
                            height: mHeight/20,
                            width: mWidth * .06,
                            decoration: BoxDecoration(
                            color: newCheckValue == true ? const Color(0xff067834) : const Color(0xffE6E6E6),
                            shape: BoxShape.circle,
                            ),
                            child: Checkbox(
                            checkColor: const Color(0xffffffff),
                            activeColor: Colors.transparent,
                            fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                            value: newCheckValue,
                            onChanged: (value) {

                            if(value!){
                            markAsZakah.value = false;
                            }


                            markAsInterest.value = !markAsInterest.value;




                            }));
                            }),
                            SizedBox(
                            width: mWidth * .02,
                            ),
                            Text(
                            "Interest",
                            style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 14.0),
                            ),
                            ],
                            ),
                               ],
                             ),



                          if(    zakath == true && isIntrest == false)

      Column(
        children: [
          Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                  valueListenable: markAsZakah,
                  builder: (BuildContext context, bool newCheckValue, _) {
                    return Container(
                        height: mHeight/20,
                        width: mWidth * .06,
                        decoration: BoxDecoration(
                          color: newCheckValue == true ? const Color(0xff067834) : const Color(0xffE6E6E6),
                          shape: BoxShape.circle,
                        ),
                        child: Checkbox(
                            checkColor: const Color(0xffffffff),
                            activeColor: Colors.transparent,
                            fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                            value: newCheckValue,
                            onChanged: (value) {
                              if(value!){
                                markAsInterest.value = false;
                              }
                              markAsZakah.value = !markAsZakah.value;
                            }));
                  }),
              SizedBox(
                width: mWidth * .02,
              ),
              Text(
                "Zakah",
                style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 13.0),
              ),
            ],
          ),
        ],
      )
   , if(isIntrest == true &&     zakath == true )


                          Table(
                              defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width / 2),
                              border: TableBorder.all(color: Color(0xffE9E9E9), style: BorderStyle.solid, width: 1),
                              children: [
                                TableRow(
                                    children: [
                                     Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ValueListenableBuilder(
                                              valueListenable: markAsInterest,
                                              builder: (BuildContext context, bool newCheckValue, _) {
                                                return Container(
                                                    height: mHeight/20,
                                                    width: mWidth * .06,
                                                    decoration: BoxDecoration(
                                                      color: newCheckValue == true ? const Color(0xff067834) : const Color(0xffE6E6E6),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Checkbox(
                                                        checkColor: const Color(0xffffffff),
                                                        activeColor: Colors.transparent,
                                                        fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                                        value: newCheckValue,
                                                        onChanged: (value) {

                                                          if(value!){
                                                            markAsZakah.value = false;
                                                          }


                                                          markAsInterest.value = !markAsInterest.value;




                                                        }));
                                              }),
                                          SizedBox(
                                            width: mWidth * .02,
                                          ),
                                          Text(
                                            "Interest",
                                            style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 14.0),
                                          ),
                                        ],
                                      ),

                               Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ValueListenableBuilder(
                                              valueListenable: markAsZakah,
                                              builder: (BuildContext context, bool newCheckValue, _) {
                                                return Container(
                                                    height: mHeight/20,
                                                    width: mWidth * .06,
                                                    decoration: BoxDecoration(
                                                      color: newCheckValue == true ? const Color(0xff067834) : const Color(0xffE6E6E6),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Checkbox(
                                                        checkColor: const Color(0xffffffff),
                                                        activeColor: Colors.transparent,
                                                        fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                                        value: newCheckValue,
                                                        onChanged: (value) {
                                                          if(value!){
                                                            markAsInterest.value = false;
                                                          }
                                                          markAsZakah.value = !markAsZakah.value;
                                                        }));
                                              }),
                                          SizedBox(
                                            width: mWidth * .02,
                                          ),
                                          Text(
                                            "Zakah",
                                            style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 13.0),
                                          ),
                                        ],
                                      )
                                    ]),
                              ]),
                          if(isIntrest == false &&     zakath == false )
                            SizedBox(),





                          Table(
                              defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width / 2),
                              border: TableBorder.all(color: Color(0xffE9E9E9), style: BorderStyle.solid, width: 1),
                              children: [
                                TableRow(children: [
                                  Column(children: [
                                    GestureDetector(
                                      onTap: (){
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
                                        builder: (BuildContext ctx, dateNewValue, _) {
                                        return GestureDetector(
                                          onTap: (){

                                            if(widget.isFromNotification ==false){
                                              setReminderDatePicker(context, SetReminderDateNotifier);
                                            };

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
                                                  isReminderSet == false?   'Set Reminder':dateFormat.format(dateNewValue),
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
                                      }
                                    )
                                  ]),
                                ]),
                              ]),


                        ],
                      ),
                    )
                  ],
                ),
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
                  Container(
                    width: mWidth*.6,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          width: mWidth*.25,
                          child: Text(
                            selectedFromAccountName,
                            overflow: TextOverflow.ellipsis,
                            style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            height: 10,
                            "assets/svg/arrow_right.svg",
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: mWidth*.25,
                          child: Text(
                            selectedToAccountName,
                            overflow: TextOverflow.ellipsis,
                            style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {

                          var amount = double.parse(finalAmount);
                          if(amount > 0.0){

                            if(selectedFromAccountID ==""||selectedToAccountID ==""){
                              msgBtmDialogueFunction(context: context, textMsg: "Select account details");
                            }
                            else{
                              CreateExpenseTransaction(isReminder: isReminderSet, date: apiDateFormat.format(SetReminderDateNotifier.value));

                            }

                          }
                          else{
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


  btmSheetFunction(context) {

    final formKey = GlobalKey<FormState>();


    final mWidth = MediaQuery
        .of(context)
        .size
        .width;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape:

      const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        return  Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[



                  Container(
                    margin: EdgeInsets.all(17),
                    height: MediaQuery.of(context).size.height/6,
                    color:  Color(0xffF3F7FC),
                    child: TextFormField(


                        style: customisedStyle(context,  Color(0xff13213A), FontWeight.normal, 14.0),
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

                        decoration:  InputDecoration(
                          fillColor: Color(0xffF3F7FC),
                          filled: true,
                          hintStyle:customisedStyle(context, Color(0xff778EB8), FontWeight.normal,15.0) ,
                          contentPadding: EdgeInsets.all(7),
                          hintText: "Add a note here..",
                          border: InputBorder.none,

                        )),
                  ),

                  Divider(
                    color:
                    Color(0xffE2E2E2),
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
                            backgroundColor:
                            Color(
                                0xffE31919),
                            radius: 20.0,
                            child:
                            CircleAvatar(
                              backgroundColor:
                              Colors
                                  .white,
                              child: Icon(
                                  Icons.close,
                                  color: Color(
                                      0xffE31919)),
                              radius: 18.0,
                            ),
                          ),
                        ),
                        Text(
                          'Note',
                          style:
                          customisedStyle(
                              context,
                              Colors
                                  .black,
                              FontWeight
                                  .w500,
                              16.0),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },

                          child: CircleAvatar(
                            backgroundColor:
                            Color(
                                0xff087A04),
                            radius: 20.0,
                            child:
                            CircleAvatar(
                              backgroundColor:
                              Colors
                                  .white,
                              child: Icon(
                                  Icons.done,
                                  color: Color(
                                      0xff087A04)),
                              radius: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            )
        );

      },
    );

  }


  Notes(context) {
    final formKey = GlobalKey<FormState>();


    final mWidth = MediaQuery
        .of(context)
        .size
        .width;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape:

      const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        return  Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[


                  Padding(
                    padding:       EdgeInsets.only(left: mWidth*.06,right: mWidth*.06),

                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 300.0,
                        minHeight: 150.0,
                      ),

                      child: Container(
                        height: 250,
                        child: TextFormField(

                            style: customisedStyle(context,  Color(0xff13213A), FontWeight.normal, 14.0),

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Value  ';
                              }
                              return null;
                            },
                            controller: notesController,
                            textAlign: TextAlign.start,
                            readOnly: false,
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.words,
                            obscureText: false,

                            decoration:  InputDecoration(
                              fillColor: Color(0xffF3F7FC),
                              hintStyle:customisedStyle(context, Color(0xff778EB8), FontWeight.normal,15.0) ,
                              contentPadding: EdgeInsets.all(7),
                              hintText: "Notes",
                              border: InputBorder.none,

                            )),
                      ),
                    ),
                  ),

                  Divider(
                    color:
                    Color(0xffE2E2E2),
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
                            backgroundColor:
                            Color(
                                0xffE31919),
                            radius: 20.0,
                            child:
                            CircleAvatar(
                              backgroundColor:
                              Colors
                                  .white,
                              child: Icon(
                                  Icons.close,
                                  color: Color(
                                      0xffE31919)),
                              radius: 18.0,
                            ),
                          ),
                        ),
                        Text(
                          'Notes',
                          style:
                          customisedStyle(
                              context,
                              Colors
                                  .black,
                              FontWeight
                                  .w500,
                              16.0),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },

                          child: CircleAvatar(
                            backgroundColor:
                            Color(
                                0xff087A04),
                            radius: 20.0,
                            child:
                            CircleAvatar(
                              backgroundColor:
                              Colors
                                  .white,
                              child: Icon(
                                  Icons.done,
                                  color: Color(
                                      0xff087A04)),
                              radius: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            )
        );

      },
    );

  }



  CreateExpenseTransaction({required bool isReminder,required String date}) async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      showProgressBar();


      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String baseUrl = ApiClient.basePath;
        var accessToken = prefs.getString('token') ?? '';
        final organizationId = prefs.getString("organisation");

        var uri = "finance/create-finance/";
        if(widget.type =="Edit"){
          uri = "finance/update-finance/";
        }
        final url = baseUrl + uri;


        String inputDateTime = "${DateTime.now()}";
        DateTime dateTime = DateTime.parse(inputDateTime);
        String formattedTime = DateFormat('HH:mm').format(dateTime);



        Map data = {
          "id":widget.id,
          "organization": organizationId,
          "is_interest":markAsInterest.value,
          "is_zakath":markAsZakah.value,
          "date":apiDateFormat.format(fromDateNotifier.value),
          "time":"$formattedTime",
          "from_account": selectedFromAccountID,
          "to_account":selectedToAccountID,
          "amount":roundStringWithOnlyDigit(finalAmount),
          "description":notesController.text,
          "finance_type":1,
          "asset_master_id":widget.assetMasterID,
          "is_asset":widget.isAsset,
          "is_reminder":isReminder,
          "reminder_date": date,

          "reminder_uid": widget.reminderID,
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
          Navigator.pop(context,true);

        }
        else{
          hideProgressBar();
        }
      } catch (e) {
        print(e.toString());
        hideProgressBar();
        print(e.toString());
      }

    }
    else {

      hideProgressBar();
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

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

    String lastCharacter = input[input.length-1];


    List<String> validCharacters = ['.', '+', '-', '×', '/'];

   var val= validCharacters.contains(lastCharacter);
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

    }

    else  {
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

List<AccountListModel> searchAccountListShownFrom = [];
List<AccountListModel> accountListShownFrom = [];
List<AccountListModel> accountListFrom = [];



List<AccountListModel> searchAccountListShownTo = [];
List<AccountListModel> accountListShownTo = [];
List<AccountListModel> accountListTo = [];



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
