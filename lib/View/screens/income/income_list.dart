// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// import '../../../Api Helper/Bloc/Income/income_bloc.dart';
// import '../../../Api Helper/ModelClasses/Income/DeleteIncomeModelClass.dart';
// import '../../../Api Helper/ModelClasses/Income/DetailsIncomeModelClass.dart';
// import '../../../Api Helper/ModelClasses/Income/ListIncomeModelClass.dart';
// import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
// import '../../../Utilities/Commen Functions/delete_permission function.dart';
// import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
// import '../../../Utilities/Commen Functions/roundoff_function.dart';
// import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
// import '../../../Utilities/CommenClass/search_commen_class.dart';
// import '../../../Utilities/global/text_style.dart';
// import '../../../Utilities/global/variables.dart';
// import 'add_income.dart';
//
// class IncomeList extends StatefulWidget {
//   @override
//   State<IncomeList> createState() => _IncomeListState();
// }
//
// class _IncomeListState extends State<IncomeList> {
//   TextEditingController searchController = TextEditingController();
//   late ProgressBar progressBar;
//
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
//
//   var photo = "";
//   late ListIncomeModelClass listIncomeModelClass;
//
//   listIncomeApiFunction() async {
//     var netWork = await checkNetwork();
//
//     if (netWork) {
//       if (!mounted) return;
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       final organizationId = prefs.getString("organisation");
//       return BlocProvider.of<IncomeBloc>(context).add(ListIncomeEvent(organization: organizationId!, search: "", financeType: 0));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   deleteIncomeApiFunction() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId = prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//       showProgressBar();
//       return BlocProvider.of<IncomeBloc>(context).add(DeleteIncomeEvent(organization: organizationId!, id: incomeID));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   String incomeID = "";
//
//   detailIncomeApiFunction() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId = prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//       showProgressBar();
//       return BlocProvider.of<IncomeBloc>(context).add(DetailsIncomeEvent(organization: organizationId!, id: incomeID));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   String convertDateFormat(String inputDate) {
//     DateTime date = DateTime.parse(inputDate);
//
//     DateFormat formatter = DateFormat('dd-MM-yyyy');
//     String formattedDate = formatter.format(date);
//
//     return formattedDate;
//   }
//
//   @override
//   void initState() {
//     progressBar = ProgressBar();
//     listIncomeApiFunction();
//     super.initState();
//   }
//
//   late DeleteIncomeModelClass deleteIncomeModelClass;
//
//   late DetailsIncomeModelClass detailsIncomeModelClass;
//
//   String roundFunction(String val) {
//     double convertedTodDouble = double.parse(val);
//     var number = convertedTodDouble.toStringAsFixed(2);
//
//     return number;
//   }
//
//   DateFormat dateFormat = DateFormat('dd-MM-yyyy');
//
//   @override
//   Widget build(BuildContext context) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<IncomeBloc, IncomeState>(
//           listener: (context, state) async {
//             if (state is DetailIncomeLoaded) {
//               hideProgressBar();
//               detailsIncomeModelClass = BlocProvider.of<IncomeBloc>(context).detailsIncomeModelClass;
//               final DateFormat formatter = DateFormat('DD/MM/YYYY');
//
//               DateTime dateTimeValue = DateTime.parse(detailsIncomeModelClass.data!.date.toString());
//
//               final result = await Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => CreateAndEditIncome(
//                         type: 'Edit',
//                         balance: "0.00",
//                         is_loan: false,
//                         is_zakath: detailsIncomeModelClass.data!.isZakath!,
//                         isInterest: detailsIncomeModelClass.data!.isInterest,
//                         date: detailsIncomeModelClass.data!.date.toString(),
//                         time: detailsIncomeModelClass.data!.time,
//                         organization: detailsIncomeModelClass.data!.organization,
//                         from_account: detailsIncomeModelClass.data!.fromAccount!.id,
//                         from_accountName: detailsIncomeModelClass.data!.fromAccount!.accountName,
//                         to_account: detailsIncomeModelClass.data!.toAccount!.id,
//                         to_accountName: detailsIncomeModelClass.data!.toAccount!.accountName,
//                         amount: roundStringWith(detailsIncomeModelClass.data!.amount!),
//                         description: detailsIncomeModelClass.data!.description,
//                         id: detailsIncomeModelClass.data!.id,
//                         fromAccountAmount: detailsIncomeModelClass.data!.fromAccount!.amount,
//                         finance_type: detailsIncomeModelClass.data!.financeType,
//                       )));
//
//               listIncomeApiFunction();
//             }
//             if (state is DetailIncomeError) {
//               hideProgressBar();
//             }
//           },
//         ),
//         BlocListener<IncomeBloc, IncomeState>(
//           listener: (context, state) {
//             if (state is DeleteIncomeLoading) {
//               const CircularProgressIndicator(
//                 color: Color(0xff5728C4),
//               );
//             }
//             if (state is DeleteIncomeLoaded) {
//               hideProgressBar();
//
//               listIncomeApiFunction();
//               deleteIncomeModelClass = BlocProvider.of<IncomeBloc>(context).deleteIncomeModelClass;
//               if (deleteIncomeModelClass.statusCode == 6001) {
//                 msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
//               }
//             }
//             if (state is DeleteIncomeError) {
//               hideProgressBar();
//             }
//           },
//         ),
//       ],
//       child: Scaffold(
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
//             'Income',
//             style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 22.0),
//           ),
//         ),
//         body: Container(
//           color: Colors.white,
//           padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
//           child: Column(
//             children: [
//               SearchFieldWidget(
//                 autoFocus: false,
//                 mHeight: mHeight,
//                 hintText: 'Search',
//                 controller: searchController,
//                 onChanged: (quary) async {
//                   SharedPreferences prefs = await SharedPreferences.getInstance();
//                   final organizationId = prefs.getString("organisation");
//                   if (quary.isNotEmpty) {
//                     BlocProvider.of<IncomeBloc>(context).add(ListIncomeEvent(organization: organizationId!, search: quary, financeType: 0));
//                   } else {
//                     BlocProvider.of<IncomeBloc>(context).add(ListIncomeEvent(organization: organizationId!, search: "", financeType: 0));
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: mHeight * .02,
//               ),
//               Expanded(
//                 child: BlocBuilder<IncomeBloc, IncomeState>(
//                   builder: (context, state) {
//                     if (state is IncomeListLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(
//                           color: Color(0xff5728C4),
//                         ),
//                       );
//                     }
//                     if (state is IncomeListLoaded) {
//                       listIncomeModelClass = BlocProvider.of<IncomeBloc>(context).listIncomeModelClass;
//                       return listIncomeModelClass.data!.isNotEmpty
//                           ? ListView.builder(
//                               physics: BouncingScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: listIncomeModelClass.data!.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 String time = listIncomeModelClass.data![index].date.toString();
//                                 DateTime dateTime = DateTime.parse(time);
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                       color: const Color(0xffFFFFFF),
//                                       borderRadius: BorderRadius.circular(1),
//                                       border: Border.all(color: Color(0xffDEDEDE), width: 1)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: ListTile(
//                                         tileColor: const Color(0xffFFFFFF),
//                                         title: Container(
//                                           width: mWidth * .02,
//                                            child: Text(
//                                               "${(convertDateFormat(listIncomeModelClass.data![index].date!))}, " +
//                                                   listIncomeModelClass.data![index].time!.split(":00").first,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: customisedStyle(context, Color(0xff8D8D8D), FontWeight.normal, 11.0)),
//                                         ),
//                                         subtitle: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Text("From:", style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.normal, 12.0)),
//                                                 Container(
//                                                   width: mWidth * .5,
//                                                   padding: EdgeInsets.only(left: mWidth * .02),
//                                                   child: Text(listIncomeModelClass.data![index].fromAccount!.accountName!,
//                                                       overflow: TextOverflow.ellipsis,
//                                                       style: customisedStyle(context, Colors.black, FontWeight.w500, 12.0)),
//                                                 )
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text("To:", style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.normal, 12.0)),
//                                                 Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(left: mWidth * .065),
//                                                       child: Container(
//                                                         width: mWidth * .3,
//                                                         child: Text(listIncomeModelClass.data![index].toAccount!.accountName!,
//                                                             overflow: TextOverflow.ellipsis,
//                                                             style: customisedStyle(context, Colors.black, FontWeight.w500, 12.0)),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                         alignment: AlignmentDirectional.centerEnd,
//                                                              width: mWidth * .2,
//                                                         child: Text(
//                                                           countryCurrencyCode + " " + roundStringWith(listIncomeModelClass.data![index].amount!),
//                                                           overflow: TextOverflow.ellipsis,
//                                                           style: customisedStyle(context, Colors.black, FontWeight.w600, 11.0),
//                                                         ))
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         trailing: PopupMenuButton<String>(
//                                           icon: SvgPicture.asset("assets/svg/options.svg"),
//                                           itemBuilder: (BuildContext context) {
//                                             return [
//                                               PopupMenuItem(
//                                                 value: 'edit',
//                                                 child: Text('Edit'),
//                                               ),
//                                               PopupMenuItem(
//                                                 value: 'delete',
//                                                 child: Text('Delete'),
//                                               ),
//                                             ];
//                                           },
//                                           onSelected: (String value) {
//                                             if (value == 'edit') {
//                                               incomeID = listIncomeModelClass.data![index].id!;
//                                               detailIncomeApiFunction();
//                                             } else if (value == 'delete') {
//                                               btmDialogueFunction(
//                                                   isDismissible: true,
//                                                   context: context,
//                                                   textMsg: 'Are you sure delete ?',
//                                                   fistBtnOnPressed: () {
//                                                     Navigator.of(context).pop(true);
//                                                   },
//                                                   secondBtnPressed: () async {
//                                                     incomeID = listIncomeModelClass.data![index].id!;
//                                                     deleteIncomeApiFunction();
//                                                     Navigator.of(context).pop(true);
//                                                   },
//                                                   secondBtnText: 'Yes');
//
//                                             }
//                                           },
//                                         )),
//                                   ),
//                                 );
//                               })
//                           : SizedBox(
//                               height: mHeight * .7,
//                               child: const Center(
//                                   child: Text(
//                                 "Items not found !",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               )));
//                     }
//                     if (state is IncomeListError) {
//                       return Center(
//                           child: Text(
//                         "Something went wrong",
//                         style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
//                       ));
//                     }
//                     return SizedBox();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           color: const Color(0xffF3F7FC),
//           height: MediaQuery.of(context).size.height / 16,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               const SizedBox(
//                 width: 8,
//               ),
//               Container(
//                 height: 33.0,
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(17.0), color: const Color(0xff2BAAFC)),
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     final result = await Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => CreateAndEditIncome(
//                               type: 'Create',
//                               amount: "0.00",
//                               from_accountName: "",
//                               from_account: "",
//                               is_loan: false,
//                               balance: "0.00",
//                             )));
//                     listIncomeApiFunction();
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Icon(
//                         Icons.add,
//                         color: Colors.white,
//                       ),
//                       const Text('Add'),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: mWidth * .01,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
