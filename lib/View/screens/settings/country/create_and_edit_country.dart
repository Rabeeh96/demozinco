// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../Api Helper/Bloc/Country/country_bloc.dart';
// import '../../../../Api Helper/ModelClasses/Settings/Country/CreateCountryModelClass.dart';
// import '../../../../Api Helper/ModelClasses/Settings/Country/DetailCountryModelClass.dart';
// import '../../../../Api Helper/ModelClasses/Settings/Country/EditCountryModelClass.dart';
// import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
// import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
// import '../../../../Utilities/CommenClass/commen_txtfield_widget.dart';
// import '../../../../Utilities/global/text_style.dart';
// import 'default_countrylist.dart';
//
//
// class CreateAndEditCountry extends StatefulWidget {
//
//    CreateAndEditCountry({super.key, required this.type,  this.id,this.currencyName,this.countryName,this.countryId,this.organisationId});
//    final String type;
//    String? id;
//    String? countryName;
//    String? currencyName;
//    String? organisationId;
//    String? countryId;
//
//    @override
//   State<CreateAndEditCountry> createState() => _CreateAndEditCountryState();
// }
//
// class _CreateAndEditCountryState extends State<CreateAndEditCountry> {
//   TextEditingController countryController = TextEditingController();
//   TextEditingController currencyController = TextEditingController();
//
//   DateTime selectedDateAndTime = DateTime.now();
//    String organisationIdEdit = "";
//    String countryIdEdit = "";
//    String idEdit = "";
//
//   @override
//   void initState() {
//     countryController = TextEditingController( )..text = widget.type == "Edit"?widget.countryName!:""  ;
//     currencyController = TextEditingController() ..text =  widget.type == "Edit"?widget.currencyName!:""  ;
//     organisationIdEdit = widget.type == "Edit"? widget.organisationId.toString() :"";
//     countryIdEdit = widget.type == "Edit"? widget.countryId.toString() :"";
//     idEdit = widget.type == "Edit"?widget.id.toString() :"";
//   }
//   String countryId = "";
//   late DetailCountryModelClass detailCountryModelClass ;
//   late  CreateCountryModelClass createCountryModelClass;
//   late EditCountryModelClass editCountryModelClass;
//   @override
//   Widget build(BuildContext context) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//     final space = SizedBox(
//       height:mHeight*.02
//     );
//     final formKey = GlobalKey<FormState>();
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<CountryBloc, CountryState>(
//           listener: (context, state) {
//             if (state is CreateCountryLoaded) {
//               createCountryModelClass = BlocProvider
//                   .of<CountryBloc>(context)
//                   .createCountryModelClass;
//               if (createCountryModelClass.statusCode == 6000) {
//                 Navigator.pop(context);
//                 msgBtmDialogueFunction(
//                   context: context,
//                   textMsg: createCountryModelClass.data.toString(),);
//               }
//               if (createCountryModelClass.statusCode == 6001) {
//                 alreadyCreateBtmDialogueFunction(context: context,
//                     textMsg: createCountryModelClass.errors.toString(),
//                     buttonOnPressed: () {
//                       Navigator.of(context)
//                           .pop(false);
//                     });}
//             }}),
//
//         BlocListener<CountryBloc, CountryState>(
//           listener: (context, state) {
//             if (state is EditCountryLoading) {
//               const CircularProgressIndicator();
//             }
//             if (state is EditCountryLoaded) {
//               editCountryModelClass = BlocProvider
//                   .of<CountryBloc>(context)
//                   .editCountryModelClass;
//               if (editCountryModelClass.statusCode == 6000) {
//                 Navigator.pop(context);
//                 msgBtmDialogueFunction(
//                   context: context,
//                   textMsg: editCountryModelClass.data.toString(),);
//               }
//               if (editCountryModelClass.statusCode == 6001) {
//                 alreadyCreateBtmDialogueFunction(context: context,
//                     textMsg: "Something went wrong",
//                     buttonOnPressed: () {
//                       Navigator.of(context)
//                           .pop(false);
//                     });
//               }
//             }
//             if (state is EditCountryError) {
//               const Text("Something went wrong");
//             }
//           }
//
//         ),
//
//       ],
//   child: Scaffold(
//     backgroundColor: Colors.white,
//       appBar: AppBar(
//         toolbarHeight: MediaQuery.of(context).size.height / 11,
//
//         backgroundColor: const Color(0xffffffff),
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Color(0xff2BAAFC),
//           ),
//         ),
//         title: Text(
//      widget.type == "Create"?     "Add Country": "Edit Country",
//           style: customisedStyle(
//               context, Color(0xff13213A), FontWeight.w600, 22.0),),
//       ),
//       body: Padding(
//         padding:  EdgeInsets.only(left: mWidth*.06, right: mWidth*.06),
//
//       child : Form(
//         key: formKey,
//         child: ListView(
//           physics: BouncingScrollPhysics(),
//           children: [
//             TextButton(onPressed: (){
//               Notes(context);
//             }, child: Text("tap")),
//             space,
//             CommenTextFieldWidget(controller: countryController,
//               validator: (val) {
//                 if (val == null || val.isEmpty || val
//                     .trim()
//                     .isEmpty) {
//                   return 'This field is required';
//                 }
//                 return null;
//               },
//               hintText: "Country Name",
//               readOnly: true,
//               textAlign: TextAlign.start,
//               onTap: () async {
//                 var result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => DefaultCountryList()),
//                 );
//
//                 result != null
//                     ? countryController.text = result[0]
//                     : Null;
//                 result != null
//                     ? currencyController.text = result[1]
//                     : Null;
//                 result != null
//                     ? countryId = result[2]
//                     : Null;
//
//               },
//               suffixIcon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black,
//               ),
//               textInputAction: TextInputAction.next,
//               textCapitalization: TextCapitalization.none,
//               textInputType: TextInputType.text,
//               obscureText: false,
//             ),
//             space,
//             CommenTextFieldWidget(controller: currencyController,
//               validator: (val) {
//                 if (val == null || val.isEmpty || val
//                     .trim()
//                     .isEmpty) {
//                   return 'This field is required';
//                 }
//                 return null;
//               },
//               hintText: "Currency",
//               readOnly: true,
//               textAlign: TextAlign.start,
//
//               textInputAction: TextInputAction.next,
//               textCapitalization: TextCapitalization.none,
//               textInputType: TextInputType.text,
//               obscureText: false,
//             ),
//             space,
//           ],
//         ),
//       )
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       floatingActionButton: GestureDetector(
//         child: SvgPicture.asset('assets/svg/save.svg'),
//         onTap: () async{
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           final organizationId =   prefs.getString("organisation");
//           print("_______________________________${formKey.currentState!.validate()}");
//           if(formKey.currentState!.validate() && widget.type == "Create"){
//             createCountryApiFunction();
//
//           }
//     if( formKey.currentState!.validate() && widget.type == "Edit"){
//       editCountryApiFunction();
//     }
//     },
//       ),
//     ),
// );
//   }
//
//   Notes(context) {
//     TextEditingController notesController = TextEditingController();
//     final formKey = GlobalKey<FormState>();
//
//
//     final mWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//     showModalBottomSheet<void>(
//       isScrollControlled: true,
//       context: context,
//       shape:
//
//       const RoundedRectangleBorder(
//         borderRadius:
//         BorderRadius.vertical(
//           top: Radius.circular(10.0),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return  Container(
//             color: Colors.white,
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery
//                     .of(context)
//                     .viewInsets
//                     .bottom),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//
//
//
//                   Container(
//                     margin: EdgeInsets.all(17),
//                     height: MediaQuery.of(context).size.height*.2,
//                   color:  Color(0xffF3F7FC),
//                     child: TextFormField(
//
//
//                         style: customisedStyle(context,  Color(0xff13213A), FontWeight.normal, 14.0),
//                         maxLines: null,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Enter Value  ';
//                           }
//                           return null;
//                         },
//                         controller: notesController,
//                         textAlign: TextAlign.start,
//                         readOnly: false,
//                         textInputAction: TextInputAction.newline,
//                         textCapitalization: TextCapitalization.words,
//                         obscureText: false,
//
//                         decoration:  InputDecoration(
//                           fillColor: Color(0xffF3F7FC),
//                           filled: true,
//                           hintStyle:customisedStyle(context, Color(0xff778EB8), FontWeight.normal,15.0) ,
//                           contentPadding: EdgeInsets.all(7),
//                           hintText: "Add a note here..",
//                           border: InputBorder.none,
//
//                         )),
//                   ),
//
//                   Divider(
//                     color:
//                     Color(0xffE2E2E2),
//                     thickness: 1,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(16.0),
//
//
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: CircleAvatar(
//                             backgroundColor:
//                             Color(
//                                 0xffE31919),
//                             radius: 20.0,
//                             child:
//                             CircleAvatar(
//                               backgroundColor:
//                               Colors
//                                   .white,
//                               child: Icon(
//                                   Icons.close,
//                                   color: Color(
//                                       0xffE31919)),
//                               radius: 18.0,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           'Note',
//                           style:
//                           customisedStyle(
//                               context,
//                               Colors
//                                   .black,
//                               FontWeight
//                                   .w500,
//                               16.0),
//                         ),
//                         GestureDetector(
//                           onTap: () async {
//                             Navigator.pop(context);
//                           },
//
//                           child: CircleAvatar(
//                             backgroundColor:
//                             Color(
//                                 0xff087A04),
//                             radius: 20.0,
//                             child:
//                             CircleAvatar(
//                               backgroundColor:
//                               Colors
//                                   .white,
//                               child: Icon(
//                                   Icons.done,
//                                   color: Color(
//                                       0xff087A04)),
//                               radius: 18.0,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//
//                 ],
//               ),
//             )
//         );
//
//       },
//     );
//
//   }
//
//
//   createCountryApiFunction() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId =   prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//
//       return  BlocProvider.of<CountryBloc>(context).add(CreateCountryEvent(organisation: organizationId!, country: countryId));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
//     }
//
//   }
//   editCountryApiFunction() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId =   prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//
//       return  BlocProvider.of<CountryBloc>(context).add(EditCountryEvent(organisation: organisationIdEdit, country: countryIdEdit, id: idEdit));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
//     }
//
//   }
//
// }
