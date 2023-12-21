import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';


import '../../../../Utilities/global/custom_class.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../../Export/export_to_excel.dart';
import '../../Export/export_to_pdf.dart';
import 'loan_api.dart';

class PaymentSchedule extends StatefulWidget {
  const PaymentSchedule({super.key,

    required this.heading,
    required this.isExist,
    required this.loan_name,
    required this.date,
    required this.payment_type,
    required this.loan_amount,
    required this.interest,
    required this.duration,
    required this.payment_date,
    required this.processing_fee,
    required this.is_fee_include_loan,
    required this.is_fee_include_emi,
    required this.uID,
    required this.is_purchase,
    required this.is_existing,
    required this.down_payment,
    required this.to_account,
    required this.emi_data, required this.isEdit, required this.selectedIDExpense,
  });

  @override
  State<PaymentSchedule> createState() => _AddIncomePageState();

  final String loan_name;
  final String uID;
  final String date;
  final String heading;
  final String payment_type;
  final String loan_amount;
  final String interest;
  final String duration;
  final String payment_date;
  final String processing_fee;
  final bool is_fee_include_loan;
  final bool is_fee_include_emi;
  final bool is_purchase;
  final bool is_existing;
  final String down_payment;

  final String to_account;
  final String selectedIDExpense;
  final List emi_data;

  final bool isExist;
  final bool isEdit;
}

class _AddIncomePageState extends State<PaymentSchedule> {
  DateTime selectedDateAndTime = DateTime.now();

  ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime.now());
  TextEditingController emiAmountController = TextEditingController()..text = '0.00';
  ValueNotifier<bool> IsCustomEMI = ValueNotifier(false);
  ValueNotifier<bool> IsFixedAmount = ValueNotifier(true);

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  List<TextEditingController> amountControllersList = [];

  changeValue(index, value) {
    var item = {"amount": roundStringWithOnlyDigit(value), "status": responseLIst[index]["status"], "date": responseLIst[index]["date"]};
    setState(() {
      responseLIst[index] = item;
    });
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

  var responseLIst = [];

  @override
  void initState() {
    super.initState();



    responseLIst = widget.emi_data;
    progressBar = ProgressBar();


    if(widget.isEdit){
    IsCustomEMI = ValueNotifier(false);
    IsFixedAmount = ValueNotifier(false);
    }

  }





  changeAmount(String val) {
    if (val == "") {
      val = "0.00";
    }

    setState(() {
      amountControllersList.clear();
      responseLIst = responseLIst.map((item) {
        item["amount"] = val;
        return item;
      }).toList();
    });
  }
  DateFormat apiDateFormat = DateFormat("y-M-d");
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
          widget.heading,
          style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 22.0),
        ),
        actions: [],
      ),
      body: ValueListenableBuilder(
          valueListenable: IsFixedAmount,
          builder: (BuildContext context, bool newCheckValue, _) {
            return Container(
              child: Column(
                children: [
                  space,

                  Container(
                    height: MediaQuery.of(context).size.height / 17,
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE9E9E9)), top: BorderSide(color: Color(0xffE9E9E9)))),
                    child: Padding(
                      padding: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Set Payment schedule",
                            style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 16.0),
                          ),
                          Row(
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
                                          SvgPicture.asset("assets/svg/export.svg",color:  Color(0xff2BAAFC),),
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





                                      List<dynamic> data = [
                                        ['', '     ', '', '     '],
                                        ['', '     ', '', '     '],
                                        ['Date', 'Due date', 'Amount', ''],
                                      ];

                                      if (responseLIst.isEmpty) {
                                        msgBtmDialogueFunction(
                                            context: context,
                                            textMsg: "Please ensure there is data before exporting.");
                                      } else {

                                        for (var i = 0; i < responseLIst.length; i++) {


                                          List a = [
                                            (i + 1).toString(),
                                            responseLIst[i]["date"] ?? "",
                                            roundStringWith(responseLIst[i]["amount"] ?? 0.0).toString(),
                                            "",
                                          ];

                                          data.add(a);
                                        }





                                        var head = "Loan schedule ";


                                        if (value == 'pdf') {
                                          loadDataToReport(data: data,heading: head,date: "",type: 5,balance: '');
                                        }
                                        else if (value == 'excel') {
                                          convertToExcel(data: data,
                                              heading: head,
                                              date: "",balance: '');
                                        } else {}
                                      }




                                    },
                                  )),


                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  space,
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: mHeight * .06,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 0.5,
                          color: Color(0xffECECEC),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: IsFixedAmount,
                            builder: (BuildContext context, bool newCheckValue, _) {
                              return GestureDetector(
                                onTap: () {
                                  if (IsFixedAmount.value == false) {
                                    IsFixedAmount.value = !newCheckValue;
                                    if (newCheckValue == false) {
                                      IsCustomEMI.value = false;
                                    }
                                    changeAmount(emiAmountController.text);
                                  }
                                },
                                child: InkWell(
                                  child: Row(
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
                                      SizedBox(
                                        width: mWidth * .03,
                                      ),
                                      Text(
                                        "Fixed amount",
                                        style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        ValueListenableBuilder(
                            valueListenable: IsCustomEMI,
                            builder: (BuildContext context, bool newCheckValue, _) {
                              return GestureDetector(
                                onTap: () {
                                  if (IsCustomEMI.value == false) {
                                    emiAmountController.text = "0.00";
                                    IsCustomEMI.value = !newCheckValue;
                                    if (newCheckValue == false) {
                                      IsFixedAmount.value = false;
                                    }
                                  }
                                },
                                child: InkWell(
                                  child: Row(
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
                                      SizedBox(
                                        width: mWidth * .03,
                                      ),
                                      Text(
                                        "Custom EMI",
                                        style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  space,
                  Center(
                      child: Text(
                    "You can mark the payments you've \nalready made.",
                    style: customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 14.0),
                    textAlign: TextAlign.center,
                  )),

                  IsFixedAmount.value? Padding(
                    padding:   EdgeInsets.only(top: mHeight * .02),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextFormField(
                            onChanged: (text) {
                              changeAmount(text);
                            },
                            onTap: () {
                              emiAmountController.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: emiAmountController.value.text.length,
                              );
                            },
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
                            controller: emiAmountController,
                            decoration: TextFieldDecoration.defaultStyleWithLabel(context, hintTextStr: "EMI Amount"))),
                  ):Container(),
                  space,
                  Expanded(
                      child: responseLIst.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: responseLIst.length,

                              itemBuilder: (context, index) {
                                amountControllersList.add(TextEditingController()..text = roundStringWith(responseLIst[index]["amount"]));
                                return Padding(
                                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),

                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:  MediaQuery.of(context).size.width / 2,
                                            height: MediaQuery.of(context).size.height / 20,
                                            child: GestureDetector(
                                              onTap: () {
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    widget.isExist
                                                        ? Padding(
                                                            padding: const EdgeInsets.only(right: 15.0),
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  responseLIst[index]['status'] = !responseLIst[index]['status'];
                                                                });
                                                                 },
                                                              child: InkWell(
                                                                child: Container(

                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(5.0),
                                                                    child: SvgPicture.asset(
                                                                      "assets/svg/checkmark-filled (2).svg",
                                                                      height: mHeight * .025,
                                                                      color: responseLIst[index]['status'] == true ? Color(0xff067834) : Color(0xffD0E1E8),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 1.0),
                                                      child: Text(
                                                        "${1 + index}.",
                                                        style: customisedStyle(context, Colors.black, FontWeight.w400, 14.0),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Color(0xff2BAAFC),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0),
                                                      child: Text(
                                                        changeDateFormat(responseLIst[index]["date"]),
                                                        style: customisedStyle(
                                                          context,
                                                          Color(0xff878787),
                                                          FontWeight.normal,
                                                          13.0,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: MediaQuery.of(context).size.height / 20,
                                              width: mWidth / 3.2,
                                              child: TextField(
                                                style: customisedStyle(
                                                  context,
                                                  Colors.black,
                                                  FontWeight.w500,
                                                  15.0,
                                                ),
                                                readOnly: newCheckValue == true ? true : false,
                                                onChanged: (text) {
                                                  changeValue(index, text);
                                                },
                                                textAlign: TextAlign.right,
                                                onTap: () {
                                                  amountControllersList[index].selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: amountControllersList[index].value.text.length,
                                                  );
                                                },
                                                keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                                ],
                                                controller: amountControllersList[index],
                                                decoration: InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      borderSide:
                                                          BorderSide(width: 1, color: newCheckValue == true ? Colors.transparent : Color(0xffF3F7FC)),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      borderSide:
                                                          BorderSide(width: 1, color: newCheckValue == true ? Colors.transparent : Color(0xffF3F7FC)),
                                                    ),
                                                    contentPadding: EdgeInsets.all(7),
                                                    labelText: "",
                                                    labelStyle: TextStyleDecoration.hintTextColor(context),
                                                    hintText: "",
                                                    hintStyle: TextStyleDecoration.hintTextColor(context),
                                                    border: InputBorder.none,
                                                    filled: true,
                                                    fillColor: newCheckValue == true ? Colors.white : Color(0xffF3F7FC)),
                                              )
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : Container()),

                ],
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * .08,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xffE2E2E2),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  child: SvgPicture.asset('assets/svg/plus-circle-line (1).svg'),
                  onTap: () async {
                    Navigator.pop(context);
                  }),
              Row(
                children: [
                  GestureDetector(
                      child: SvgPicture.asset('assets/svg/Group 1361 (1).svg',color: Color(0xff2BAAFC)),
                      onTap: () async {
                        Navigator.pop(context);

                      }),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(child: SvgPicture.asset('assets/svg/Group 1351.svg'),
                      onTap: () async {


                    bool isAmountValid = validateAmount();
                    if(isAmountValid){

                      var total = totalAmount();

                      var amt = widget.is_fee_include_loan ? double.parse(widget.loan_amount)-double.parse(widget.processing_fee):double.parse(widget.loan_amount);


                      if(total>= amt){

                        var accountID = "";

                        if(widget.is_existing ==false){
                          if(widget.is_purchase ==false){
                            accountID = widget.to_account;
                          }
                          else{
                            accountID = widget.selectedIDExpense;
                          }
                        }

                        var res = await crateLoan(
                          uID: widget.uID,
                          type:widget.isEdit,
                          loan_name:widget.loan_name,
                          date: widget.date,
                          down_payment:widget.down_payment,
                          duration: widget.duration,
                          processing_fee: widget.processing_fee,
                          emi_data: responseLIst,
                          interest: widget.interest,
                          is_existing: widget.is_existing,
                          is_fee_include_emi: widget.is_fee_include_emi,
                          is_fee_include_loan: widget.is_fee_include_loan,
                          is_purchase: widget.is_purchase,
                          loan_amount: widget.loan_amount,
                          payment_date: responseLIst[0]["date"],
                          payment_type: widget.payment_type,
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
                      else{
                        msgBtmDialogueFunction(context: context, textMsg: "Total EMI Amount is ${roundStringWith(total.toString())} must be greater than loan amount  ${roundStringWith(amt.toString())}");
                      }

                    }
                    else{
                      msgBtmDialogueFunction(context: context, textMsg: "Amount must be greater than zero");
                    }




                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAmount() {
    return responseLIst.every((element) {
      if (element['amount'] != null && double.parse(element['amount']) > 0) {
        return true;
      }
      return false;
    });
  }
  double totalAmount() {
    double totalAmount = 0;

    for (var item in responseLIst) {
      totalAmount += double.parse(item['amount']);
    }
    return totalAmount;

  }

  String changeDateFormat(String inputDate) {
    DateTime originalDate = DateTime.parse(inputDate);

    String formattedDate = DateFormat('dd-MM-yyyy').format(originalDate);

    return formattedDate;
  }


}
