import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../../Api Helper/Bloc/Account/account_bloc.dart';
import '../../../../Api Helper/Bloc/NewDesignBloc/expnse/new_expense_bloc.dart';
import '../../../../Api Helper/ModelClasses/New Design ModelClass/exp/DelteTransactionModelClass.dart';
import '../../../../Api Helper/ModelClasses/New Design ModelClass/exp/ModelClassDetailExpense.dart';
import '../../../../Api Helper/ModelClasses/Settings/Account/DeleteAccountModelClass.dart';
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
import 'btmsheetclass.dart';
import 'filter_in_exp_detail.dart';
import 'transaction_page_expense.dart';

class ExpenseDetailScreen extends StatefulWidget {
  const ExpenseDetailScreen({Key? key, required this.id, required this.AccountName, required this.total, required this.thisMonth}) : super(key: key);
  final String id;
  final String AccountName;
  final String total;
  final String thisMonth;

  @override
  State<ExpenseDetailScreen> createState() => _ExpenseDetailScreenState();
}

class _ExpenseDetailScreenState extends State<ExpenseDetailScreen> {
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

  @override
  void initState() {
    progressBar = ProgressBar();
    detailExpenseApiFunction();
    super.initState();
  }

  deleteExpenseApi() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<AccountBloc>(context).add(DeleteAccountEvent(id: widget.id, organisation: organizationId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  String appBarTitle = "Initial Title";

  void updateAppBarTitle(String newTitle) {
    setState(() {
      appBarTitle = newTitle;
    });
  }

  detailExpenseApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<NewExpenseBloc>(context)
          .add(FetchNewExpenseDetailEvent(accountId: widget.id, pageNumber: 1, pageSize: 50, fromDate: '', toDate: ''));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  late DeleteAccountModelClass deleteAccountModelClass;
  late ModelClassDetailExpense modelClassDetailExpense;

  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late DelteTransactionModelClass delteTransactionModelClass;

  var fromDate;

  var toDate;

  String getShortenedName(String fullName) {
    const int maxLength = 12;
    return fullName.length <= maxLength ? fullName : fullName.substring(0, maxLength - 1) + "...";
  }

  bool _isVisible = false;
  CommonBottomSheetClass commonBottomSheetClass = CommonBottomSheetClass();

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
        BlocListener<NewExpenseBloc, NewExpenseState>(
          listener: (context, state) async {
            if (state is ExpenseTransactionDeleteLoaded) {
              hideProgressBar();
              delteTransactionModelClass = BlocProvider.of<NewExpenseBloc>(context).delteTransactionModelClass;

              if (delteTransactionModelClass.statusCode == 6000) {

                detailExpenseApiFunction();
              }
              if (delteTransactionModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
              }
            }
            if (state is ExpenseTransactionDeleteError) {
              hideProgressBar();
            }
          },
        ),
      ],
      child: BlocBuilder<NewExpenseBloc, NewExpenseState>(
        builder: (context, state) {
          if (state is ExpenseDetailLoading) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xff5728C4),
                ),
              ),
            );
          }
          if (state is ExpenseDetailLoaded) {
            modelClassDetailExpense = BlocProvider.of<NewExpenseBloc>(context).modelClassDetailExpense;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: MediaQuery.of(context).size.height / 11,

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
                elevation: 0,
                automaticallyImplyLeading: true,
                titleSpacing: 0,
                title: Container(
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          getShortenedName(modelClassDetailExpense.summary!.accountName!),
                          overflow: TextOverflow.ellipsis,
                          style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 17.0),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10.0),
                        child: Text(
                          "Expense",
                          style: customisedStyle(context, Color(0xffC91010), FontWeight.normal, 11.0),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        commonBottomSheetClass.ExpenseAddBottomSheet(
                            context: context,
                            type: 'Edit',
                            addOrEdit: 'Edit',
                            id: widget.id,
                            typeName: modelClassDetailExpense.summary!.accountName!);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xff2BAAFC),
                      )),
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
                              deleteExpenseApi();
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
                  child: Column(children: [
                    Container(
                      height: mHeight * .09,
                      decoration: BoxDecoration(
                          color: Color(0xffF9F9F9),
                          border: Border.all(
                            color: Color(0xffE2E2E2),
                          )),
                      child: Row(
                        children: [
                          Container(
                            width: mWidth * .4,
                            padding: EdgeInsets.only(left: mWidth * .04, top: mHeight * .02, bottom: mHeight * .02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total",
                                  style: customisedStyle(context, Color(0xff0D4A95), FontWeight.normal, 13.0),
                                ),
                                Text(
                                  countryCurrencyCode + " " + "${roundStringWith(modelClassDetailExpense.summary!.total!)}",
                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: mWidth * .08,
                          ),
                          Container(color: Color(0xffE2E2E2), height: mHeight * .1, width: 1),
                          Container(
                            padding: EdgeInsets.only(top: mHeight * .02, bottom: mHeight * .02, left: mWidth * .04),
                            width: mWidth * .4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "This Month",
                                  style: customisedStyle(context, Color(0xffC91010), FontWeight.normal, 13.0),
                                ),
                                Text(
                                  countryCurrencyCode + " " + "${roundStringWith(modelClassDetailExpense.summary!.thisMonth!)!}",
                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
                      height: mHeight * .1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Transactions",
                                style: customisedStyle(context, Colors.black, FontWeight.w600, 16.0),
                              ),
                              SizedBox(
                                width: mWidth * .03,
                              ),
                              fromDate != null && toDate != null
                                  ? Visibility(
                                      visible: _isVisible,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isVisible = !_isVisible;
                                            detailExpenseApiFunction();
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
                                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                                                ),
                                                Icon(
                                                  Icons.close,
                                                  color: Color(0xff2BAAFC),
                                                )
                                              ],
                                            )),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                          GestureDetector(
                              onTap: () async {
                                final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailExpenseFilter()));

                                if (result != null) {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                    fromDate = result[0];
                                    toDate = result[1];
                                  });
                                }

                                var netWork = await checkNetwork();

                                if (netWork) {
                                  if (!mounted) return;
                                  return BlocProvider.of<NewExpenseBloc>(context).add(FetchNewExpenseDetailEvent(
                                      accountId: widget.id, pageNumber: 1, pageSize: 50, fromDate: fromDate, toDate: toDate));
                                } else {
                                  if (!mounted) return;
                                  msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                }
                              },
                              child: SvgPicture.asset("assets/svg/filter.svg")),
                        ],
                      ),
                    ),
                    Container(
                        color: Colors.white,
                        child: modelClassDetailExpense.data!.isNotEmpty
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: modelClassDetailExpense.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DateTime date = DateTime.parse(modelClassDetailExpense.data![index].date.toString());

                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                                        color: Color(0xffF8F8F8),
                                        height: mHeight * .05,
                                        width: mWidth,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              dateFormat.format(date),
                                              style: customisedStyle(context, Color(0xff878787), FontWeight.normal, 16.0),
                                            ),
                                            Text(
                                              countryCurrencyCode + " " + "${roundStringWith(modelClassDetailExpense.data![index].total!)}",
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
                                            itemCount: modelClassDetailExpense.data![index].data!.length,
                                            itemBuilder: (BuildContext context, int iindex) {
                                              var detailsItem = modelClassDetailExpense.data![index];

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

                                                          showProgressBar();

                                                          return BlocProvider.of<NewExpenseBloc>(context)
                                                              .add(FetchDeleteTransactionEvent(id: detailsItem.data![iindex].id!));
                                                        } else {
                                                          if (!mounted) return;
                                                          msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                                        }
                                                      },
                                                      secondBtnText: 'Delete');
                                                },
                                                key: Key(detailsItem.data![iindex].id!),
                                                onDismissed: (direction) async {},
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: mHeight * .01,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (detailsItem.data![iindex].voucherType == "LIC") {
                                                            msgBtmDialogueFunction(context: context, textMsg: "Loan transaction cant edit from here");
                                                          } else {
                                                            navigateToEdit(detailsItem.data![iindex].id!);
                                                          }


                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                                                          color: Colors.white,
                                                          height: mHeight * .06,
                                                          width: mWidth,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    detailsItem.data![iindex].fromAccountName!,
                                                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                                                  ),
                                                                  Text(
                                                                    countryCurrencyCode +
                                                                        " " +
                                                                        "${roundStringWith(detailsItem.data![iindex].amount!)}",
                                                                    style: customisedStyle(context, Color(0xffC91010), FontWeight.w600, 14.0),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Text(
                                                                    detailsItem.data![iindex].description!,
                                                                    style: customisedStyle(context, Color(0xff878787), FontWeight.normal, 12.0),
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
                                              );
                                            }),
                                      )
                                    ],
                                  );
                                })
                            : SizedBox(
                                height: mHeight * .7,
                                child: const Center(
                                    child: Text(
                                  "Not found !",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))))
                  ]),
                ),
              ),
              bottomNavigationBar:
              Container(
                padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .03),
                color: const Color(0xffF3F7FC),
                height: MediaQuery.of(context).size.height * .07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<String>(
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
                        var head = "${modelClassDetailExpense.summary!.accountName!} Report";
                        var dateDet = fromDate == null && toDate == null ? "" : "$fromDate $toDate";

                        if (modelClassDetailExpense.data!.isEmpty) {
                          msgBtmDialogueFunction(context: context, textMsg: "Please ensure there is data before exporting.");
                        } else {
                          for (var i = 0; i < modelClassDetailExpense.data!.length; i++) {
                            var detailsItem = modelClassDetailExpense.data![i].data;
                            for (var t = 0; t < detailsItem!.length; t++) {
                              String accountName = returnAccountDetails(detailsItem[t].fromAccountName, detailsItem[t].toAccountName);
                              String note = detailsItem[t].description!;
                              List<String?> a = [modelClassDetailExpense.data![i].date, accountName, roundStringWith(detailsItem[t].amount!), note];
                              data.add(a);
                            }
                          }
                          if (value == 'pdf') {
                            loadDataToReport(data: data, heading: head, date: "", type: 1,balance: '');
                          } else if (value == 'excel') {
                            convertToExcel(data: data, heading: head, date: dateDet,balance: '');
                          } else {}
                        }
                      },
                    ),
                    IconButton(
                        onPressed: () async {
                          var result = await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TransactionPageExpense(
                                    isAsset: false,
                                    assetMasterID: 0,
                                    isFromNotification: false,
                                    reminderID: "",
                                    zakath: false,
                                    isDetail: true,
                                    type: "Create",
                                    balance: "0.00",
                                    amount: "0.00",
                                    transactionType: "3",
                                    to_account_id: widget.id,
                                    to_accountName: widget.AccountName,
                                    description: "",
                                    from_account_id: "",
                                    from_accountName: "",
                                    id: "",
                                    date: "",
                                    isInterest: false,
                                    isReminder: false,
                                    isReminderDate: '',
                                  )));

                          detailExpenseApiFunction();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Color(0xff2BAAFC),
                        ))
                  ],
                ),
              ),
            );
          }
          if (state is ExpenseDetailError) {
            return Center(
                child: Text(
              "Something went wrong",
              style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
            ));
          }
          return SizedBox();
        },
      ),
    );
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
              builder: (context) => TransactionPageExpense(
                    isAsset: false,
                    assetMasterID: 0,
                isFromNotification: false,
                reminderID: "",
                    zakath: responseJson["is_zakath"],
                    isDetail: false,
                    type: "Edit",
                    balance: "0.00",
                    transactionType: "",
                    amount: responseJson["amount"].toString(),
                    to_account_id: responseJson["to_account"]["id"],
                    to_accountName: responseJson["to_account"]["account_name"],
                    description: responseJson["description"] ?? "",
                    from_account_id: responseJson["from_account"]["id"],
                    from_accountName: responseJson["from_account"]["account_name"],
                    id: id,
                    date: responseJson["date"],
                    isInterest: responseJson["is_interest"],
                    isReminder: responseJson["is_reminder"] ?? false,
                    isReminderDate: responseJson["reminder_date"] ?? '2023-09-19',
                  )));

          detailExpenseApiFunction();
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

  returnAccountDetails(fromAccount, toAccount) {
    if (modelClassDetailExpense.summary!.accountName! == fromAccount) {
      return toAccount;
    } else {
      return fromAccount;
    }
  }
}
