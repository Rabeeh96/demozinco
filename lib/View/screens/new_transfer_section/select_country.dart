import 'package:cuentaguestor_edit/Api%20Helper/Bloc/Country/country_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api Helper/Bloc/defaultContryList/default_country_list_bloc.dart';
import '../../../Api Helper/ModelClasses/Settings/Country/ListCountryModelClass.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';

class SelectCountryTransfer extends StatefulWidget {
  @override
  State<SelectCountryTransfer> createState() => _SelectCountryTransferState();
}

class _SelectCountryTransferState extends State<SelectCountryTransfer> {
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

  TextEditingController searchController = TextEditingController();
  var photo = "";

  listCountryApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<CountryBloc>(context).add(ListCountryEvent(organisation: organizationId!, search: ""));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }



  @override
  void initState() {
    progressBar = ProgressBar();

    listCountryApiFunction();

    super.initState();
  }

  late ListCountryModelClass listCountryModelClass;
  var countryName;
  var currencyName;
  var id;

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
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'Countries',
          style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 21.0),
        ),
        actions: [

        ],
      ),
      body: Container(
        color: Colors.white,

        height: mHeight,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
              ),
              height: mHeight * .07,
              width: mWidth,
              child: TextField(
                onChanged: (quary) {
                  if (quary.isNotEmpty) {
                    BlocProvider.of<DefaultCountryListBloc>(context).add(FetchDefaultCountryEvent(search: quary));
                  } else {
                    BlocProvider.of<DefaultCountryListBloc>(context).add(FetchDefaultCountryEvent(search: ''));
                  }
                },
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: mWidth * .07),
                    hintText: 'Search',
                    helperStyle: customisedStyle(context, Color(0xff929292), FontWeight.normal, 15.0),
                    border: InputBorder.none),
              ),
            ),
            Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
            SizedBox(
              height: mHeight * .03,
            ),
            Expanded(
              child: BlocBuilder<CountryBloc, CountryState>(
                builder: (context, state) {
                  if (state is ListCountryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff5728C4),
                      ),
                    );
                  }



                  if (state is ListCountryLoaded) {
                    listCountryModelClass = BlocProvider.of<CountryBloc>(context).listCountryModelClass;

                    return listCountryModelClass.data!.isNotEmpty
                        ? ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: listCountryModelClass.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            child: ListTile(
                              onTap: () async {
                                Navigator.pop(context,[listCountryModelClass.data![index].country!.countryName!,listCountryModelClass.data![index].id!,]);
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          listCountryModelClass.data![index].country!.countryName!,
                                          style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                                        ),
                                        listCountryModelClass.data![index].isDefault == true
                                            ? Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: SvgPicture.asset("assets/svg/done.svg"),
                                        )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),


                                  Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                                ],
                              ),
                            ),
                          );
                        })
                        : SizedBox(
                        height: mHeight * .7,
                        child: const Center(
                            child: Text(
                              "Not found !",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )));
                  }
                  if (state is DefaultCountryError) {
                    return Center(child: Text("Something went wrong"));
                  }
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomUseroleListModelClass {
  String id, userTypeName, organization;
  int userTypeId;

  CustomUseroleListModelClass({required this.id, required this.userTypeName, required this.organization, required this.userTypeId});

  factory CustomUseroleListModelClass.fromJson(Map<dynamic, dynamic> json) {
    return CustomUseroleListModelClass(
        id: json['id'], userTypeName: json['user_type_name'], organization: json['organization'], userTypeId: json['user_type_id']);
  }
}
