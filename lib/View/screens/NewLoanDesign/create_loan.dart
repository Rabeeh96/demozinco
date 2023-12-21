import 'dart:convert';

import 'package:cuentaguestor_edit/View/screens/NewLoanDesign/payment_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../../Utilities/global/custom_class.dart';
import '../../../Api Helper/ModelClasses/Loan/EditLoanModelClass.dart';
import '../../../Api Helper/ModelClasses/Loan/LoanCreateModelClass.dart';
import '../../../Api Helper/Repository/api_client.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/date_picker_function.dart';
import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import 'loan_api.dart';

class AddLoanPage extends StatefulWidget {
  String? loanName;
  String? loanType;
  String? amount;
  String? interest;
  String? date;
  String? organisation;
  String? duration;
  String? interestAmount;
  String? processingFee;
  String? loanAmount;
  String? downPayment;

  bool? isExisting;
  bool? isIncludeInEMI;
  bool? isPurchase;
  bool? isIncludingLoan;

  String? accountId;
  String? id;
  String? accountName;
  String? paymentDate;
  List? reminderList;
  bool? isEdit;

  AddLoanPage({
    super.key,
    this.loanName,
   required this.id,
    this.paymentDate,
    this.loanType,
    this.amount,
    this.interest,
    this.duration,
    this.processingFee,
    this.date,
    this.loanAmount,
    this.isIncludeInEMI,
    this.isPurchase,
    this.isIncludingLoan,
    this.isExisting,
    this.accountId,

    this.interestAmount,
    this.downPayment,
    this.organisation,
    this.accountName,
    this.isEdit,
    this.reminderList,
  });

  @override
  State<AddLoanPage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddLoanPage> {
  DateTime selectedDateAndTime = DateTime.now();
  TextEditingController loanNameController = TextEditingController();
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController interestPerController = TextEditingController();
  TextEditingController processingFeeController = TextEditingController();
  TextEditingController amountPaidController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();

  ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime> dueDateNotifier = ValueNotifier(DateTime.now());
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  ValueNotifier<bool> IsIncludeInLoan = ValueNotifier(false);
  ValueNotifier<bool> IsIncludeInEMI = ValueNotifier(false);
  ValueNotifier<bool> IsPurchase = ValueNotifier(false);
  ValueNotifier<bool> IsExistingLoan = ValueNotifier(false);
  bool isChange = false;


  List<AccountListModel> searchAccountListShownFrom = [];
  List<AccountListModel> accountListShownFrom = [];
  List<AccountListModel> accountListFrom = [];

  List<AccountListModel> searchAccountListShownExpense = [];
  List<AccountListModel> accountListShownExpense = [];
  List<AccountListModel> accountListExpense = [];

  String selectedAccountID = "";
  String selectedAccountName = "";


  String selectedAccountIDExpense = "";
  String selectedAccountNameExpense = "";



  TextEditingController searchController = TextEditingController();

  returnAccountListFrom(selectedID) async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';
      final country_id = prefs.getString("country_id");
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 30,
        "search": "",
        "country_id": country_id,
        "account_type": [1, 2]
      };
      print(data);
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

      print(data);
      print(accessToken);
      print(url);
      if (statusCode == 6000) {
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
            if (widget.isEdit == false) {
              selectedAccountID = accountListShownFrom[0].id;
              selectedAccountName = accountListShownFrom[0].account_name;
            } else {
              int indexToDelete = accountListShownFrom.indexWhere((item) => item.id == selectedID);
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
              setState(() {});
            }
          } else {
            selectedAccountID = "";
            selectedAccountName = "";
          }
        });
      } else {
        setState(() {
          searchAccountListShownFrom = [];
          accountListShownFrom = [];
          accountListFrom = [];
        });
      }
    } catch (e) {
      print("  ivdey  2  ${e.toString()}");
    }
  }
  returnAccountListExpense(selectedID) async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';
      final country_id = prefs.getString("country_id");
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 30,
        "search": "",
        "country_id": country_id,
        "account_type": [4]
      };
      print(data);
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

      print(data);
      print(accessToken);
      print(url);
      if (statusCode == 6000) {
        setState(() {
          searchAccountListShownExpense = [];
          accountListShownExpense = [];
          accountListExpense = [];

          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountListExpense.add(account);
            accountListShownExpense.add(account);
            searchAccountListShownExpense.add(account);
          }

          if (accountListShownExpense.isNotEmpty) {
            if (widget.isEdit == false) {
              selectedAccountIDExpense = accountListShownExpense[0].id;
              selectedAccountNameExpense = accountListShownExpense[0].account_name;
            } else {
              int indexToDelete = accountListShownExpense.indexWhere((item) => item.id == selectedID);
              AccountListModel newItem = AccountListModel(
                id: accountListShownExpense[indexToDelete].id,
                account_name: accountListShownExpense[indexToDelete].account_name,
                accounts_id: accountListShownExpense[indexToDelete].accounts_id,
                opening_balance: '0.00',
                account_type: accountListShownExpense[indexToDelete].account_type,
                amount: accountListShownExpense[indexToDelete].amount,
              );

              accountListShownExpense.removeAt(indexToDelete);
              accountListShownExpense.insert(0, newItem);
              setState(() {});
            }
          } else {
            selectedAccountIDExpense = "";
            selectedAccountNameExpense = "";
          }
        });
      } else {
        setState(() {
          searchAccountListShownExpense = [];
          accountListShownExpense = [];
          accountListExpense = [];
        });
      }
    } catch (e) {
      print("  ivdey    ${e.toString()}");
    }
  }
  var items = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
  ];





  changeValue(index, value) {

  }

  generatePaymentCycle() {
    var responseJson = [];

    var duration = int.parse(durationController.text);
    var dateList = [];
    dateList = getNextMonthsDate(duration, int.parse(selectedDateForEMI));
    for (int i = 0; i < duration; i++) {
      responseJson.add({"status": false, "amount": '0.00', "date": dateList[i]});
    }
    return responseJson;
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

  var listData = [];

  loadData() async {

    if (widget.isEdit!) {
      IsExistingLoan = ValueNotifier(widget.isExisting!);
      IsPurchase = ValueNotifier(widget.isPurchase!);

      if(widget.isExisting ==false){
        if(widget.isPurchase ==true){
          selectedAccountID = "";
          selectedAccountIDExpense = widget.accountId!;
        }
        else{
          selectedAccountIDExpense = "";
          selectedAccountID = widget.accountId!;
        }
      }




      print("selectedAccountID selectedAccountID selectedAccountID$selectedAccountID");


      dateNotifier = ValueNotifier(DateTime.parse(widget.date!));

      loanNameController = TextEditingController()..text = widget.loanName.toString();
      loanAmountController = TextEditingController()..text =roundStringWithOnlyDigit(widget.loanAmount.toString());
      durationController = TextEditingController()..text =roundStringWithValue(widget.duration.toString(),0);
      interestPerController = TextEditingController()..text = roundStringWithOnlyDigit(widget.interestAmount.toString());
      processingFeeController = TextEditingController()..text = roundStringWithOnlyDigit(widget.processingFee.toString());
      amountPaidController = TextEditingController()..text = roundStringWithOnlyDigit(widget.amount.toString());
      downPaymentController = TextEditingController()..text = roundStringWithOnlyDigit(widget.downPayment.toString());
      IsIncludeInLoan = ValueNotifier(widget.isIncludingLoan!);
      IsIncludeInEMI = ValueNotifier(widget.isIncludeInEMI!);
      changePaymentMode.value = int.parse(widget.loanType!);
      if(widget.loanType =="0"){
        List<String> parts = widget.paymentDate!.split('-');
        selectedDateForEMI =parts[2];
        listData = widget.reminderList!;
      }
      else{

        dueDateNotifier.value = DateTime.parse(widget.paymentDate!);
      }


    } else {
      selectedAccountID = selectedAccountID;
      selectedAccountIDExpense = selectedAccountIDExpense;
      IsExistingLoan = ValueNotifier(false);
      dateNotifier = ValueNotifier(DateTime.now());
      dueDateNotifier = ValueNotifier(DateTime.now());
      loanNameController = TextEditingController();
      loanAmountController = TextEditingController();
      durationController = TextEditingController()..text = "0";
      interestPerController = TextEditingController()..text = "";
      processingFeeController = TextEditingController()..text = "";
      amountPaidController = TextEditingController()..text = "";
      IsIncludeInLoan = ValueNotifier(false);
      IsIncludeInEMI = ValueNotifier(false);
      IsPurchase = ValueNotifier(false);
      changePaymentMode.value = int.parse("0");
      listData = [];
    }



    await returnAccountListFrom(selectedAccountID);
    await returnAccountListExpense(selectedAccountIDExpense);
  }

  @override
  void initState() {
    super.initState();
    progressBar = ProgressBar();
    loadData();
  }

  ValueNotifier<int> changeButtonIndex = ValueNotifier<int>(1);
  ValueNotifier<int> changePaymentMode = ValueNotifier<int>(0);

  final _formKey = GlobalKey<FormState>();
  late EditLoanModelClass editLoanModelClass;
  late LoanCreateModelClass loanCreateModelClass;

  List<String> getNextMonthsDate(duration, int day) {
    List<String> dates = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < duration; i++) {
      DateTime nextMonth = DateTime(now.year, now.month + i + 1, day);
      String formattedDate = DateFormat('yyyy-MM-dd').format(nextMonth);
      dates.add(formattedDate);
    }
    return dates;
  }

  ValueNotifier<bool> showFirstPage = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .02,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 11,

        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff2BAAFC),
          ),
        ),
        titleSpacing: 0,
        title: Text(
          widget.isEdit == false ? 'Add Loan' : "Edit Loan",
          style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 22.0),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Color(0xffE2E2E2),
              thickness: 1,
            ),
            space,
            Padding(
              padding: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
              child: Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          Container(
                            width: mWidth * .46,
                            child: Text("Loan Date :", style: customisedStyle(context, Color(0xff8D8D8D), FontWeight.w500, 15.0)),
                          ),
                          ValueListenableBuilder(
                              valueListenable: dateNotifier,
                              builder: (BuildContext ctx, date_value, _) {
                                return Container(
                                  color: Color(0xffF3F7FC),
                                  width: MediaQuery.of(context).size.width / 2.3,
                                  height: MediaQuery.of(context).size.height / 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDatePickerFunction(context, dateNotifier);
                                    },
                                    child: InkWell(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: Color(0xff2BAAFC),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            formatter.format(dateNotifier.value),
                                            style: customisedStyle(
                                              context,
                                              Colors.black,
                                              FontWeight.w400,
                                              12.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                      space,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          onTap: () {
                            loanNameController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: loanNameController.value.text.length,
                            );
                          },
                          style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          readOnly: false,
                          controller: loanNameController,
                          decoration: TextFieldDecoration.defUnderLine(context, hintTextStr: "Loan name"),
                        ),
                      ),
                      space,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: TextFormField(
                                  style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                                  onTap: () {
                                    loanAmountController.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: loanAmountController.value.text.length,
                                    );
                                  },
                                  onChanged: (value) {

                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                  ],
                                  controller: loanAmountController,
                                  decoration: TextFieldDecoration.defaultStyleWithLabel(context, hintTextStr: "Loan Amount"))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: TextFormField(
                                  style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                                  onChanged: (value) {
                                  },
                                  onTap: () {
                                    interestPerController.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: interestPerController.value.text.length,
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                  ],
                                  controller: interestPerController,
                                  decoration: TextFieldDecoration.defaultStyleWithLabel(context, hintTextStr: "interest%"))),
                        ],
                      ),
                      space,
                      Container(
                        height: mHeight * .06,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), border: Border.all(color: Color(0xffECECEC))),
                        child: ValueListenableBuilder<int>(
                          valueListenable: changePaymentMode,
                          builder: (context, color, child) {
                            return Container(
                              decoration: const BoxDecoration(),

                              height: MediaQuery.of(context).size.height / 18,
                              width: MediaQuery.of(context).size.width / 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      changePaymentMode.value = 0;
                                      IsExistingLoan.value = false;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 2.3,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Container(
                                              height: mHeight * .040,
                                              width: mWidth * .050,
                                              child: changePaymentMode.value == 0
                                                  ? SvgPicture.asset(
                                                "assets/svg/checkmark.svg",
                                                height: mHeight * .04,
                                              )
                                                  : SvgPicture.asset(
                                                "assets/svg/checkmark-filled (2).svg",
                                                height: mHeight * .04,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "Pay in Installment",
                                              style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 14.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      changePaymentMode.value = 1;
                                      IsPurchase.value = false;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 2.3,
                                      child: InkWell(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: mHeight * .040,
                                              width: mWidth * .050,
                                              child: changePaymentMode.value == 1
                                                  ? SvgPicture.asset(
                                                "assets/svg/checkmark.svg",
                                                height: mHeight * .04,
                                              )
                                                  : SvgPicture.asset(
                                                "assets/svg/checkmark-filled (2).svg",
                                                height: mHeight * .04,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                "Pay to Amount",
                                                style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 14.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      space,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder<int>(
                                  valueListenable: changePaymentMode,
                                  builder: (context, value, child) {
                                    print(value);
                                    switch (value) {
                                      case 0:
                                        return SizedBox(
                                          width: MediaQuery.of(context).size.width / 2.3,
                                          child: TextFormField(
                                              readOnly: widget.isEdit!,
                                              style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                                              onChanged: (val) {

                                              },
                                              onTap: () {
                                                durationController.selection = TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: durationController.value.text.length,
                                                );
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty || value.trim().isEmpty) {
                                                  return 'This field is required';
                                                }
                                                return null;
                                              },
                                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                              ],
                                              controller: durationController,
                                              decoration: TextFieldDecoration.defaultStyleWithLabel(context, hintTextStr: "Duration in months")),
                                        );
                                      case 1:
                                        return Container(
                                          child: Text(
                                            "Due Date:",
                                            style: customisedStyle(context, Colors.black, FontWeight.w500, 12.0),
                                          ),
                                        );
                                      default:
                                        return Container();
                                    }
                                  }),
                              ValueListenableBuilder<int>(
                                  valueListenable: changePaymentMode,
                                  builder: (context, value, child) {
                                    print(value);
                                    switch (value) {
                                      case 0:
                                        return Container(
                                          color: Color(0xffF3F7FC),
                                          width: MediaQuery.of(context).size.width / 2.3,
                                          height: MediaQuery.of(context).size.height / 19,
                                          child: GestureDetector(
                                            onTap: () async {

                                              if(widget.isEdit!){
                                                bool anyItemWithTrueStatus = listData.any((item) => item["status"] == true);
                                                if(anyItemWithTrueStatus){
                                                  msgBtmDialogueFunction(context: context, textMsg: "You cant change date, already create ");
                                                }
                                                else{
                                                  dateForEmiFunction(context, selectedDateForEMI,true);
                                                }
                                              }
                                              else{
                                                dateForEmiFunction(context, selectedDateForEMI,false);
                                              }


                                            },
                                            child: InkWell(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 10.0, left: 25.0),
                                                    child: Icon(
                                                      Icons.calendar_month,
                                                      color: Color(0xff2BAAFC),
                                                    ),
                                                  ),
                                                  Text(
                                                    selectedDateForEMI,
                                                    style: customisedStyle(
                                                      context,
                                                      Colors.black,
                                                      FontWeight.w400,
                                                      14.0,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );

                                      case 1:
                                        return ValueListenableBuilder(
                                            valueListenable: dueDateNotifier,
                                            builder: (BuildContext ctx, date_value, _) {
                                              return Container(
                                                color: Color(0xffF3F7FC),
                                                width: MediaQuery.of(context).size.width / 2.3,
                                                height: MediaQuery.of(context).size.height / 19,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDatePickerFunction(context, dueDateNotifier);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.calendar_month,
                                                        color: Color(0xff2BAAFC),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        formatter.format(date_value),
                                                        style: customisedStyle(
                                                          context,
                                                          Colors.black,
                                                          FontWeight.w400,
                                                          12.0,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });

                                      default:
                                        return Container();
                                    }
                                  }),
                            ],
                          ),
                          space,
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                  ],
                                  onTap: () {
                                    processingFeeController.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: processingFeeController.value.text.length,
                                    );
                                  },
                                  controller: processingFeeController,
                                  decoration: TextFieldDecoration.defaultStyleWithLabel(context, hintTextStr: "Processing Fee"))),
                          space,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.4,
                                  child: ValueListenableBuilder(
                                      valueListenable: IsIncludeInLoan,
                                      builder: (BuildContext context, bool newCheckValue, _) {
                                        return GestureDetector(
                                          onTap: () {

                                            if(processingFeeController.text !=""){

                                              IsIncludeInLoan.value = !newCheckValue;
                                              if (newCheckValue == false) {
                                                IsIncludeInEMI.value = false;
                                              }
                                            }

                                          },
                                          child: InkWell(
                                            child: Opacity(
                                              opacity:processingFeeController.text !=""? 1:0.3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: mHeight * .028,
                                                    width: mWidth * .05,
                                                    child: newCheckValue
                                                        ? SvgPicture.asset(
                                                      "assets/svg/checkmark.svg",
                                                      height: mHeight * .03,
                                                    )
                                                        : SvgPicture.asset(
                                                      "assets/svg/checkmark-filled (2).svg",
                                                      height: mHeight * .03,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text(
                                                      "Include in Loan",
                                                      style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 12.5),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.4,
                                  child: ValueListenableBuilder(
                                      valueListenable: IsIncludeInEMI,
                                      builder: (BuildContext context, bool newCheckValue, _) {
                                        return GestureDetector(
                                          onTap: () {

                                            if(processingFeeController.text !=""){
                                              IsIncludeInEMI.value = !newCheckValue;

                                              if (newCheckValue == false) {
                                                IsIncludeInLoan.value = false;
                                              }
                                            }

                                          },
                                          child: InkWell(
                                            child: Opacity(
                                              opacity:processingFeeController.text !=""? 1:0.3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: mHeight * .028,
                                                    width: mWidth * .05,
                                                    child: newCheckValue
                                                        ? SvgPicture.asset(
                                                      "assets/svg/checkmark.svg",
                                                      height: mHeight * .03,
                                                    )
                                                        : SvgPicture.asset(
                                                      "assets/svg/checkmark-filled (2).svg",
                                                      height: mHeight * .03,
                                                    ),
                                                  ),
                                                  ValueListenableBuilder<int>(
                                                      valueListenable: changePaymentMode,
                                                      builder: (context, value, child) {
                                                        switch (value) {
                                                          case 0:
                                                            return Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: Text(
                                                                "Include in EMI",
                                                                style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 12.5),
                                                              ),
                                                            );
                                                          case 1:
                                                            return Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: Text(
                                                                "Include in payment",
                                                                style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 12.5),
                                                              ),
                                                            );
                                                          default:
                                                            return Container();
                                                        }
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: ValueListenableBuilder(
                                    valueListenable: IsExistingLoan,
                                    builder: (BuildContext context, bool newCheckValue, _) {
                                      return GestureDetector(
                                        onTap: () {
                                          IsExistingLoan.value = !newCheckValue;

                                          print(IsPurchase.value);
                                        },
                                        child: InkWell(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: mHeight * .028,
                                                width: mWidth * .05,
                                                child: newCheckValue
                                                    ? SvgPicture.asset(
                                                  "assets/svg/checkmark.svg",
                                                  height: mHeight * .03,
                                                )
                                                    : SvgPicture.asset(
                                                  "assets/svg/checkmark-filled (2).svg",
                                                  height: mHeight * .03,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "Existing Loan",
                                                  style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 12.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              ValueListenableBuilder<int>(
                                  valueListenable: changePaymentMode,
                                  builder: (context, value, child) {
                                    print(value);
                                    switch (value) {
                                      case 0:
                                        return Container(
                                          width: MediaQuery.of(context).size.width / 2.4,
                                          child: ValueListenableBuilder(
                                              valueListenable: IsPurchase,
                                              builder: (BuildContext context, bool newCheckValue, _) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    IsPurchase.value = !newCheckValue;
                                                    setState(() {
                                                      IsExistingLoan.value = IsExistingLoan.value;
                                                    });
                                                  },
                                                  child: InkWell(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          height: mHeight * .028,
                                                          width: mWidth * .05,
                                                          child: newCheckValue
                                                              ? SvgPicture.asset(
                                                            "assets/svg/checkmark.svg",
                                                            height: mHeight * .03,
                                                          )
                                                              : SvgPicture.asset(
                                                            "assets/svg/checkmark-filled (2).svg",
                                                            height: mHeight * .03,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 8.0),
                                                          child: Text(
                                                            "Purchase",
                                                            style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 12.5),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        );
                                      case 1:
                                        return Container();
                                      default:
                                        return Container();
                                    }
                                  }),
                            ],
                          ),

                          ValueListenableBuilder<bool>(
                              valueListenable: IsPurchase,
                              builder: (context, value, child) {
                                print(value);
                                switch (value) {
                                  case false:
                                    return Container();
                                  case true:
                                    return Padding(
                                      padding: EdgeInsets.only(top: mHeight * .02),
                                      child: SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: TextFormField(
                                              style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                                              validator: (value) {
                                                if (value == null || value.isEmpty || value.trim().isEmpty) {
                                                  return 'This field is required';
                                                }
                                                return null;
                                              },
                                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                              ],
                                              controller: downPaymentController,
                                              decoration: TextFieldDecoration.defaultStyleWithLabel(context, hintTextStr: "Down payment"))),
                                    );
                                  default:
                                    return Container();
                                }
                              }),

                          ValueListenableBuilder<bool>(
                              valueListenable: IsExistingLoan,
                              builder: (context, value, child) {
                                print("___________IsPurchase.value____$value ____________${IsPurchase.value}");
                                switch (value) {
                                  case false:
                                    return IsPurchase.value == true
                                        ? Padding(
                                      padding: EdgeInsets.only(top: mHeight * .02),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 1.1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Expense Account",
                                                  style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    accountBtmSheetExpense(context, selectedAccountIDExpense);
                                                  },
                                                  child: Icon(
                                                    Icons.search,
                                                    color: Color(0xff2BAAFC),
                                                    size: 30,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          accountListShownExpense.isNotEmpty
                                              ? Padding(
                                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 15),
                                            child: GridView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: accountListShownExpense.length > 4 ? 4 : accountListShownExpense.length,
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
                                                        selectedAccountIDExpense = accountListShownExpense[index].id;
                                                        selectedAccountNameExpense = accountListShownExpense[index].account_name;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: mHeight * .01,

                                                      decoration: BoxDecoration(
                                                          color: selectedAccountIDExpense == accountListShownExpense[index].id
                                                              ? Color(0xff2BAAFC)
                                                              : Colors.white,
                                                          borderRadius: BorderRadius.circular(30),
                                                          border: Border.all(color: Color(0xffD6E0F6))),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 12.0),
                                                            child: accountListShownExpense[index].account_type == "2"
                                                                ? SvgPicture.asset(
                                                                color: selectedAccountIDExpense == accountListShownExpense[index].id
                                                                    ? Colors.white
                                                                    : Colors.black,
                                                                "assets/svg/bank_type.svg")
                                                                : SvgPicture.asset(
                                                                color: selectedAccountIDExpense == accountListShownExpense[index].id
                                                                    ? Colors.white
                                                                    : Colors.black,
                                                                "assets/svg/cash_type.svg"),
                                                          ),
                                                          SizedBox(
                                                            width: mWidth * .03,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              accountListShownExpense[index].account_name,
                                                              style: customisedStyle(
                                                                  context,
                                                                  selectedAccountIDExpense == accountListShownExpense[index].id
                                                                      ? Colors.white
                                                                      : Colors.black,
                                                                  FontWeight.normal,
                                                                  12.0),
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
                                              child: Center(
                                                  child: Text("", style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                        : Padding(
                                      padding: EdgeInsets.only(top: mHeight * .02),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 1.1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Receiving Account",
                                                  style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    accountBtmSheet(context, selectedAccountID);
                                                  },
                                                  child: Icon(
                                                    Icons.search,
                                                    color: Color(0xff2BAAFC),
                                                    size: 30,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          accountListShownFrom.isNotEmpty
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
                                                        selectedAccountID = accountListShownFrom[index].id;
                                                        selectedAccountName = accountListShownFrom[index].account_name;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: mHeight * .01,
                                                      decoration: BoxDecoration(
                                                          color: selectedAccountID == accountListShownFrom[index].id
                                                              ? Color(0xff2BAAFC)
                                                              : Colors.white,
                                                          borderRadius: BorderRadius.circular(30),
                                                          border: Border.all(color: Color(0xffD6E0F6))),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 12.0),
                                                            child: accountListShownFrom[index].account_type == "2"
                                                                ? SvgPicture.asset(
                                                                color: selectedAccountID == accountListShownFrom[index].id
                                                                    ? Colors.white
                                                                    : Colors.black,
                                                                "assets/svg/bank_type.svg")
                                                                : SvgPicture.asset(
                                                                color: selectedAccountID == accountListShownFrom[index].id
                                                                    ? Colors.white
                                                                    : Colors.black,
                                                                "assets/svg/cash_type.svg"),
                                                          ),
                                                          SizedBox(
                                                            width: mWidth * .03,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              accountListShownFrom[index].account_name,
                                                              style: customisedStyle(
                                                                  context,
                                                                  selectedAccountID == accountListShownFrom[index].id
                                                                      ? Colors.white
                                                                      : Colors.black,
                                                                  FontWeight.normal,
                                                                  12.0),
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
                                              child: Center(
                                                  child: Text("", style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  case true:
                                    return changePaymentMode.value == 1
                                        ? Padding(
                                      padding: EdgeInsets.only(top: mHeight * .02),
                                      child: SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: TextFormField(
                                              style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 15.0),
                                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                              ],
                                              controller: amountPaidController,
                                              decoration: TextFieldDecoration.defaultStyleWithLabel(context, hintTextStr: "Amount Paid"))),
                                    )
                                        : Container();
                                  default:
                                    return Container();
                                }
                              }),
                          space,
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * .07,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xffE2E2E2),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ValueListenableBuilder<int>(
              valueListenable: changePaymentMode,
              builder: (context, value, child) {
                switch (value) {
                  case 0:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         
                        GestureDetector(
                            child: SvgPicture.asset(
                              'assets/svg/plus-circle-line (1).svg',
                            ),
                            onTap: () async {
                              Navigator.pop(context);
                            }),
                        GestureDetector(
                            child: SvgPicture.asset(
                              'assets/svg/Group 1361.svg',color: Color(0xff2BAAFC),
                            ),
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if(double.parse(durationController.text)>0){
                                  var cycle = [];
                                  if (listData.isEmpty) {
                                    cycle = await generatePaymentCycle();
                                  } else {
                                    cycle = listData;
                                  }



                                  print(processingFeeController.text);


                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentSchedule(
                                          heading: widget.isEdit == false ? 'Add Loan' : "Edit Loan",
                                          uID: widget.id!,
                                          selectedIDExpense: selectedAccountIDExpense,
                                          isExist: IsExistingLoan.value,
                                          isEdit: widget.isEdit!,
                                          date: apiDateFormat.format(dateNotifier.value),
                                          down_payment: downPaymentController.text.isNotEmpty ? downPaymentController.text : "0",
                                          duration: durationController.text.isNotEmpty ? durationController.text : "0",
                                          emi_data: cycle,
                                          interest: interestPerController.text,
                                          is_existing: IsExistingLoan.value,
                                          is_fee_include_emi: IsIncludeInEMI.value,
                                          is_fee_include_loan: IsIncludeInLoan.value,
                                          is_purchase: IsPurchase.value,
                                          loan_amount: loanAmountController.text,
                                          loan_name: loanNameController.text,
                                          payment_date: apiDateFormat.format(dueDateNotifier.value),
                                          payment_type: "${changePaymentMode.value}",
                                          processing_fee: processingFeeController.text.isNotEmpty ? processingFeeController.text : "0",
                                          to_account: selectedAccountID,
                                        )),
                                  );


                                  if(result != null){


                                    Navigator.pop(context,true);


                                  }

                                }
                                else{
                                  msgBtmDialogueFunction(context: context, textMsg: "Duration is must br greater than 0");
                                }



                              }

                            }

                            ),
                      ],
                    );
                  case 1:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            child: SvgPicture.asset(
                              'assets/svg/plus-circle-line (1).svg',
                            ),
                            onTap: () async {
                              Navigator.pop(context);
                            }),
                        GestureDetector(
                            child: SvgPicture.asset(
                              'assets/svg/Group 1351.svg',
                            ),
                            onTap: () async {


                              if (_formKey.currentState!.validate()) {
                                var accountID = "";
                                if(IsExistingLoan.value ==false){
                                  if(IsPurchase.value ==false){
                                    accountID =selectedAccountID;
                                  }
                                  else{
                                    accountID =selectedAccountIDExpense;
                                  }
                                }



                                var res = await crateLoan(
                                  uID: widget.id!,
                                  type: widget.isEdit!,
                                  loan_name: loanNameController.text,
                                  date: apiDateFormat.format(dateNotifier.value),
                                  down_payment: downPaymentController.text.isNotEmpty ? downPaymentController.text : "0",
                                  duration: durationController.text.isNotEmpty ? durationController.text : "0",
                                  processing_fee: processingFeeController.text.isNotEmpty ? processingFeeController.text : "0",
                                  emi_data: [],
                                  interest: interestPerController.text.isNotEmpty ? interestPerController.text : "0",
                                  is_existing: IsExistingLoan.value,
                                  is_fee_include_emi: IsIncludeInEMI.value,
                                  is_fee_include_loan: IsIncludeInLoan.value,
                                  is_purchase: IsPurchase.value,
                                  loan_amount: loanAmountController.text,
                                  payment_date: apiDateFormat.format(dueDateNotifier.value),
                                  payment_type: "${changePaymentMode.value}",
                                  to_account: accountID,
                                );
                                progressBar.hide();

                                if (res[0] == 6000) {

                                  Navigator.pop(context,true);

                                } else {

                                  progressBar.hide();
                                  msgBtmDialogueFunction(context: context, textMsg: res[1]);
                                }

                              }


                            }),
                      ],
                    );
                  default:
                    return Container();
                }
              }),
        ),
      ),
    );
  }

  String selectedDateForEMI = "1";

  dateForEmiFunction(context, selectedNumber,isEdit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            height: 250,
            width: 300,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFFF3F7FC),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  "Select a day",
                  style: customisedStyle(context, Colors.black, FontWeight.w400, 17.0),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(28, (index) {
                    final number = index + 1;
                    return NumberItem(
                      number: number,
                      isSelected: selectedNumber == number,
                      onTap: () {
                        selectedNumber = number;
                        setState(() {
                          selectedDateForEMI = "$selectedNumber";

                          if(isEdit){

                            var responseJson = [];
                            var duration = int.parse(durationController.text);
                            var dateList = [];
                            dateList = getNextMonthsDate(duration, int.parse(selectedDateForEMI));
                            for (int i = 0; i < duration; i++) {
                              responseJson.add({"status": false, "amount": listData[i]['amount'], "date": dateList[i]});
                            }

                            listData = responseJson;
                          }

                        });
                        Navigator.pop(context);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  returnDateFormat(String stringDate) {
    var parsedDate = DateFormat('dd-MM-yyyy').parse(stringDate);
    var formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return formattedDate;
  }

  DateFormat apiDateFormat = DateFormat("y-M-d");


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
                  physics: NeverScrollableScrollPhysics(),
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
                                    searchAccountListApi(val, setStater,1);
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
                            shrinkWrap: true,
                            itemCount: searchAccountListShownFrom.length,
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
                                    id: searchAccountListShownFrom[index].id,
                                    account_name: searchAccountListShownFrom[index].account_name,
                                    accounts_id: searchAccountListShownFrom[index].accounts_id,
                                    opening_balance: '0.00',
                                    account_type: searchAccountListShownFrom[index].account_type,
                                    amount: searchAccountListShownFrom[index].amount,
                                  );

                                  selectedAccountID = searchAccountListShownFrom[index].id;
                                  selectedAccountName = searchAccountListShownFrom[index].account_name;

                                  bool exists = isItemWithIdExists(searchAccountListShownFrom[index].id);
                                  if (exists) {
                                    int indexToDelete = accountListShownFrom.indexWhere((item) => item.id == searchAccountListShownFrom[index].id);
                                    accountListShownFrom.removeAt(indexToDelete);
                                  }
                                  accountListShownFrom.insert(0, newItem);
                                  searchAccountListShownFrom = accountListFrom;

                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  height: mHeight * .01,

                                  decoration: BoxDecoration(
                                      color: selectedCardAccount == searchAccountListShownFrom[index].id ? Color(0xff2BAAFC) : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffD6E0F6))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: searchAccountListShownFrom[index].account_type == "2"
                                            ? SvgPicture.asset(
                                                color: selectedAccountID == searchAccountListShownFrom[index].id ? Colors.white : Colors.black,
                                                "assets/svg/bank_type.svg")
                                            : SvgPicture.asset(
                                                color: selectedAccountID == searchAccountListShownFrom[index].id ? Colors.white : Colors.black,
                                                "assets/svg/cash_type.svg"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          searchAccountListShownFrom[index].account_name,
                                          style: customisedStyle(
                                              context,
                                              selectedCardAccount == searchAccountListShownFrom[index].id ? Colors.white : Colors.black,
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
                    SizedBox(
                      height: mHeight * .19,
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
  accountBtmSheetExpense(context, String selectedCardAccount) {
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
                  physics: NeverScrollableScrollPhysics(),
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
                                    searchAccountListApi(val, setStater,2);
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
                            shrinkWrap: true,
                            itemCount: searchAccountListShownExpense.length,
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
                                    id: searchAccountListShownExpense[index].id,
                                    account_name: searchAccountListShownExpense[index].account_name,
                                    accounts_id: searchAccountListShownExpense[index].accounts_id,
                                    opening_balance: '0.00',
                                    account_type: searchAccountListShownExpense[index].account_type,
                                    amount: searchAccountListShownExpense[index].amount,
                                  );

                                  selectedAccountIDExpense = searchAccountListShownExpense[index].id;
                                  selectedAccountNameExpense = searchAccountListShownExpense[index].account_name;

                                  bool exists = isItemWithIdExists(searchAccountListShownExpense[index].id);
                                  if (exists) {
                                    int indexToDelete = accountListShownExpense.indexWhere((item) => item.id == searchAccountListShownExpense[index].id);
                                    accountListShownExpense.removeAt(indexToDelete);
                                  }
                                  accountListShownExpense.insert(0, newItem);
                                  searchAccountListShownExpense = accountListExpense;

                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  height: mHeight * .01,

                                  decoration: BoxDecoration(
                                      color: selectedCardAccount == searchAccountListShownExpense[index].id ? Color(0xff2BAAFC) : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffD6E0F6))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: searchAccountListShownExpense[index].account_type == "2"
                                            ? SvgPicture.asset(
                                            color: selectedAccountIDExpense == searchAccountListShownExpense[index].id ? Colors.white : Colors.black,
                                            "assets/svg/bank_type.svg")
                                            : SvgPicture.asset(
                                            color: selectedAccountIDExpense == searchAccountListShownExpense[index].id ? Colors.white : Colors.black,
                                            "assets/svg/cash_type.svg"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          searchAccountListShownExpense[index].account_name,
                                          style: customisedStyle(
                                              context,
                                              selectedCardAccount == searchAccountListShownExpense[index].id ? Colors.white : Colors.black,
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
                    SizedBox(
                      height: mHeight * .19,
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

  searchAccountListApi(searchData, setStater,type) async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';

      var accountType = [1, 2];

      if(type ==2){
        accountType = [4];
      }
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 20,
        "search": searchData,
        "country": "",
        "account_type": accountType
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


        if(type ==1){
          searchAccountListShownFrom.clear();
          setStater(() {
            for (Map user in responseJson) {
              searchAccountListShownFrom.add(AccountListModel.fromJson(user));
            }
          });
        }
        else{
          searchAccountListShownExpense.clear();
          setStater(() {
            for (Map user in responseJson) {
              searchAccountListShownExpense.add(AccountListModel.fromJson(user));
            }
          });
        }


      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool isItemWithIdExists(String id) {
    return accountListShownFrom.any((item) => item.id == id);
  }
}

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

class NumberItem extends StatelessWidget {
  final int number;
  final bool isSelected;
  final Function() onTap;

  NumberItem({
    required this.number,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          number.toString(),
          style: customisedStyle(context, isSelected ? Colors.white : Colors.black, FontWeight.w400, 13.0),
        ),
      ),
    );
  }
}
