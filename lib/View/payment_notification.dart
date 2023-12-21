// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Api Helper/Bloc/reminder/reminder_bloc.dart';
// import '../Api Helper/ModelClasses/Reminder/ListReminderModelClass.dart';
// import '../Utilities/Commen Functions/bottomsheet_fucntion.dart';
// import '../Utilities/Commen Functions/internet_connection_checker.dart';
// import '../Utilities/Commen Functions/roundoff_function.dart';
// import '../Utilities/CommenClass/custom_overlay_loader.dart';
//
// import '../Utilities/global/text_style.dart';
// import '../Utilities/global/variables.dart';
// class PaymentNotification extends StatefulWidget {
//    PaymentNotification({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentNotification> createState() => _PaymentNotificationState();
// }
//
// class _PaymentNotificationState extends State<PaymentNotification> {
//   TextEditingController searchController = TextEditingController();
//   late ProgressBar progressBar;
//
//   void showProgressBar() {
//     progressBar.show(context);
//   }
//
//   void hideProgressBar() {
//     progressBar.hide();
//   }
//
//   @override
//   void dispose() {
//     progressBar.hide();
//
//     super.dispose();
//   }
//   @override
//   void initState() {
//     progressBar = ProgressBar();
//     super.initState();
//     listReminderApiFunction();
//   }
//   late  ListReminderModelClass listReminderModelClass;
//   listReminderApiFunction() async {
//     var netWork = await checkNetwork();
//
//     if (netWork) {
//       if (!mounted) return;
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       final organizationId = prefs.getString("organisation");
//       return BlocProvider.of<ReminderBloc>(context).add(ListReminderEvent(organization: organizationId!, description: "", date: "", amount: "", reminder_cycle: 0, master_id: 1, voucher_type: "AST"));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(
//           context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           toolbarHeight: MediaQuery.of(context).size.height / 11,
//
//           backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         elevation: 1,
//         title:
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Payment Notification',
//                 style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 20.0),
//               ),
//               Container(
//                   alignment: Alignment.center,
//                   height: mHeight * .05,
//                   width: mWidth * .3,
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF3F7FC)),
//                   child: Text(
//                     default_country_name + "-" + countryShortCode,
//                     style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),
//                   ))
//             ],
//           )
//
//
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: mWidth * .03, right: mWidth * .03),
//         height: mHeight,
//         child:  Center(
//           child:  Column(
//           children: [
//             SizedBox(height: mHeight * .02),
//
//
//             Expanded(
//               child: BlocBuilder<ReminderBloc, ReminderState>(
//                 builder: (context, state) {
//                   if (state is ReminderListLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: Color(0xff5728C4),
//                       ),
//                     );
//                   }
//                   if (state is ReminderListLoaded) {
//                     listReminderModelClass =
//                         BlocProvider.of<ReminderBloc>(context)
//                             .listReminderModelClass;
//                     return listReminderModelClass.data!.isNotEmpty
//                         ? ListView.builder(
//                       physics: BouncingScrollPhysics(),
//                         itemCount: listReminderModelClass.data!.length,
//                         itemBuilder: (BuildContext context, int index) {
//
//                           bool isGave = index == 0;
//                           bool isTook = index == 1;
//
//                           return ListTile(
//                             shape: RoundedRectangleBorder(
//                                 side: const BorderSide(
//                                     color: Color(0xffDEDEDE), width: .5),
//                                 borderRadius: BorderRadius.circular(1)),
//                             tileColor: const Color(0xffFFFFFF),
//                             title: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children:  [
//
//
//                                 Row(
//                                   children: [
//                                     Text(
//                                       listReminderModelClass.data![index].masterName!,
//                                       style:  customisedStyle(context, Color(0xff7B61DA), FontWeight.normal, 12.0),
//                                     ),
//
//                                   ],
//                                 ),
//                                 Text(
//                                   listReminderModelClass.data![index].accountName!,
//                                   style:  customisedStyle(context, Colors.black, FontWeight.w300, 12.0),
//                                 )
//                               ],
//                             ),
//                             subtitle: Row(
//                               children:  [
//                                 Text(roundStringWith(listReminderModelClass.data![index].amount!),
//                                   style:  customisedStyle(context, listReminderModelClass.data![index].voucherType == "EX" ?
//                                       Color(0xffDC0000):Color(0xff086712), FontWeight.w600, 13.0),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 6),
//                                   child: Text(
//                                    "${listReminderModelClass.data![index].day}",
//                                     style:  customisedStyle(context, Color(0xff707070), FontWeight.w500, 11.0),
//                                   ),
//                                 )
//                               ],
//                             ),
//
//                           );
//                         })
//                         : SizedBox(
//                         height: mHeight * .7,
//                         child: const Center(
//                             child: Text(
//                               "Items not found !",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )));
//                   }
//                   if (state is ReminderListError) {
//                     return Center(
//                         child: Text(
//                           "Something went wrong",
//                           style: customisedStyle(
//                               context, Colors.black, FontWeight.w500, 13.0),
//                         ));
//                   }
//                   return SizedBox();
//                 },
//               ),
//             ),
//
//           ],
//         ),
//         )
//
//       ),
//
//
//     );
//   }
// }




import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Reminder/ListReminderModelClass.dart';
import 'package:cuentaguestor_edit/Utilities/global/text_style.dart';
import 'package:cuentaguestor_edit/Utilities/global/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api Helper/Bloc/reminder/reminder_bloc.dart';
import '../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../Utilities/Commen Functions/internet_connection_checker.dart';
import '../Utilities/Commen Functions/roundoff_function.dart';
import '../Utilities/CommenClass/custom_overlay_loader.dart';
import 'screens/expenses/expense_new_design/transaction_page_expense.dart';
import 'screens/income/Income_new_design/transaction_page_income.dart';

class PaymentNotification extends StatefulWidget {
  PaymentNotification({Key? key}) : super(key: key);

  @override
  State<PaymentNotification> createState() => _PaymentNotificationState();
}

class _PaymentNotificationState extends State<PaymentNotification> {
  TextEditingController searchController = TextEditingController();
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
    super.initState();
    listReminderApiFunction();
  }

  late ListReminderModelClass listReminderModelClass;

  listReminderApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");
      return BlocProvider.of<ReminderBloc>(context).add(ListReminderEvent(
          organization: organizationId!, description: "", date: "", amount: "", reminder_cycle: 0, master_id: 1, voucher_type: "AST"));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

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

    // else if(type =="EX"){
    //   return "Expense";
    // }
    // else if(type =="EX"){
    //   return "Expense";
    // }
  }

  returnMasterName(type) {
    if (type == "0") {
      return "Contact";
    }
    else if (type == "1") {
      return "Cash";
    } else if (type == "2") {
      return "Bank";
    }
    else if (type == "3") {
      return "Income";
    }
    else if (type == "4") {
      return "Expense";
    }
    else if (type == "5") {
      return "Suspense";
    }
    else if (type == "6") {
      return "Asset";
    }
    else if (type == "7") {
      return "Loan";
    }
    else if (type == "8") {
      return "Loan";
    }
    else {
      return "";
    }

    // else if(type =="EX"){
    //   return "Expense";
    // }
    // else if(type =="EX"){
    //   return "Expense";
    // }
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: MediaQuery.of(context).size.height / 11,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Notification',
                style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 20.0),
              ),
              Container(
                  alignment: Alignment.center,
                  height: mHeight * .05,
                  width: mWidth * .3,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF3F7FC)),
                  child: Text(
                    default_country_name + "-" + countryShortCode,
                    style: customisedStyle(context, Color(0xff3645A9), FontWeight.w500, 14.0),
                  ))
            ],
          )),
      body: Container(
          padding: EdgeInsets.only(left: mWidth * .03, right: mWidth * .03),
          height: mHeight,
          child: Center(
            // child: Text(
            //     textAlign: TextAlign.center,
            //     "The feature you mentioned is currently in development and will be available in our upcoming updates. "
            //     "Thank you for your patience and stay tuned for more exciting updates.",style: customisedStyle(context,  Color(0xff13213A), FontWeight.w500, 13.0)),
            child: Column(
              children: [
                SizedBox(height: mHeight * .02),
                Expanded(
                  child: BlocBuilder<ReminderBloc, ReminderState>(
                    builder: (context, state) {
                      if (state is ReminderListLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff5728C4),
                          ),
                        );
                      }
                      if (state is ReminderListLoaded) {
                        listReminderModelClass = BlocProvider.of<ReminderBloc>(context).listReminderModelClass;
                        return listReminderModelClass.data!.isNotEmpty
                            ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: listReminderModelClass.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              bool isGave = index == 0;
                              bool isTook = index == 1;

                              return ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Color(0xffDEDEDE), width: .5), borderRadius: BorderRadius.circular(1)),
                                  tileColor: const Color(0xffFFFFFF),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        returnMasterName(listReminderModelClass.data![index].account_type!),
                                        style: customisedStyle(context, Colors.black, FontWeight.w600, 13.0),
                                      ),

                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       returnVoucherType(listReminderModelClass.data![index].voucherType!),
                                      //       style: customisedStyle(context, Color(0xff7B61DA), FontWeight.normal, 12.0),
                                      //     ),
                                      //     // Text(
                                      //     //   isTook ? " - took" : (isGave ? " - Gave" : ""),
                                      //     //
                                      //     //   style:  customisedStyle(context,isTook? Color(0xffA50808):Color(0xff0E9A1C), FontWeight.normal, 12.0),
                                      //     // ),
                                      //   ],
                                      // ),

                                      Text(
                                        listReminderModelClass.data![index].accountName!,
                                        style: customisedStyle(context, Colors.black, FontWeight.w300, 12.0),
                                      )
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        roundStringWith(listReminderModelClass.data![index].amount!),
                                        style: customisedStyle(
                                            context,
                                            listReminderModelClass.data![index].voucherType == "EX" ? Color(0xffDC0000) : Color(0xff086712),
                                            FontWeight.w600,
                                            13.0),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 6),
                                        child: Text(
                                          "${listReminderModelClass.data![index].day}",
                                          style: customisedStyle(context, Color(0xff707070), FontWeight.w500, 11.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  /// commented for updatoin
                                  // trailing: ElevatedButton(
                                  //   onPressed: () async {
                                  //     if (listReminderModelClass.data![index].account_type == "0") {
                                  //       var result = await Navigator.of(context).push(MaterialPageRoute(
                                  //           builder: (context) => TransactionPageContact(
                                  //             contactID: listReminderModelClass.data![index].account,
                                  //             contactName: listReminderModelClass.data![index].accountName,
                                  //             isZakath: false,
                                  //             isDetail: false,
                                  //             reminderID:listReminderModelClass.data![index].id,
                                  //             isFromNotification: true,
                                  //             financeType: listReminderModelClass.data![index].transactionType == 1 ? "0" : "1",
                                  //             type: "Create",
                                  //             balance: "0.00",
                                  //             amount: "0.00",
                                  //             to_account_id: "",
                                  //             to_accountName: "",
                                  //             description: "",
                                  //             from_account_id: "",
                                  //             from_accountName: "",
                                  //             id: "",
                                  //             date: "",
                                  //             isInterest: false,
                                  //           )));
                                  //
                                  //       listReminderApiFunction();
                                  //     }
                                  //     else if (listReminderModelClass.data![index].account_type == "3"||
                                  //         listReminderModelClass.data![index].account_type == "4" ||
                                  //         listReminderModelClass.data![index].account_type == "6") {
                                  //       if(listReminderModelClass.data![index].transactionType == 0) {
                                  //
                                  //         var result = await Navigator.of(context).push(MaterialPageRoute(
                                  //             builder: (context) => TransactionPageIncome(
                                  //               isZakath: false,
                                  //               isDetail: true,
                                  //               isFromNotification: true,
                                  //               type: "Create",
                                  //               assetMasterID: 0,
                                  //               isAsset: false,
                                  //               reminderID:listReminderModelClass.data![index].id,
                                  //               balance: "0.00",
                                  //               amount: listReminderModelClass.data![index].amount,
                                  //               transactionType: "",
                                  //               from_account_id: listReminderModelClass.data![index].account,
                                  //               from_accountName: listReminderModelClass.data![index].accountName,
                                  //               description: "",
                                  //               to_account_id: "",
                                  //               to_accountName: "",
                                  //               id: "",
                                  //               date: "",
                                  //               isInterest: false,
                                  //               isReminder: false,
                                  //               isReminderDate: "",
                                  //             )));
                                  //
                                  //         listReminderApiFunction();
                                  //       } else {
                                  //         var result = await Navigator.of(context).push(MaterialPageRoute(
                                  //             builder: (context) => TransactionPageExpense(
                                  //               isAsset: false,
                                  //               assetMasterID: 0,
                                  //               fromAccounts: true,
                                  //               zakath: false,
                                  //               isDetail: true,
                                  //               isFromNotification:true,
                                  //               type: "Create",
                                  //               balance: "0.00",
                                  //               reminderID:listReminderModelClass.data![index].id,
                                  //               amount: listReminderModelClass.data![index].amount,
                                  //               to_account_id: listReminderModelClass.data![index].account,
                                  //               to_accountName: listReminderModelClass.data![index].accountName,
                                  //               transactionType: "",
                                  //               description: "",
                                  //               from_account_id: "",
                                  //               from_accountName: "",
                                  //               id: "",
                                  //               date: "",
                                  //               isInterest: false,
                                  //               isReminder: false,
                                  //               isReminderDate: '',
                                  //             )));
                                  //
                                  //         listReminderApiFunction();
                                  //       }
                                  //     }
                                  //
                                  //     else if(listReminderModelClass.data![index].account_type == "8"){
                                  //       var result = await Navigator.of(context).push(MaterialPageRoute(
                                  //           builder: (context) => TransactionPageLoan(
                                  //             outStandingAmount: '0.00',
                                  //             isProcessingFee: false,
                                  //             loanType: '0',
                                  //             isDetail: false,
                                  //             type: "Create",
                                  //             amount: listReminderModelClass.data![index].amount,
                                  //             to_account_id: listReminderModelClass.data![index].account,
                                  //             to_accountName: listReminderModelClass.data![index].accountName,
                                  //             from_account_id: "",
                                  //             from_accountName: "",
                                  //             id: "",
                                  //             date: "",
                                  //             closeLoan: false,
                                  //             isInterest: false,
                                  //             description: '',
                                  //           )));
                                  //
                                  //       listReminderApiFunction();
                                  //     }
                                  //   },
                                  //   child: Text(
                                  //     listReminderModelClass.data![index].voucherType == "LON"
                                  //         ? "Pay now"
                                  //         : listReminderModelClass.data![index].transactionType == 0
                                  //         ? 'Pay now'
                                  //         : "Receive ",
                                  //     style: customisedStyle(context, Colors.white, FontWeight.w400, 11.0),
                                  //   ),
                                  //   style: ElevatedButton.styleFrom(
                                  //     backgroundColor: listReminderModelClass.data![index].voucherType == "LON"
                                  //         ? Color(0xffFF5757)
                                  //         : listReminderModelClass.data![index].transactionType == 0
                                  //         ? Color(0xffFF5757)
                                  //         : Color(0xff49B771),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(30), // <-- Radius
                                  //     ),
                                  //   ),
                                  // )

                              );
                            })
                            : SizedBox(
                            height: mHeight * .7,
                            child: const Center(
                                child: Text(
                                  "Items not found !",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )));
                      }
                      if (state is ReminderListError) {
                        return Center(
                            child: Text(
                              "Something went wrong",
                              style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                            ));
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ],
            ),
          )),

      /// commented

      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: GestureDetector(
      //   child: SvgPicture.asset('assets/svg/add_nte.svg'),
      //   onTap: () async {
      //     // final result = await  Navigator.of(context).push(MaterialPageRoute(
      //     //     builder: (context) => ContactPage( contact: Contact(), type: 'Create',)));
      //     // listContactFunction();
      //   },
      // ),
    );
  }
}
