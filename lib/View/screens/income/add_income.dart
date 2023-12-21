// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../Api Helper/Bloc/Income/income_bloc.dart';
// import '../../../Api Helper/ModelClasses/Income/CreateIncomeModelClass.dart';
// import '../../../Api Helper/ModelClasses/Income/EditIncomeModelClass.dart';
// import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
// import '../../../Utilities/Commen Functions/date_picker_function.dart';
// import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
// import '../../../Utilities/Commen Functions/time_picker.dart';
// import '../../../Utilities/CommenClass/commen_txtfield_widget.dart';
// import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
// import '../../../Utilities/CommenClass/date_and_time_textfield_class.dart';
// import '../../../Utilities/global/custom_class.dart';
// import '../../../Utilities/global/text_style.dart';
// import 'account_list.dart';
//
//
// class CreateAndEditIncome extends StatefulWidget {
//   final String type;
//   bool? isInterest;
//   bool? is_zakath;
//   bool? is_loan;
//   String? date;
//   String? time;
//   String? organization;
//   String? from_account;
//   String? from_accountName;
//   String? to_account;
//   String? to_accountName;
//   String? amount;
//   String? description;
//   String? id;
//   double? fromAccountAmount;
//   String? finance_type;
//   String? balance;
//
//   CreateAndEditIncome(
//       {super.key,
//       required this.type,
//       this.isInterest,
//       this.is_zakath,
//       this.date,
//       this.time,
//       this.organization,
//       required this.from_account,
//       required this.amount,
//       required this.from_accountName,
//       required this.is_loan,
//       required this.balance,
//       this.to_account,
//       this.description,
//       this.id,
//       this.finance_type,
//       this.to_accountName,
//       this.fromAccountAmount});
//
//   @override
//   State<CreateAndEditIncome> createState() => _CreateAndEditIncomeState();
// }
//
// class _CreateAndEditIncomeState extends State<CreateAndEditIncome> {
//   TextEditingController calenderController = TextEditingController();
//   TextEditingController fromAccountController = TextEditingController();
//   TextEditingController toAccountController = TextEditingController();
//   TextEditingController amountController = TextEditingController();
//   TextEditingController narationController = TextEditingController();
//   TextEditingController timeController = TextEditingController();
//   DateTime selectedDateAndTime = DateTime.now();
//   FocusNode initialFCNode = FocusNode();
//   String _date = "DD/MM/YYYY";
//   String dateFormat = "2022-01-01";
//   bool isZakath = false;
//   ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime.now());
//   ValueNotifier<DateTime> timeNotifier = ValueNotifier(DateTime.now());
//   DateFormat timeFormat = DateFormat.jm();
//   final DateFormat formatter = DateFormat('dd-MM-yyyy');
//   DateFormat apiDateFormat = DateFormat("y-M-d");
//   DateFormat apiTimeFormate = DateFormat('HH:mm');
//
//   String roundFunction1(String val) {
//     if (val == "") {
//       val = "0.00";
//     }
//
//
//     double convertedTodDouble = double.parse(val);
//     var number = convertedTodDouble.toStringAsFixed(2);
//
//     return number;
//   }
//
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
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     progressBar = ProgressBar();
//
//     if (widget.type == "Edit") {
//       DateTime parsedTime = DateFormat('hh:mm').parse(widget.time!);
//       dateNotifier = ValueNotifier(DateTime.parse(widget.date!));
//       timeNotifier = ValueNotifier(parsedTime);
//       toAccountController.text = widget.to_accountName!;
//       narationController.text = widget.description!;
//       isZakathanotifier = ValueNotifier(widget.is_zakath!);
//       isInterest = ValueNotifier(widget.isInterest!);
//       amountController.text = widget.amount!;
//       fromAccountController.text = widget.from_accountName!;
//       fromAccountId = widget.from_account!;
//       toAccountId = widget.to_account!;
//       fromAccountBalance = widget.fromAccountAmount!;
//     } else {
//       timeNotifier = ValueNotifier(DateTime.now());
//       dateNotifier = ValueNotifier(DateTime.now());
//       toAccountController.text = "";
//       narationController.text = "";
//       isZakathanotifier = ValueNotifier(false);
//       isInterest = ValueNotifier(false);
//       toAccountId = toAccountId;
//       fromAccountBalance = double.parse(widget.balance!);
//       amountController.text = widget.amount!;
//       fromAccountController.text = widget.from_accountName!;
//       fromAccountId = widget.from_account!;
//
//     }
//   }
//
//   double fromAccountBalance = 0.00;
//
//   ValueNotifier<bool> isZakathanotifier = ValueNotifier(false);
//   ValueNotifier<bool> isInterest = ValueNotifier(false);
//
//   String apiFormatTime = "";
//   final _formKey = GlobalKey<FormState>();
//   String fromAccountId = "";
//   String toAccountId = "";
//   late EditIncomeModelClass editIncomeModelClass;
//   late CreateIncomeModelClass createIncomeModelClass;
//
//   @override
//   Widget build(BuildContext context) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//     final space = SizedBox(
//       height: mHeight * .02,
//     );
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<IncomeBloc, IncomeState>(listener: (context, state) {
//           if (state is IncomeCreateLoaded) {
//             hideProgressBar();
//             createIncomeModelClass = BlocProvider.of<IncomeBloc>(context).createIncomeModelClass;
//             if (createIncomeModelClass.statusCode == 6000) {
//               Navigator.pop(context);
//             }
//             if (createIncomeModelClass.statusCode == 6001) {
//               msgBtmDialogueFunction(
//                 context: context,
//                 textMsg: createIncomeModelClass.data.toString(),
//               );
//             }
//             if (createIncomeModelClass.statusCode == 6002) {
//               alreadyCreateBtmDialogueFunction(
//                   context: context,
//                   textMsg: "Something went wrong",
//                   buttonOnPressed: () {
//                     Navigator.of(context).pop(false);
//                   });
//             }
//           }
//         }),
//         BlocListener<IncomeBloc, IncomeState>(listener: (context, state) {
//           if (state is EditIncomeLoading) {
//             const CircularProgressIndicator();
//           }
//           if (state is EditIncomeLoaded) {
//             hideProgressBar();
//             editIncomeModelClass = BlocProvider.of<IncomeBloc>(context).editIncomeModelClass;
//
//
//             if (editIncomeModelClass.statusCode == 6000) {
//               Navigator.pop(context);
//             }
//             if (editIncomeModelClass.statusCode == 6001) {
//               msgBtmDialogueFunction(
//                 context: context,
//                 textMsg: editIncomeModelClass.data.toString(),
//               );
//             }
//             if (editIncomeModelClass.statusCode == 6002) {
//               alreadyCreateBtmDialogueFunction(
//                   context: context,
//                   textMsg: "Something went wrong",
//                   buttonOnPressed: () {
//                     Navigator.of(context).pop(false);
//                   });
//             }
//           }
//           if (state is EditIncomeError) {
//             const Text("Something went wrong");
//           }
//         }),
//       ],
//       child: Scaffold(
//
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           toolbarHeight: MediaQuery.of(context).size.height / 11,
//
//           backgroundColor: const Color(0xffffffff),
//           elevation: 0,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Color(0xff2BAAFC),
//             ),
//           ),
//           title: Text(
//             widget.is_loan!
//                 ? "Receipt"
//                 : widget.type == "Create"
//                     ? 'Add Income'
//                     : "Edit Income",
//             style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 22.0),
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06),
//           child: Form(
//             key: _formKey,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: ListView(
//               physics: BouncingScrollPhysics(),
//               children: [
//                 space,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ValueListenableBuilder(
//                         valueListenable: dateNotifier,
//                         builder: (BuildContext ctx, fromDateNewValue, _) {
//                           final String formatted = formatter.format(dateNotifier.value);
//                           return SizedBox(
//                             width: MediaQuery.of(context).size.width * .42,
//                             height: MediaQuery.of(context).size.height * .05,
//                             child: TextfieldWidgetDateAndTime(
//                               controller: calenderController..text = formatted,
//                               readOnly: true,
//                               prefixIcon: Padding(
//                                 padding: const EdgeInsets.all(6.0),
//                                 child: SvgPicture.asset("assets/svg/calender.svg"),
//                               ),
//                               onTap: () {
//                                 showDatePickerFunction(context, dateNotifier);
//                               },
//                             ),
//                           );
//                         }),
//                     ValueListenableBuilder(
//                         valueListenable: timeNotifier,
//                         builder: (BuildContext ctx, timeNotifierNewValue, _) {
//                           final String time = timeFormat.format(timeNotifierNewValue);
//
//                           return Container(
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width * .42,
//                               height: MediaQuery.of(context).size.height * .05,
//                               child: TextfieldWidgetDateAndTime(
//                                 controller: timeController..text = time,
//                                 readOnly: true,
//                                 prefixIcon: Padding(
//                                   padding: const EdgeInsets.all(6.0),
//                                   child: SvgPicture.asset("assets/svg/clock.svg"),
//                                 ),
//                                 onTap: () {
//                                   timePicker(context, timeNotifier);
//                                 },
//                               ));
//                         }),
//                   ],
//                 ),
//
//
//                 space,
//                 SizedBox(
//                     child: CommenTextFieldWidget(
//                   controller: amountController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty || value.trim().isEmpty) {
//                       amountController..text = "0.00";
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                       onTap: () => amountController.selection = TextSelection(
//                           baseOffset: 0,
//                           extentOffset: amountController.value.text.length),
//                   hintText: 'Amount',
//                   readOnly: widget.is_loan!,
//                   textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
//                   list: [
//                     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
//                   ],
//                   textAlign: TextAlign.start,
//                   textInputAction: TextInputAction.next,
//                   textCapitalization: TextCapitalization.words,
//                   obscureText: false,
//                 )),
//                 space,
//                 Container(
//                   height: 100,
//                   child: TextFormField(
//                     style: customisedStyle(context, Color(0xff13213A), FontWeight.normal, 15.0),
//                     controller: narationController,
//                     maxLines: null,
//                     expands: true,
//                     keyboardType: TextInputType.multiline,
//                     decoration: const InputDecoration(
//                       contentPadding: EdgeInsets.all(7),
//                       hintText: "Narration",
//                       hintStyle: TextStyle(color: Color(0xff778EB8)),
//                       border: InputBorder.none,
//                       filled: true,
//                       fillColor: Color(0xffF3F7FC),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(4)),
//                         borderSide: BorderSide(color: Color(0xffF3F7FC)),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(4)),
//                         borderSide: BorderSide(color: Color(0xffF3F7FC)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 space,
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width / 1.1,
//                     child: CommenTextFieldWidget(
//                       controller: fromAccountController,
//                       hintText: "From Account",
//                       readOnly: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty || value.trim().isEmpty) {
//                           return 'This field is required';
//                         }
//                         return null;
//                       },
//                       onTap: () async {
//                         if (widget.is_loan == false) {
//                           var result = await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AccountList(
//                                       type: [3],
//                                     )),
//                           );
//                           result != null ? fromAccountId = result[0] : Null;
//                           result != null ? fromAccountController.text = result[1] : Null;
//                           setState(() {
//                             result != null ? fromAccountBalance = result[2] : Null;
//                           });
//                         }
//                       },
//                       suffixIcon: Icon(
//                         Icons.arrow_drop_down,
//                         color: Colors.black,
//                       ),
//                       textAlign: TextAlign.start,
//                       textInputAction: TextInputAction.next,
//                       textCapitalization: TextCapitalization.words,
//                       textInputType: TextInputType.text,
//                       obscureText: false,
//                     )),
//
//                 space,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "Balance :",
//                       style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 15.0),
//                     ),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text(
//                       roundFunction1(fromAccountBalance.toString()),
//                       style: customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 15.0),
//                     ),
//                   ],
//                 ),
//                 space,
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width / 1.1,
//                     child: TextFormField(
//                         style: customisedStyle(context, Color(0xff13213A), FontWeight.normal, 15.0),
//                         validator: (value) {
//                           if (value == null || value.isEmpty || value.trim().isEmpty) {
//                             return 'This field is required';
//                           }
//                           return null;
//                         },
//                         onTap: () async {
//                           var result = await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AccountList(
//                                       type: [1, 2],
//                                     )),
//                           );
//                           result != null ? toAccountId = result[0] : Null;
//                           result != null ? toAccountController.text = result[1] : Null;
//                         },
//                         controller: toAccountController,
//                         readOnly: true,
//                         decoration: TextFieldDecoration.defaultStyleWithIcon(context, hintTextStr: "To Account"))),
//                 space,
//                 widget.is_loan ==false? Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ValueListenableBuilder(
//                             valueListenable: isZakathanotifier,
//                             builder: (BuildContext context, bool newCheckValue, _) {
//                               return Container(
//                                   height: mHeight * .033,
//                                   width: mWidth * .06,
//                                   decoration: BoxDecoration(
//                                     color: newCheckValue == true ? const Color(0xff067834) : const Color(0xffE6E6E6),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Checkbox(
//                                       checkColor: const Color(0xffffffff),
//                                       activeColor: Colors.transparent,
//                                       fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
//                                       value: newCheckValue,
//                                       onChanged: (value) {
//                                         isZakathanotifier.value = !isZakathanotifier.value;
//                                       }));
//                             }),
//                         SizedBox(
//                           width: mWidth * .02,
//                         ),
//                         Text(
//                           "Mark As Zakath",
//                           style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 15.0),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: mWidth * .05,
//                     ),
//                     Container(
//                       child: Row(
//                         children: [
//                           ValueListenableBuilder(
//                               valueListenable: isInterest,
//                               builder: (BuildContext context, bool newCheckValue, _) {
//                                 return Container(
//                                     height: mHeight * .033,
//                                     width: mWidth * .06,
//                                     decoration: BoxDecoration(
//                                       color: newCheckValue == true ? const Color(0xff067834) : const Color(0xffE6E6E6),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Checkbox(
//                                         checkColor: const Color(0xffffffff),
//                                         activeColor: Colors.transparent,
//                                         fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
//                                         value: newCheckValue,
//                                         onChanged: (value) {
//                                           isInterest.value = !isInterest.value;
//                                         }));
//                               }),
//                           SizedBox(
//                             width: mWidth * .02,
//                           ),
//                           Text(
//                             "Mark As Interest",
//                             style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 15.0),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ):SizedBox(),
//                 SizedBox(
//                   height: mHeight * .5,
//                 )
//               ],
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         floatingActionButton: GestureDetector(
//           child: SvgPicture.asset('assets/svg/save.svg'),
//           onTap: () {
//             if (_formKey.currentState!.validate()) {
//               if (fromAccountId == toAccountId) {
//                 msgBtmDialogueFunction(context: context, textMsg: " Can't be paid to the same account");
//               } else {
//                 if (widget.type == "Create") {
//                   createIncomeApi();
//                 } else {
//                   editIncomeApi();
//                 }
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   createIncomeApi() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId = prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//       showProgressBar();
//       return BlocProvider.of<IncomeBloc>(context).add(CreateIncomeEvent(
//           isInterest: isInterest.value,
//           is_zakath: isZakathanotifier.value,
//           date: apiDateFormat.format(dateNotifier.value),
//           time: apiTimeFormate.format(timeNotifier.value),
//           organization: organizationId!,
//           from_account: fromAccountId,
//           to_account: toAccountId,
//           amount: amountController.text,
//           description: narationController.text,
//           finance_type: 0));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   editIncomeApi() async {
//     var netWork = await checkNetwork();
//
//     if (netWork) {
//       if (!mounted) return;
//       return BlocProvider.of<IncomeBloc>(context).add(EditIncomeEvent(
//           isInterest: isInterest.value,
//           is_zakath: isZakathanotifier.value,
//           date: apiDateFormat.format(dateNotifier.value),
//           time: apiTimeFormate.format(timeNotifier.value),
//           organization: widget.organization!,
//           from_account: fromAccountId,
//           to_account: toAccountId,
//           amount: amountController.text,
//           description: narationController.text,
//           id: widget.id!,
//           finance_type: 0));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
// }
