
import 'package:cuentaguestor_edit/Api%20Helper/Bloc/Country/country_bloc.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/DeleteCountryModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/DetailCountryModelClass.dart';
import 'package:cuentaguestor_edit/Utilities/CommenClass/search_commen_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/ModelClasses/Settings/Country/ListCountryModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';




class OnlyCountryList extends StatefulWidget {

  @override
  State<OnlyCountryList> createState() => _OnlyCountryListState();
}

class _OnlyCountryListState extends State<OnlyCountryList> {
  TextEditingController searchController = TextEditingController();
  var photo = "";
  late  ListCountryModelClass listCountryModelClass ;

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
    listCountryApiFunction();

    super.initState();
  }

  String id = "";
  late DetailCountryModelClass detailCountryModelClass ;
  late  DeleteCountryModelClass deleteCountryModelClass;
  listCountryApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;

      return BlocProvider.of<CountryBloc>(context).add(ListCountryEvent(organisation:organizationId!, search: "" ));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }





  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery
        .of(context)
        .size
        .height;
    final mWidth = MediaQuery.of(context).size.width;


    return Scaffold(
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
        title: Text(
          'Country',
          style:customisedStyle(
              context, Color(0xff13213A), FontWeight.w600, 22.0),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
        child: Column(
          children: [

            SizedBox(height: mHeight * .02),
            SearchFieldWidget(
              autoFocus: false,
              mHeight: mHeight,
              hintText: 'Search',
              controller: searchController,
              onChanged: (quary) async { SharedPreferences prefs = await SharedPreferences.getInstance();
              final organizationId =   prefs.getString("organisation");

              if (quary.isNotEmpty) {
                BlocProvider.of<CountryBloc>(context).add(ListCountryEvent(organisation:organizationId!, search:quary ));

              } else {
                BlocProvider.of<CountryBloc>(context).add(ListCountryEvent(organisation:organizationId!, search: '' ));

              }
              },),
            SizedBox(height: mHeight * .01),
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
                    listCountryModelClass  = BlocProvider.of<CountryBloc>(context).listCountryModelClass;

                    return listCountryModelClass.data!.isNotEmpty ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listCountryModelClass.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context, [listCountryModelClass.data![index].country!.countryName!,
                                listCountryModelClass.data![index].country!.currencyName!, listCountryModelClass.data![index].id],);

                            },
                            child: Container(

                              height: mHeight*.1,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color(0xffDEDEDE), width: .5),
                                    borderRadius: BorderRadius.circular(1)),
                                tileColor: const Color(0xffFFFFFF),
                                title: Text(listCountryModelClass.data![index].country!.countryName!, style: customisedStyle(
                                    context,
                                    Colors.black,
                                    FontWeight.bold,
                                    15.0)),
                                subtitle: Text(listCountryModelClass.data![index].country!.countryCode!, style:
                                customisedStyle(
                                    context,
                                    Color(0xff9974EF),
                                    FontWeight.bold,
                                    13.0)
                                ),

                              ),
                            ),
                          );
                        }):SizedBox(
                        height: mHeight * .7,
                        child: const Center(
                            child: Text(
                              "Items not found !",
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            )));


                  }
                  if(state is ListCountryError){
                    return Center(child:
                    Text("Something went wrong",style: customisedStyle(
                        context, Colors.black, FontWeight.w500, 13.0),));
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
