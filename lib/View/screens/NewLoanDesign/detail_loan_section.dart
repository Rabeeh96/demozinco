import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../../../Api Helper/Bloc/Loan/loan_bloc.dart';
import '../../../Api Helper/ModelClasses/Loan/LoanViewModelClass.dart';
import '../../../Api Helper/Repository/api_client.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../../../Utilities/global/variables.dart';
import 'create_loan.dart';
import 'progress.dart';
import 'transaction_loan.dart';

class LoanSectionDetails extends StatefulWidget {
  String id, name, type, status;

  LoanSectionDetails({Key? key, required this.id, required this.name, required this.type, required this.status}) : super(key: key);

  @override
  State<LoanSectionDetails> createState() => _LoanSectionDetailsState();
}

class _LoanSectionDetailsState extends State<LoanSectionDetails> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation animation;
  late LoanViewModelClass loanViewModelClass;

  LoanViewFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");

    if (netWork) {
      if (!mounted) return;

      return BlocProvider.of<LoanBloc>(context).add(LoanViewEvent(organization: organizationId!, id: widget.id));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  double beginAnim = 0.0;
  late ProgressBar progressBar;
  double endAnim = 5.0;

  void showProgressBar() {
    progressBar.show(context);
  }

  void hideProgressBar() {
    progressBar.hide();
  }

  @override
  void dispose() {
    hideProgressBar();
    controller.stop();
    super.dispose();
  }

  deleteItemLoan(String transferId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'finance/delete-finance/';
      final country_id = prefs.getString("country_id");
      showProgressBar();

      Map data = {"organization": organizationId, "id": transferId, "country_id": country_id};
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          },
          body: body);
      Map n = json.decode(utf8.decode(response.bodyBytes));
      print(response.body);
      var statusCode = n["StatusCode"];
      if (statusCode == 6000) {
        hideProgressBar();
        LoanViewFunction();
      } else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
    }
  }

  deleteLoan(String transferId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'loans/delete-loans/';
      final country_id = prefs.getString("country_id");
      showProgressBar();

      Map data = {"organization": organizationId, "id": transferId, "country_id": country_id};
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          },
          body: body);
      Map n = json.decode(utf8.decode(response.bodyBytes));
      print(response.body);
      var statusCode = n["StatusCode"];

      if (statusCode == 6000) {
        hideProgressBar();
        Navigator.pop(context);
      } else {
        var msg = n["message"];
        msgBtmDialogueFunction(context: context, textMsg: msg);
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
    }
  }

  detailLoan(String transferId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'loans/details-loans/';
      final country_id = prefs.getString("country_id");
      showProgressBar();

      Map data = {"organization": organizationId, "id": transferId, "country_id": country_id};
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          },
          body: body);
      Map n = json.decode(utf8.decode(response.bodyBytes));
      print(url);
      print(data);
      print(response.body);
      var statusCode = n["StatusCode"];
      var responseJson = n["data"];

      if (statusCode == 6000) {
        hideProgressBar();



        final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                AddLoanPage(
                  paymentDate: responseJson["payment_date"],
                  isEdit: true,
                  date: responseJson["date"],
                  accountName: responseJson["date"],
                  loanName: responseJson["loan_name"],
                  loanType: responseJson["payment_type"],
                  amount: responseJson["total_amount"].toString(),
                  interest: responseJson["interest"] ?? "0",
                  duration: responseJson["duration"] ?? "0",
                  interestAmount: responseJson["interest"] ?? "0",
                  processingFee: responseJson["processing_fee"] ?? '0',
                  loanAmount: responseJson["loan_amount"].toString(),
                  isIncludingLoan: responseJson["is_fee_include_loan"],
                  isIncludeInEMI: responseJson["is_fee_include_emi"],
                  isPurchase: responseJson["is_purchase"],
                  isExisting: responseJson["is_existing"],
                  downPayment: responseJson["down_payment"] ?? "0",
                  accountId: responseJson["to_account"],
                  id: responseJson["id"],
                  reminderList: responseJson["reminder"],
                  organisation: responseJson["organization"],
                )));

        LoanViewFunction();

      } else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
    }
  }

  @override
  void initState() {
    super.initState();
    progressBar = ProgressBar();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    print("________________________________________________________________________${widget.type}");
    LoanViewFunction();

    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {
        });
      });

    controller.forward();
  }

  String convertDateFormat(String inputDate) {
    DateTime date = DateTime.parse(inputDate);

    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(date);

    return formattedDate;
  }

  final divider = Divider(
    color: Color(0xffE2E2E2),
    thickness: 1,
  );

  getMonthFromDate(String dateString) {
    DateTime date = DateTime.parse(dateString);

    int day = date.day;

    return "$day";
  }

  monthsToYearsAndMonths(months) {
    var val = roundStringWithValue(months, 0);
    int numberOfMonths = int.parse(val);
    int years = numberOfMonths ~/ 12;
    int remainingMonths = numberOfMonths % 12;
    if (numberOfMonths < 12) {
      return "$remainingMonths months";
    } else if (numberOfMonths == 12) {
      return "$years year";
    } else {
      return "$years year and $remainingMonths months";
    }
  }

  amountWithInterest(val1, val2) {
    var result = double.parse(val1) + double.parse(val2);
    return "$result";
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Tab(
        icon: Text(
          "Schedule",
          style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
        ),
      ),
      Tab(
        icon: Text(
          "History",
          style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
        ),
      ),
    ];

    final mHeight = MediaQuery
        .of(context)
        .size
        .height;
    final mWidth = MediaQuery
        .of(context)
        .size
        .width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 11,

          backgroundColor: const Color(0xffffffff),
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff2BAAFC),
            ),
          ),
          title: Text(
            widget.name,
            style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 20.0),
          ),
          actions: [
            widget.status == "0"
                ? IconButton(
                onPressed: () async {
                  btmDialogueFunction(
                      isDismissible: true,
                      context: context,
                      textMsg: 'Are you sure delete ?',
                      fistBtnOnPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      secondBtnPressed: () async {
                        Navigator.of(context).pop(true);

                        deleteLoan(widget.id);
                      },
                      secondBtnText: 'Yes');


                },
                icon: const Icon(
                  Icons.delete,

                  color: Color(0xff2BAAFC),
                ))
                : Container(),
            widget.status == "0"
                ? IconButton(
                onPressed: () async {
                  print("___________________________${loanViewModelClass.data!.paymentType}");
                  if (loanViewModelClass.data!.loan_status == "1") {
                    msgBtmDialogueFunction(context: context, textMsg: "You cant edit closed loan");
                  } else {
                    detailLoan(widget.id);
                  }
                },
                icon: const Icon(

                  Icons.edit,
                  color: Color(0xff2BAAFC),
                ))
                : Container(),
          ],
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<LoanBloc, LoanState>(
          builder: (context, state) {
            if (state is ViewLoanLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff5728C4),
                ),
              );
            }
            if (state is ViewLoanLoaded) {
              loanViewModelClass = BlocProvider
                  .of<LoanBloc>(context)
                  .loanViewModelClass;
              widget.status = loanViewModelClass.data!.loan_status!;
              widget.name = loanViewModelClass.data!.loanName!;
              WidgetsBinding.instance.addPostFrameCallback((_) {

                setState(() {});
              });


              return widget.type == "0"
                  ? Container(
                height: mHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffF3F7FC),
                        ),


                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: mWidth * .04, left: mWidth * .04, right: mWidth * .04),


                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Took",
                                    style: customisedStyle(context, Color(0xffB10B0B), FontWeight.w500, 15.0),
                                  ),
                                  Text(
                                    convertDateFormat(loanViewModelClass.data!.date!),
                                    style: customisedStyle(context, Color(0xff707070), FontWeight.normal, 14.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5, left: mWidth * .04, right: mWidth * .04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        countryCurrencyCode + " " + roundStringWith(loanViewModelClass.data!.loanAmount!),
                                        style: customisedStyle(context, Color(0xffB10B0B), FontWeight.w600, 13.0),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${roundStringWith(loanViewModelClass.data!.interest!)}%",
                                            style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.w500, 13.0),
                                          ),
                                          SizedBox(
                                            width: mWidth * .01,
                                          ),
                                          loanViewModelClass.data!.loan_status != "1"
                                              ? Text(
                                            "For ${monthsToYearsAndMonths(loanViewModelClass.data!.duration)}",
                                            style: customisedStyle(context, Color(0xff707070), FontWeight.normal, 11.6),
                                          )
                                              : Container(),
                                        ],
                                      ),
                                      loanViewModelClass.data!.loan_status != "1"
                                          ? Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Paid monthly",
                                              style: customisedStyle(context, Color(0xff707070), FontWeight.normal, 12.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                "On every",
                                                style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.w500, 12.0),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                getMonthFromDate(loanViewModelClass.data!.paymentDate!),
                                                style: customisedStyle(context, Colors.black, FontWeight.w600, 13.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                          : Container(),
                                    ],
                                  ),
                                  loanViewModelClass.data!.loan_status != "1"
                                      ? ElevatedButton(
                                    onPressed: () async {
                                      print("close loan");


                                      var result = await Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionPageLoan(
                                                total_intrest:loanViewModelClass.data!.totalInterest,
                                                isProcessingFee: false,
                                                loanType: "1",

                                                isDetail: false,
                                                type: "Create",
                                                amount: "0.00",
                                                to_account_id: loanViewModelClass.data!.account!,
                                                to_accountName: loanViewModelClass.data!.loanName!,
                                                from_account_id: "",
                                                from_accountName: "",
                                                id: "",
                                                date: "",
                                                closeLoan: true,
                                                outStandingAmount: loanViewModelClass.data!.outstanding_amount,
                                                isInterest: false,
                                                description: '',
                                              )));

                                      LoanViewFunction();
                                    },
                                    child: Text(
                                      'Close Loan',
                                      style: customisedStyle(context, Colors.white, FontWeight.normal, 12.0),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff2BAAFC),
                                      textStyle: TextStyle(fontSize: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              ),
                            ),
                            divider,
                            Container(
                              padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total interest",
                                        style: customisedStyle(context, Colors.grey, FontWeight.w500, 13.0),
                                      ),
                                      loanViewModelClass.data!.loan_status != "1"
                                          ? Text(
                                        "Next Payment",
                                        style: customisedStyle(context, Colors.grey, FontWeight.w500, 13.0),
                                      )
                                          : Container(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        countryCurrencyCode + " " + roundStringWith(loanViewModelClass.data!.totalInterest!),
                                        style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                      ),
                                      loanViewModelClass.data!.loan_status != "1"
                                          ? Row(
                                        children: [
                                          Text(
                                            countryCurrencyCode + " " + loanViewModelClass.data!.nextPayment!,
                                            style: customisedStyle(context, Color(0xffB10B0B), FontWeight.w600, 14.0),
                                          ),
                                        ],
                                      )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Amount With Interest",
                                        style: customisedStyle(context, Colors.grey, FontWeight.w500, 13.0),
                                      ),
                                      loanViewModelClass.data!.loan_status != "1"
                                          ? Text(
                                        "Pending Tenture",
                                        style: customisedStyle(context, Colors.grey, FontWeight.w500, 13.0),
                                      )
                                          : Container()
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        countryCurrencyCode +
                                            " " +
                                            roundStringWith(amountWithInterest(
                                              loanViewModelClass.data!.loanAmount!,
                                              loanViewModelClass.data!.totalInterest!,
                                            )),
                                        style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                      ),
                                      loanViewModelClass.data!.loan_status != "1"
                                          ? Row(
                                        children: [
                                          Text(
                                            roundStringWithValue(loanViewModelClass.data!.pendingEmi!, 0),
                                            style: customisedStyle(context, Color(0xffB10B0B), FontWeight.w600, 14.0),
                                          ),
                                         ],
                                      )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: mWidth * .04,
                                right: mWidth * .04,
                                bottom: mWidth * .04,
                              ),
                              child: Container(
                                  height: 40,
                                  child: ProgressIndicatorWidget(
                                    pendingEmi: loanViewModelClass.data!.pendingEmi!,
                                    maxNumber: int.parse(roundStringWithValue(loanViewModelClass.data!.duration!, 0)),
                                    totalValue: "$countryCurrencyCode. ${roundStringWith(loanViewModelClass.data!.outstanding_amount!)}",
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.red,
                            height: mHeight * .1,
                            child: SizedBox(
                              height: 50,
                              child: AppBar(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                bottom: TabBar(indicatorWeight: 5, indicatorColor: Colors.black, tabs: tabs),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                loanViewModelClass.shedule!.isNotEmpty
                                    ? ListView.builder(
                                    itemCount: loanViewModelClass.shedule!.length,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {

                                      var nextPayment = findFirstFalseStatusIndex();
                                      return loanViewModelClass.shedule![index].is_initial! == true &&
                                          loanViewModelClass.shedule![index].status == false
                                          ? Container(
                                        height: mHeight * .08,
                                        decoration: BoxDecoration(
                                            color:
                                            loanViewModelClass.shedule![index].status == false ? Colors.white : Color(0xffF2F2F2),
                                            border: Border.all(color: Color(0xffDEDEDE), width: 0.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.0),
                                                child: Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width / 14,
                                                  child: Text(
                                                    loanViewModelClass.data!.is_initial_payment! ? "${index}" : "${index + 1}",
                                                    style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 1.7,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          convertDateFormat(loanViewModelClass.shedule![index].date!),
                                                          style: customisedStyle(context, Color(0xff8D8D8D), FontWeight.normal, 11.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 2.5,
                                                      child: loanViewModelClass.shedule![index].is_initial == true
                                                          ? Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Processing fee",
                                                            style: customisedStyle(
                                                                context, Color(0xff8D8D8D), FontWeight.normal, 10.5),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 8.0),
                                                            child: Text(
                                                              countryCurrencyCode +
                                                                  " " +
                                                                  roundStringWith(loanViewModelClass
                                                                      .shedule![index].down_payment ==
                                                                      ""
                                                                      ? loanViewModelClass.shedule![index].amount!
                                                                      : (double.parse(
                                                                      loanViewModelClass.shedule![index].amount!) -
                                                                      double.parse(loanViewModelClass
                                                                          .shedule![index].down_payment!))
                                                                      .toString()),
                                                              style:
                                                              customisedStyle(context, Colors.black, FontWeight.w400, 10.5),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                          : Container(),
                                                    ),
                                                    loanViewModelClass.shedule![index].is_initial == true
                                                        ? Container(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          loanViewModelClass.shedule![index].down_payment != ""
                                                              ? Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "Down payment:",
                                                                style: customisedStyle(
                                                                    context, Color(0xff8D8D8D), FontWeight.normal, 10.5),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 8.0),
                                                                child: Text(
                                                                  countryCurrencyCode +
                                                                      " " +
                                                                      roundStringWith(loanViewModelClass
                                                                          .shedule![index].down_payment!),
                                                                  style: customisedStyle(
                                                                      context, Colors.black, FontWeight.w400, 10.5),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                              : Container(),
                                                        ],
                                                      ),
                                                    )
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                              loanViewModelClass.shedule![index].status == false
                                                  ? Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 4,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 5,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          var result = await Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TransactionPageLoan(
                                                                    isProcessingFee: loanViewModelClass.shedule![index].is_initial,
                                                                    loanType: widget.type,
                                                                    isDetail: false,
                                                                    type: "Create",
                                                                    amount: loanViewModelClass.shedule![index].amount,
                                                                    to_account_id: loanViewModelClass.data!.account!,
                                                                    to_accountName: loanViewModelClass.data!.loanName!,
                                                                    from_account_id: "",
                                                                    from_accountName: "",
                                                                    id: "",
                                                                    date: "",
                                                                    closeLoan: false,
                                                                    isInterest: false,
                                                                    description: '',
                                                                  )));

                                                          LoanViewFunction();
                                                        },
                                                        child: Text(
                                                          'Pay',
                                                          style:
                                                          customisedStyle(context, Colors.white, FontWeight.normal, 12.0),
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 0.5,
                                                          backgroundColor:
                                                          nextPayment == index ? Color(0xff2BAAFC) : Colors.white30,
                                                            textStyle: TextStyle(fontSize: 16),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "$countryCurrencyCode ${roundStringWith(loanViewModelClass.shedule![index].amount.toString())}",
                                                      style: customisedStyle(context, Color(0xffC50000), FontWeight.w600, 12.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      )
                                          : Container(
                                        height: mHeight * .08,
                                        decoration: BoxDecoration(
                                            color:
                                            loanViewModelClass.shedule![index].status == false ? Colors.white : Color(0xffF2F2F2),
                                            border: Border.all(color: Color(0xffDEDEDE), width: 0.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.0),
                                                child: Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width / 14,
                                                  child: Text(
                                                    loanViewModelClass.data!.is_initial_payment! ? "${index}" : "${index + 1}",
                                                    style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 3.5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          convertDateFormat(loanViewModelClass.shedule![index].date!),
                                                          style: customisedStyle(context, Color(0xff8D8D8D), FontWeight.normal, 11.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "$countryCurrencyCode ${roundStringWith(loanViewModelClass.shedule![index].amount.toString())}",
                                                      style: customisedStyle(context, Color(0xffC50000), FontWeight.w600, 12.0),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 3.5,
                                                child: loanViewModelClass.shedule![index].is_initial == true
                                                    ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Processing fee",
                                                      style:
                                                      customisedStyle(context, Color(0xff8D8D8D), FontWeight.normal, 10.5),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: Text(
                                                        countryCurrencyCode +
                                                            " " +
                                                            roundStringWith(loanViewModelClass.shedule![index].down_payment ==
                                                                ""
                                                                ? loanViewModelClass.shedule![index].amount!
                                                                : (double.parse(loanViewModelClass.shedule![index].amount!) -
                                                                double.parse(
                                                                    loanViewModelClass.shedule![index].down_payment!))
                                                                .toString()),
                                                        style: customisedStyle(context, Colors.black, FontWeight.w400, 10.5),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                    : Container(),
                                              ),
                                              loanViewModelClass.shedule![index].is_initial == true
                                                  ? Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  loanViewModelClass.shedule![index].down_payment != ""
                                                      ? Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Down payment:",
                                                        style: customisedStyle(
                                                            context, Color(0xff8D8D8D), FontWeight.normal, 10.5),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0),
                                                        child: Text(
                                                          roundStringWith(
                                                              loanViewModelClass.shedule![index].down_payment!),
                                                          style: customisedStyle(
                                                              context, Colors.black, FontWeight.w400, 10.5),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                      : Container(),
                                                ],
                                              )
                                                  : Container(),
                                              loanViewModelClass.shedule![index].status == false
                                                  ? Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 4,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                     Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 5,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          var result = await Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TransactionPageLoan(
                                                                    isProcessingFee:
                                                                    loanViewModelClass.shedule![index].is_initial,
                                                                    loanType: widget.type,
                                                                    isDetail: false,
                                                                    type: "Create",
                                                                    amount: loanViewModelClass.shedule![index].amount,
                                                                    to_account_id: loanViewModelClass.data!.account!,
                                                                    to_accountName: loanViewModelClass.data!.loanName!,
                                                                    from_account_id: "",
                                                                    from_accountName: "",
                                                                    id: "",
                                                                    date: "",
                                                                    closeLoan: false,
                                                                    isInterest: false,
                                                                    description: '',
                                                                  )));

                                                          LoanViewFunction();
                                                        },
                                                        child: Text(
                                                          'Pay',
                                                          style:
                                                          customisedStyle(context, Colors.white, FontWeight.normal, 12.0),
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 0.5,
                                                          backgroundColor:
                                                          nextPayment == index ? Color(0xff2BAAFC) : Colors.white30,
                                                           textStyle: TextStyle(fontSize: 16),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Container(

                                              ),
                                              loanViewModelClass.shedule![index].is_initial == false
                                                  ? loanViewModelClass.shedule![index].status!
                                                  ? Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 4,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Late fee",
                                                      style: customisedStyle(
                                                          context, Color(0xff8D8D8D), FontWeight.normal, 11.0),
                                                    ),
                                                    Text(
                                                      "$countryCurrencyCode ${roundStringWith(
                                                          loanViewModelClass.shedule![index].add_amount.toString())}",
                                                      style: customisedStyle(
                                                          context, Color(0xffC50000), FontWeight.w600, 12.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Container(

                                              )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                    : SizedBox(
                                    height: mHeight * .7,
                                    child: const Center(
                                        child: Text(
                                          "Items not found !",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ))),
                                loanViewModelClass.history!.isNotEmpty
                                    ? ListView.builder(
                                    itemCount: loanViewModelClass.history!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                          height: mHeight * .08,
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(color: Color(0xffDEDEDE), width: 1),
                                                borderRadius: BorderRadius.circular(1)),
                                            tileColor: const Color(0xffFFFFFF),
                                            title: Container(
                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 8, bottom: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(convertDateFormat(loanViewModelClass.history![index].date!),
                                                      style: customisedStyle(context, Color(0xff8D8D8D), FontWeight.normal, 12.0)),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(loanViewModelClass.history![index].from_account_name!,
                                                              style: customisedStyle(context, Colors.black, FontWeight.w500, 12.0)),
                                                        ],
                                                      ),
                                                      Text(
                                                          "$countryCurrencyCode. ${roundStringWith(loanViewModelClass.history![index].amount!)}",
                                                          style: customisedStyle(context, Color(0xffC50000), FontWeight.w600, 12.0)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    })
                                    : SizedBox(
                                    height: mHeight * .7,
                                    child: const Center(
                                        child: Text(
                                          "No paid history !",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  :

              Container(
                height: mHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04, top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffF3F7FC),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: mWidth * .04, left: mWidth * .04, right: mWidth * .04),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Took",
                                    style: customisedStyle(context, Color(0xffB10B0B), FontWeight.w500, 15.0),
                                  ),
                                  Text(
                                    convertDateFormat(loanViewModelClass.data!.date!),
                                    style: customisedStyle(context, Color(0xff707070), FontWeight.normal, 14.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5, left: mWidth * .04, right: mWidth * .04),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        countryCurrencyCode + " " + roundStringWith(loanViewModelClass.data!.loanAmount!),
                                        style: customisedStyle(context, Color(0xffB10B0B), FontWeight.w600, 13.0),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${roundStringWith(loanViewModelClass.data!.interest!)}%",
                                            style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.w500, 13.0),
                                          ),
                                          SizedBox(
                                            width: mWidth * .01,
                                          ),
                                          loanViewModelClass.data!.loan_status != "1"
                                              ? Text(
                                            "Till ${convertDateFormat(loanViewModelClass.data!.paymentDate!)}",
                                            style: customisedStyle(context, Color(0xff707070), FontWeight.normal, 11.6),
                                          )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  loanViewModelClass.data!.loan_status != "1"
                                      ? ElevatedButton(
                                    onPressed: () async {
                                      var result = await Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionPageLoan(
                                                loanType: widget.type,
                                                isProcessingFee: false,
                                                isDetail: false,
                                                type: "Create",
                                                amount: "0.00",
                                                to_account_id: loanViewModelClass.data!.account!,
                                                to_accountName: loanViewModelClass.data!.loanName!,
                                                from_account_id: "",
                                                from_accountName: "",
                                                id: "",
                                                date: "",
                                                isInterest: false,
                                                description: '',
                                                closeLoan: false,
                                              )));

                                      LoanViewFunction();
                                    },
                                    child: Text(
                                      'Pay to Loan',
                                      style: customisedStyle(context, Colors.white, FontWeight.normal, 12.0),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff2BAAFC),
                                      textStyle: TextStyle(fontSize: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              ),
                            ),
                            divider,
                            Container(
                              padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04, bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Amount paid",
                                          style: customisedStyle(context, Colors.grey, FontWeight.w500, 11.0),
                                        ),
                                        Text(
                                          countryCurrencyCode + " " + roundStringWith(loanViewModelClass.data!.amount_paid!),
                                          style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Interest paid",
                                          style: customisedStyle(context, Colors.grey, FontWeight.w500, 11.0),
                                        ),
                                        Text(
                                          countryCurrencyCode + " " + roundStringWith(loanViewModelClass.data!.interest_paid!),
                                          style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  loanViewModelClass.data!.loan_status != "1"
                                      ? Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 4,
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {


                                            var result = await Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) =>
                                                    TransactionPageLoan(
                                                      isProcessingFee: false,
                                                      total_intrest:loanViewModelClass.data!.totalInterest,
                                                      loanType: "1",
                                                      isDetail: false,
                                                      type: "Create",
                                                      amount: "0.00",
                                                      to_account_id: loanViewModelClass.data!.account!,
                                                      to_accountName: loanViewModelClass.data!.loanName!,
                                                      from_account_id: "",
                                                      from_accountName: "",
                                                      outStandingAmount: '0',
                                                      id: "",
                                                      date: "",
                                                      closeLoan: true,
                                                      isInterest: false,
                                                      description: '',
                                                    )));

                                            LoanViewFunction();
                                          },
                                          child: Text(
                                            'Close Loan',
                                            style: customisedStyle(context, Colors.white, FontWeight.normal, 12.0),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff2BAAFC),
                                             textStyle: TextStyle(fontSize: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 3.5,
                                    child: ElevatedButton(

                                      onPressed: () {},

                                      child: Text(
                                        'Loan Closed',
                                        style: customisedStyle(context, Colors.white, FontWeight.normal, 12.0),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        elevation: 0,

                                        backgroundColor: Color(0xff46B862),
                                         textStyle: TextStyle(fontSize: 16, color: Colors.red),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: loanViewModelClass.history!.isNotEmpty
                          ? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: ListView.builder(
                            itemCount: loanViewModelClass.history!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                    color: Colors.red,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )),
                                confirmDismiss: (DismissDirection direction) async {
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

                                          deleteItemLoan(loanViewModelClass.history![index].id!);
                                        } else {
                                          if (!mounted) return;
                                          msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                        }
                                      },
                                      secondBtnText: 'Delete');
                                },
                                key: Key(loanViewModelClass.history![index].id!),
                                onDismissed: (direction) async {},
                                child: Container(
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Color(0xffDEDEDE), width: 1), borderRadius: BorderRadius.circular(1)),
                                    tileColor: const Color(0xffFFFFFF),
                                    title: Container(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(convertDateFormat(loanViewModelClass.history![index].date!),
                                                  style: customisedStyle(context, Color(0xff8D8D8D), FontWeight.normal, 11.0)),
                                              Text(loanViewModelClass.history![index].from_account_name!,
                                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 12.0)),
                                            ],
                                          ),
                                          Text("$countryCurrencyCode. ${roundStringWith(loanViewModelClass.history![index].amount!)}",
                                              style: customisedStyle(context, Color(0xffE14242), FontWeight.w600, 12.5)),


                                        ],
                                      ),
                                    ),

                                  ),
                                ),
                              );
                            }),
                      )
                          : SizedBox(
                          height: mHeight * .7,
                          child: const Center(
                              child: Text(
                                "Items not found !",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))),
                    )
                  ],
                ),
              );
            }
            if (state is ViewLoanError) {
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
        bottomNavigationBar: Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 13,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: mWidth * .08, bottom: mHeight * .10, right: mWidth * .05),
              margin: EdgeInsets.symmetric(vertical: 11),
              color: const Color(0xffF3F7FC),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PopupMenuButton<String>(
                    constraints: BoxConstraints(
                      minWidth: 2.0 * 56.0,
                      maxWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                    ),
                    child: Container(

                      child: Row(
                        children: [
                          SvgPicture.asset("assets/svg/export.svg"),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PDF",
                                style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                              ),
                              SvgPicture.asset("assets/svg/pdf.svg"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'excel',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Excel",
                                style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                              ),
                              SvgPicture.asset("assets/svg/excel.svg"),
                            ],
                          ),
                        ),
                      ];
                    },
                    onSelected: (String value) async {

                    },
                  ),
                ],
              ),
            )),


      ),
    );
  }

  int findFirstFalseStatusIndex() {
    var schedule = loanViewModelClass.shedule;
    return schedule!.indexWhere((item) => item.status == false);
  }
}
