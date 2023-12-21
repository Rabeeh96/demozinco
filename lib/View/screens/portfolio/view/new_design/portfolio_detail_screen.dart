import 'dart:convert';

import 'package:cuentaguestor_edit/Utilities/Commen%20Functions/bottomsheet_fucntion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../../../../../Api Helper/Bloc/NewDesignBloc/expnse/new_expense_bloc.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/asset_bloc.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/asset_event.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/asset_state.dart';
import '../../../../../Api Helper/Bloc/portfolio_transaction_bloc/portfolio_transaction_bloc.dart';
import '../../../../../Api Helper/ModelClasses/New Design ModelClass/exp/DelteTransactionModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/AssetDeleteModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/AssetDetailModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/TransactionAssetModelClass.dart';
import '../../../../../Api Helper/Repository/api_client.dart';
import '../../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../../Utilities/global/text_style.dart';
import '../../../../../Utilities/global/variables.dart';
import '../../../../Export/export_to_excel.dart';
import '../../../../Export/export_to_pdf.dart';
import '../../../expenses/expense_new_design/transaction_page_expense.dart';
import '../../../income/Income_new_design/transaction_page_income.dart';
import 'create portfolio.dart';
import 'filter.dart';
import 'info_page.dart';
import 'portfolio_list.dart';

class PortfolioDetailScreen extends StatefulWidget {
  PortfolioDetailScreen({
    super.key,
    required this.id,
    required this.state,
    required this.asset,
    required this.type,
    required this.masterId,
  });

  final String id;
  final int masterId;
  final String state;
  String type;
  String asset;

  @override
  State<PortfolioDetailScreen> createState() => _PortfolioDetailScreenState();
}


class _PortfolioDetailScreenState extends State<PortfolioDetailScreen>
    with SingleTickerProviderStateMixin {
  int currentTabIndex = 0;
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
    assetName = widget.asset;
    assetType = widget.type;
    overviewAssetApiFunction();
    AssetTransactionApiFunction();

    progressBar = ProgressBar();

    super.initState();
  }

  var assetName = "";
  var assetType = "";
  Color textColor = Colors.green;

  String transactionType = "";

  String convertDateFormat(String inputDate) {
    DateTime date = DateTime.parse(inputDate);

    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(date);

    return formattedDate;
  }

  AssetTransactionApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<PortfolioTransactionBloc>(context).add(
          FetchTransactionAssetEvent(
              fromDate: '', toDate: '', masterId: widget.masterId));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  overviewAssetApiFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;

      return BlocProvider.of<AssetBloc>(context)
          .add(FetchOverViewAssetEvent(id: widget.id));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  late AssetDeleteModelClass assetDeleteModelClass;
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

  deleteContactApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();

      return BlocProvider.of<AssetBloc>(context)
          .add(DeleteAssetEvent(organisation: organizationId!, id: widget.id!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  late DetailAssetModelClass detailAssetModelClass;
  final divider = Divider(
    color: Color(0xffE2E2E2),
    thickness: 1,
  );
  String dropdownvalue = 'Quaterly';

  var items = [
    'Quaterly',
    'Halfearly',
  ];
  final statusList = ["Income", "Expense"];
  bool _isVisible = false;
  late TransactionAssetModelClass transactionAssetModelClass;

  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var fromDate;

  var toDate;
  late DelteTransactionModelClass delteTransactionModelClass;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<AssetBloc, AssetState>(
          listener: (context, state) async {
            if (state is AssetDeleteLoaded) {
              hideProgressBar();

              assetDeleteModelClass =
                  BlocProvider.of<AssetBloc>(context).assetDeleteModelClass;

              if (assetDeleteModelClass.statusCode == 6000) {


                SharedPreferences prefs = await SharedPreferences.getInstance();
                final organizationId = prefs.getString("organisation");
                BlocProvider.of<AssetBloc>(context).add(ListAssetEvent(
                    organization: organizationId!,
                    search: '',
                    pageNumber: 1,
                    page_size: 40));
                Navigator.pop(context);
              }

              if (assetDeleteModelClass.statusCode == 6001) {
                await msgBtmDialogueFunction(
                    context: context,
                    textMsg: assetDeleteModelClass.message ?? '');
                overviewAssetApiFunction();
                AssetTransactionApiFunction();
              } else if (assetDeleteModelClass.statusCode == 6002) {
                await msgBtmDialogueFunction(
                    context: context, textMsg: "Something went wrong");
                Navigator.pop(context);
              }
            }
          },
        )
      ],
      child: DefaultTabController(
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assetName,
                  style: customisedStyle(
                      context, Color(0xff13213A), FontWeight.w500, 18.0),
                ),
                Text(
                  assetType,
                  style: customisedStyle(
                      context, Color(0xff0073D8), FontWeight.w500, 12.0),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    final result =
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateAssetScreen(
                                  id: widget.id,
                                  isEdit: true,
                                )));

                    overviewAssetApiFunction();
                    AssetTransactionApiFunction();
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
                          deleteContactApiFunction();
                          Navigator.of(context).pop(true);
                        },
                        secondBtnText: 'Yes');
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Color(0xff2BAAFC),
                  )),
              IconButton(
                  onPressed: () async {
                    var result =
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InfoPage(
                                  id: widget.id,
                                  type: widget.type,
                                  isEdit: false,
                                  state: widget.state,
                                  asset: widget.asset,
                                )));

                    overviewAssetApiFunction();
                    AssetTransactionApiFunction();
                  },
                  icon: Icon(
                    Icons.info,
                    color: Color(0xff2BAAFC),
                  )),
            ],
          ),
          body: Container(
            color: Colors.white,

            height: mHeight,
            child: Column(
              children: [
                Divider(
                  color: Color(0xffE2E2E2),
                  thickness: 1,
                ),
                Container(
                  height: mHeight / 16,
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
                                context, Colors.black, FontWeight.normal, 14.0),
                          ),
                        ),
                        Tab(
                          icon: Text(
                            "Transactions",
                            style: customisedStyle(
                                context, Colors.black, FontWeight.normal, 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    children: [overViewWidget(), transactionWidget()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatTime(String timeString) {
    final inputFormat = DateFormat('HH:mm:ss');
    final outputFormat = DateFormat('hh:mm a');

    final dateTime = inputFormat.parse(timeString);
    final formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  String removeString(String input) {
    List<String> parts = input.split(' ');
    return parts[0];
  }

  loadData(assetName, assetType) {
    setState(() {
      widget.asset = assetName;
      widget.type = assetType;
    });
  }

  Widget overViewWidget() {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AssetBloc, AssetState>(
      builder: (context, state) {
        if (state is AssetOverviewLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff5728C4),
            ),
          );
        }

        if (state is AssetOverviewLoaded) {
          detailAssetModelClass =
              BlocProvider.of<AssetBloc>(context).detailAssetModelClass;
          assetName = detailAssetModelClass.summary!.assetName!;
          assetType = getNameFromValuePortfolio(
              1, detailAssetModelClass.summary!.assetType!);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });

          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: mHeight / 10,
                    child: Column(
                      children: [
                        Text(
                          "Worth",
                          style: customisedStyle(context, Color(0xff3634A8),
                              FontWeight.normal, 14.0),
                        ),
                        Text(
                          countryCurrencyCode +
                              " " +
                              "${roundStringWith(detailAssetModelClass.summary!.totalValue.toString())}",
                          style: customisedStyle(
                              context, Colors.black, FontWeight.w500, 22.0),
                        ),
                        Text(
                          "${roundStringWith(detailAssetModelClass.summary!.totalShare.toString())}% share",
                          style: customisedStyle(
                              context, Color(0xff858585), FontWeight.normal, 13.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: mWidth * .04, right: mWidth * .04),
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
                            children: [
                              Text(
                                "Total income",
                                style: customisedStyle(context,
                                    Color(0xff31950D), FontWeight.normal, 13.0),
                              ),
                              Text(
                                countryCurrencyCode +
                                    " " +
                                    "${roundStringWith(detailAssetModelClass.summary!.totalIncome.toString())}",
                                style: customisedStyle(context, Colors.black,
                                    FontWeight.w500, 14.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mWidth * .08,
                        ),
                        Container(
                            color: Color(0xffE2E2E2),
                            height: mHeight * .11,
                            width: 1),
                        Container(
                          padding: EdgeInsets.only(
                              top: mHeight * .02,
                              bottom: mHeight * .02,
                              left: mWidth * .04),
                          width: mWidth * .4,
                          child: Column(
                            children: [
                              Text(
                                "Total expenses",
                                style: customisedStyle(context,
                                    Color(0xffC91010), FontWeight.normal, 13.0),
                              ),
                              Text(
                                countryCurrencyCode +
                                    " " +
                                    "${roundStringWith(detailAssetModelClass.summary!.totalExpense.toString())}",
                                style: customisedStyle(context, Colors.black,
                                    FontWeight.w500, 14.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(
                    height: mHeight * .03,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: mWidth * .04, right: mWidth * .04),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Expenses",
                      style: customisedStyle(
                          context, Colors.black, FontWeight.w500, 18.0),
                    ),
                  ),


                  divider,
                  detailAssetModelClass.expenseAccountList!.isNotEmpty
                      ? GridView.builder(
                          padding: EdgeInsets.only(
                            left: mWidth * .04,
                            right: mWidth * .04,
                          ),
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              detailAssetModelClass.expenseAccountList!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent:
                                100,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: mWidth * .2,
                                        child: Text(
                                        detailAssetModelClass
                                            .expenseAccountList![index]
                                            .accountName!,
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(
                                            context,
                                            Color(0xff5B5B5B),
                                            FontWeight.w500,
                                            10.0),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
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
                                      width: mWidth * .35,
                                      height: mHeight * .029,
                                      child: Text(
                                        "$countryCurrencyCode ${roundStringWith(
                                          detailAssetModelClass
                                              .expenseAccountList![index]
                                              .balance!,
                                        )}",
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(
                                            context,
                                            Color(0xff000000),
                                            FontWeight.w500,
                                            10.0),
                                      )),
                                ],
                              ),
                            );
                          })
                      : SizedBox(
                          height: mHeight * .08,
                          child: Center(
                              child: Text(
                            "Not found !",
                            style: customisedStyle(
                                context, Colors.black, FontWeight.w500, 12.0),
                          ))),
                  SizedBox(
                    height: mHeight * .02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: mWidth * .04, right: mWidth * .04),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Incomes",
                      style: customisedStyle(
                          context, Colors.black, FontWeight.w500, 18.0),
                    ),
                  ),
                  divider,
                  detailAssetModelClass.incomeAccountList!.isNotEmpty
                      ? GridView.builder(
                          padding: EdgeInsets.only(
                            left: mWidth * .04,
                            right: mWidth * .04,
                          ),
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              detailAssetModelClass.incomeAccountList!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent:
                                100,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: mWidth * .2,

                                      child: Text(
                                        detailAssetModelClass
                                            .incomeAccountList![index]
                                            .accountName!,
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(
                                            context,
                                            Color(0xff5B5B5B),
                                            FontWeight.w500,
                                            10.0),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xff35BDF1),
                                      child: SvgPicture.asset(
                                        'assets/menu/walletwhite.svg',
                                        width: 25,
                                        height: 25,
                                      ),
                                      minRadius: 25,
                                      maxRadius: 25,
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: mWidth * .35,
                                      height: mHeight * .029,
                                      child: Text(
                                        "$countryCurrencyCode ${roundStringWith(detailAssetModelClass.incomeAccountList![index].balance!)}",
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(
                                            context,
                                            Color(0xff000000),
                                            FontWeight.w500,
                                            10.0),
                                      )),
                                ],
                              ),
                            );
                          })
                      : SizedBox(
                          height: mHeight * .08,
                          child: Center(
                              child: Text(
                            "Not found !",
                            style: customisedStyle(
                                context, Colors.black, FontWeight.w500, 12.0),
                          ))),
                  SizedBox(
                    height: mHeight * .1,
                  )
                ],
              ),
            ),
          );
        }
        if (state is AssetOverviewError) {
          return Center(
              child: Text(
            "Something went wrong",
            style:
                customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
          ));
        }

        return SizedBox();
      },
    );
  }

  Widget transactionWidget() {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return BlocListener<NewExpenseBloc, NewExpenseState>(
      listener: (context, state) async {
        if (state is ExpenseTransactionDeleteLoaded) {
          hideProgressBar();
          delteTransactionModelClass = BlocProvider.of<NewExpenseBloc>(context)
              .delteTransactionModelClass;

          if (delteTransactionModelClass.statusCode == 6000) {
              AssetTransactionApiFunction();
            overviewAssetApiFunction();
          }
          if (delteTransactionModelClass.statusCode == 6001) {
            msgBtmDialogueFunction(
                context: context, textMsg: "Something went wrong");
          }
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body:
              BlocBuilder<PortfolioTransactionBloc, PortfolioTransactionState>(
            builder: (context, state) {
              if (state is AssetTransactionLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff5728C4),
                  ),
                );
              }
              if (state is AssetTransactionLoaded) {
                transactionAssetModelClass =
                    BlocProvider.of<PortfolioTransactionBloc>(context)
                        .transactionAssetModelClass;
                return Container(
                    color: Colors.white,
                    child: transactionAssetModelClass.data!.isNotEmpty
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: transactionAssetModelClass.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime date = DateTime.parse(
                                  transactionAssetModelClass.data![index].date
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
                                                "${roundStringWith(transactionAssetModelClass.data![index].total!)}",
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
                                        child: transactionAssetModelClass
                                                .data![index].data!.isNotEmpty
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    transactionAssetModelClass
                                                        .data![index]
                                                        .data!
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int indexx) {
                                                  var detailsItem =
                                                      transactionAssetModelClass
                                                          .data![index];

                                                  return Dismissible(
                                                    direction: DismissDirection
                                                        .endToStart,
                                                    background: Container(
                                                        color: Colors.red,
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        )),
                                                    confirmDismiss:
                                                        (DismissDirection
                                                            direction) async {
                                                      return await btmDialogueFunction(
                                                          isDismissible: true,
                                                          context: context,
                                                          textMsg:
                                                              'Are you sure delete ?',
                                                          fistBtnOnPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          },
                                                          secondBtnPressed:
                                                              () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                            var netWork =
                                                                await checkNetwork();
                                                            if (netWork) {
                                                              if (!mounted)
                                                                return;

                                                              showProgressBar();

                                                              return BlocProvider
                                                                      .of<NewExpenseBloc>(
                                                                          context)
                                                                  .add(FetchDeleteTransactionEvent(
                                                                      id: detailsItem
                                                                          .data![
                                                                              indexx]
                                                                          .id!));
                                                            } else {
                                                              if (!mounted)
                                                                return;
                                                              msgBtmDialogueFunction(
                                                                  context:
                                                                      context,
                                                                  textMsg:
                                                                      "Check your network connection");
                                                            }
                                                          },
                                                          secondBtnText:
                                                              'Delete');
                                                    },
                                                    key: Key(detailsItem
                                                        .data![indexx].id!),
                                                    onDismissed:
                                                        (direction) async {},
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                mHeight * .01,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              navigateToEdit(
                                                                  detailsItem
                                                                      .data![
                                                                          indexx]
                                                                      .id,
                                                                  detailsItem
                                                                      .data![
                                                                          indexx]
                                                                      .voucherType);

                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                  left: mWidth *
                                                                      .07,
                                                                  right:
                                                                      mWidth *
                                                                          .07),
                                                              color:
                                                                  Colors.white,
                                                              height:
                                                                  mHeight * .07,
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
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            detailsItem.data![indexx].voucherType == "IC" || detailsItem.data![indexx].voucherType == "AIC"
                                                                                ? "Income"
                                                                                : "Expense",
                                                                            style: customisedStyle(
                                                                                context,
                                                                                detailsItem.data![indexx].voucherType == "IC" || detailsItem.data![indexx].voucherType == "AIC" ? Color(0xff017511) : Colors.red,
                                                                                FontWeight.w500,
                                                                                13.0),
                                                                          ),

                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        "$countryCurrencyCode ${roundStringWith(detailsItem.data![indexx].amount!)}",
                                                                        style: customisedStyle(
                                                                            context,
                                                                            detailsItem.data![indexx].voucherType == "IC" || detailsItem.data![indexx].voucherType == "AIC"
                                                                                ? Color(0xff00A405)
                                                                                : Colors.red,
                                                                            FontWeight.w600,
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
                                                                            detailsItem.data![indexx].fromAccountName!,
                                                                            style: customisedStyle(
                                                                                context,
                                                                                Colors.black,
                                                                                FontWeight.w500,
                                                                                15.0),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        detailsItem
                                                                            .data![indexx]
                                                                            .description!,
                                                                        style: customisedStyle(
                                                                            context,
                                                                            Color(0xff878787),
                                                                            FontWeight.normal,
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
                                                              color: Color(
                                                                  0xffE2E2E2),
                                                              width:
                                                                  mWidth * .99),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                })
                                            : SizedBox(
                                                height: mHeight * .7,
                                                child: Center(
                                                    child: Text(
                                                  "Not found !",
                                                  style: customisedStyle(
                                                      context,
                                                      Colors.black,
                                                      FontWeight.w500,
                                                      12.0),
                                                ))))
                                  ],
                                ),
                              );
                            })
                        : SizedBox(
                            height: mHeight * .7,
                            child: Center(
                                child: Text(
                              "Not found !",
                              style: customisedStyle(
                                  context, Colors.black, FontWeight.w500, 12.0),
                            ))));
              }
              if (state is AssetTransactionError) {
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
            color: const Color(0xffF3F7FC),
            height: MediaQuery.of(context).size.height * .08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          SvgPicture.asset("assets/svg/export.svg",color:Color(0xff2BAAFC)),
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
                      var head = "${assetName} Report";
                      var dateDet = fromDate == null && toDate == null
                          ? ""
                          : "$fromDate $toDate";

                      if (transactionAssetModelClass.data!.isEmpty) {
                        msgBtmDialogueFunction(
                            context: context,
                            textMsg:
                                "Please ensure there is data before exporting.");
                      } else {
                        for (var i = 0;
                            i < transactionAssetModelClass.data!.length;
                            i++) {
                          var detailsItem =
                              transactionAssetModelClass.data![i].data;
                          for (var t = 0; t < detailsItem!.length; t++) {
                            String symbol = "-";
                            String accountName = returnAccountDetails(
                                detailsItem[t].fromAccountName,
                                detailsItem[t].toAccountName);
                            String notes = detailsItem[t].description!;
                            String value =  returnVoucherType(detailsItem[t].voucherType);
                            String amount = roundStringWith(detailsItem[t].amount!);
                            String check = symbol + amount;
                            String finalAmount = value == "Expense" ? check : amount;


                            List<String?> a = [
                              transactionAssetModelClass.data![i].date,
                              accountName,
                              finalAmount,
                              notes
                            ];
                            data.add(a);
                          }
                        }
                        if (value == 'pdf') {
                          loadDataToReport(data: data, heading: head, date: "", type: 1,balance: '');
                        } else if (value == 'excel') {
                          convertToExcel(data: data, heading: head, date: dateDet,balance: '');
                        } else {

                        }
                      }
                    },
                  ),
                ),
                fromDate != null && toDate != null
                    ? Visibility(
                        visible: _isVisible,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                            AssetTransactionApiFunction();

                            print(
                                "*****************************************$fromDate");
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: mHeight * .03,
                              width: mWidth * .25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffD9E5F3)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '1 Filter',
                                    style: customisedStyle(context,
                                        Colors.black, FontWeight.w500, 14.0),
                                  ),
                                  Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Color(0xff2BAAFC),
                                  )
                                ],
                              )),
                        ),
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: mWidth * .08),
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FilterTransactionAsset()));
                          print(
                              "+++++++++++++++++++++++++++++++++++++++++++++++$result");

                          result != null ? fromDate = result[0] : Null;
                          result != null ? toDate = result[1] : Null;
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                          setState(() {
                            result != null ? fromDate = result[0] : Null;
                          });
                           var netWork = await checkNetwork();

                          if (netWork) {
                            if (!mounted) return;
                            return BlocProvider.of<PortfolioTransactionBloc>(
                                    context)
                                .add(FetchTransactionAssetEvent(
                                    fromDate: fromDate,
                                    toDate: toDate,
                                    masterId: widget.masterId));
                          } else {
                            if (!mounted) return;
                            msgBtmDialogueFunction(
                                context: context,
                                textMsg: "Check your network connection");
                          }
                        },
                        child: SvgPicture.asset("assets/svg/filter.svg",color: Color(0xff2BAAFC),),
                      ),
                    ),
                    SizedBox(
                      width: mWidth * .015,
                    ),
                    Text(
                      "Filter",
                      style: customisedStyle(
                          context, Colors.black, FontWeight.w500, 14.0),
                    ),
                  ],
                ),
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
                                style: customisedStyle(context, Colors.black,
                                    FontWeight.w500, 13.0),
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
                                style: customisedStyle(context, Colors.black,
                                    FontWeight.w500, 13.0),
                              ),
                              SvgPicture.asset("assets/svg/circle_income.svg"),
                            ],
                          ),
                        ),
                      ];
                    },
                    onSelected: (String value) async {
                      if (value == 'expenses') {
                        var result =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TransactionPageExpense(
                                      isAsset: true,
                                      assetMasterID: widget.masterId,
                                      zakath: false,
                                  isFromNotification: false,
                                  reminderID: "",
                                      isDetail: false,
                                      type: "Create",
                                      balance: "0.00",
                                      amount: "0.00",
                                      to_account_id: "",
                                      transactionType: "2",
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

                        if (result != null) {
                           BlocProvider.of<AssetBloc>(context)
                              .add(FetchOverViewAssetEvent(id: widget.id));
                          BlocProvider.of<PortfolioTransactionBloc>(context)
                              .add(FetchTransactionAssetEvent(
                                  fromDate: "",
                                  toDate: "",
                                  masterId: widget.masterId));
                        }
                      } else if (value == 'income') {
                        var result =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TransactionPageIncome(
                                      isZakath: false,
                                      isDetail: true,
                                      transactionType: "1",
                                      reminderID: "",
                                      isFromNotification: false,
                                      type: "Create",
                                      assetMasterID: widget.masterId,
                                      isAsset: true,
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

                        if (result != null) {
                          BlocProvider.of<AssetBloc>(context)
                              .add(FetchOverViewAssetEvent(id: widget.id));
                          BlocProvider.of<PortfolioTransactionBloc>(context)
                              .add(FetchTransactionAssetEvent(
                                  fromDate: "",
                                  toDate: "",
                                  masterId: widget.masterId));
                        }
                      } else {}
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  returnAccountDetails(fromAccount, toAccount) {
    if (assetName == fromAccount) {
      return toAccount;
    } else {
      return fromAccount;
    }
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
                      assetMasterID: widget.masterId,
                      isAsset: true,
                      transactionType: "",
                      type: "Edit",
                      balance: "0.00",
                  reminderID: "",
                  isFromNotification: false,
                      amount: responseJson["amount"].toString(),
                      to_account_id: responseJson["to_account"]["id"],
                      to_accountName: responseJson["to_account"]
                          ["account_name"],
                      description: responseJson["description"],
                      from_account_id: responseJson["from_account"]["id"],
                      isZakath: responseJson["is_zakath"],
                      from_accountName: responseJson["from_account"]
                          ["account_name"],
                      id: id,
                      date: responseJson["date"],
                      isInterest: responseJson["is_interest"],
                      isReminder: responseJson["is_reminder"] ?? false,
                      isReminderDate:
                          responseJson["reminder_date"] ?? '2023-09-19',
                    )));
          } else {
            result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TransactionPageExpense(
                      zakath: responseJson["is_zakath"],
                      isAsset: true,
                      assetMasterID: widget.masterId,
                      isDetail: false,
                      isFromNotification: false,
                      reminderID: "",
                      transactionType: "",
                      type: "Edit",
                      balance: "0.00",
                      amount: responseJson["amount"].toString(),
                      to_account_id: responseJson["to_account"]["id"],
                      to_accountName: responseJson["to_account"]
                          ["account_name"],
                      description: responseJson["description"],
                      from_account_id: responseJson["from_account"]["id"],
                      from_accountName: responseJson["from_account"]
                          ["account_name"],
                      id: id,
                      date: responseJson["date"],
                      isInterest: responseJson["is_interest"],
                      isReminder: responseJson["is_reminder"] ?? false,
                      isReminderDate:
                          responseJson["reminder_date"] ?? '2023-09-19',
                    )));
          }

          if (result != null) {
            BlocProvider.of<AssetBloc>(context)
                .add(FetchOverViewAssetEvent(id: widget.id));
            BlocProvider.of<PortfolioTransactionBloc>(context).add(
                FetchTransactionAssetEvent(
                    fromDate: "", toDate: "", masterId: widget.masterId));
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
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }
}


class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}


