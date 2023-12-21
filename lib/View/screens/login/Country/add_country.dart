

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Country/country_bloc.dart';
import '../../../../Api Helper/Bloc/defaultContryList/default_country_list_bloc.dart';
import '../../../../Api Helper/ModelClasses/Settings/Country/CreateCountryModelClass.dart';
import '../../../../Api Helper/ModelClasses/Settings/Country/DefaultCountryModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';




class AddCountry extends StatefulWidget {

  @override
  State<AddCountry> createState() => _AddCountryState();
}

class _AddCountryState extends State<AddCountry> {
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
  late  CreateCountryModelClass createCountryModelClass;



  TextEditingController searchController = TextEditingController();
  var photo = "";
  listDefaultCountryFunction() async {

    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;

      return
        BlocProvider.of<DefaultCountryListBloc>(context).add(FetchDefaultCountryEvent(search: ''));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }
  @override
  void initState() {
    progressBar = ProgressBar();


    listDefaultCountryFunction();

    super.initState();
  }

  late DefaultCountryModelClass defaultCountryModelClass;



  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<CountryBloc, CountryState>(
            listener: (context, state) {
              if (state is CreateCountryLoaded) {
                  hideProgressBar();
                createCountryModelClass = BlocProvider
                    .of<CountryBloc>(context)
                    .createCountryModelClass;
                if (createCountryModelClass.statusCode == 6000) {
                  Navigator.pop(context);
                  msgBtmDialogueFunction(
                    context: context,
                    textMsg: createCountryModelClass.data.toString(),);

                }
                if (createCountryModelClass.statusCode == 6001) {
                  alreadyCreateBtmDialogueFunction(context: context,
                      textMsg: createCountryModelClass.errors.toString(),
                      buttonOnPressed: () {
                        Navigator.of(context)
                            .pop(false);
                      });}
              }
              if (state is CreateCountryError){
                hideProgressBar();

              }
            }),
      ],
      child: Scaffold(
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
          title:  Text(
            'Add Countries',
            style:customisedStyle(
                context, Color(0xff13213A), FontWeight.w500, 21.0),

          ),

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
                height: mHeight * .06,
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
                      helperStyle:
                      customisedStyle(context, Color(0xff929292),
                          FontWeight.normal, 15.0),

                      border: InputBorder.none
                  ),
                ),
              ),

              SizedBox(height: mHeight*.03,),

              Expanded(
                child: BlocBuilder<DefaultCountryListBloc, DefaultCountryListState>(
                  builder: (context, state) {
                    if (state is DefaultCountryLoading) {

                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff5728C4),
                        ),
                      );
                    }
                    if (state is DefaultCountryLoaded) {
                      hideProgressBar();
                      defaultCountryModelClass  = BlocProvider.of<DefaultCountryListBloc>(context).defaultCountryModelClass;

                      return  defaultCountryModelClass.data!.isNotEmpty ? ListView.builder(shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),

                          itemCount: defaultCountryModelClass.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: ()async{
                                var netWork = await checkNetwork();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                final organizationId =   prefs.getString("organisation");
                                if (netWork) {
                                  if (!mounted) return;
                                  return  BlocProvider.of<CountryBloc>(context).add(CreateCountryEvent(organisation: organizationId!, country: defaultCountryModelClass.data![index].id!));
                                } else {
                                  if (!mounted) return;
                                  msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
                                }

                              },
                              child:  Container(
                                  height: mHeight*.08,
                                  width: mWidth,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(bottom: mHeight*.02,left: mHeight*.037),
                                        child: Text(
                                          defaultCountryModelClass.data![index].countryName!,
                                          style: customisedStyle(
                                              context,
                                              Colors.black,
                                              FontWeight.w500,
                                              16.0),
                                        ),
                                      ),
                                      Container(
                                          height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                                    ],
                                  )
                              ),
                            );
                          }):SizedBox(
                          height: mHeight * .7,
                          child: const Center(
                              child: Text(
                                "Not found !",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
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

      ),
    );
  }





}
class CustomUseroleListModelClass {
  String id, userTypeName, organization;
  int userTypeId;
  CustomUseroleListModelClass(
      {required this.id,
        required this.userTypeName,
        required this.organization,
        required this.userTypeId });

  factory CustomUseroleListModelClass.fromJson(Map<dynamic, dynamic> json) {
    return CustomUseroleListModelClass(
        id: json['id'],
        userTypeName: json['user_type_name'],
        organization: json['organization'],
        userTypeId: json['user_type_id']);

  }
}