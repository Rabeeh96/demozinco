import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

import '../../../Api Helper/Bloc/Account/account_bloc.dart';
import '../../../Api Helper/Bloc/dash_detail/dash_detail_bloc.dart';
import '../../../Api Helper/Bloc/dash_detail/dash_detail_event.dart';
import '../../../Api Helper/Bloc/dash_detail/dash_detail_state.dart';
import '../../../Api Helper/Bloc/transaction_list/transaction_list_bloc.dart';
import '../../../Api Helper/Bloc/transaction_list/transaction_list_event.dart';
import '../../../Api Helper/Bloc/transaction_list/transaction_list_state.dart';
import '../../../Api Helper/ModelClasses/Settings/Account/DeleteAccountModelClass.dart';
import '../../../Api Helper/ModelClasses/dashboard_detail_model/DashboardDEtailModel.dart';
import '../../../Api Helper/ModelClasses/dashboard_detail_model/DeleteAccountModel.dart';
import '../../../Api Helper/ModelClasses/dashboard_detail_model/DeleteTransferList.dart';
import '../../../Api Helper/ModelClasses/transfer_list/transfer_list_model.dart';
import '../../../Api Helper/Repository/api_client.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../../../Utilities/global/variables.dart';
import '../../Export/export_to_excel.dart';
import '../../Export/export_to_pdf.dart';
import '../expenses/expense_new_design/transaction_page_expense.dart';
import '../income/Income_new_design/transaction_page_income.dart';
import '../new_transfer_section/add_transfer.dart';
import 'dashboard_new_design.dart';
import 'filter.dart';

class DashboardDetailScreen extends StatefulWidget {
  final String accountId;
  String? accountType;

  DashboardDetailScreen({
    super.key,
    required this.accountId,
    required this.accountType,
  });

  @override
  State<DashboardDetailScreen> createState() => _DashboardDetailScreenState();
}

class _DashboardDetailScreenState extends State<DashboardDetailScreen> {
  late DashboardDEtailModel dashboardDEtailModel;
  late TransactionListModelClass transactionListModelClass;
  late DeleteTransferList deleteTransferList;
  late DeleteAccountModel deleteAccountModel;
  var fromDate;
  var toDate;
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    progressBar = ProgressBar();
    dashboardDetailFunction();
    transactionListApiFunc();
    accountType();
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

  var orgID;
  var zakath = false;
  var isIntrest = false;
  String bankOrCash = "";

  transactionListApiFunc() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    orgID = prefs.getString("organisation");
    zakath = prefs.getBool("is_zakath") ?? false;
    isIntrest = prefs.getBool("is_intrest") ?? false;

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<Transaction_listBloc>(context)
          .add(TransferListEventEvent(organisation: organizationId!, account_id: widget.accountId, toDate: '', fromDate: ''));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }


  dashboardDetailFunction() async {
    var netWork = await checkNetwork();
    final prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<Dash_detailBloc>(context).add(DashDetailEvent(organisationId: organizationId!, id: widget.accountId));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  accountType() {
    if (widget.accountType == "2") {
      bankOrCash = "0";
    } else {
      bankOrCash = "1";
    }
  }

  String accountID = "";

  deleteApiFunction(accountID) async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;

      return BlocProvider.of<Transaction_listBloc>(context).add(DeleteTransferListEventEvent(id: accountID, organisation: organizationId!));
    } else {
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
      final url = baseUrl + 'transfer/delete-transfer/';
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
        dashboardDetailFunction();
        transactionListApiFunc();
        accountType();
      } else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
    }
  }

  deleteDashboardAccountApi() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<AccountBloc>(context).add(DeleteAccountEvent(id: widget.accountId, organisation: organizationId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  late DeleteAccountModelClass deleteAccountModelClass;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
        listeners: [
          BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is DeleteAccountLoaded) {
                hideProgressBar();

                deleteAccountModelClass = BlocProvider.of<AccountBloc>(context).deleteAccountModelClass;

                if (deleteAccountModelClass.statusCode == 6000) {
                  Navigator.pop(context);
                } else if (deleteAccountModelClass.statusCode == 6001) {
                  if (deleteAccountModelClass.data! == "Account Already Using") {
                    alreadyCreateBtmDialogueFunction(
                        context: context,
                        textMsg: deleteAccountModelClass.data.toString(),
                        buttonOnPressed: () {
                          Navigator.of(context).pop(false);
                        });
                  }

                  msgBtmDialogueFunction(context: context, textMsg: deleteAccountModelClass.data!);
                  Navigator.pop(context);
                }
              }
              if (state is DeleteAccountError) {
                hideProgressBar();
              }
            },
          ),
          BlocListener<Transaction_listBloc, Transaction_listState>(
            listener: (context, state) {
              if (state is DeleteTransferListLoading) {
                const CircularProgressIndicator(
                  color: Color(0xff5728C4),
                );
              }
              if (state is DeleteTransferListLoaded) {
                hideProgressBar();
                deleteTransferList = BlocProvider.of<Transaction_listBloc>(context).deleteTransferList;
                if (deleteTransferList.statusCode == 6000) {

                  transactionListApiFunc();
                  dashboardDetailFunction();
                } else if (deleteTransferList.statusCode == 6001) {
                  transactionListApiFunc();
                  dashboardDetailFunction();
                  msgBtmDialogueFunction(context: context, textMsg: deleteTransferList.data!);
                } else if (deleteTransferList.statusCode == 6002) {
                  msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
                }
              }
              if (state is DeleteTransferListError) {
                hideProgressBar();
              }
            },
          ),
        ],
        child: BlocBuilder<Dash_detailBloc, Dash_detailState>(
          builder: (context, state) {
            if (state is DashDetailsLoading) {
              return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff5728C4),
                  ),
                ),
              );
            }
            if (state is DashDetailsLoaded) {
              dashboardDEtailModel = BlocProvider.of<Dash_detailBloc>(context).dashboradDEtailModel;
              return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: MediaQuery.of(context).size.height / 11,

                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: Color(0xff2BAAFC),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: true,
                    titleSpacing: 0,
                    title: Text(
                      dashboardDEtailModel.data!.accountName!,
                      style: customisedStyle(context, Colors.black, FontWeight.w600, 21.0),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            btmSheetFunction(
                                context: context,
                                type: "Edit",
                                id: widget.accountId,
                                accountName: dashboardDEtailModel.data!.accountName!,
                                openingBalance: dashboardDEtailModel.data!.openingBalance,
                                BankOrCash: int.parse(bankOrCash));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xff2BAAFC),
                          )),
                      IconButton(
                          onPressed: () {
                            btmDialogueFunction(
                                isDismissible: true,
                                context: context,
                                textMsg: 'Are you sure delete ?',
                                fistBtnOnPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                secondBtnPressed: () async {
                                  accountID = widget.accountId!;
                                  deleteDashboardAccountApi();
                                  Navigator.of(context).pop(true);
                                },
                                secondBtnText: 'Yes');
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xff2BAAFC),
                          )),
                    ],
                  ),
                  body: Container(
                    height: mHeight,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Divider(
                            color: Color(0xffE2E2E2),
                            thickness: 1,
                          ),
                          if (zakath == true && isIntrest == false || zakath == false && isIntrest == true || zakath == true && isIntrest == true)
                            Container(
                              margin: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07, top: mHeight * .02),
                              color: Color(0xffF3F7FC),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: mHeight * .06,
                                    width: mWidth * .83,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: mWidth * .03),
                                          child: Text(
                                            "Balance",
                                            style: customisedStyle(context, Color(0xff9CA4C9), FontWeight.w500, 14.0),
                                          ),
                                        ),
                                        Text(
                                          "$countryCurrencyCode ${roundStringWith(dashboardDEtailModel.data!.balance!)}",
                                          style: customisedStyle(context, Colors.black, FontWeight.w500, 17.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(height: 1, color: Color(0xffDAE8F9), width: mWidth * .9),
                                  Container(

                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: mWidth * .03),
                                              child: Container(
                                                width: mWidth * .4,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Country",
                                                          style: customisedStyle(context, Color(0xff354AA9), FontWeight.w500, 12.0),
                                                        ),
                                                        Text(
                                                          dashboardDEtailModel.data!.country!.countryName!,
                                                          style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: mHeight * .01,
                                                    ),
                                                    zakath == true
                                                        ? Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "Zakah",
                                                                style: customisedStyle(context, Color(0xff017511), FontWeight.w500, 12.0),
                                                              ),
                                                              Text(
                                                                "$countryCurrencyCode ${roundStringWith(dashboardDEtailModel.data!.amountDetails!.totalZakath!)}",
                                                                style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                                              ),
                                                            ],
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: mHeight * .17,
                                              width: 1,
                                              color: Color(0xffDAE8F9),
                                            ),
                                            SizedBox(
                                              width: mWidth * .05,
                                            ),

                                            Container(
                                              width: mWidth * .3,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Usable",
                                                        style: customisedStyle(context, Color(0xff354AA9), FontWeight.w500, 12.0),
                                                      ),
                                                      Text(
                                                        countryCurrencyCode +
                                                            " " +
                                                            roundStringWith(dashboardDEtailModel.data!.amountDetails!.usable!),
                                                        style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: mHeight * .01,
                                                  ),
                                                  isIntrest == true
                                                      ? Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "Interest",
                                                              style: customisedStyle(context, Color(0xff01B483), FontWeight.w500, 12.0),
                                                            ),
                                                            Text(
                                                              "$countryCurrencyCode ${roundStringWith(dashboardDEtailModel.data!.amountDetails!.totalInterest!)}",
                                                              style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox()
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          if (zakath == false && isIntrest == false)
                            Container(
                              margin: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07, top: mHeight * .02),
                              color: Color(0xffF3F7FC),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: mHeight * .06,
                                    width: mWidth * .83,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: mWidth * .03),
                                          child: Text(
                                            "Balance",
                                            style: customisedStyle(context, Color(0xff9CA4C9), FontWeight.w500, 14.0),
                                          ),
                                        ),
                                        Text(
                                          "$countryCurrencyCode ${roundStringWith(dashboardDEtailModel.data!.balance!)}",
                                          style: customisedStyle(context, Colors.black, FontWeight.w500, 17.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(height: 1, color: Color(0xffDAE8F9), width: mWidth * .9),
                                  Container(
                                    padding: EdgeInsets.only(left: mWidth * .03, top: mHeight * .01),
                                    height: mHeight * .08,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Country",
                                          style: customisedStyle(context, Color(0xff354AA9), FontWeight.w500, 12.0),
                                        ),
                                        Text(
                                          dashboardDEtailModel.data!.country!.countryName!,
                                          style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                          Container(
                            margin: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
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
                                              transactionListApiFunc();
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
                                    final result =
                                        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FilterForDashboardDetail()));

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

                                      return BlocProvider.of<Transaction_listBloc>(context).add(TransferListEventEvent(
                                          account_id: widget.accountId, organisation: orgID, fromDate: fromDate, toDate: toDate));
                                    } else {
                                      if (!mounted) return;
                                      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                    }
                                    transactionListApiFunc();
                                  },
                                  child: SvgPicture.asset("assets/svg/filter.svg",color:Color(0xff2BAAFC) ,),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),

                          BlocBuilder<Transaction_listBloc, Transaction_listState>(builder: (context, state) {
                            if (state is TransferListLoading) {
                              return CircularProgressIndicator(
                                color: Color(0xff5728C4),
                              );
                            }

                            if (state is TransferListLoaded) {
                              transactionListModelClass = BlocProvider.of<Transaction_listBloc>(context).transactionListModelClass;

                              return Container(
                                  child: transactionListModelClass.data!.isNotEmpty
                                      ?


                                      ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: transactionListModelClass.data!.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07, bottom: 5),
                                                    color: Color(0xffF8F8F8),
                                                    height: mHeight * .05,
                                                    width: mWidth,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          transactionListModelClass.data![index].date.toString(),
                                                          style: customisedStyle(context, Color(0xff878787), FontWeight.normal, 16.0),
                                                        ),
                                                        Text(
                                                          "$countryCurrencyCode ${roundStringWith(transactionListModelClass.data![index].total.toString())}",
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
                                                        itemCount: transactionListModelClass.data![index].data!.length,
                                                        itemBuilder: (BuildContext context, int indexx) {
                                                          var detailsItem = transactionListModelClass.data![index];
                                                          return Dismissible(
                                                            direction: DismissDirection.endToStart,
                                                            background: Container(
                                                                color: Colors.red,
                                                                child: const Icon(
                                                                  Icons.delete,
                                                                  color: Colors.white,
                                                                )),
                                                            confirmDismiss: (DismissDirection direction) async {

                                                              if (detailsItem.data![indexx].voucherType == "LIC") {
                                                                msgBtmDialogueFunction(context: context, textMsg: "Cant Delete loan transaction");
                                                                return false;
                                                              }

                                                              return await btmDialogueFunction(
                                                                  isDismissible: true,
                                                                  context: context,
                                                                  textMsg: 'Are you sure delete ?',
                                                                  fistBtnOnPressed: () {
                                                                    Navigator.of(context).pop(false);
                                                                  },
                                                                  secondBtnPressed: () async {
                                                                    Navigator.of(context).pop(true);

                                                                    if (detailsItem.data![indexx].voucherType == "TRF" ||
                                                                        detailsItem.data![indexx].voucherType == "TEX" ||
                                                                        detailsItem.data![indexx].voucherType == "TIC") {
                                                                      deleteTransfer(detailsItem.data![indexx].id!);
                                                                    } else {
                                                                      deleteApiFunction(detailsItem.data![indexx].id);
                                                                    }
                                                                  },
                                                                  secondBtnText: 'Delete');
                                                            },
                                                            key: Key('item ${[index]}'),
                                                            onDismissed: (direction) async {},
                                                            child: GestureDetector(
                                                              onTap: () {



                                                                print("from_account_type ${detailsItem.data![indexx].from_account_type}");
                                                                print("to_account_type ${detailsItem.data![indexx].to_account_type}");


                                                                if(detailsItem.data![indexx].from_account_type ==0||detailsItem.data![indexx].to_account_type ==0){
                                                                  msgBtmDialogueFunction(context: context, textMsg: "Cant edit contact transaction");
                                                                }
                                                                else{
                                                                  if (detailsItem.data![indexx].voucherType == "LEX" ||
                                                                      detailsItem.data![indexx].voucherType == "LIC") {
                                                                    msgBtmDialogueFunction(context: context, textMsg: "Cant edit loan transaction");
                                                                  } else {
                                                                    if (detailsItem.data![indexx].voucherType == "TRF" ||
                                                                        detailsItem.data![indexx].voucherType == "TEX" ||
                                                                        detailsItem.data![indexx].voucherType == "TIC") {
                                                                      navigateToEditTransfer(detailsItem.data![indexx].id);
                                                                    }
                                                                    else {
                                                                      navigateToEdit(detailsItem.data![indexx].id, detailsItem.data![indexx].voucherType);
                                                                    }
                                                                  }
                                                                }


                                                              },
                                                              child: Container(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                          height: mHeight * .01,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                                                                      child: Container(
                                                                        padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                                                                        color: Colors.white,
                                                                        width: mWidth,
                                                                        child: Column(
                                                                          children: [
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      returnVoucherType(detailsItem.data![indexx].voucherType),
                                                                                      style: customisedStyle(
                                                                                          context,
                                                                                          returnColorVoucherType(
                                                                                              detailsItem.data![indexx].voucherType),
                                                                                          FontWeight.w500,
                                                                                          13.0),
                                                                                    ),


                                                                                  ],
                                                                                ),
                                                                                Text(
                                                                                  "$countryCurrencyCode ${roundStringWith(detailsItem.data![indexx].amount!)}",
                                                                                  style: customisedStyle(
                                                                                      context,
                                                                                      returnColorVoucherType(detailsItem.data![indexx].voucherType),
                                                                                      FontWeight.w600,
                                                                                      14.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      returnAccountDetails(detailsItem.data![indexx].fromAccountName,
                                                                                          detailsItem.data![indexx].toAccountName),
                                                                                      style: customisedStyle(
                                                                                          context, Colors.black, FontWeight.w500, 15.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Text(
                                                                                  detailsItem.data![indexx].description!,
                                                                                  style: customisedStyle(
                                                                                      context, Color(0xff878787), FontWeight.normal, 12.0),
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
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                ],
                                              ),
                                            );
                                          })
                                      : SizedBox(
                                          height: mHeight * .4,
                                          child: const Center(
                                              child: Text(
                                            "Items not found !",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ))));
                            }
                            if (state is TransferListLoaded) {
                              return Center(
                                  child: Text(
                                "Something went wrong",
                                style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                              ));
                            }
                            return SizedBox();
                          }),


                          SizedBox(
                            height: mHeight * .02,
                          )
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Container(
                      color: const Color(0xffF3F7FC),
                      height: MediaQuery.of(context).size.height * .08,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                                List<List<String?>> data = [
                                  ['', '     ', '', '     '],
                                  ['', '     ', '', '     '],
                                  ['Date', 'Particular', 'Amount', 'Notes'],
                                ];

                                for (var i = 0; i < transactionListModelClass.data!.length; i++) {
                                  String symbol = "-";
                                  var detailsItem = transactionListModelClass.data![i].data;

                                  for (var t = 0; t < detailsItem!.length; t++) {
                                    String notes = detailsItem[t].description!;

                                    String accountName = returnAccountDetails(detailsItem[t].fromAccountName, detailsItem[t].toAccountName);
                                    String value = returnVoucherType(detailsItem[t].voucherType);
                                    String amount = roundStringWith(detailsItem[t].amount!);
                                    String check = symbol + amount;
                                    String finalAmount = value == "Expense" ? check : amount;

                                    var a = [transactionListModelClass.data![i].date, accountName, finalAmount, notes];
                                    data.add(a);
                                  }


                                }
                                var head = "${dashboardDEtailModel.data!.accountName!}Report";

                                if (value == 'pdf') {
                                  loadDataToReport(data: data, heading: head, date: "", type: 1,balance: '');
                                } else if (value == 'excel') {
                                  convertToExcel(data: data, heading: head, date: "",balance: '');
                                } else {}
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.only(right: mWidth * .08),
                          child: PopupMenuButton<String>(
                            icon: Icon(
                              Icons.add,
                              color: Color(0xff2BAAFC),
                            ),
                            itemBuilder: (BuildContext context) {
                              return [

                                PopupMenuItem(
                                  value: 'expenses',
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Expenses",
                                        style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                      ),
                                      SvgPicture.asset("assets/svg/cicle_expense.svg"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'income',
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Income",
                                        style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                      ),
                                      SvgPicture.asset("assets/svg/circle_income.svg"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'transfer',
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Transfer",
                                        style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                      ),
                                      SvgPicture.asset("assets/svg/circle_transfer.svg"),
                                    ],
                                  ),
                                ),
                              ];
                            },
                            onSelected: (String value) async {
                              if (value == 'income') {
                                var result = await Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TransactionPageIncome(
                                          isZakath: false,
                                          isDetail: true,
                                          type: "Create",
                                          assetMasterID: 0,
                                          isAsset: false,
                                      reminderID: "",
                                      isFromNotification: false,
                                          balance: "0.00",
                                          amount: "0.00",
                                          transactionType: "1",
                                          to_account_id: widget.accountId,
                                          to_accountName: dashboardDEtailModel.data!.accountName!,
                                          description: "",
                                          from_account_id: "",
                                          from_accountName: "",
                                          id: "",
                                          date: "",
                                          isInterest: false,
                                          isReminder: false,
                                          isReminderDate: "",
                                        )));

                                dashboardDetailFunction();
                                transactionListApiFunc();
                              } else if (value == 'expenses') {
                                var result = await Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TransactionPageExpense(
                                          isAsset: false,
                                          assetMasterID: 0,
                                          fromAccounts: true,
                                          zakath: false,
                                          isDetail: true,
                                          type: "Create",
                                          balance: "0.00",
                                          amount: "0.00",

                                      reminderID: "",
                                      isFromNotification: false,
                                          to_account_id: "",
                                          to_accountName: "",
                                          transactionType: "1",
                                          description: "",
                                          from_account_id: widget.accountId,
                                          from_accountName: dashboardDEtailModel.data!.accountName!,
                                          id: "",
                                          date: "",
                                          isInterest: false,
                                          isReminder: false,
                                          isReminderDate: '',
                                        )));

                                dashboardDetailFunction();
                                transactionListApiFunc();
                              } else if (value == 'transfer') {
                                var result = await Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddTransferTransaction(
                                          toAmount: "0.0",
                                          to_country_Name: "",
                                          to_country_id: "",
                                          from_country_Name: "",
                                          from_country_id: "",
                                          type: "Create",
                                          balance: "0.00",
                                          fromAmount: "0.00",
                                          to_account_id: "",
                                          to_accountName: "",
                                          transactionType: "1",
                                          description: "",
                                          from_account_id: widget.accountId,
                                          from_accountName: dashboardDEtailModel.data!.accountName!,
                                          id: "",
                                          date: "",
                                          isZakah: false,
                                        )));

                                dashboardDetailFunction();
                                transactionListApiFunc();
                              } else {}
                            },
                          ),
                        )
                      ])));
            }
            if (state is DashDetailsError) {
              return Center(
                child: Text(
                  "Something went wrong",
                  style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                ),
              );
            }
            return SizedBox();
          },
        ));
  }

  List<List<String>> extractDataFromJson(jsonData) {
    final List<dynamic> dataList = jsonDecode(jsonData);
    List<List<String>> data = [];

    for (final item in dataList) {
      for (final dynamic dataItem in item['data']) {
        final row = [
          item['date'],
          dataItem['from_account_name'],
          dataItem['amount'].toString(),
        ];
        data.add(row.cast<String>());
      }
    }

    return data;
  }

  navigateToEdit(id, type) async {
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
          var result;
          if (type == "IC" || type == "AIC") {
            result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TransactionPageIncome(
                      isDetail: false,
                      assetMasterID: 0,
                      isAsset: false,
                  reminderID: "",
                  isFromNotification: false,
                      type: "Edit",
                      balance: "0.00",
                      transactionType: "",
                      amount: responseJson["amount"].toString(),
                      to_account_id: responseJson["to_account"]["id"],
                      to_accountName: responseJson["to_account"]["account_name"],
                      description: responseJson["description"],
                      from_account_id: responseJson["from_account"]["id"],
                      isZakath: responseJson["is_zakath"],
                      from_accountName: responseJson["from_account"]["account_name"],
                      id: id,
                      date: responseJson["date"],
                      isInterest: responseJson["is_interest"],
                      isReminder: responseJson["is_reminder"] ?? false,
                      isReminderDate: responseJson["reminder_date"] ?? '2023-09-19',
                    )));
          } else {
            result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TransactionPageExpense(
                      zakath: responseJson["is_zakath"],
                      isAsset: false,
                  reminderID: "",
                  isFromNotification: false,
                      assetMasterID: 0,
                      isDetail: false,
                      type: "Edit",
                      balance: "0.00",
                      transactionType: "",
                      amount: responseJson["amount"].toString(),
                      to_account_id: responseJson["to_account"]["id"],
                      to_accountName: responseJson["to_account"]["account_name"],
                      description: responseJson["description"]??"",
                      from_account_id: responseJson["from_account"]["id"],
                      from_accountName: responseJson["from_account"]["account_name"],
                      id: id,
                      date: responseJson["date"],
                      isInterest: responseJson["is_interest"],
                      isReminder: responseJson["is_reminder"] ?? false,
                      isReminderDate: responseJson["reminder_date"] ?? '2023-09-19',
                    )));
          }

          if (result != null) {
            dashboardDetailFunction();
            transactionListApiFunc();
          }
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

  navigateToEditTransfer(id) async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      showProgressBar();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String baseUrl = ApiClient.basePath;
        var accessToken = prefs.getString('token') ?? '';
        final organizationId = prefs.getString("organisation");
        var uri = "transfer/details-transfer/";
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
              builder: (context) => AddTransferTransaction(
                    from_country_id: responseJson["from_country"]["id"],
                    from_country_Name: responseJson["from_country"]["country_name"],
                    to_country_id: responseJson["to_country"]["id"],
                    to_country_Name: responseJson["to_country"]["country_name"],
                    toAmount: responseJson["to_amount"].toString(),
                    type: "Edit",
                    balance: "0.00",
                    transactionType: "0",
                    fromAmount: responseJson["from_amount"].toString(),
                    to_account_id: responseJson["to_account"]["id"],
                    to_accountName: responseJson["to_account"]["account_name"],
                    description: responseJson["description"],
                    from_account_id: responseJson["from_account"]["id"],
                    from_accountName: responseJson["from_account"]["account_name"],
                    id: id,
                    date: responseJson["date"],
                    isZakah: responseJson["is_zakath"],
                  )));

          if (result != null) {
            dashboardDetailFunction();
            transactionListApiFunc();
          }
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

  returnVoucherType(type) {

    if (type == "LEX" || type == "LIC") {
      return "Loan";
    } else if (type == "EX" || type == "AEX") {
      return "Expense";
    } else if (type == "IC" || type == "AIC") {
      return "Income";
    } else if (type == "TEX" || type == "TIC") {
      return "Transfer";
    } else {
      return "";
    }

  }

  returnColorVoucherType(type) {
    if (type == "EX" || type == "AEX" || type == "TEX" || type == "LEX") {
      return Color(0xffEC0000);
    } else if (type == "IC" || type == "AIC" || type == "TIC" || type == "LIC") {
      return Color(0xff017511);
    } else if (type == "TRF") {
      return Color(0xff3A8ABF);
    } else {
      return Colors.black;
    }
  }

  returnAccountDetails(fromAccount, toAccount) {
    if (dashboardDEtailModel.data!.accountName == fromAccount) {
      return toAccount;
    } else {
      return fromAccount;
    }
  }
}
