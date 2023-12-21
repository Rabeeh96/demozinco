// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../Api Helper/Bloc/Account/account_bloc.dart';
// import '../../../Api Helper/ModelClasses/Settings/Account/DeleteAccountModelClass.dart';
// import '../../../Api Helper/ModelClasses/Settings/Account/DetailAccountModelClass.dart';
// import '../../../Api Helper/ModelClasses/Settings/Account/ListAccountModelClass.dart';
// import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
// import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
// import '../../../Utilities/Commen Functions/roundoff_function.dart';
// import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
// import '../../../Utilities/CommenClass/search_commen_class.dart';
// import '../../../Utilities/global/custom_class.dart';
// import '../../../Utilities/global/text_style.dart';
// import '../settings/account/add_account.dart';
// import '../settings/account/countrylist.dart';
//
//
//
// class AccountList extends StatefulWidget {
//
//
//   List type;
//
//   AccountList(
//       {super.key,
//         required this.type,
//        });
//
//
//   @override
//   State<AccountList> createState() => _AccountListState();
// }
//
// class _AccountListState extends State<AccountList> {
//
//   TextEditingController searchController = TextEditingController();
//   TextEditingController fromDateController = TextEditingController();
//   TextEditingController toDateController = TextEditingController();
//   late ListAccountModelClass listAccountModelClass ;
//   String countryID = "";
//   TextEditingController countryController = TextEditingController();
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
//
//     super.dispose();
//   }
//   @override
//   void initState() {
//     progressBar = ProgressBar();
//     super.initState();
//     listAccountApiFunction();
//   }
//   late int demoValue ;
//
//   listAccountApiFunction() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId =   prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//       return BlocProvider.of<AccountBloc>(context).add(ListAccountEvent(organisation:organizationId!,
//           page_number: 1, page_size: 50, search: '', country: '', type: widget.type));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
//     }
//   }
//   ValueNotifier valueNotifier = ValueNotifier(2);
//   late String id ="";
//   DateFormat dateFormat = DateFormat("dd/MM/yyy");
//
//
//
//
//
//
//   late DeleteAccountModelClass deleteAccountModelClass;
//   late DetailAccountModelClass detailAccountModelClass ;
//   ValueNotifier<DateTime>    dateNotifier = ValueNotifier(DateTime.now());
//
//   final DateFormat formatter = DateFormat('dd-MM-yyyy');
//
//   String convertDateFormat(String inputDate) {
//     DateTime date = DateTime.parse(inputDate);
//     DateFormat formatter = DateFormat('dd-MM-yyyy');
//     String formattedDate = formatter.format(date);
//     return formattedDate;
//   }
//
//
//   String getNameFromValue(type, String value) {
//
//     var list = [
//       {"value": "0", "name": "Contact"},
//       {"value": "1", "name": "Cash"},
//       {"value": "2", "name": "Bank"},
//       {"value": "3", "name": "Income"},
//       {"value": "4", "name": "Expense"},
//       {"value": "5", "name": "Suspense"},
//       {"value": "6", "name": "Asset"},
//       {"value": "7", "name": "Loan give"},
//       {"value": "8", "name": "Loan take"},
//
//     ];
//     if (type == 1) {
//       for (var item in list) {
//         if (item["value"] == value) {
//           return item["name"]!;
//         }
//       }
//     } else {
//       for (var item in list) {
//         if (item["name"] == value) {
//           return item["value"]!;
//         }
//       }
//     }
//
//     return "";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         toolbarHeight: MediaQuery.of(context).size.height / 11,
//
//         backgroundColor: const Color(0xffffffff),
//         elevation: 0,
//         titleSpacing: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Color(0xff2BAAFC),
//           ),
//         ),
//         title: Text('Accounts',
//             style: customisedStyle(
//                 context, Color(0xff13213A), FontWeight.w600, 22.0),
//         ),
//
//       ),
//       body: Container(
//
//         padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
//         height: mHeight,
//         child: Column(
//           children: [
//             SizedBox(height: mHeight * .02),
//             SearchFieldWidget(
//               autoFocus: false,
//               mHeight: mHeight,
//
//               hintText: 'Search',
//               controller: searchController,
//               onChanged: (quary) async{
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//               final organizationId =   prefs.getString("organisation");
//
//               if (quary.isNotEmpty) {
//                 BlocProvider.of<AccountBloc>(context).add(ListAccountEvent(organisation:organizationId!,
//                     page_number: 1, page_size: 30, search: quary, country: '', type:widget.type));
//
//               } else {
//                 BlocProvider.of<AccountBloc>(context).add(ListAccountEvent(organisation:organizationId!,
//                     page_number: 1, page_size: 30, search: '', country: '', type: widget.type));
//
//               }
//
//               },
//             ),
//
//             SizedBox(height: mHeight * .02),
//             Container(
//
//               child: BlocBuilder<AccountBloc, AccountState>(
//                 builder: (context, state) {
//                   if (state is ListAccountLoading) {
//                     return CircularProgressIndicator(
//                       color: Color(0xff5728C4),
//                     );
//                   }
//                   if (state is ListAccountLoaded) {
//                listAccountModelClass  = BlocProvider.of<AccountBloc>(context).listAccountModelClass;
//               return listAccountModelClass.data!.isNotEmpty
//                         ?
//
//               Expanded(
//                 child: ListView(
//                   shrinkWrap: true,
//                   physics: const BouncingScrollPhysics(),
//                   children: [
//                     listAccountModelClass.data!.isNotEmpty
//                         ? ListView.builder(
//                         padding: const EdgeInsets.only(
//                             bottom: kFloatingActionButtonMargin + 80),
//                         shrinkWrap: true,
//                         physics: BouncingScrollPhysics(),
//                         itemCount: listAccountModelClass.data!.length,
//                         itemBuilder: (BuildContext context, int index) {
//          return Container(
//                               child: ListTile(
//                                 onTap: (){
//                                   Navigator.pop(context,[
//                                     listAccountModelClass.data![index].id,
//                                     listAccountModelClass.data![index].accountName!,
//                                     double.parse('1223'),
//                                   ]);
//                                 },
//                                 shape: RoundedRectangleBorder(
//                                     side: const BorderSide(color: Color(0xffDEDEDE), width: 1), borderRadius: BorderRadius.circular(1)),
//                                 tileColor: const Color(0xffFFFFFF),
//                                 title: Container(
//                                   width: mWidth * .02,
//
//                                   margin: EdgeInsets.only(top: mHeight * .01),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//
//                                     ],
//                                   ),
//                                 ),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//
//
//                                           width: mWidth * .3,
//                                           child: Text(listAccountModelClass.data![index].accountName!,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0)),
//                                         ),
//
//                                       ],
//                                     ),
//                                     Container(
//                                       height: 5,
//                                     ),
//
//
//                                     listAccountModelClass.data![index].amount!.isNotEmpty? Container(
//                                       width: mWidth * .8,
//                                       child: Text(
//                                           listAccountModelClass.data![index].country!.currency_simbol! + " " + roundStringWith(listAccountModelClass.data![index].amount!),
//                                           style: customisedStyle(context, Colors.black, FontWeight.w500, 12.0)),
//                                     ):SizedBox(),
//
//
//                                     Row(
//                                       children: [
//                                         Text("As if on  ",
//                                             style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.normal, 13.0)),
//                                         Text(
//                                             listAccountModelClass.data![index].asOnDate!.isNotEmpty
//                                                 ? convertDateFormat(listAccountModelClass.data![index].asOnDate!)
//                                                 : "",
//                                             style: customisedStyle(context, Colors.black, FontWeight.normal, 12.0)),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               )
//                           );
//                         })
//                         : SizedBox(
//                         height: mHeight * .7,
//                         child: const Center(
//                             child: Text(
//                               "Items not found !",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )))
//                   ],
//                 ),
//               )
//
//                   :
//                   SizedBox(
//                         height: mHeight * .7,
//                         child: const Center(
//                             child: Text(
//                               "Items not found !",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold),
//                             )));
//                   }
//                   if(state is ListAccountError){
//                     return Center(child:
//                     Text("Something went wrong",style: customisedStyle(
//                         context, Colors.black, FontWeight.w500, 13.0),));
//                   }
//                   return const Center(
//                     child: SizedBox(),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       floatingActionButton: GestureDetector(
//         child: SvgPicture.asset('assets/svg/add_circle.svg'),
//         onTap: () async {
//           final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  CreateAndEditAccountScreen(type: 'Create',)));
//           listAccountApiFunction();
//         },
//       ),
//     );
//   }
//   filterBottomsheet({required BuildContext context}) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//     var items = [
//       'Contact',
//       'Cash',
//       'Bank',
//       'Income',
//       'Expense'];
//
//     String dropdownValue = "Contact";
//     return           showModalBottomSheet(
//       context: context,
//
//
//       enableDrag: false,
//       builder: (BuildContext context) {
//         return Container(
//           padding:
//           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child:Container(
//                 width: MediaQuery.of(context).size.width*.7,
//                 height: MediaQuery.of(context).size.height*.3,
//                 child:          Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                         height: mHeight*.01
//                     ),
//                     Container(
//                       height: mHeight*.05,
//                       child: Row(
//                         children: [
//                           SvgPicture.asset("assets/svg/filter.svg"),
//
//
//                           SizedBox(
//                               width: mWidth*.04
//                           ),
//
//                           Text("Filter",style: customisedStyle(
//                               context, Color(0xff13213A), FontWeight.w700, 16.0),),],
//                       ),
//
//                     ),
//                     SizedBox(
//                         height: mHeight*.02
//                     ),
//                     SizedBox(
//                         width: MediaQuery.of(context).size.width / 1.1,
//                         child: FormField<String>(
//                           builder: (FormFieldState<String> state) {
//                             return InputDecorator(
//                               decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Account Type"),
//                               isEmpty: dropdownValue == '',
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton<String>(
//                                   value: dropdownValue,
//                                   isDense: true,
//                                   onChanged: (String? newValue) {
//                                     setState(() {
//
//                                       dropdownValue = newValue!;
//
//                                     });
//                                   },
//                                   style: customisedStyle(
//                                       context,
//                                       Color(0xff778EB8),
//                                       FontWeight.bold,
//                                       13.0),
//                                   items: items.map((String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                     ),
//                     SizedBox(
//                       height: mHeight*.01,
//
//                     ),
//                     SizedBox(
//                         width: MediaQuery.of(context).size.width / 1.1,
//                         child: TextFormField(
//                             readOnly: true,
//                             style: customisedStyle(
//                                 context,
//                                 Colors.black,
//                                 FontWeight.bold,
//                                 13.0),
//
//
//                             validator: (value) {
//                               if (value == null || value.isEmpty || value.trim().isEmpty) {
//                                 return 'This field is required';
//                               }
//                               return null;
//                             },
//                             onTap: () async {
//                               var result = await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => OnlyCountryList()),
//                               );
//
//                               result != null
//                                   ? countryController.text = result[0]
//                                   : Null;
//
//                               result != null
//                                   ? countryID = result[2]
//                                   : Null;
//
//                             },
//                             controller: countryController,
//                             decoration: TextFieldDecoration.defaultStyleWithIcon(context,hintTextStr: "Country"))),
//                     Container(
//                         alignment: AlignmentDirectional.bottomEnd,
//                         height: mHeight*.05,
//                         child: TextButton(
//                           onPressed: () {
//                             if (dropdownValue == "Contact") {
//                               demoValue = 0 ;
//                             } else if (dropdownValue == "Cash") {
//                               demoValue = 1;
//                             }
//                             else if (dropdownValue == "Bank") {
//                               demoValue = 2;
//                             }
//                             else if (dropdownValue == "Income") {
//                               demoValue = 3;
//                             } else{
//                               demoValue = 4;
//                             }
//                             Navigator.pop(context,[
//                               demoValue,
//                               countryController.text
//                             ]);
//                           },
//                           child: Text("Submit",style :customisedStyle(
//                               context, Color(0xff13213A), FontWeight.w700, 14.0)),
//                         )
//
//                     ),
//                   ],
//                 ),
//               )
//           ),
//         );
//       },
//     );
//   }
// }
