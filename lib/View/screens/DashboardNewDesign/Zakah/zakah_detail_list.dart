import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../Api Helper/Bloc/Dashboard_Zakath_Interest_bloc/zakath_interest_list_bloc.dart';
import '../../../../Api Helper/ModelClasses/dashboard/ZakathOrInterestDetailListModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../Utilities/global/text_style.dart';
import '../../../../Utilities/global/variables.dart';
import '../../../Export/export_to_excel.dart';
import '../../../Export/export_to_pdf.dart';
import 'filter.dart';

class ZakahDetailList extends StatefulWidget {
  const ZakahDetailList({Key? key, required this.id, required this.accountName}) : super(key: key);
  final String id;
  final String accountName;

  @override
  State<ZakahDetailList> createState() => _ZakahDetailListState();
}

class _ZakahDetailListState extends State<ZakahDetailList> {
  var fromDate;

var toDate;
bool _isVisible = false;


  late ZakathOrInterestDetailListModelClass zakathOrInterestDetailListModelClass ;
  DetaillistZakahFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<ZakathInterestListBloc>(context)
          .add(FetchInterestZakathDetailListEvent(filter: "Z", id: widget.id, fromDate: '', toDate: ''));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }
  @override
  void initState() {
    DetaillistZakahFunction();
    super.initState();
  }
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');


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
              widget.accountName,
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
                ))
          ],
        ),
      ),
      body: Container(
        height: mHeight,
        child:                 Container(
          child: BlocBuilder<ZakathInterestListBloc, ZakathInterestListState>(
            builder: (context, state) {
              if (state is ZakathInterestDetailListLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff5728C4),
                  ),
                );
              }
              if (state is ZakathInterestDetailListLoaded) {
                zakathOrInterestDetailListModelClass = BlocProvider
                    .of<ZakathInterestListBloc>(context)
                    .zakathOrInterestDetailListModelClass;
                return zakathOrInterestDetailListModelClass.data!.isNotEmpty? ListView.builder(
                    shrinkWrap: true,
                    physics:
                    BouncingScrollPhysics(),
                    itemCount: zakathOrInterestDetailListModelClass.data!.length,
                    itemBuilder: (BuildContext context,
                        int index) {
                            DateTime date = DateTime.parse(
                                zakathOrInterestDetailListModelClass.data![index].date
                              .toString());

                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: mWidth * .07,
                                  top: 10,
                                  bottom: 10,
                                  right: mWidth * .07),
                              color: Color(0xffF8F8F8),
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
                                        "${zakathOrInterestDetailListModelClass.data![index].total!}",
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
                                  zakathOrInterestDetailListModelClass
                                      .data![index].result!.length,
                                  itemBuilder: (BuildContext context,
                                      int indexx) {
                                    var detailsItem =
                                    zakathOrInterestDetailListModelClass
                                        .data![index];

                                    return Container(
                                      child: Column(
                                        children: [

                                          Container(
                                            padding:
                                            EdgeInsets.only(
                                                left: mWidth *
                                                    .07,
                                                right: mWidth *
                                                    .07),
                                            color: Colors.white,
                                            height: mHeight * .06,
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
                                                  detailsItem
                                                      .result![
                                                  indexx].accountName!,
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
                                                          .result![
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
                                          ),
                                          Container(
                                              height: 1,
                                              color:
                                              Color(0xffE2E2E2),
                                              width: mWidth * .99),
                                        ],
                                      ),
                                    );
                                  }),
                            )
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
              if (state is ZakathInterestListError) {
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
                    if (zakathOrInterestDetailListModelClass.data!.isEmpty) {
                      msgBtmDialogueFunction(
                          context: context,
                          textMsg: "Please ensure there is data before exporting.");
                    } else {
                      for (var i = 0; i <
                          zakathOrInterestDetailListModelClass.data!
                              .length; i++) {
                        var detailsItem = zakathOrInterestDetailListModelClass
                            .data![i].result;

                        for (var t = 0; t < detailsItem!.length; t++) {
                          var a = [
                            zakathOrInterestDetailListModelClass.data![i].date,
                            detailsItem[t].accountName,

                            roundStringWith(detailsItem[t].amount!),
                            /// notes
                            ""
                          ];
                          data.add(a);
                        }
                      }



                      var head = "Zakah${widget.accountName} Statement";
                      var dateDet =  fromDate == null && toDate == null ? "": "$fromDate $toDate";



                      if (value == 'pdf') {
                        loadDataToReport(data: data,heading: head,date: "",type: 1,balance: '');

                      }
                      else if (value == 'excel') {
                        convertToExcel(data: data,
                            heading: head,
                            date: dateDet,balance: '');
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
                            DetaillistZakahFunction();
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
                                      ZakahFilter()));

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
                            return BlocProvider.of<ZakathInterestListBloc>(context)
                                .add(FetchInterestZakathDetailListEvent(filter: "Z", id: widget.id,
                                fromDate: fromDate, toDate: toDate));
                          } else {
                            if (!mounted) return;
                            msgBtmDialogueFunction(
                                context: context,
                                textMsg: "Check your network connection");
                          }
                          DetaillistZakahFunction();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: mWidth * .05),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/svg/filter.svg"),
                              SizedBox(
                                width: mWidth * .03,
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
                    ),


                  ],
                ),
              ],
            ),
          )),

    );

  }

}
