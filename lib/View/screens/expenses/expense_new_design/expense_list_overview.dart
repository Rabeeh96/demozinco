import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Api Helper/Bloc/NewDesignBloc/expnse/exptransaction_bloc.dart';
import '../../../../Api Helper/Bloc/NewDesignBloc/expnse/new_expense_bloc.dart';
import '../../../../Api Helper/ModelClasses/New Design ModelClass/exp/DelteTransactionModelClass.dart';
import '../../../../Api Helper/ModelClasses/New Design ModelClass/exp/ModelClassExpense.dart';
import '../../../../Api Helper/ModelClasses/New Design ModelClass/exp/TransactionExpenseModelClass.dart';
import '../../../../Api Helper/Repository/api_client.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';
import '../../../../Utilities/global/variables.dart';
import '../../../Export/export_from_to.dart';
import '../../../Export/export_to_pdf.dart';
import 'btmsheetclass.dart';
import 'expense_detail_screen.dart';
import 'filter.dart';
import 'transaction_page_expense.dart';

class ListExpenseScreen extends StatefulWidget {
  const ListExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ListExpenseScreen> createState() => _ListExpenseScreenState();
}

class _ListExpenseScreenState extends State<ListExpenseScreen> {
  listExpenseApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<NewExpenseBloc>(context).add(
          FetchNewExpenseOverviewEvent(
              fromDate: "", toDate: "", pageNumber: 1, pageSize: 50));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  late ModelClassExpense modelClassExpense;
  CommonBottomSheetClass commonBottomSheetClass = CommonBottomSheetClass();

  @override
  void initState() {
    progressBar = ProgressBar();

    listExpenseApiFunction();
    listTransactionApiFunction();
    super.initState();
  }

  bool _isVisible = false;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  var fromDate;

  var toDate;

  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late DelteTransactionModelClass delteTransactionModelClass;
  String dropdownvalue = 'Quaterly';

  var items = [
    'Quaterly',
    'Halfearly',
  ];
  late TransactionExpenseModelClass transactionExpenseModelClass;

  listTransactionApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<ExptransactionBloc>(context)
          .add(FetchExpTransactionEvent(fromDate: '', toDate: ''));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  DateFormat apiDateFormat = DateFormat("y-M-d");

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
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .02,
    );
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expense',
                  style: customisedStyle(
                      context, Color(0xff13213A), FontWeight.w500, 21.0),
                ),
                Container(
                    alignment: Alignment.center,
                    height: mHeight * .05,
                    width: mWidth * .3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF3F7FC)),
                    child: Text(
                      default_country_name + " - " + countryShortCode,
                      style: customisedStyle(
                          context, Color(0xff0073D8), FontWeight.w500, 14.0),
                    )
                )
              ],
            ),
          ),
          body: Container(
              height: mHeight,
              color: Colors.white,
              child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(children: [
                    Container(
                      color: Colors.white,

                      height: mHeight,
                      child: Column(
                        children: [
                          BlocBuilder<NewExpenseBloc, NewExpenseState>(
                            builder: (context, state) {
                              if (state is ExpenseOverviewLoading) {
                                return Container(
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
                                        padding: EdgeInsets.only(
                                            left: mWidth * .04,
                                            top: mHeight * .02,
                                            bottom: mHeight * .02),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total",
                                              style: customisedStyle(
                                                  context,
                                                  Color(0xff0D4A95),
                                                  FontWeight.normal,
                                                  12.0),
                                            ),
                                            Text(
                                              countryCurrencyCode +
                                                  " " +
                                                  "0.00",
                                              style: customisedStyle(
                                                  context,
                                                  Colors.black,
                                                  FontWeight.w500,
                                                  14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: mWidth * .08,
                                      ),
                                      Container(
                                          color: Color(0xffE2E2E2),
                                          height: mHeight * .1,
                                          width: 1),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: mHeight * .02,
                                            bottom: mHeight * .02,
                                            left: mWidth * .04),
                                        width: mWidth * .4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "This Month",
                                              style: customisedStyle(
                                                  context,
                                                  Colors.red,
                                                  FontWeight.normal,
                                                  12.0),
                                            ),
                                            Text(
                                              countryCurrencyCode +
                                                  " " +
                                                  "0.00",
                                              style: customisedStyle(
                                                  context,
                                                  Colors.black,
                                                  FontWeight.w500,
                                                  14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              if (state is ExpenseOverviewLoaded) {
                                modelClassExpense =
                                    BlocProvider.of<NewExpenseBloc>(context)
                                        .modelClassExpense;
                                return Container(
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
                                        padding: EdgeInsets.only(
                                            left: mWidth * .04,
                                            top: mHeight * .02,
                                            bottom: mHeight * .02),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              "Total",
                                              style: customisedStyle(
                                                  context,
                                                  Color(0xff0D4A95),
                                                  FontWeight.normal,
                                                  12.0),
                                            ),
                                            Text(
                                              countryCurrencyCode +
                                                  " " +
                                                  "${roundStringWith(modelClassExpense.summary!.total.toString())}",
                                              style: customisedStyle(
                                                  context,
                                                  Colors.black,
                                                  FontWeight.w500,
                                                  14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: mWidth * .08,
                                      ),
                                      Container(
                                          color: Color(0xffE2E2E2),
                                          height: mHeight * .1,
                                          width: 1),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: mHeight * .02,
                                            bottom: mHeight * .02,
                                            left: mWidth * .04),
                                        width: mWidth * .4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "This Month",
                                              style: customisedStyle(
                                                  context,
                                                  Colors.red,
                                                  FontWeight.normal,
                                                  12.0),
                                            ),
                                            Text(
                                              countryCurrencyCode +
                                                  " " +
                                                  "${roundStringWith(modelClassExpense.summary!.thisMonth.toString())}",
                                              style: customisedStyle(
                                                  context,
                                                  Colors.black,
                                                  FontWeight.w500,
                                                  14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              if (state is ExpenseOverviewError) {
                                return Center(
                                    child: Text(
                                  "Something went wrong",
                                  style: customisedStyle(context, Colors.black,
                                      FontWeight.w500, 13.0),
                                ));
                              }
                              return SizedBox();
                            },
                          ),
                          Container(
                            height: mHeight * .08,
                            child: AppBar(
                              elevation: 1,
                              backgroundColor: Colors.white,
                              bottom: TabBar(
                                indicatorWeight: 5,
                                indicatorColor: Color(0xff2BAAFC),
                                tabs: [
                                  Tab(
                                    icon: Text(
                                      "Overview",
                                      style: customisedStyle(
                                          context,
                                          Colors.black,
                                          FontWeight.normal,
                                          14.0),
                                    ),
                                  ),
                                  Tab(
                                    icon: Text(
                                      "Transactions",
                                      style: customisedStyle(
                                          context,
                                          Colors.black,
                                          FontWeight.normal,
                                          14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(children: [
                              overView(),
                              transaction(),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ]))),
        ));
  }

  Widget overView() {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              BlocBuilder<NewExpenseBloc, NewExpenseState>(
                builder: (context, state) {
                  if (state is ExpenseOverviewLoading) {
                    return CircularProgressIndicator(
                      color: Color(0xff5728C4),
                    );
                  }
                  if (state is ExpenseOverviewLoaded) {
                    modelClassExpense = BlocProvider.of<NewExpenseBloc>(context)
                        .modelClassExpense;
                    return GridView.builder(
                      padding: EdgeInsets.only(
                        left: mWidth * .04,
                        right: mWidth * .04,
                      ),
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: modelClassExpense.data!.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 100, // here set custom Height You Want
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (modelClassExpense.data!.isEmpty ||
                            modelClassExpense.data!.length == index) {
                          return Center(
                            child: Container(
                              height: mHeight / 18,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffF9F9F9),

                                  shape: const CircleBorder(),
                                ),
                                onPressed: () {
                                  commonBottomSheetClass.ExpenseAddBottomSheet(
                                      context: context,
                                      type: 'Create',
                                      addOrEdit: 'Add',
                                      id: "");
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => ExpenseDetailScreen(
                                            id: modelClassExpense
                                                .data![index].id!,
                                            AccountName: modelClassExpense
                                                .data![index].accountName!,
                                            total: modelClassExpense
                                                .summary!.total!,
                                            thisMonth: modelClassExpense
                                                .summary!.thisMonth!,
                                          )));
                              listExpenseApiFunction();
                              listTransactionApiFunction();
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: mWidth * .2,

                                      child: Text(
                                        modelClassExpense
                                            .data![index].accountName!,
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(
                                            context,
                                            Color(0xff5B5B5B),
                                            FontWeight.w500,
                                            10.0),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xffF54040),
                                      child: SvgPicture.asset(
                                        'assets/menu/expense_wallet.svg',
                                        width: 25,
                                        height: 25,
                                      ),
                                      minRadius: 25,
                                      maxRadius: 25,
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: mWidth * .3,
                                      child: Text(
                                        countryCurrencyCode +
                                            " " +
                                            roundStringWith(modelClassExpense
                                                .data![index].balance!),
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(
                                            context,
                                            Color(0xff000000),
                                            FontWeight.w500,
                                            10.0),
                                      )),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );

                  }
                  if (state is ExpenseOverviewError) {
                    return Center(
                        child: Text(
                      "Something went wrong",
                      style: customisedStyle(
                          context, Colors.black, FontWeight.w500, 13.0),
                    ));
                  }
                  return SizedBox();
                },
              ),
              Container(
                height: mHeight * .2,
              )
            ])));
  }

  Widget transaction() {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
        listeners: [
          BlocListener<NewExpenseBloc, NewExpenseState>(
            listener: (context, state) async {
              if (state is ExpenseTransactionDeleteLoaded) {
                hideProgressBar();
                delteTransactionModelClass =
                    BlocProvider.of<NewExpenseBloc>(context)
                        .delteTransactionModelClass;

                if (delteTransactionModelClass.statusCode == 6000) {

                  listExpenseApiFunction();
                  listTransactionApiFunction();
                }
                if (delteTransactionModelClass.statusCode == 6001) {
                  msgBtmDialogueFunction(
                      context: context, textMsg: "Something went wrong");
                }
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<ExptransactionBloc, ExptransactionState>(
            builder: (context, state) {
              if (state is ExpTransactionLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff5728C4),
                  ),
                );
              }
              if (state is ExpTransactionLoaded) {
                transactionExpenseModelClass =
                    BlocProvider.of<ExptransactionBloc>(context)
                        .transactionExpenseModelClass;
                return Container(
                    color: Colors.white,
                    child: transactionExpenseModelClass.data!.isNotEmpty
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                transactionExpenseModelClass.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime date = DateTime.parse(
                                  transactionExpenseModelClass.data![index].date
                                      .toString());

                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: mWidth * .07,
                                          right: mWidth * .07),
                                      color: Color(0xffF8F8F8),
                                      height: mHeight * .05,
                                      width: mWidth,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            dateFormat.format(date),
                                            style: customisedStyle(
                                                context,
                                                Color(0xff878787),
                                                FontWeight.normal,
                                                16.0),
                                          ),
                                          Text(
                                            countryCurrencyCode +
                                                " " +
                                                "${roundStringWith(transactionExpenseModelClass.data![index].total!)}",
                                            style: customisedStyle(
                                                context,
                                                Colors.black,
                                                FontWeight.w600,
                                                14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 1,
                                        color: Color(0xffE2E2E2),
                                        width: mWidth * .99),
                                    Container(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              transactionExpenseModelClass
                                                  .data![index].data!.length,
                                          itemBuilder: (BuildContext context,
                                              int indexx) {
                                            var detailsItem =
                                                transactionExpenseModelClass
                                                    .data![index];

                                            return Dismissible(
                                              direction:
                                                  DismissDirection.endToStart,
                                              background: Container(
                                                  color: Colors.red,
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  )),
                                              confirmDismiss: (DismissDirection
                                                  direction) async {
                                                return await btmDialogueFunction(
                                                    isDismissible: true,
                                                    context: context,
                                                    textMsg:
                                                        'Are you sure delete ?',
                                                    fistBtnOnPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    secondBtnPressed: () async {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      var netWork =
                                                          await checkNetwork();
                                                      if (netWork) {
                                                        if (!mounted) return;

                                                        showProgressBar();

                                                        return BlocProvider.of<
                                                                    NewExpenseBloc>(
                                                                context)
                                                            .add(FetchDeleteTransactionEvent(
                                                                id: detailsItem
                                                                    .data![
                                                                        indexx]
                                                                    .id!));
                                                      } else {
                                                        if (!mounted) return;
                                                        msgBtmDialogueFunction(
                                                            context: context,
                                                            textMsg:
                                                                "Check your network connection");
                                                      }
                                                    },
                                                    secondBtnText: 'Delete');
                                              },
                                              key: Key(detailsItem
                                                  .data![indexx].id!),
                                              onDismissed: (direction) async {},
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: mHeight * .01,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {



                                                        if(detailsItem.data![indexx].voucherType =="LON"){
                                                         msgBtmDialogueFunction(context: context, textMsg: "Loan transaction cant edit from here");
                                                        }
                                                        else{
                                                          navigateToEdit(
                                                              detailsItem
                                                                  .data![indexx]
                                                                  .id);
                                                        }


                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: mWidth *
                                                                    .07,
                                                                right: mWidth *
                                                                    .07),
                                                        color: Colors.white,
                                                        height: mHeight * .07,
                                                        width: mWidth,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  detailsItem
                                                                      .data![
                                                                          indexx]
                                                                      .fromAccountName!,
                                                                  style: customisedStyle(
                                                                      context,
                                                                      Colors
                                                                          .black,
                                                                      FontWeight
                                                                          .w500,
                                                                      15.0),
                                                                ),
                                                                Text(
                                                                  countryCurrencyCode +
                                                                      " " +
                                                                      roundStringWith(detailsItem
                                                                          .data![
                                                                              indexx]
                                                                          .amount!),
                                                                  style: customisedStyle(
                                                                      context,
                                                                      Color(
                                                                          0xffEC0000),
                                                                      FontWeight
                                                                          .w600,
                                                                      14.0),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      detailsItem
                                                                          .data![
                                                                              indexx]
                                                                          .toAccountName!,
                                                                      style: customisedStyle(
                                                                          context,
                                                                          Color(
                                                                              0xff2BAAFC),
                                                                          FontWeight
                                                                              .w500,
                                                                          13.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  detailsItem
                                                                      .data![
                                                                          indexx]
                                                                      .description!,
                                                                  style: customisedStyle(
                                                                      context,
                                                                      Color(
                                                                          0xff878787),
                                                                      FontWeight
                                                                          .normal,
                                                                      12.0),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        height: 1,
                                                        color:
                                                            Color(0xffE2E2E2),
                                                        width: mWidth * .99),
                                                  ],
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
                            height: mHeight * .7,
                            child: const Center(
                                child: Text(
                              "Items not found !",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ))));
              }
              if (state is ExpTransactionError) {
                return Center(
                    child: Text(
                  "Something went wrong",
                  style: customisedStyle(
                      context, Colors.black, FontWeight.w500, 13.0),
                ));
              }
              return SizedBox();
            },
          ),
          bottomNavigationBar: Container(
              height: MediaQuery.of(context).size.height * .2,
              color: Colors.white,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: mWidth * .08,
                    bottom: mHeight * .10,
                    right: mWidth * .03),
                margin: EdgeInsets.symmetric(vertical: 11),
                color: const Color(0xffF3F7FC),
                height: MediaQuery.of(context).size.height * .18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PopupMenuButton<String>(
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
                              style: customisedStyle(
                                  context, Colors.black, FontWeight.w500, 14.0),
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
                                  style: customisedStyle(context, Colors.black,
                                      FontWeight.w500, 13.0),
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
                                  style: customisedStyle(context, Colors.black,
                                      FontWeight.w500, 13.0),
                                ),
                                SvgPicture.asset("assets/svg/excel.svg",),
                              ],
                            ),
                          ),
                        ];
                      },
                      onSelected: (String value) async {
                        var head = "Expense Report";
                        var dateDet =  fromDate == null && toDate == null ? "": "$fromDate $toDate";

                        List<List<String?>> data = [
                          ['', ' ', ' ', '', '     '],
                          ['', ' ', ' ', '', '     '],
                          ['Date', 'From Account', 'To Account', 'Amount', 'Notes'],
                        ];


                        if (transactionExpenseModelClass.data!.isEmpty) {
                          msgBtmDialogueFunction(
                              context: context,
                              textMsg: "Please ensure there is data before exporting.");
                        } else {

                          for (var i = 0;
                          i < transactionExpenseModelClass.data!.length;
                          i++) {
                            var detailsItem =
                                transactionExpenseModelClass.data![i].data;

                            for (var t = 0; t < detailsItem!.length; t++) {
                              String notes = detailsItem[t].description!;

                              var a = [
                                transactionExpenseModelClass.data![i].date,
                                detailsItem[t].fromAccountName,
                                detailsItem[t].toAccountName,
                                roundStringWith(detailsItem[t].amount!),
                                notes
                              ];
                              data.add(a);
                            }
                          }
                          if (value == 'pdf') {

                            loadDataToReport(data: data,heading: head,date: "",type: 2,balance: '');
                          } else if (value == 'excel') {


                              convertToExcelFromTo(data: data, heading: head, date: dateDet);


                          } else {}

                        }

                      },
                    ),
                    Row(
                      children: [
                         fromDate != null && toDate != null
                            ? Visibility(
                                visible: _isVisible,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isVisible = !_isVisible;
                                      listTransactionApiFunction();
                                    });
                                    print(
                                        "*****************************************$_isVisible");
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: mHeight * .03,
                                      width: mWidth * .25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Color(0xffD9E5F3)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '1 Filter',
                                            style: customisedStyle(
                                                context,
                                                Colors.black,
                                                FontWeight.w500,
                                                13.0),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: GestureDetector(
                            onTap: () async {
                              final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FilterTransactionExpense()));
                              print(
                                  "+++++++++++++++++++++++++++++++++++++++++++++++$result");

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
                                return BlocProvider.of<ExptransactionBloc>(
                                        context)
                                    .add(FetchExpTransactionEvent(
                                        fromDate: fromDate, toDate: toDate));
                              } else {
                                if (!mounted) return;
                                msgBtmDialogueFunction(
                                    context: context,
                                    textMsg: "Check your network connection");
                              }
                              listTransactionApiFunction();
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: mWidth * .08),
                                  child:
                                      SvgPicture.asset("assets/svg/filter.svg",color: Color(0xff2BAAFC),),
                                ),
                                SizedBox(
                                  width: mWidth * .06,
                                ),
                                Text(
                                  "Filter",
                                  style: customisedStyle(context, Colors.black,
                                      FontWeight.w500, 14.0),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: IconButton(
                              onPressed: () async {
                                var result = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionPageExpense(
                                              isAsset: false,
                                              assetMasterID: 0,
                                              isFromNotification: false,
                                              reminderID: "",
                                              zakath: false,
                                              isDetail: false,
                                              type: "Create",
                                              transactionType: "2",
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
                                              isReminder: false,
                                              isReminderDate: '',
                                            )));

                                listExpenseApiFunction();
                                listTransactionApiFunction();
                              },
                              icon: Icon(
                                Icons.add,
                                color: Color(0xff2BAAFC),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ));
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
                    zakath: responseJson["is_zakath"],
                    isAsset: false,
                isFromNotification: false,
                reminderID: "",
                    assetMasterID: 0,
                    isDetail: false,
                    type: "Edit",
                    balance: "0.00",
                    amount: responseJson["amount"].toString(),
                    to_account_id: responseJson["to_account"]["id"],
                    to_accountName: responseJson["to_account"]["account_name"],
                    description: responseJson["description"]??"",
                    from_account_id: responseJson["from_account"]["id"],
                    from_accountName: responseJson["from_account"]["account_name"],
                    id: id,
                   transactionType: "",
                    date: responseJson["date"],
                    isInterest: responseJson["is_interest"],
                    isReminder: responseJson["is_reminder"] ?? false,
                    isReminderDate:
                        responseJson["reminder_date"] ?? '2023-09-19',
                  )));

          listExpenseApiFunction();
          listTransactionApiFunction();
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
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }
}


class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}
