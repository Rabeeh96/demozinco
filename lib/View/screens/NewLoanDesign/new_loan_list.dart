import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api Helper/Bloc/Loan/loan_bloc.dart';
import '../../../Api Helper/ModelClasses/Loan/DeleteLoanModelClass.dart';
import '../../../Api Helper/ModelClasses/Loan/DetailLoanModelClass.dart';
import '../../../Api Helper/ModelClasses/Loan/ListLoanModelClass.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../../../Utilities/global/variables.dart';
import 'create_loan.dart';
import 'detail_loan_section.dart';


class NewLoanList extends StatefulWidget {
  const NewLoanList({Key? key}) : super(key: key);

  @override
  State<NewLoanList> createState() => _NewLoanListState();
}

class _NewLoanListState extends State<NewLoanList> {

  listLoanApiFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");
      return BlocProvider.of<LoanBloc>(context).add(ListLoanEvent());
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  detailLoanApiFunction(id) async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<LoanBloc>(context).add(DetailsLoanEvent(organization: organizationId!, id: id));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  late ListLoanModelClass listLoanModelClass;

  @override
  void initState() {
    progressBar = ProgressBar();
    listLoanApiFunction();
    super.initState();
  }

  String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
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

  late DeleteLoanModelClass deleteLoanModelClass;

  late DetailLoanModelClass detailLoanModelClass;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .02,
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<LoanBloc, LoanState>(
          listener: (context, state) {
            if (state is LoanListLoading) {
              const CircularProgressIndicator(
                color: Color(0xff5728C4),
              );
            }
            if (state is LoanListLoaded) {
              hideProgressBar();
              listLoanModelClass = BlocProvider.of<LoanBloc>(context).listLoanModelClass;
              if (listLoanModelClass.statusCode == 6000) {
              } else if (listLoanModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
              } else {
                msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
              }
            }
            if (state is LoanListError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<LoanBloc, LoanState>(
          listener: (context, state) {
            if (state is DeleteLoanLoading) {
              const CircularProgressIndicator(
                color: Color(0xff5728C4),
              );
            }
            if (state is DeleteLoanLoaded) {
              listLoanApiFunction();
              deleteLoanModelClass = BlocProvider.of<LoanBloc>(context).deleteLoanModelClass;
              if (deleteLoanModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
              }
            }
            if (state is DeleteLoanError) {
              hideProgressBar();
            }
          },
        )
      ],
      child: Scaffold(
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
            elevation: 1,
            automaticallyImplyLeading: true,
            titleSpacing: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Loans',
                  style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 21.0),
                ),
                Container(
                    alignment: Alignment.center,
                    height: mHeight * .05,
                    width: mWidth * .3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF3F7FC)),
                    child: Text(
                      default_country_name + "-" + countryShortCode,
                      style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),
                    ))
              ],
            ),
          ),
          body: Container(
            child: BlocBuilder<LoanBloc, LoanState>(
              builder: (context, state) {
                if (state is LoanListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff5728C4),
                    ),
                  );
                }
                if (state is LoanListLoaded) {
                  listLoanModelClass = BlocProvider.of<LoanBloc>(context).listLoanModelClass;
                  return Container(
                      height: mHeight,
                      color: Colors.white,
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(children: [
                            space,
                            Container(
                              margin: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                              height: mHeight * .1,
                              width: mWidth,
                              decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        listLoanModelClass.summary!.numbers.toString() + " ",
                                        style: customisedStyle(context, Color(0xffF2385E), FontWeight.w600, 25.0),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: mHeight * .01),
                                        child: Text(
                                          "Loans took.",
                                          style: customisedStyle(context, Color(0xffF2385E), FontWeight.w500, 14.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Total Outstanding",
                                        style: customisedStyle(context, Color(0xff0073D8), FontWeight.normal, 12.0),
                                      ),



                                      Text(
                                        countryCurrencyCode + " " + "${roundStringWith(listLoanModelClass.summary!.totOutstanding.toString())}",
                                        style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(20),
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listLoanModelClass.data!.length + 1,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 130,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    if (listLoanModelClass.data!.isEmpty || listLoanModelClass.data!.length == index) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              alignment: Alignment.center,
                                              width: mWidth * .2,
                                              height: mHeight * .02,
                                              child: Text(
                                                "",
                                                overflow: TextOverflow.ellipsis,
                                                style: customisedStyle(context, Color(0xff003D88), FontWeight.w500, 10.0),
                                              )),

                                          Container(

                                            height: mHeight * .060,
                                            width: mWidth * .5,
                                            child:    Container(

                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(0xffF9F9F9),
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () async {
                                                  final result = await Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => AddLoanPage(
                                                        id: "",
                                                        isEdit: false,
                                                      )));
                                                  listLoanApiFunction();
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  width: mWidth * .3,
                                                  child: Text(
                                                    "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 9.0),
                                                  )),
                                              Container(
                                                  alignment: Alignment.center,
                                                  width: mWidth * .3,
                                                  child: Text(
                                                    "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: customisedStyle(context, Color(0xffC91919), FontWeight.w500, 9.0),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () async {
                                          print("loanName   ${listLoanModelClass.data![index].loanName}");
                                          print("id         ${listLoanModelClass.data![index].loan_status}");

                                          final result = await Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => LoanSectionDetails(
                                                    name: listLoanModelClass.data![index].loanName!,
                                                    id:  listLoanModelClass.data![index].id!,
                                                    type: listLoanModelClass.data![index].paymentType!,
                                                   status: listLoanModelClass.data![index].loan_status!,

                                                  )));
                                          listLoanApiFunction();
                                        },
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  width: mWidth * .2,
                                                  height: mHeight * .02,
                                                  child: Text(
                                                    listLoanModelClass.data![index].loanName!.isNotEmpty
                                                        ? listLoanModelClass.data![index].loanName!
                                                        : "No Name",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: customisedStyle(context, Color(0xff003D88), FontWeight.w500, 10.0),
                                                  )),
                                              Container(
                                                height: mHeight * .080,
                                                width: mWidth * .5,
                                                child: CircularPercentIndicator(
                                                  progressColor: Color(0xffE2123C),
                                                  circularStrokeCap: CircularStrokeCap.butt,
                                                  animation: true,
                                                  animationDuration: 1200,
                                                  backgroundColor: Colors.red.shade50,
                                                  radius: 26.0,
                                                  percent: calculatePercentage(
                                                      outstandingAmount: listLoanModelClass.data![index].outstandingAmount ?? '0.0',
                                                      total: listLoanModelClass.data![index].loanAmount ?? '0'),
                                                  center: CircleAvatar(
                                                    backgroundColor: Color(0xffF2385E),
                                                    child: SvgPicture.asset(
                                                      'assets/Loan/archive (1).svg',
                                                      width: 22,
                                                      height: 22,
                                                    ),
                                                    radius: 20,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                      alignment: Alignment.center,
                                                      width: mWidth * .3,
                                                      child: Text(
                                                        countryCurrencyCode + "." + roundStringWith(listLoanModelClass.data![index].loanAmount!),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: customisedStyle(context, Colors.black, FontWeight.w500, 9.0),
                                                      )),
                                                  Container(
                                                      alignment: Alignment.center,
                                                      width: mWidth * .3,
                                                      child: Text(
                                                        countryCurrencyCode +
                                                            "." +
                                                            roundStringWith(listLoanModelClass.data![index].outstandingAmount!),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: customisedStyle(context, Color(0xffC91919), FontWeight.w500, 9.0),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )),
                          ])));
                }
                if (state is LoanListError) {
                  return Center(
                      child: Text(
                    "Something went wrong",
                    style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                  ));
                }
                return SizedBox();
              },
            ),
          )),
    );
  }

  double calculatePercentage({required String outstandingAmount, required String total}) {
    var tot = double.parse(total);
    var outStand = double.parse(outstandingAmount);
    var balance = tot - outStand;

    if (balance == 0) {
      return 0.0;
    }
    var result = ( balance/ tot) * 1;
    if (result > 1) {
      return 1;
    } else if (result < 0) {
      return 0;
    } else {
      return result;
    }
  }
}
