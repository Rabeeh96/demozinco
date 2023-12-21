//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../Api Helper/Bloc/defaultContryList/default_country_list_bloc.dart';
// import '../../../../Api Helper/ModelClasses/Settings/Country/DefaultCountryModelClass.dart';
// import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
// import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
// import '../../../../Utilities/CommenClass/search_commen_class.dart';
// import '../../../../Utilities/global/text_style.dart';
//
//
//
//
//
//
// class DefaultCountryList extends StatefulWidget {
//
//   @override
//   State<DefaultCountryList> createState() => _DefaultCountryListState();
// }
//
// class _DefaultCountryListState extends State<DefaultCountryList> {
//
//
//   TextEditingController searchController = TextEditingController();
//   var photo = "";
//   listDefaultCountryFunction() async {
//
//     var netWork = await checkNetwork();
//     if (netWork) {
//       if (!mounted) return;
//
//       return
//         BlocProvider.of<DefaultCountryListBloc>(context).add(FetchDetailCountryEvent(search: ''));
//     } else {
//       if (!mounted) return;
//       msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
//     }
//
//   }
//   @override
//   void initState() {
//
//     listDefaultCountryFunction();
//
//     super.initState();
//   }
//
//   late DefaultCountryModelClass defaultCountryModelClass;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
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
//         title:  Text(
//           'Country List',
//           style:customisedStyle(
//               context, Color(0xff13213A), FontWeight.w600, 22.0),
//
//         ),
//
//       ),
//       body: Container(
//         padding:  EdgeInsets.only(left: mWidth*.04, right: mWidth*.04),
//         child: Column(
//           children: [
//             SearchFieldWidget(
//               autoFocus: false,
//               mHeight: mHeight,
//               hintText: 'Search',
//               controller: searchController,
//               onChanged: (quary) {
//
//                 if (quary.isNotEmpty) {
//                   BlocProvider.of<DefaultCountryListBloc>(context).add(FetchDetailCountryEvent(search: quary));
//
//                 } else {
//                   BlocProvider.of<DefaultCountryListBloc>(context).add(FetchDetailCountryEvent(search: ''));
//
//                 }
//
//                 }
//
//                 ),
//
//             SizedBox(
//               height: mHeight * .02,
//             ),
//
//                     Expanded(
//               child: BlocBuilder<DefaultCountryListBloc, DefaultCountryListState>(
//                 builder: (context, state) {
//                   if (state is CountryDefaultLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: Color(0xff5728C4),
//                       ),
//                     );
//                   }
//                   if (state is CountryDefaultLoaded) {
//                     defaultCountryModelClass  = BlocProvider.of<DefaultCountryListBloc>(context).defaultCountryModelClass;
//
//
//
//
//                     return  defaultCountryModelClass.data!.isNotEmpty ? ListView.builder(shrinkWrap: true,
//                         physics: const BouncingScrollPhysics(),
//
//                         itemCount: defaultCountryModelClass.data!.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return GestureDetector(
//                             onTap: (){
//                               Navigator.pop(context, [defaultCountryModelClass.data![index].countryName,
//                                 defaultCountryModelClass.data![index].currencyName, defaultCountryModelClass.data![index].id],);
//
//                             },
//                             child: ListTile(
//                               shape: RoundedRectangleBorder(
//                                   side: const BorderSide(color: Color(0xffDEDEDE), width: .5),
//                                   borderRadius: BorderRadius.circular(1)),
//                               tileColor: const Color(0xffFFFFFF),
//                               title: Text(defaultCountryModelClass.data![index].countryName!, style: customisedStyle(
//                                   context,
//                                   Colors.black,
//                                   FontWeight.w500,
//                                   15.0),),
//
//                             ),
//                           );
//                         }):SizedBox(
//                         height: mHeight * .7,
//                         child: const Center(
//                             child: Text(
//                               "Not found !",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold),
//                             )));
//                   }
//                    if (state is CountryDefaultError) {
//                     return Center(child: Text("Something went wrong"));
//                   }
//                   return SizedBox();
//                 },
//               ),
//             )
//
//
//
//
//
//           ],
//         ),
//       ),
//
//     );
//   }
//
//
//
//
//
// }
// class CustomUseroleListModelClass {
//   String id, userTypeName, organization;
//   int userTypeId;
//   CustomUseroleListModelClass(
//       {required this.id,
//         required this.userTypeName,
//         required this.organization,
//         required this.userTypeId });
//
//   factory CustomUseroleListModelClass.fromJson(Map<dynamic, dynamic> json) {
//     return CustomUseroleListModelClass(
//         id: json['id'],
//         userTypeName: json['user_type_name'],
//         organization: json['organization'],
//         userTypeId: json['user_type_id']);
//
//   }
// }