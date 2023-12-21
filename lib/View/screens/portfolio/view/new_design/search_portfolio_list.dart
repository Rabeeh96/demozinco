import 'package:cuentaguestor_edit/View/screens/portfolio/view/new_design/portfolio_detail_screen.dart';
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
import '../../../../../Utilities/global/text_style.dart';
import '../../../../../Utilities/global/variables.dart';
import 'portfolio_list.dart';

class SearchPortfolioList extends StatefulWidget {
  const SearchPortfolioList({Key? key}) : super(key: key);

  @override
  State<SearchPortfolioList> createState() => _SearchPortfolioListState();
}

class _SearchPortfolioListState extends State<SearchPortfolioList> {
  TextEditingController searchController = TextEditingController();
  late ListAssetModelClass listAssetModelClass;

  listAssetIncomeApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");
      return BlocProvider.of<AssetBloc>(context).add(ListAssetEvent(
          organization: organizationId!,
          search: '',
          pageNumber: 1,
          page_size: 40));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  @override
  void initState() {
    listAssetIncomeApiFunction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 11,

          backgroundColor: const Color(0xffffffff),
          elevation: 1,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff0073D8),
            ),
          ),
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio',
                style: customisedStyle(
                    context, Color(0xff13213A), FontWeight.w500, 21.0),
              ),
              Row(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: mHeight * .05,
                      width: mWidth * .3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffF3F7FC)),
                      child: Text(
                        default_country_name + "-" + countryShortCode,
                        style: customisedStyle(
                            context, Color(0xff0073D8), FontWeight.w500, 14.0),
                      )),
                  IconButton(
                      onPressed: () async {},
                      icon:
                          SvgPicture.asset("assets/svg/search-normal (1).svg",color: Color(0xff0073D8),))
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
            height: mHeight,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF6F6F6),
                ),
                height: mHeight * .06,
                width: mWidth,
                child: TextField(
                  onChanged: (quary) async {

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final organizationId = prefs.getString("organisation");
                    if (quary.isNotEmpty) {
                      BlocProvider.of<AssetBloc>(context).add(ListAssetEvent(
                          organization: organizationId!,
                          search: quary,
                          pageNumber: 1,
                          page_size: 40));
                    } else {
                      BlocProvider.of<AssetBloc>(context).add(ListAssetEvent(
                          organization: organizationId!,
                          search: '',
                          pageNumber: 1,
                          page_size: 40));
                    }
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: mWidth * .07),
                      hintText: 'Search',
                      helperStyle: customisedStyle(context, Color(0xff929292),
                          FontWeight.normal, 15.0),
                      border: InputBorder.none),
                ),
              ),
              Expanded(
                child: BlocBuilder<AssetBloc, AssetState>(
                  builder: (context, state) {
                    if (state is AssetListLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff5728C4),
                        ),
                      );
                    }

                    if (state is AssetListLoaded) {
                      listAssetModelClass =
                          BlocProvider.of<AssetBloc>(context).listAssetModelClass;
                      return listAssetModelClass.data!.isNotEmpty
                          ? Container(
                          padding: EdgeInsets.all(20),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listAssetModelClass.data!.length ,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent:
                                  130,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PortfolioDetailScreen(
                                                id: listAssetModelClass
                                                    .data![index].id!,
                                                type: getNameFromValuePortfolio(
                                                    1,
                                                    listAssetModelClass
                                                        .data![index].assetType!),
                                                state: listAssetModelClass
                                                    .data![index].state!,
                                                asset: listAssetModelClass
                                                    .data![index].assetName!,
                                                masterId: listAssetModelClass
                                                    .data![index].assetMasterId!,
                                              )));
                                  listAssetIncomeApiFunction();
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: mWidth * .2,
                                          height: mHeight * .03,
                                          child: Text(
                                            listAssetModelClass
                                                .data![index].assetName!,
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(
                                                context,
                                                Color(0xff000000),
                                                FontWeight.w500,
                                                11.0),
                                          )),
                                      listAssetModelClass
                                              .data![index].photo!.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundColor: Color(0xffF3F7FC),
                                              minRadius: 25,
                                              maxRadius: 25,
                                              backgroundImage: NetworkImage(
                                                  ApiClient.imageBasePath +
                                                      listAssetModelClass
                                                          .data![index].photo!))
                                          : CircleAvatar(
                                              backgroundColor: Color(0xffF3F7FC),
                                              backgroundImage: NetworkImage(
                                                  'https://www.assetcues.com/wp-content/uploads/2022/11/8-'
                                                  'Factors-to-Consider-in-Finding-the-Best-Fixed-Asset-Management-Software-for-Your-Company-'
                                                  'Thumbnail-1024x1024.jpg'),
                                              minRadius: 25,
                                              maxRadius: 25,
                                            ),
                                      SizedBox(
                                        height: mHeight * .01,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          width: mWidth * .3,
                                          height: mHeight * .029,
                                          child: Text(
                                            getNameFromValuePortfolio(
                                                1,
                                                listAssetModelClass
                                                    .data![index].assetType!)!,
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(
                                                context,
                                                Color(0xff0073D8),
                                                FontWeight.w500,
                                                10.0),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )) : SizedBox(
                          height: mHeight * .7,
                          child: const Center(
                              child: Text(
                                "Not found !",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )));
                    }
                    if (state is AssetListError) {
                      return Center(
                          child: Text(
                        "Something went wrong",
                        style: customisedStyle(
                            context, Colors.black, FontWeight.w500, 13.0),
                      ));
                    }

                    return SizedBox();
                  },
                ),
              ),
            ])));
  }
}
