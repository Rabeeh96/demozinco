import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api Helper/Repository/api_client.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import 'package:http/http.dart' as http;

import '../../../Utilities/global/variables.dart';
import '../../Export/excel_export.dart';
import '../../Export/export_to_pdf.dart';
import 'add_transfer.dart';
import 'filter.dart';

class TransactionList extends StatefulWidget {
  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    super.initState();
    progressBar = ProgressBar();
    transferList.clear();
    listTransfer();
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

  listTransfer() async {
    final response;
    try {

      isLoading =true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'transfer/list-transfer/';

      final country_id = prefs.getString("country_id");
      showProgressBar();
      Map data = {
        "organization": organizationId,
        "to_date":toDate,
        "country_id":country_id,
        "from_date":fromDate
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
        isLoading = false;
        transferList.clear();
        hideProgressBar();
        setState(() {
          for (Map user in responseJson) {
            transferList.add(TransferListModel.fromJson(user));
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });

        hideProgressBar();
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      hideProgressBar();
      print(e.toString());
    }
  }


  bool isLoading = true;
  deleteTransfer(String transferId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'transfer/delete-transfer/';
      final country_id = prefs.getString("country_id");
      showProgressBar();

      Map data = {
        "organization": organizationId,
        "country_id": country_id,
        "id":transferId
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
      if (statusCode == 6000) {
        hideProgressBar();
        setState(() {
          transferList.clear();
        });
        listTransfer();
      }
      else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();

    }
  }


  var fromDate;
  var toDate;
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 11,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
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
          "Transfers",
          style: customisedStyle(context, Colors.black, FontWeight.w600, 18.0),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),

              isLoading ==true ?SizedBox(
                  height: mHeight * .7,
                  child:   Center(
                      child: Text(
                        "",
                        style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                      ))):
              transferList.isNotEmpty?
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: transferList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07,bottom: 10),
                               color: Color(0xffF8F8F8),
                              height: mHeight * .06,
                              width: mWidth,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    transferList[index].date,
                                    style: customisedStyle(context, Color(0xff878787), FontWeight.normal, 16.0),
                                  ),
                                 Text("$countryCurrencyCode ${roundStringWith(transferList[index].total)}",
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
                                  itemCount: transferList[index].data.length,
                                  itemBuilder: (BuildContext context, int indexx) {
                                    var data = transferList[index].data;

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


                                                deleteTransfer(data[indexx]["id"]);

                                              } else {
                                                if (!mounted) return;
                                                msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
                                              }
                                            },
                                            secondBtnText: 'Delete');
                                      },
                                      key: Key('item ${[index]}'),
                                      onDismissed: (direction) async {},
                                      child: GestureDetector(
                                        onTap: (){
                                          navigateToEdit(data[indexx]["id"]);
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [

                                              Container(
                                                padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07,top: 10),
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
                                                              data[indexx]["from_account"],
                                                              style: customisedStyle(context, Colors.black  , FontWeight.w500, 13.0),
                                                            ),
                                                            Text(
                                                              "",
                                                              style: customisedStyle(context, Color(0xff878787), FontWeight.normal, 12.0),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          data[indexx]["from_currency"] +"  "+roundStringWith(data[indexx]["from_amount"].toString()),
                                                          style: customisedStyle(context, Color(0xffDC0000), FontWeight.w600, 13.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [

                                                            Text(
                                                              "To ",
                                                              style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.w500, 13.0),
                                                            ),
                                                            Text(
                                                              data[indexx]["to_account"],
                                                              style: customisedStyle(context, Colors.black, FontWeight.normal, 13.0),
                                                            ),
                                                            Text(
                                                              "",
                                                              style: customisedStyle(context, Color(0xff878787), FontWeight.normal, 12.0),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                            data[indexx]["to_currency"] +"  "+ roundStringWith(data[indexx]["to_amount"].toString()),
                                                          style: customisedStyle(context, Color(0xff00A405), FontWeight.w600, 14.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
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
                    }),
              ):
              SizedBox(
                  height: mHeight * .7,
                  child:   Center(
                      child: Text(
                        "Not found ",
                        style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                      ))),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Padding(
                padding: EdgeInsets.only(left: mWidth * .07),
                child: PopupMenuButton<String>(
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
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PDF",
                              style: customisedStyle(
                                  context,
                                  Colors.black,
                                  FontWeight.w500,
                                  13.0),
                            ),
                            SvgPicture.asset(
                                "assets/svg/pdf.svg"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'excel',
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Excel",
                              style: customisedStyle(
                                  context,
                                  Colors.black,
                                  FontWeight.w500,
                                  13.0),
                            ),
                            SvgPicture.asset(
                                "assets/svg/excel.svg"),
                          ],
                        ),

                      ),

                    ];
                  },
                  onSelected: (String value) async{
                    var head = "Transfer Report";
                    var dateDet =  fromDate == null && toDate == null ? "": "$fromDate $toDate";

                    List<List<String?>> data = [
                      ['', ' ', ' ', '', '', '     '],
                      ['', ' ', ' ', '', '', '     '],
                      [
                        'Date',
                        'From Account',
                        'To Account',
                        'From Amount',
                        'To Amount',
                        'Notes'
                      ],
                    ];
                    if (transferList.isEmpty) {
                      msgBtmDialogueFunction(
                          context: context,
                          textMsg: "Please ensure there is data before exporting.");
                    }      else {

                      for (var i = 0;
                      i < transferList.length;
                      i++) {
                        var detailsItem = transferList[i].data;

                        for (var t = 0; t < detailsItem!.length; t++) {
                          print(
                              "+++++++++++++++++++++++++++++++${detailsItem[t]["from_currency"]}");

                          List<String?> a = [
                            transferList[i].date,
                            detailsItem[t]["from_account"],
                            detailsItem[t]["to_account"],
                            roundStringWith(detailsItem[t]["from_amount"]
                                .toString()),
                            roundStringWith(detailsItem[t]["to_amount"]
                                .toString()),
                            detailsItem[t]["description"],

                          ];
                          data.add(a);
                        }
                      }
                      if (value == 'pdf') {

                        loadDataToReport(data: data,heading: head,date: "",type: 3,balance: '');
                      }

                      else if (value == 'excel') {




                          convertToExcelFromToAmountAlso(
                              data: data, heading: head, date: dateDet);


                      }
                      else {}

                    }


                  },
                )),

            fromDate != null && toDate != null
                ? Padding(
                  padding: const EdgeInsets.only(right:20.0),
                  child: Visibility(
              visible: _isVisible,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVisible = !_isVisible;
                      fromDate = null;
                      toDate = null;
                    });
                    listTransfer();

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
                            size: 20,
                            color: Color(0xff2BAAFC),
                          )
                        ],
                      )),
              ),
            ),
                )
                : SizedBox(),
            Row(
              children: [

                GestureDetector(

                  onTap: () async {
                    final result = await Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: (context) =>
                            FilterForTransferList()));
                    print(
                        "+++++++++++++++++++++++++++++++++++++++++++++++$result");


                    if(result != null){
                      setState(() {
                        toDate = result[0];
                        fromDate = result[1];
                        _isVisible = !_isVisible;

                      });
                    }

                    var netWork = await checkNetwork();


                    if (netWork) {
                      if (!mounted) return;
                      listTransfer();

                    } else {
                      if (!mounted) return;
                      msgBtmDialogueFunction(
                          context: context,
                          textMsg:
                          "Check your network connection");
                    }

                  },


                  child: SvgPicture.asset("assets/svg/filter.svg",color: Color(0xff2BAAFC),),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 15.0,left: 15.0),
                  child: IconButton(
                      onPressed: ()async{
                        var result = await      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransferTransaction(
                          toAmount: "0.0",
                          transactionType: "",
                          to_country_Name: "",to_country_id: "",from_country_Name: "",from_country_id: "",
                          type: "Create",balance: "0.00",fromAmount: "0.00",to_account_id: "",to_accountName: "",description: "",from_account_id: "",
                          from_accountName: "",id: "",date: "",isZakah: false,
                        )));


                        listTransfer();
                      },
                      icon: Icon(
                        Icons.add,
                        color: Color(0xff2BAAFC),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  navigateToEdit(id)async{
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
        final country_id = prefs.getString("country_id");
        final url = baseUrl + uri;


        Map data = {
          "id": id,
          "country_id": country_id,
          "organization": organizationId
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
          var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransferTransaction(
            from_country_id:responseJson["from_country"]["id"] ,from_country_Name: responseJson["from_country"]["country_name"],
            to_country_id: responseJson["to_country"]["id"],to_country_Name: responseJson["to_country"]["country_name"],
            toAmount: responseJson["to_amount"].toString(),
            transactionType: "",
            type: "Edit",balance: "0.00",fromAmount: responseJson["from_amount"].toString(),to_account_id: responseJson["to_account"]["id"],to_accountName: responseJson["to_account"]["account_name"],description: responseJson["description"],
            from_account_id:responseJson["from_account"]["id"],
            from_accountName: responseJson["from_account"]["account_name"],id:id,date: responseJson["date"],isZakah: responseJson["is_zakath"],
          )));

          listTransfer();
        }
        else{
          hideProgressBar();
        }
      } catch (e) {

        hideProgressBar();
        print(e.toString());
      }

    }
    else {

      hideProgressBar();
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

}

List<TransferListModel> transferList = [];

class TransferListModel {
  final String date, total;

  var data;

  TransferListModel({
    required this.date,
    required this.total,
    required this.data,
  });

  factory TransferListModel.fromJson(Map<dynamic, dynamic> json) {
    return new TransferListModel(
      date: json['date'],
      total: json['total'].toString(),
      data: json['data'],
    );
  }
}
