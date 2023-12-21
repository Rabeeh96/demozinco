import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Api Helper/Bloc/Dashborad_Receivables_payables/payables_receivable_bloc.dart';
import '../../../../Api Helper/ModelClasses/dashboard/PayableReceivableModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../Utilities/global/text_style.dart';
import '../../../../Utilities/global/variables.dart';
import '../../../Export/export_to_excel.dart';
import '../../../Export/export_to_pdf.dart';


class PayableRecievaleList extends StatefulWidget {
  const PayableRecievaleList({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<PayableRecievaleList> createState() => _PayableRecievaleListState();
}

class _PayableRecievaleListState extends State<PayableRecievaleList> {
  late  PayableReceivableModelClass payableReceivableModelClass ;
  PayableRecievaleListFunction() async {


    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<PayablesReceivableBloc>(context).add(FetchPayablesReceivableListEvent(filter: widget.type == "Receivable"?"R":"P"));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }


  var fromDate;

  var toDate;
  bool _isVisible = false;

  @override
  void initState() {
    PayableRecievaleListFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
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
        elevation: 1,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.type} List',
              style: customisedStyle(
                  context, Color(0xff13213A), FontWeight.w500, 19.0),
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
                ))
          ],
        ),
      ),
      body: Container(
        height: mHeight,
        child:                 Container(
          child: BlocBuilder<PayablesReceivableBloc, PayablesReceivableState>(
            builder: (context, state) {
              if (state is PayablesReceivableListLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff5728C4),
                  ),
                );
              }
              if (state is PayablesReceivableListLoaded) {
                payableReceivableModelClass = BlocProvider
                    .of<PayablesReceivableBloc>(context)
                    .payableReceivableModelClass;
                return payableReceivableModelClass.data!.isNotEmpty ?
                ListView.builder(
                    shrinkWrap: true,
                    physics:
                    BouncingScrollPhysics(),
                    itemCount: payableReceivableModelClass.data!.length,
                    itemBuilder: (BuildContext context,
                        int index) {
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: mHeight * .01,
                            ),
                            Container(
                              padding:
                              EdgeInsets.only(
                                  left: mWidth *
                                      .07,
                                  right: mWidth *
                                      .07),
                              color: Colors.white,
                              height: mHeight * .08,
                              width: mWidth,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .center,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    payableReceivableModelClass.data![index].accountName!,
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
                                        roundStringWith(payableReceivableModelClass.data![index].amount!),
                                    style: customisedStyle(
                                        context,
                                        Colors.black,
                                        FontWeight
                                            .w600,
                                        14.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 1,
                                color:
                                Color(0xffE2E2E2),
                                width: mWidth * .99),
                          ],
                        ),
                      );
                    }):SizedBox(
                    height: mHeight * .7,
                    child: const Center(
                        child: Text(
                          "Not found !",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )));
              }
              if (state is PayablesReceivableListError) {
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
        ),
      ),

      bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * .06,
          color: Colors.white,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: mWidth * .08,
                right: mWidth * .03),
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
                        SvgPicture.asset("assets/svg/export.svg"),
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
                    if (payableReceivableModelClass.data!.isEmpty) {
                      msgBtmDialogueFunction(
                          context: context,
                          textMsg: "Please ensure there is data before exporting.");
                    } else {
                      for (var i = 0; i <
                          payableReceivableModelClass.data!.length; i++) {
                        var detailsItem = payableReceivableModelClass.data;

                        var a = [
                          /// date
                          "",
                          detailsItem![i].accountName,

                          roundStringWith(detailsItem[i].amount!),
                          ///notes
                          ""
                        ];
                        data.add(a);

                      }




                      var head = " ${widget.type} Statement";
                      var dateDet =  fromDate == null && toDate == null ? "": "$fromDate $toDate";



                      if (value == 'pdf') {
                        loadDataToReport(data: data,heading: head,date: "",type: 4,balance: '');
                      }
                      else if (value == 'excel') {
                        convertToExcel(data: data,
                            heading: head,
                            date: dateDet,balance: '');
                      } else {}
                    }
                  },
                )

              ],
            ),
          )),

    );
  }
}
