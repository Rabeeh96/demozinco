// import 'package:cuentaguestor/Api%20Helper/Bloc/Country/country_bloc.dart';
// import 'package:cuentaguestor/Utilities/global/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// import '../../../../Api Helper/ModelClasses/Settings/Country/DeleteCountryModelClass.dart';
// import '../../../../Api Helper/ModelClasses/Settings/Country/DetailCountryModelClass.dart';
// import '../../../../Api Helper/ModelClasses/Settings/Country/ListCountryModelClass.dart';
// import '../../../../Api Helper/ModelClasses/Settings/Country/SetAsDefaultCountryModelClass.dart';
// import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
// import '../../../../Utilities/Commen Functions/delete_permission function.dart';
// import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
// import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
// import '../../../../Utilities/CommenClass/search_commen_class.dart';
// import 'create_and_edit_country.dart';
//
// class CountryList extends StatefulWidget {
//   @override
//   State<CountryList> createState() => _CountryListState();
// }
//
// class _CountryListState extends State<CountryList> {
//   TextEditingController searchController = TextEditingController();
//   var photo = "";
//   late ListCountryModelClass listCountryModelClass;
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
//
//
//
//
//   @override
//   void initState() {
//     progressBar = ProgressBar();
//     listCountryApiFunction();
//
//     super.initState();
//   }
//
//   ValueNotifier<bool> isZakathanotifier = ValueNotifier(true);
//   late SetAsDefaultCountryModelClass setAsDefaultCountryModelClass;
//
//   String id = "";
//   late DetailCountryModelClass detailCountryModelClass;
//
//   late DeleteCountryModelClass deleteCountryModelClass;
//
//   listCountryApiFunction() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId = prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//       return BlocProvider.of<CountryBloc>(context).add(ListCountryEvent(organisation: organizationId!, search: ""));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   detailCountryApiFunction() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId = prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//       showProgressBar();
//       return BlocProvider.of<CountryBloc>(context).add(DetailCountryEvent(organisation: organizationId!, id: id));
//     }
//     else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   setAsDefaultCountryApiFunction(index) async {
//     var netWork = await checkNetwork();
//     if (netWork) {
//       if (!mounted) return;
//
//
//       showProgressBar();
//
//       return BlocProvider.of<CountryBloc>(context).add(SetAsDefaultCountryEvent(
//         countryName: listCountryModelClass.data![index].country!.countryName!,
//         id: listCountryModelClass.data![index].id!,
//         currencyCode:listCountryModelClass.data![index].country!.countryCode!,
//         currency:listCountryModelClass.data![index].country!.currencySimbol!,
//         isDefault: true,
//       ));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   deleteCountryApiFunction() async {
//     var netWork = await checkNetwork();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final organizationId = prefs.getString("organisation");
//     if (netWork) {
//       if (!mounted) return;
//       return BlocProvider.of<CountryBloc>(context).add(DeleteCountryEvent(organisation: organizationId!, id: id));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<CountryBloc, CountryState>(
//           listener: (context, state) async {
//             if (state is DetailCountryLoaded) {
//               hideProgressBar();
//               detailCountryModelClass = BlocProvider.of<CountryBloc>(context).detailCountryModelClass;
//               final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CreateAndEditCountry(
//                             type: 'Edit',
//                             id: id,
//                             countryName: detailCountryModelClass.data!.country!.countryName!,
//                             currencyName: detailCountryModelClass.data!.country!.currencyName!,
//                             organisationId: detailCountryModelClass.data!.organization!,
//                             countryId: detailCountryModelClass.data!.country!.id,
//                           )));
//               listCountryApiFunction();
//             }
//             if (state is DetailCountryError) {
//               hideProgressBar();
//             }
//           },
//         ),
//         BlocListener<CountryBloc, CountryState>(
//           listener: (context, state) {
//             if (state is DeleteCountryLoading) {
//               const CircularProgressIndicator(
//                 color: Color(0xff5728C4),
//               );
//             }
//             if (state is DeleteCountryLoaded) {
//               hideProgressBar();
//               listCountryApiFunction();
//               deleteCountryModelClass = BlocProvider.of<CountryBloc>(context).deleteCountryModelClass;
//               if (deleteCountryModelClass.statusCode == 6000) {
//                 msgBtmDialogueFunction(context: context, textMsg: deleteCountryModelClass.data!);
//               } else if (deleteCountryModelClass.statusCode == 6001) {
//                 msgBtmDialogueFunction(context: context, textMsg: deleteCountryModelClass.data!);
//               } else {
//                 msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
//               }
//             }
//             if (state is DeleteCountryError) {
//               hideProgressBar();
//             }
//           },
//         ),
//         BlocListener<CountryBloc, CountryState>(
//           listener: (context, state) {
//             if (state is SetAsDefaultCountryLoading) {
//               const CircularProgressIndicator(
//                 color: Color(0xff5728C4),
//               );
//             }
//             if (state is SetAsDefaultCountryLoaded) {
//               hideProgressBar();
//
//               listCountryApiFunction();
//               setAsDefaultCountryModelClass = BlocProvider.of<CountryBloc>(context).setAsDefaultCountryModelClass;
//               if (setAsDefaultCountryModelClass.statusCode == 6001) {
//                 msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
//               }
//             }
//             if (state is SetAsDefaultCountryError) {
//               hideProgressBar();
//             }
//           },
//         )
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
//             'Country',
//             style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 22.0),
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
//           child: Column(
//             children: [
//               ElevatedButton(onPressed: ()async{
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//
//
//               }, child: Text("a")),
//               SizedBox(height: mHeight * .02),
//               SearchFieldWidget(
//                 autoFocus: false,
//                 mHeight: mHeight,
//                 hintText: 'Search',
//                 controller: searchController,
//                 onChanged: (quary) async {
//                   SharedPreferences prefs = await SharedPreferences.getInstance();
//                   final organizationId = prefs.getString("organisation");
//
//                   if (quary.isNotEmpty) {
//                     BlocProvider.of<CountryBloc>(context).add(ListCountryEvent(organisation: organizationId!, search: quary));
//                   } else {
//                     BlocProvider.of<CountryBloc>(context).add(ListCountryEvent(organisation: organizationId!, search: ''));
//                   }
//                 },
//               ),
//               SizedBox(height: mHeight * .01),
//               Expanded(
//                 child: BlocBuilder<CountryBloc, CountryState>(
//                   builder: (context, state) {
//                     if (state is ListCountryLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(
//                           color: Color(0xff5728C4),
//                         ),
//                       );
//                     }
//                     if (state is ListCountryLoaded) {
//                       listCountryModelClass = BlocProvider.of<CountryBloc>(context).listCountryModelClass;
//
//                       return listCountryModelClass.data!.isNotEmpty
//                           ? ListView.builder(
//                               physics: BouncingScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: listCountryModelClass.data!.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Container(
//                                   height: mHeight * .08,
//                                   child: ListTile(
//                                       shape: RoundedRectangleBorder(
//                                           side: const BorderSide(color: Color(0xffDEDEDE), width: .5), borderRadius: BorderRadius.circular(1)),
//                                       tileColor: const Color(0xffFFFFFF),
//                                       title: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             child: Row(
//                                               children: [
//                                                 listCountryModelClass.data![index].isDefault == true
//                                                     ? Padding(
//                                                         padding: const EdgeInsets.only(right: 8.0),
//                                                         child: SvgPicture.asset("assets/svg/done.svg"),
//                                                       )
//                                                     : SizedBox(),
//                                                 Text(listCountryModelClass.data![index].country!.countryName!,
//                                                     style: customisedStyle(context, Colors.black, FontWeight.bold, 15.0)),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             child: Text(listCountryModelClass.data![index].country!.currencyName!,
//                                                 style: customisedStyle(context, Color(0xff9974EF), FontWeight.bold, 13.0)),
//                                           ),
//                                         ],
//                                       ),
//
//                                       trailing: PopupMenuButton<String>(
//                                         icon: SvgPicture.asset("assets/svg/options.svg"),
//                                         itemBuilder: (BuildContext context) {
//                                           return [
//                                             PopupMenuItem(
//                                               value: 'edit',
//                                               child: Text('Edit'),
//                                             ),
//                                             PopupMenuItem(
//                                               value: 'delete',
//                                               child: Text('Delete'),
//                                             ),
//                                             PopupMenuItem(
//                                               value: 'set as Default',
//                                               child: Text('Set as Default'),
//                                             ),
//                                           ];
//                                         },
//                                         onSelected: (String value) {
//                                           if (value == 'edit') {
//                                             id = listCountryModelClass.data![index].id!;
//                                             detailCountryApiFunction();
//                                           } else if (value == 'delete') {
//                                             btmDialogueFunction(
//                                                 isDismissible: true,
//                                                 context: context,
//                                                 textMsg: 'Are you sure delete ?',
//                                                 fistBtnOnPressed: () {
//                                                   Navigator.of(context).pop(true);
//                                                 },
//                                                 secondBtnPressed: () async {
//                                                   id = listCountryModelClass.data![index].id!;
//                                                   deleteCountryApiFunction();
//                                                   Navigator.of(context).pop(true);
//                                                 },
//                                                 secondBtnText: 'Yes');
//
//                                           } else {
//
//
//                                         setAsDefaultCountryApiFunction(index);
//                                           }
//                                         },
//                                       )),
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
//                     if (state is ListCountryError) {
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
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         floatingActionButton: GestureDetector(
//           child: SvgPicture.asset('assets/svg/add_circle.svg'),
//           onTap: () async {
//             final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAndEditCountry(type: 'Create')));
//             listCountryApiFunction();
//           },
//         ),
//       ),
//     );
//   }
// }
