import 'package:cuentaguestor_edit/View/screens/portfolio/view/new_design/portfolio_detail_screen.dart';
import 'package:cuentaguestor_edit/View/screens/portfolio/view/new_design/search_portfolio_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Api Helper/Bloc/asset new design bloc/asset_bloc.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/asset_event.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/asset_state.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/ListAssetModelClass.dart';
import '../../../../../Api Helper/Repository/api_client.dart';
import '../../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../../Utilities/global/text_style.dart';
import '../../../../../Utilities/global/variables.dart';
import 'create portfolio.dart';


class PortfolioList extends StatefulWidget {
  const PortfolioList({Key? key}) : super(key: key);

  @override
  State<PortfolioList> createState() => _PortfolioListState();
}

class _PortfolioListState extends State<PortfolioList> {
  late ProgressBar progressBar;

  void showProgressBar() {
    progressBar.show(context);
  }

  @override
  void initState() {
    super.initState();
    progressBar = ProgressBar();
    listAssetIncomeApiFunction();
  }

  void hideProgressBar() {
    progressBar.hide();
  }

  @override
  void dispose() {
    progressBar.hide();

    super.dispose();
  }

  listAssetIncomeApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");
      return BlocProvider.of<AssetBloc>(context).add(ListAssetEvent(organization: organizationId!, search: '', pageNumber: 1, page_size: 40));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  String incomeID = "";
  late ListAssetModelClass listAssetModelClass;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .02,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 11,

        backgroundColor: const Color(0xffffffff),
        elevation: 1,
       automaticallyImplyLeading: true,

        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              '  Portfolio',
              style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 21.0),
            ),
            Row(
              children: [
                Container(
                    alignment: Alignment.center,
                    height: mHeight * .05,
                    width: mWidth * .3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF3F7FC)),
                    child: Text(
                      default_country_name + "-" + countryShortCode,
                      style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),
                    )),
                IconButton(
                    onPressed: () async {
                      final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPortfolioList()));
                      listAssetIncomeApiFunction();

                    },
                    icon: SvgPicture.asset("assets/svg/search-normal (1).svg",color: Color(0xff0073D8),))
              ],
            )
          ],
        ),
      ),
      body: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          if (state is AssetListLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff5728C4),
              ),
            );
          }

          if (state is AssetListLoaded) {
            listAssetModelClass = BlocProvider.of<AssetBloc>(context).listAssetModelClass;

            return Container(
                height: mHeight,
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [

                     space,
                    Container(
                      margin: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                      height: mHeight * .1,
                      width: mWidth,
                      decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                listAssetModelClass.summary!.count!,
                                style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 30.0),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: mHeight * .01),
                                child: Text(
                                  "Assets",
                                  style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Approx. value",
                                style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),
                              ),
                              Text(
                                countryCurrencyCode + ".${roundStringWith(listAssetModelClass.summary!.totalValue!)}",
                                style: customisedStyle(context, Colors.black, FontWeight.w500, 17.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listAssetModelClass.data!.length + 1,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 130,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (listAssetModelClass.data!.isEmpty || listAssetModelClass.data!.length == index) {


                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: mWidth * .2,
                                      height: mHeight * .03,
                                      child: Text(
                                        "",
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 11.0),
                                      )),


                                  Container(

                                    height: mHeight * .056,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffF9F9F9),

                                        shape: const CircleBorder(),
                                      ),
                                      onPressed: () async {
                                        final result = await Navigator.of(context)
                                            .push(MaterialPageRoute(builder: (context) => CreateAssetScreen(id: "", isEdit: false)));
                                        listAssetIncomeApiFunction();
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),

                                  Container(
                                      alignment: Alignment.center,
                                      width: mWidth * .3,
                                      height: mHeight * .029,
                                      child: Text(
                                        "",
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 10.0),
                                      )),
                                ],
                              );



                            }

                            else {
                              return GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PortfolioDetailScreen(
                                            id: listAssetModelClass.data![index].id!,
                                            type: getNameFromValuePortfolio(1, listAssetModelClass.data![index].assetType!),
                                            state: listAssetModelClass.data![index].state!,
                                            asset: listAssetModelClass.data![index].assetName!,
                                            masterId: listAssetModelClass.data![index].assetMasterId!,
                                          )));
                                  listAssetIncomeApiFunction();
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: mWidth * .2,
                                          height: mHeight * .03,
                                          child: Text(
                                            listAssetModelClass.data![index].assetName!,
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(context, Color(0xff000000), FontWeight.w500, 11.0),
                                          )),
                                      listAssetModelClass.data![index].photo!.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundColor: Color(0xffF3F7FC),
                                              minRadius: 25,
                                              maxRadius: 25,
                                              backgroundImage: NetworkImage(ApiClient.imageBasePath + listAssetModelClass.data![index].photo!))
                                          : CircleAvatar(
                                              backgroundColor: Color(0xffF3F7FC),
                                              backgroundImage: NetworkImage('https://www.assetcues.com/wp-content/uploads/2022/11/8-'
                                                  'Factors-to-Consider-in-Finding-the-Best-Fixed-Asset-Management-Software-for-Your-Company-'
                                                  'Thumbnail-1024x1024.jpg'),
                                              minRadius: 25,
                                              maxRadius: 25,
                                            ),

                                      Container(
                                          alignment: Alignment.center,
                                          width: mWidth * .3,
                                          height: mHeight * .029,
                                          child: Text(
                                            getNameFromValuePortfolio(1, listAssetModelClass.data![index].assetType!)!,
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 10.0),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        )),
                  ]),
                ));
          }
          if (state is AssetListError) {
            return Center(
                child: Text(
              "Something went wrong",
              style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
            ));
          }

          return SizedBox();
        },
      ),
    );
  }
}

String getNameFromValuePortfolio(type, String value) {
  var list = [
    {"value": "0", "name": "Organization"},
    {"value": "1", "name": "Building"},
    {"value": "2", "name": "Land"},
    {"value": "3", "name": "share market"},
    {"value": "4", "name": "Rental building"},
  ];
  if (type == 1) {
    for (var item in list) {
      if (item["value"] == value) {
        return item["name"]!;
      }
    }
  } else {
    for (var item in list) {
      if (item["name"] == value) {
        return item["value"]!;
      }
    }
  }

  return "";
}
