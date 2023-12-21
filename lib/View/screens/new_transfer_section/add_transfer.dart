import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'package:http/http.dart' as http;
import '../../../Api Helper/Repository/api_client.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/date_picker_function.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../../../Utilities/global/variables.dart';
import 'select_country.dart';

class AddTransferTransaction extends StatefulWidget {
  final String type;
  bool? isZakah;
  String? date;
  String? balance;
  String? from_account_id;
  String? from_country_id;
  String? from_accountName;
  String? to_country_Name;
  String? from_country_Name;
  String? to_account_id;
  String? to_country_id;
  String? to_accountName;
  String? transactionType;
  String? fromAmount;
  String? toAmount;
  String? description;
  String? id;

  AddTransferTransaction({
    super.key,
    required this.type,
    required this.isZakah,
    required this.date,
    required this.from_account_id,
    required this.from_accountName,
    required this.to_account_id,
    required this.to_accountName,
    required this.fromAmount,
    required this.balance,
    required this.description,
    required this.from_country_id,
    required this.to_country_Name,
    required this.from_country_Name,
    required this.transactionType,
    required this.toAmount,
    required this.to_country_id,
    required this.id,
  });

  @override
  State<AddTransferTransaction> createState() => _AddTransferTransactionState();
}

class _AddTransferTransactionState extends State<AddTransferTransaction> with SingleTickerProviderStateMixin {
  var userInputFrom = '';
  var finalAmountFrom = '0.00';

  var userInputTo = '';
  var finalAmountTo = '0.00';

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  TextEditingController notesController = TextEditingController();
  String selectedFromCountryID = "";
  String selectedFromCountryCurrency = "";
  String selectedToCountryCurrency = "";
  String selectedToCountryID = "";
  String selectedFromAccountID = "";
  String selectedToAccountID = "";

  String selectedFromAccountName = "";
  String selectedFromCountryName = "";
  String selectedToAccountName = "";
  String selectedToCountryName = "";

  ValueNotifier<bool> markAsZakha = ValueNotifier(false);
  DateFormat apiDateFormat = DateFormat("y-M-d");
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
  ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime.now());
  TextEditingController searchController = TextEditingController();

  bool zakath = false;
  bool isIntrest = false;
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

  returnAccountListFrom() async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      zakath = prefs.getBool("is_zakath") ?? false;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';
      showProgressBar();
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 30,
        "search": "",
        "country": selectedFromCountryID,
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
          searchAccountListShownFrom = [];
          accountListShownFrom = [];
          accountListFrom = [];

          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountListFrom.add(account);
            accountListShownFrom.add(account);
            searchAccountListShownFrom.add(account);
          }

          print("______________________________$selectedFromAccountName");
          print("_______widget.type_______________________${widget.type}");
          print("_______widget.transactionType_______________________${widget.transactionType}");
          print("_______widget.from_accountName_______________________${widget.from_accountName}");

          if (accountListShownFrom.isNotEmpty) {
            if (widget.type == "Create") {

              if(widget.transactionType == "1"){
                selectedFromAccountID = widget.from_account_id!;
                selectedFromAccountName= widget.from_accountName!;
              }

              else{

                selectedFromAccountID = accountListShownFrom[0].id;
                selectedFromAccountName = accountListShownFrom[0].account_name;;
              }

            }

            print("______________$selectedFromAccountID ________________$selectedFromAccountName");


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


          } else {
            selectedFromAccountID = "";
            selectedFromAccountName = "";
          }
        });
      } else {
        hideProgressBar();
        setState(() {
          searchAccountListShownFrom = [];
          accountListShownFrom = [];
          accountListFrom = [];
        });
      }
    } catch (e) {
      hideProgressBar();
      print(e.toString());
    }
  }
  accountListChangeFrom() async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      zakath = prefs.getBool("is_zakath") ?? false;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';
      showProgressBar();
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 30,
        "search": "",
        "country": selectedFromCountryID,
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
          searchAccountListShownFrom = [];
          accountListShownFrom = [];
          accountListFrom = [];

          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountListFrom.add(account);
            accountListShownFrom.add(account);
            searchAccountListShownFrom.add(account);
          }



          if (accountListShownFrom.isNotEmpty) {
            selectedFromAccountID = accountListShownFrom[0].id;
            selectedFromAccountName = accountListShownFrom[0].account_name;;


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


          } else {
            selectedFromAccountID = "";
            selectedFromAccountName = "";
          }
        });
      } else {
        hideProgressBar();
        setState(() {
          searchAccountListShownFrom = [];
          accountListShownFrom = [];
          accountListFrom = [];
        });
      }
    } catch (e) {
      hideProgressBar();
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
        "country": selectedToCountryID,
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
        searchAccountListShownTo = [];
        accountListShownTo = [];
        accountListTo = [];
        setState(() {
          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountListTo.add(account);
            accountListShownTo.add(account);
            searchAccountListShownTo.add(account);
          }

          if (accountListShownTo.isNotEmpty) {
            if (widget.type == "Edit") {
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
              setState(() {});
            } else {
              selectedToAccountID = accountListShownTo[0].id;
              selectedToAccountName = accountListShownTo[0].account_name;
            }
          } else {
            selectedToAccountID = "";
            selectedToAccountName = "";
          }
        });
      } else {
        setState(() {
          searchAccountListShownTo = [];
          accountListShownTo = [];
          accountListTo = [];
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  accountListChangeTo() async {
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
        "country": selectedToCountryID,
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
        searchAccountListShownTo = [];
        accountListShownTo = [];
        accountListTo = [];
        setState(() {
          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountListTo.add(account);
            accountListShownTo.add(account);
            searchAccountListShownTo.add(account);
          }

          if (accountListShownTo.isNotEmpty) {

            selectedToAccountID = accountListShownTo[0].id;
            selectedToAccountName = accountListShownTo[0].account_name;

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
              setState(() {});

          } else {
            selectedToAccountID = "";
            selectedToAccountName = "";
          }
        });
      } else {
        setState(() {
          searchAccountListShownTo = [];
          accountListShownTo = [];
          accountListTo = [];
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


      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 20,
        "search": searchData,
        "country": tabController.index == 0 ? selectedFromCountryID : selectedToCountryID,
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

        if (tabController.index == 0) {
          searchAccountListShownFrom.clear();
          setStater(() {
            for (Map user in responseJson) {
              searchAccountListShownFrom.add(AccountListModel.fromJson(user));
            }
          });
        } else {
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
                            itemCount: tabController.index == 0 ? searchAccountListShownFrom.length : searchAccountListShownTo.length,
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
                                  if (tabController.index == 0) {
                                    AccountListModel newItem = AccountListModel(
                                      id: searchAccountListShownFrom[index].id,
                                      account_name: searchAccountListShownFrom[index].account_name,
                                      accounts_id: searchAccountListShownFrom[index].accounts_id,
                                      opening_balance: '0.00',
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
                                  } else {
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
                                      color: tabController.index == 0
                                          ? selectedCardAccount == searchAccountListShownFrom[index].id
                                              ? Color(0xff2BAAFC)
                                              : Colors.white
                                          : selectedCardAccount == searchAccountListShownTo[index].id
                                              ? Color(0xff2BAAFC)
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffD6E0F6))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                       Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          tabController.index == 0
                                              ? searchAccountListShownFrom[index].account_name
                                              : searchAccountListShownTo[index].account_name,
                                          style: customisedStyle(
                                              context,
                                              tabController.index == 0
                                                  ? selectedCardAccount == searchAccountListShownFrom[index].id
                                                      ? Colors.white
                                                      : Colors.black
                                                  : selectedCardAccount == searchAccountListShownTo[index].id
                                                      ? Colors.white
                                                      : Colors.black,
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
                    Container(
                      child: Center(
                        child: Text(
                          'Accounts',
                          style: customisedStyle(context, Colors.black, FontWeight.normal, 15.0),
                        ),
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
    if (tabController.index == 0) {
      return accountListShownFrom.any((item) => item.id == id);
    } else {
      return accountListShownTo.any((item) => item.id == id);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressBar = ProgressBar();

    searchAccountListShownFrom = [];
    accountListShownFrom = [];
    accountListFrom = [];
    searchAccountListShownTo = [];
    accountListShownTo = [];
    accountListTo = [];
    selectedFromCountryID = default_country_id;
    selectedToCountryID = default_country_id;
    selectedToCountryName = default_country_name;
    selectedFromCountryName = default_country_name;

    tabController = TabController(length: 2, vsync: this);

    if (widget.type == "Edit") {
      dateNotifier = ValueNotifier(DateTime.parse(widget.date!));
      selectedToAccountName = widget.to_accountName!;
      notesController.text = widget.description!;
      markAsZakha = ValueNotifier(widget.isZakah!);
      finalAmountFrom = widget.fromAmount!;
      finalAmountTo = widget.toAmount!;
      selectedFromAccountName = widget.from_accountName!;
      selectedFromAccountID = widget.from_account_id!;
      selectedToAccountID = widget.to_account_id!;
      selectedFromCountryID = widget.from_country_id!;
      selectedToCountryID = widget.to_country_id!;
      selectedToCountryName = widget.to_country_Name!;
      selectedFromCountryName = widget.from_country_Name!;
    } else {
      selectedFromAccountName = widget.from_accountName!;
      selectedFromAccountID = widget.from_account_id!;

      dateNotifier = ValueNotifier(DateTime.now());
      notesController.text = "";
      markAsZakha = ValueNotifier(widget.isZakah!);
      finalAmountFrom = "0.00";
    }

    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await returnAccountListFrom();
        await returnAccountListTo();
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
                          tabController.index == 0 ? userInputFrom : userInputTo,
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
                              roundStringWith(tabController.index == 0 ? finalAmountFrom : finalAmountTo),
                              style: const TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              " "+ getCurrencySymbolByCountryName(tabController.index == 0 ? selectedFromAccountName : selectedToCountryName)!,
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
                                    width: 4.0,
                                  ),
                                ),
                              ),
                            )),
                        IconButton(
                            onPressed: () {
                              accountBtmSheet(context, tabController.index == 0 ? selectedFromAccountID : selectedToAccountID);
                            },
                            icon: SvgPicture.asset(
                              "assets/menu/search-normal.svg",
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectCountryTransfer()));

                              if (result != null) {
                                if (tabController.index == 0) {
                                  selectedFromCountryID = result[1];
                                  selectedFromCountryName = result[0];
                                  accountListChangeFrom();
                                } else {
                                  selectedToCountryID = result[1];
                                  selectedToCountryName = result[0];
                                  accountListChangeTo();
                                }
                              }

                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: mHeight * .04,
                            decoration: BoxDecoration(
                              color: Color(0XFFE4EAF0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: mWidth * .24,
                                  child: Text(
                                    tabController.index == 0 ? selectedFromCountryName : selectedToCountryName,
                                    overflow: TextOverflow.ellipsis,
                                    style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 13.0),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  tabController.index == 0
                      ? accountListShownFrom.isNotEmpty
                          ? Padding(
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
                                          selectedFromAccountName = accountListShownFrom[index].account_name;
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
                                                style: customisedStyle(
                                                    context,
                                                    selectedFromAccountID == accountListShownFrom[index].id ? Colors.white : Colors.black,
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
                              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 18),
                              child: Container(
                                child: Center(child: Text("No Items", style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))),
                              ),
                            )
                      : accountListShownTo.isNotEmpty
                          ? Padding(
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
                                          selectedToAccountName = accountListShownTo[index].account_name;
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
                                                style: customisedStyle(
                                                    context,
                                                    selectedToAccountID == accountListShownTo[index].id ? Colors.white : Colors.black,
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
                              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 18),
                              child: Container(
                                child: Center(child: Text("No Items", style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))),
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
                                    if (tabController.index == 0) {
                                      if (userInputFrom.isNotEmpty) {
                                        userInputFrom = userInputFrom.substring(0, userInputFrom.length - 1);

                                        if (selectedToCountryID == selectedFromCountryID) {
                                          userInputTo = userInputTo.substring(0, userInputTo.length - 1);
                                        }
                                      }
                                    } else {
                                      if (userInputTo.isNotEmpty) {
                                        userInputTo = userInputTo.substring(0, userInputTo.length - 1);

                                        if (selectedToCountryID == selectedFromCountryID) {
                                          userInputFrom = userInputFrom.substring(0, userInputFrom.length - 1);
                                        }
                                      }
                                    }

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

                                  if (tabController.index == 0) {
                                    var currentValue = appendValue(userInputFrom, buttons[index]);
                                    userInputFrom = currentValue;

                                    if (selectedToCountryID == selectedFromCountryID) {
                                      var currentValue = appendValue(userInputTo, buttons[index]);
                                      userInputTo = currentValue;
                                    }
                                  } else {
                                    var currentValue = appendValue(userInputTo, buttons[index]);
                                    userInputTo = currentValue;

                                    if (selectedToCountryID == selectedFromCountryID) {
                                      var currentValue = appendValue(userInputFrom, buttons[index]);
                                      userInputFrom = currentValue;
                                    }
                                  }

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

                        if (zakath == true)
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
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ValueListenableBuilder(
                                            valueListenable: markAsZakha,
                                            builder: (BuildContext context, bool newCheckValue, _) {
                                              return Container(
                                                  height: mHeight / 20,
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
                                                        markAsZakha.value = !markAsZakha.value;
                                                      }));
                                            }),
                                        SizedBox(
                                          width: mWidth * .02,
                                        ),
                                        Text(
                                          "Mark as Zakah",
                                          style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 14.0),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ]),
                              ]),
                        if (zakath == false)
                          Column(
                            children: [
                              Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                              GestureDetector(
                                onTap: () {
                                  btmSheetFunction(context);
                                },
                                child: Container(
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
                              ),
                            ],
                          )
                      ],
                    ),
                  )
                ],
              )),
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
                    width: mWidth * .6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          width: mWidth * .25,
                          child: Text(
                            selectedFromAccountName,
                            overflow: TextOverflow.ellipsis,
                            style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            height: 15,
                            "assets/svg/arrow_right.svg",
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: mWidth * .25,
                          child: Text(
                            selectedToAccountName,
                            overflow: TextOverflow.ellipsis,
                            style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          var fromAmount = double.parse(finalAmountFrom);
                          var toAmount = double.parse(finalAmountTo);
                          if (fromAmount > 0.0 && toAmount > 0.0) {
                            if (selectedFromAccountID == "" || selectedToAccountID == "") {
                              msgBtmDialogueFunction(context: context, textMsg: "Select account details");
                            } else {
                              if (selectedFromAccountID == selectedToAccountID) {
                                msgBtmDialogueFunction(context: context, textMsg: "You're trying to transfer the same account");
                              } else {
                                createTransferApi();
                              }
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

      bool isValid = isLastCharacterValid(tabController.index == 0 ? userInputFrom : userInputTo);

      if (isValid) {
      } else {
        if (tabController.index == 0) {
          String finalUserInput = userInputFrom;
          finalUserInput = userInputFrom.replaceAll('×', '*');
          Parser p = Parser();
          Expression exp = p.parse(finalUserInput);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          finalAmountFrom = eval.toString();
          if (selectedToCountryID == selectedFromCountryID) {
            finalAmountTo = eval.toString();
          }
        } else {
          String finalUserInput = userInputTo;
          finalUserInput = userInputTo.replaceAll('×', '*');
          Parser p = Parser();
          Expression exp = p.parse(finalUserInput);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          finalAmountTo = eval.toString();
          if (selectedToCountryID == selectedFromCountryID) {
            finalAmountFrom = eval.toString();
          }
        }
      }
    } catch (e) {
      if (tabController.index == 0) {
        return finalAmountFrom = '0.00';
      } else {
        return finalAmountTo = '0.00';
      }
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


  createTransferApi() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      showProgressBar();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String baseUrl = ApiClient.basePath;
        var accessToken = prefs.getString('token') ?? '';
        final organizationId = prefs.getString("organisation");

        var uri = "transfer/create-transfer/";
        if (widget.type == "Edit") {
          uri = "transfer/update-transfer/";
        }
        final url = baseUrl + uri;

        String inputDateTime = "${DateTime.now()}";
        DateTime dateTime = DateTime.parse(inputDateTime);
        String formattedTime = DateFormat('HH:mm').format(dateTime);

        Map data = {
          "id": widget.id,
          "organization": organizationId,
          "date": apiDateFormat.format(dateNotifier.value),
          "time": "$formattedTime",
          "from_account": selectedFromAccountID,
          "to_account": selectedToAccountID,
          "description": notesController.text,
          "from_country": selectedFromCountryID,
          "from_amount": roundStringWithOnlyDigit(finalAmountFrom),
          "to_country": selectedToCountryID,
          "to_amount": roundStringWithOnlyDigit(finalAmountTo),
          "is_zakath": markAsZakha.value,
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
  String? getCurrencySymbolByCountryName(String targetCountryName) {

   var countryData = [
    {
    "country_code": "INR",
    "country_name": "India",
    "currency_name": "Rupees",
    "currency_simbol": "RS"
    },
    {
    "country_code": "OM",
    "country_name": "Oman",
    "currency_name": "Omani Rial",
    "currency_simbol": "OMR"
    },
    {
    "country_code": "AE",
    "country_name": "United Arab Emirates",
    "currency_name": "UAE Dirham",
    "currency_simbol": "AED"
    },
    {
    "country_code": "BH",
    "country_name": "Bahrain",
    "currency_name": "Bahraini Dinar",
    "currency_simbol": "BHD"
    },
    {
    "country_code": "SA",
    "country_name": "Saudi Arabia",
    "currency_name": "Saudi Riyal",
    "currency_simbol": "SAR"
    },
    {
    "country_code": "QA",
    "country_name": "Qatar",
    "currency_name": "Qatari Riyal",
    "currency_simbol": "QAR"
    },
    {
    "country_code": "KW",
    "country_name": "Kuwait",
    "currency_name": "Kuwaiti Dinar",
    "currency_simbol": "KWD"
    }
    ];
    for (var country in countryData) {
      if (country['country_name'] == targetCountryName) {
        return country['currency_simbol'];
      }
    }
    return countryCurrencyCode;
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
