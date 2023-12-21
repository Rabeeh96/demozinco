import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lean_file_picker/lean_file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:open_file_safe/open_file_safe.dart' as open_file;

import '../../../../../Api Helper/Bloc/asset new design bloc/asset_bloc.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/asset_event.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/dlt bloc/portfolio_delete_bloc.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/property/property_bloc.dart';
import '../../../../../Api Helper/Bloc/asset new design bloc/stock/stock_bloc.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/AssetDeleteModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/Stock/CreateStockModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/Stock/DeleteStockModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/Stock/EditStockModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/property/DeletePropertyModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/property/EditPropertyModelClass.dart';
import '../../../../../Api Helper/ModelClasses/asset new modelclsses/property/PropertCreateModelClass.dart';
import '../../../../../Api Helper/Repository/api_client.dart';
import '../../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../../Utilities/Commen Functions/date_picker_function.dart';
import '../../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../../Utilities/CommenClass/commen_txtfield_widget.dart';
import '../../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../../Utilities/global/text_style.dart';
import '../../create_portfolio/api/dio_method.dart';
import 'create portfolio.dart';
import 'portfolio_list.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key? key, this.id, this.isEdit, required this.state, required this.asset, required this.type}) : super(key: key);
  String? id;
  bool? isEdit;
  final String state;
  final String type;
  final String asset;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late ProgressBar progressBar;

  void showProgressBar() {
    progressBar.show(context);
  }

  void hideProgressBar() {
    progressBar.hide();
  }

  @override
  void dispose() {
    hideProgressBar();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadInitial();
  }

  String selectedAccountID = "";

  TextEditingController shareController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  loadInitial() {
    progressBar = ProgressBar();
    imageList.clear();
    fileList.clear();
    itemList.clear();

    searchAccountListShown.clear();
    accountListShown.clear();
    accountList.clear();

    Future.delayed(Duration.zero, () async {
      await loadSingleData();
      await returnAccountList();
    });
  }

  var addressID = "";
  String buildNo = "";
  String landMark = "";
  String state = "";
  String city = "";
  String country = "";
  var preOwned = false;
  String postalCode = "";
  List<ListItem> itemList = [];
  var imageList = [];
  var assetItemsDetails = [];

  String extractFileName(String filePath) {
    return path.basename(filePath);
  }


  var fileList = [];

  var documentsList = [];

  String assetTypeID = "0";

  loadSingleData() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        var result = await getPortfolioDetails(context: context, portfolioID: widget.id);

        if (result[0] == 6000) {
          var data = result[1];

          shareController.text = roundStringWith(data["total_share"].toString());
          valueController.text = roundStringWith(data["total_value"].toString());

          var building = data["address"][0];

          assetTypeID = data["asset_type"];
          buildingNameController.text = building["building_name"];
          cityController.text = building["address_name"];
          landMarkController.text = building["land_mark"];
          addressID = building["id"];

          countryController.text = building["country"]["country_name"];
          assetName = data["asset_name"];
          assetType = getNameFromValuePortfolio(1, data["asset_type"]);
          stateController.text = building["state"];
          postalCodeController.text = building["pin_code"];
          buildNo = building["building_name"];
          city = building["address_name"];
          landMark = building["land_mark"];
          state = building["state"];
          country = building["country"]["country_name"];
          postalCode = building["pin_code"];
          documentsList = data["documents"] ?? [];
          imageList = data["images"] ?? [];

          setState(() {
            itemList.clear();
            assetItemsDetails = data["asset_details"] ?? [];

            if (assetItemsDetails.isNotEmpty) {
              preOwned = assetItemsDetails[0]["pre_owned"];
            }

            var property = data["custom_properties"] ?? [];
            for (var item in property) {
              var itemName = item["property_name"];
              var itemValue = item["property_value"];
              var itemId = item["id"];
              itemList.add(ListItem(itemName, itemValue, itemId));
            }
          });

          setState(() {});
        } else {}
      } catch (e) {}
    });
  }

  String? getNameFromValue(type, String value) {
    var list = [
      {"value": "0", "name": "organization"},
      {"value": "1", "name": "building"},
      {"value": "2", "name": "land"},
      {"value": "3", "name": "share_market"},
      {"value": "4", "name": "rental_building"},
    ];
    if (type == 1) {
      for (var item in list) {
        if (item["value"] == value) {
          return item["name"];
        }
      }
    } else {
      for (var item in list) {
        if (item["name"] == value) {
          return item["value"];
        }
      }
    }

    return "";
  }

  DateFormat dateFormat = DateFormat("dd/MM/yyy");

  deleteContactApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;

      return BlocProvider.of<PortfolioDeleteBloc>(context).add(FetchPortfolioDeleteEvent(organisation: organizationId!, id: widget.id!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  TextEditingController buildingNameController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  late AssetDeleteModelClass assetDeleteModelClass;
  late DeleteStockModelClass deleteStockModelClass;

  final imgPicker = ImagePicker();
  late DeletePropertyModelClass deletePropertyModelClass;
  var assetName = "";
  var assetType = "";

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .02,
    );

    final divider = Divider(
      color: Color(0xffE2E2E2),
      thickness: 1,
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<PortfolioDeleteBloc, PortfolioDeleteState>(
          listener: (context, state) async {
            assetDeleteModelClass = BlocProvider.of<PortfolioDeleteBloc>(context).assetDeleteModelClass;

            if (state is PortfolioDeleteLoaded) {
              hideProgressBar();


              if (assetDeleteModelClass.statusCode == 6000) {

                Navigator.of(context)
                    .popUntil((route) => route.isFirst);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                final organizationId = prefs.getString("organisation");
                return BlocProvider.of<AssetBloc>(context)
                    .add(ListAssetEvent(organization: organizationId!, search: '', pageNumber: 1, page_size: 40));

              }

              if (assetDeleteModelClass.statusCode == 6001) {
                await msgBtmDialogueFunction(
                  context: context,
                  textMsg: assetDeleteModelClass.message ?? '',
                );
              } else if (assetDeleteModelClass.statusCode == 6002) {
                await msgBtmDialogueFunction(context: context, textMsg: "Something went wrong");
                Navigator.pop(context);
              }
            }
            if (state is PortfolioDeleteError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<StockBloc, StockState>(
          listener: (context, state) async {
            if (state is AssetStockDeleteLoaded) {
              hideProgressBar();
              deleteStockModelClass = BlocProvider.of<StockBloc>(context).deleteStockModelClass;
              if (deleteStockModelClass.statusCode == 6000) {

                loadSingleData();

              }
              if (deleteStockModelClass.statusCode == 6001) {
                alreadyCreateBtmDialogueFunction(
                    context: context,
                    textMsg: deleteStockModelClass.message.toString(),
                    buttonOnPressed: () {
                      Navigator.of(context).pop(false);
                    });
              }
            }
            if (state is AssetStockDeleteError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<PropertyBloc, PropertyState>(
          listener: (context, state) async {
            if (state is AssetPropertyDeleteLoaded) {
              hideProgressBar();
              deletePropertyModelClass = BlocProvider.of<PropertyBloc>(context).deletePropertyModelClass;
              if (deletePropertyModelClass.statusCode == 6000) {

                loadSingleData();

              }
              if (deletePropertyModelClass.statusCode == 6001) {
                alreadyCreateBtmDialogueFunction(
                    context: context,
                    textMsg: deletePropertyModelClass.message.toString(),
                    buttonOnPressed: () {
                      Navigator.of(context).pop(false);
                    });
              }
            }
            if (state is AssetPropertyDeleteError) {
              hideProgressBar();
            }
          },
        ),
      ],
      child: Scaffold(
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
            titleSpacing: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assetName,
                  style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 18.0),
                ),
                Text(
                  assetType,
                  style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 12.0),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateAssetScreen(
                              id: widget.id,
                              isEdit: true,
                            )));

                    loadInitial();
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Color(0xff2BAAFC),
                  )),


            ],
          ),
          body: Container(
              color: Colors.white,

              height: mHeight,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  divider,
                  imageList.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height * .18,
                                    maxWidth: MediaQuery.of(context).size.width * .99,
                                    minWidth: 0),
                                child: GridView.builder(
                                    physics: BouncingScrollPhysics(),

                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,


                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: imageList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return returnImageListItem(index);
                                    }))
                          ],
                        )
                      : Container(),
                  space,
                  Container(
                    height: mHeight * .07,
                    color: Color(0xffF8F8F8),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                    child: Text(
                      "Address",
                      style: customisedStyle(context, Colors.black, FontWeight.w500, 17.0),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                        buildNo.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: mHeight * .02),
                                child: AddressWidget(
                                  mHeight: mHeight,
                                  text: 'Building No/Name',
                                  text1: buildNo,
                                ),
                              )
                            : SizedBox(),
                        buildNo.isNotEmpty ? divider : SizedBox(),
                        landMark.isNotEmpty
                            ? AddressWidget(
                                mHeight: mHeight,
                                text: 'Landmark',
                                text1: landMark,
                              )
                            : SizedBox(),
                        landMark.isNotEmpty ? divider : SizedBox(),
                        city.isNotEmpty
                            ? AddressWidget(
                                mHeight: mHeight,
                                text: 'City',
                                text1: city,
                              )
                            : SizedBox(),
                        city.isNotEmpty ? divider : SizedBox(),
                        state.isNotEmpty
                            ? AddressWidget(
                                mHeight: mHeight,
                                text: 'State/Province',
                                text1: state,
                              )
                            : SizedBox(),
                        state.isNotEmpty ? divider : SizedBox(),
                        country.isNotEmpty ? AddressWidget(mHeight: mHeight, text: 'Country', text1: country) : SizedBox(),
                        country.isNotEmpty ? divider : SizedBox(),
                        postalCode.isNotEmpty
                            ? AddressWidget(
                                mHeight: mHeight,
                                text: 'Postal Code',
                                text1: postalCode,
                              )
                            : SizedBox(),
                        Container(
                          height: mHeight * .01,
                        ),
                        Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                              color: Color(0xffF8F8F8),
                              height: mHeight / 16,
                              width: mWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Stock",
                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchAccountListShown = accountListShown;
                                        });


                                        Future.delayed(Duration(milliseconds: 10), () async {
                                          addStockBtmSheet(
                                              context: context,
                                              assetId: widget.id!,
                                              type: 'Add',
                                              accountId: selectedAccountID,
                                              share: "0.00",
                                              value: '0.00',
                                              accountListBottomSheet: accountList);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Color(0xff2BAAFC),
                                      ))
                                ],
                              ),
                            ),
                            Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                            Container(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: assetItemsDetails.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          msgBtmDialogueFunction(context: context, textMsg: "Cant edit initial stock from here");
                                        } else {
                                          setState(() {
                                            searchAccountListShown = accountListShown;
                                          });

                                          Future.delayed(Duration(milliseconds: 10), () async {
                                            addStockBtmSheet(
                                                context: context,
                                                assetId: widget.id!,
                                                type: 'Edit',
                                                share: roundStringWithVal(assetItemsDetails[index]["share"]),
                                                value: roundStringWithVal(assetItemsDetails[index]["value"]),
                                                date: assetItemsDetails[index]["as_on_date"],
                                                accountId: assetItemsDetails[index]["from_account"],
                                                asset_detail_id: assetItemsDetails[index]["id"],
                                                accountListBottomSheet: accountList);
                                          });
                                        }
                                      },
                                      child: Container(
                                        child: Dismissible(
                                          direction: DismissDirection.endToStart,
                                          background: Container(
                                              color: Colors.red,
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              )),
                                          confirmDismiss: (DismissDirection direction) async {
                                            return await btmDialogueFunction(
                                                isDismissible: true,
                                                context: context,
                                                textMsg: 'Are you sure delete ?',
                                                fistBtnOnPressed: () {
                                                  Navigator.of(context).pop(false);
                                                },
                                                secondBtnPressed: () async {
                                                  if (index == 0) {
                                                    Navigator.of(context).pop(false);

                                                    msgBtmDialogueFunction(context: context, textMsg: "Cant edit initial stock from here");
                                                  } else {
                                                    Navigator.of(context).pop(true);
                                                    var netWork = await checkNetwork();
                                                    if (netWork) {
                                                      if (!mounted) return;
                                                      showProgressBar();
                                                      return BlocProvider.of<StockBloc>(context)
                                                          .add(FetchDeleteStockEvent(assetDetailId: assetItemsDetails[index]["id"]));
                                                    } else {
                                                      if (!mounted) return;
                                                      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                                    }
                                                  }


                                                },
                                                secondBtnText: 'Delete');
                                          },
                                          key: Key(assetItemsDetails[index]["id"]),
                                          onDismissed: (direction) async {},
                                          child: Container(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: mHeight * .01,
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                                                    color: Colors.white,
                                                    height: mHeight / 16,
                                                    width: mWidth,
                                                    child: ListTile(
                                                      leading: Transform(
                                                        transform: Matrix4.translationValues(-16, 0.0, 0.0),
                                                        child: Container(
                                                              padding: EdgeInsets.only(
                                                              left: mWidth * .01,
                                                            ),
                                                            decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffF3F7FC)),
                                                            child: Text("${index + 1}")),
                                                      ),
                                                      title: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              assetItemsDetails[index]["as_on_date"],
                                                              style: customisedStyle(context, Colors.grey, FontWeight.normal, 12.0),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Share:",
                                                                    style: customisedStyle(context, Color(0xff9974EF), FontWeight.normal, 12.0),
                                                                  ),
                                                                  SizedBox(
                                                                    width: mWidth * .02,
                                                                  ),
                                                                  Text(
                                                                    roundStringWith(assetItemsDetails[index]["share"]) + " %",
                                                                    style: customisedStyle(context, Colors.black, FontWeight.normal, 12.0),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 18.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                  children: [
                                                                    Text(
                                                                      "Value",
                                                                      style: customisedStyle(context, Color(0xff9974EF), FontWeight.normal, 12.0),
                                                                    ),
                                                                    SizedBox(
                                                                      width: mWidth * .02,
                                                                    ),
                                                                    Container(
                                                                       child: Text(
                                                                        roundStringWith(assetItemsDetails[index]["value"]),
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: customisedStyle(context, Colors.black, FontWeight.normal, 12.0),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        );
                      }),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                              color: Color(0xffF8F8F8),
                              height: mHeight / 16,
                              width: mWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Properties",
                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        addPropertyBtmSheet(context: context, id: widget.id!, type: 'Add', propertyName: "", propertyValue: "");
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Color(0xff2BAAFC),
                                      ))
                                ],
                              ),
                            ),
                            Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                            Container(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: itemList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        addPropertyBtmSheet(
                                            context: context,
                                            id: widget.id!,
                                            type: 'Edit',
                                            propertyName: itemList[index].title,
                                            propertyValue: itemList[index].subtitle,
                                            propertyId: itemList[index].id);
                                      },
                                      child: Container(
                                        child: Dismissible(
                                          direction: DismissDirection.endToStart,
                                          background: Container(
                                              color: Colors.red,
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              )),
                                          confirmDismiss: (DismissDirection direction) async {
                                            return await btmDialogueFunction(
                                                isDismissible: true,
                                                context: context,
                                                textMsg: 'Are you sure delete ?',
                                                fistBtnOnPressed: () {
                                                  Navigator.of(context).pop(false);
                                                },
                                                secondBtnPressed: () async {
                                                  Navigator.of(context).pop(true);
                                                  var netWork = await checkNetwork();
                                                  if (netWork) {
                                                    if (!mounted) return;
                                                    showProgressBar();
                                                    return BlocProvider.of<PropertyBloc>(context)
                                                        .add(FetchDeletePropertyEvent(propertyId: itemList[index].id));
                                                  } else {
                                                    if (!mounted) return;
                                                    msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                                  }
                                                },
                                                secondBtnText: 'Delete');
                                          },
                                          key: Key(itemList[index].id),
                                          onDismissed: (direction) async {},
                                          child: Column(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                                                  color: Colors.white,
                                                  height: mHeight / 14,
                                                  width: mWidth,
                                                  child: ListTile(
                                                    leading: Transform(
                                                      transform: Matrix4.translationValues(-16, 0.0, 0.0),
                                                      child: Text(
                                                        itemList[index].title,
                                                        style: customisedStyle(context, Color(0xff9974EF), FontWeight.normal, 15.0),
                                                      ),
                                                    ),
                                                    trailing: Text(
                                                      itemList[index].subtitle,
                                                      style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                                                    ),
                                                  )),
                                              Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        );
                      }),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                              color: Color(0xffF8F8F8),
                              height: mHeight / 16,
                              width: mWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Documents",
                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        var netWork = await checkNetwork();
                                        if (netWork) {
                                          if (!mounted) return;

                                          alterItem(1, 0);
                                        } else {
                                          if (!mounted) return;
                                          msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                        }
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Color(0xff2BAAFC),
                                      ))
                                ],
                              ),
                            ),
                            Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                            Container(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: documentsList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Dismissible(
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                          color: Colors.red,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          )),
                                      confirmDismiss: (DismissDirection direction) async {
                                        return await btmDialogueFunction(
                                            isDismissible: true,
                                            context: context,
                                            textMsg: 'Are you sure delete ?',
                                            fistBtnOnPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            secondBtnPressed: () async {
                                              Navigator.of(context).pop(true);
                                              var netWork = await checkNetwork();
                                              if (netWork) {
                                                if (!mounted) return;

                                                deleteDocuments(documentsList[index]["id"]);
                                              } else {
                                                if (!mounted) return;
                                                msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                              }
                                            },
                                            secondBtnText: 'Delete');
                                      },
                                      key: Key(documentsList[index]["id"]),
                                      onDismissed: (direction) async {},
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                                            color: Colors.white,
                                            height: mHeight / 14,
                                            width: mWidth,
                                            child: ListTile(
                                                tileColor: Color(0xffF3F7FC),
                                                onTap: () async {
                                                  try {
                                                    showProgressBar();
                                                    String fileName = extractFileName(documentsList[index]["file"]);
                                                    var fileUrl = ApiClient.imageBasePath + documentsList[index]["file"];
                                                    var imagePath = await downloadFile(fileUrl, fileName);

                                                    if (imagePath != "") {
                                                      hideProgressBar();
                                                      await open_file.OpenFile.open(imagePath);
                                                    } else {
                                                      msgBtmDialogueFunction(context: context, textMsg: "Please try again later");
                                                    }
                                                  } catch (e) {
                                                    hideProgressBar();
                                                    msgBtmDialogueFunction(context: context, textMsg: "Please try again later");
                                                  }
                                                },
                                                onLongPress: () {
                                                  alterItem(2, index);
                                                },
                                                leading: Transform(
                                                  transform: Matrix4.translationValues(-16, 0.0, 0.0),
                                                  child: Text(
                                                    extractFileName(documentsList[index]["file"]),
                                                    style: customisedStyle(context, Colors.black, FontWeight.w400, 15.0),
                                                  ),
                                                )),
                                          ),
                                          Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 30,
                            ),

                          ],
                        );
                      }),
                ]),
              ))),
    );
  }

  TextEditingController searchController = TextEditingController();

  bool isItemWithIdExists(String id) {
    return accountListShown.any((item) => item.id == id);
  }

  returnAccountList() async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';
      final country_id = prefs.getString("country_id");
      showProgressBar();
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 30,
        "search": "",
        "country_id": country_id,
        "account_type": [1, 2]
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          },
          body: body);
      Map n = json.decode(utf8.decode(response.bodyBytes));
      var statusCode = n["StatusCode"];
      var responseJson = n["data"];

      if (statusCode == 6000) {
        hideProgressBar();
        setState(() {
          accountList.clear();
          accountListShown.clear();
          searchAccountListShown.clear();
          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountList.add(account);
            accountListShown.add(account);
            searchAccountListShown.add(account);
          }
          selectedAccountID = accountListShown[0].id;
        });
      } else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
      print(e.toString());
    }
  }

  searchAccountListApi(searchData, setStater) async {
    final response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'accounts/list-account/';
      final country_id = prefs.getString("country_id");
      Map data = {
        "organization": organizationId,
        "type": null,
        "page_number": 1,
        "page_size": 20,
        "search": searchData,
        "country_id": country_id,
        "account_type": [1, 2]
      };

      var body = json.encode(data);

      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          },
          body: body);
      Map n = json.decode(utf8.decode(response.bodyBytes));
      var statusCode = n["StatusCode"];
      var responseJson = n["data"];

      if (statusCode == 6000) {

        searchAccountListShown.clear();
        setStater(() {
          for (Map user in responseJson) {
            searchAccountListShown.add(AccountListModel.fromJson(user));
          }
        });

        return searchAccountListShown;
      } else {
        return [];
      }
    } catch (e) {
      return [];
      print(e.toString());
    }
  }

  returnImageListItem(index) {
    if (imageList.isEmpty) {
      return SizedBox();
    } else {
      return displayImage(imageList[index]["image"]);
    }
  }

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.gallery);

    if (imgCamera != null) {
      if (imgCamera.path != "") {
        setState(() {
          imageList.add(imgCamera.path);
        });
      }

    }
  }

  Widget displayImage(imagePath) {
    if (imagePath == null) {
      return const Text("No Image Selected!");
    } else {
      return Container(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13.0),
          child: Image.network(
            "${ApiClient.imageBasePath}" + imagePath,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 8,
          ),
        ),
      );
    }
  }

  addStockBtmSheet(
      {required context,
      required String assetId,
      required String type,
      String? share,
      String? value,
      String? date,
      String? accountId,
      String? asset_detail_id,
      required var accountListBottomSheet}) {

    final formKey = GlobalKey<FormState>();
    DateFormat apiDateFormat = DateFormat("y-M-d");
    late CreateStockModelClass createStockModelClass;
    ValueNotifier<DateTime> dateValueNotifier = ValueNotifier(type == "Add" ? DateTime.now() : DateTime.parse(date!));

    late EditStockModelClass editStockModelClass;
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final FocusNode focusNodeShare = FocusNode();

    TextEditingController stockShareController = TextEditingController()..text = share.toString();
    TextEditingController stockValueController = TextEditingController()..text = value.toString();
    TextEditingController searchController = TextEditingController();
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        return MultiBlocListener(
            listeners: [
              BlocListener<StockBloc, StockState>(
                listener: (context, state) async {
                  if (state is AssetStockCreateLoaded) {
                    hideProgressBar();
                    createStockModelClass = BlocProvider.of<StockBloc>(context).createStockModelClass;
                    if (createStockModelClass.statusCode == 6000) {
                      Navigator.pop(context);

                         loadSingleData();
                    }
                    if (createStockModelClass.statusCode == 6001) {
                      hideProgressBar();
                      alreadyCreateBtmDialogueFunction(
                          context: context,
                          textMsg: createStockModelClass.message.toString(),
                          buttonOnPressed: () {
                            Navigator.of(context).pop(false);
                          });
                    }
                  }
                },
              ),
              BlocListener<StockBloc, StockState>(
                listener: (context, state) async {
                  if (state is AssetStockEditLoaded) {
                    editStockModelClass = BlocProvider.of<StockBloc>(context).editStockModelClass;

                    if (editStockModelClass.statusCode == 6000) {
                      hideProgressBar();
                      Navigator.pop(context);
                        loadSingleData();
                    }

                    if (editStockModelClass.statusCode == 6001) {
                      hideProgressBar();
                      msgBtmDialogueFunction(
                        context: context,
                        textMsg: "Something went wrong",
                      );
                    }
                  }
                },
              ),
            ],
            child: StatefulBuilder(
              builder: (context, setStater) {
                return Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: mHeight * .02,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: ValueListenableBuilder(
                              valueListenable: dateValueNotifier,
                              builder: (BuildContext ctx, dateNewValue, _) {
                                return GestureDetector(
                                  onTap: () {
                                    showDatePickerFunction(context, dateValueNotifier);
                                  },
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width * .39,
                                      height: MediaQuery.of(context).size.height * .05,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/svg/calender.svg"),
                                          SizedBox(
                                            width: mWidth * .02,
                                          ),
                                          Text(dateFormat.format(dateNewValue))
                                        ],
                                      )),
                                );
                              }),
                        ),
                        SizedBox(
                          height: mHeight * .02,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(20)),
                                  width: MediaQuery.of(context).size.width / 2.4,
                                  child: TextFormField(
                                      style: customisedStyle(context, Color(0xff13213A), FontWeight.normal, 14.0),
                                      controller: stockShareController,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                      ],
                                      onTap: () => stockShareController.selection =
                                          TextSelection(baseOffset: 0, extentOffset: stockShareController.value.text.length),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          if (value == ".") {
                                          } else {
                                            final intValue = double.tryParse(value);
                                            if (intValue != null) {
                                              if (intValue > 100.00) {
                                                stockShareController.text = '100';
                                                focusNodeShare.unfocus();
                                              }
                                            } else {
                                              stockShareController.clear();
                                            }
                                          }
                                        }
                                      },
                                      textAlign: TextAlign.start,
                                      readOnly: false,
                                      textInputAction: TextInputAction.done,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(4)),
                                            borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(4)),
                                            borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
                                          ),
                                          labelStyle: customisedStyle(
                                            context,
                                            Color(0xff778EB8),
                                            FontWeight.normal,
                                            15.0,
                                          ),
                                          contentPadding: EdgeInsets.all(7),
                                          hintText: "Share %",
                                          labelText: "Share %",
                                          hintStyle: customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 15.0),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Color(0xffF3F7FC)))),
                              Container(
                                  decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(20)),
                                  width: MediaQuery.of(context).size.width / 2.4,
                                  child: TextFormField(
                                      style: customisedStyle(context, Color(0xff13213A), FontWeight.normal, 14.0),
                                      controller: stockValueController,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                      ],
                                      onTap: () => stockValueController.selection =
                                          TextSelection(baseOffset: 0, extentOffset: stockValueController.value.text.length),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {}
                                      },
                                      textAlign: TextAlign.start,
                                      readOnly: false,
                                      textInputAction: TextInputAction.done,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(4)),
                                            borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(4)),
                                            borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
                                          ),
                                          labelStyle: customisedStyle(
                                            context,
                                            Color(0xff778EB8),
                                            FontWeight.normal,
                                            15.0,
                                          ),
                                          contentPadding: EdgeInsets.all(7),
                                          hintText: "Value",
                                          labelText: "Value",
                                          hintStyle: customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 15.0),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Color(0xffF3F7FC)))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mHeight * .02,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06),
                            decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width * .88,
                            child: BottomSheetTextfeild(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color(0xff2BAAFC),
                              ),
                              onChanged: (val) async {
                                accountListBottomSheet = await searchAccountListApi(val, setStater);
                                setStater(() {});
                              },
                              controller: searchController,
                              hintText: 'Search',
                              textInputType: TextInputType.text,
                              textAlign: TextAlign.start,
                              readOnly: false,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                            )),
                        SizedBox(
                          height: mHeight * .02,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                          child: Container(
                            height: mHeight * .3,
                            child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: accountListBottomSheet.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 40,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      AccountListModel newItem = AccountListModel(
                                        id: accountListBottomSheet[index].id,
                                        account_name: accountListBottomSheet[index].account_name,
                                        accounts_id: accountListBottomSheet[index].accounts_id,
                                        opening_balance: '0.00',
                                        account_type: accountListBottomSheet[index].account_type,
                                        amount: accountListBottomSheet[index].amount,
                                      );

                                      selectedAccountID = accountListBottomSheet[index].id;
                                      accountId = accountListBottomSheet[index].id;
                                      bool exists = isItemWithIdExists(accountListBottomSheet[index].id);
                                      if (exists) {
                                        int indexToDelete = accountListBottomSheet.indexWhere((item) => item.id == accountListBottomSheet[index].id);
                                        accountListBottomSheet.removeAt(indexToDelete);
                                      }
                                      accountListBottomSheet.insert(0, newItem);

                                      setStater(() {});
                                    },
                                    child: Container(
                                      height: mHeight * .01,

                                      decoration: BoxDecoration(
                                          color: accountId == accountListBottomSheet[index].id ? Color(0xff2BAAFC) : Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: Color(0xffD6E0F6))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              accountListBottomSheet[index].account_name,
                                              style: customisedStyle(
                                                  context,
                                                  accountId == accountListBottomSheet[index].id ? Colors.white : Colors.black,
                                                  FontWeight.normal,
                                                  13.0),
                                            ),
                                          ),
                                          SizedBox(
                                            width: mWidth * .05,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          height: mHeight * .02,
                        ),
                        Divider(
                          color: Color(0xffE2E2E2),
                          thickness: 1,
                        ),
                        SizedBox(
                          height: mHeight * .01,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0xffE31919),
                                  radius: 20.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.close, color: Color(0xffE31919)),
                                    radius: 18.0,
                                  ),
                                ),
                              ),
                              Text(
                                type == "Add" ? 'Add Stock' : "Edit Stock",
                                style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var netWork = await checkNetwork();
                                  if (selectedAccountID != "") {
                                    if (stockShareController.text == "" || stockValueController.text == "") {
                                      msgBtmDialogueFunction(context: context, textMsg: "Please enter stock details");
                                    } else {
                                      if (netWork) {
                                        showProgressBar();
                                        if (type == "Add") {
                                          return BlocProvider.of<StockBloc>(context).add(FetchCreateStockAssetEvent(
                                              assetId: assetId,
                                              share: stockShareController.text,
                                              value: stockValueController.text,
                                              preOwn: false,
                                              asOnDate: apiDateFormat.format(dateValueNotifier.value),
                                              accountId: accountId!));
                                        } else {
                                          return BlocProvider.of<StockBloc>(context).add(FetchEditStockEvent(
                                              assetId: assetId,
                                              share: stockShareController.text,
                                              Value: stockValueController.text,
                                              pre_owned: false,
                                              as_on_date: apiDateFormat.format(dateValueNotifier.value),
                                              account_id: accountId!,
                                              asset_detail_id: asset_detail_id!));
                                        }

                                      } else {
                                        msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                      }
                                    }


                                  } else {
                                    msgBtmDialogueFunction(context: context, textMsg: "Please select account");
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0xff087A04),
                                  radius: 20.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.done, color: Color(0xff087A04)),
                                    radius: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    ).whenComplete(() {
      setState(() {
      });
    });
  }

  alterItem(type, index) async {
    if (type == 1 || type == 2) {
      final file = await pickFile(
        allowedExtensions: ['zip', 'pdf'],
        allowedMimeTypes: ['pdf', 'doc', 'docx'],
      );

      if (file != null) {
        final path = file.path;
        if (type == 1) {
          uploadDocuments(false, path);
        } else {
          fileList[index] = path;
        }
        setState(() {});
      } else {}
    } else {
      fileList.removeAt(index);
    }
    setState(() {});
  }

  uploadDocuments(type, filePath) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      showProgressBar();
      var basePath = ApiClient.basePath;
      final organizationId = prefs.getString("organisation");
      final token = prefs.getString('token');
      final country_id = prefs.getString("country_id");
      var headers = {
        'Authorization': 'Bearer $token',
        'Cookie': 'csrftoken=pDlni6xLaHEpMDmxAucCWYOG8lWA6LUMwgJquwOVwuHNI5tXNv5fg0zCAoke4Cdg; sessionid=jexiiec5tdb5rk11fs0jkmr3433xez78'
      };

      String url = basePath + 'assets/add-document/';
      if (type) {
        url = basePath + 'assets/add-document/';
      }

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({'organization': organizationId!, 'asset_master_id': widget.id!, 'country_id': country_id!});
      request.files.add(await http.MultipartFile.fromPath('documents', filePath));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        hideProgressBar();
        print(await response.stream.bytesToString());
        loadInitial();
      } else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
    }
  }

  deleteDocuments(id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      showProgressBar();
      var basePath = ApiClient.basePath;
      final organizationId = prefs.getString("organisation");
      final token = prefs.getString('token');
      var url = basePath + "assets/delete-document/";
      final country_id = prefs.getString("country_id");
      Map data = {"document_id": id, "organization": organizationId, "country_id": country_id};
      var body = json.encode(data);

      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: body);

      Map n = json.decode(utf8.decode(response.bodyBytes));
      var status = n["StatusCode"];

      if (status == 6000) {
        hideProgressBar();
        msgBtmDialogueFunction(context: context, textMsg: "Successfully deleted");
        loadInitial();
      } else {
        hideProgressBar();
        msgBtmDialogueFunction(context: context, textMsg: "Please try again later");
      }
    } catch (e) {
      hideProgressBar();
    }
  }

  addPropertyBtmSheet({required context, required String id, required String type, String? propertyName, String? propertyValue, String? propertyId}) {
    final formKey = GlobalKey<FormState>();

    TextEditingController propertyNameController = TextEditingController()..text = propertyName.toString();
    TextEditingController valueController = TextEditingController()..text = propertyValue.toString();
    late PropertCreateModelClass propertCreateModelClass;
    late EditPropertyModelClass editPropertyModelClass;

    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<PropertyBloc, PropertyState>(
              listener: (context, state) async {
                if (state is AssetPropertyCreateLoaded) {
                  propertCreateModelClass = BlocProvider.of<PropertyBloc>(context).propertCreateModelClass;
                  if (propertCreateModelClass.statusCode == 6000) {
                    Navigator.pop(context);


                    loadSingleData();
                  }
                  if (propertCreateModelClass.statusCode == 6001) {
                    alreadyCreateBtmDialogueFunction(
                        context: context,
                        textMsg: propertCreateModelClass.message.toString(),
                        buttonOnPressed: () {
                          Navigator.of(context).pop(false);
                        });
                  }
                }
              },
            ),
            BlocListener<PropertyBloc, PropertyState>(
              listener: (context, state) async {
                if (state is AssetPropertyEditLoaded) {
                  editPropertyModelClass = BlocProvider.of<PropertyBloc>(context).editPropertyModelClass;

                  if (editPropertyModelClass.statusCode == 6000) {
                    Navigator.pop(context);

                    loadSingleData();
                  }

                  if (editPropertyModelClass.statusCode == 6001) {
                    msgBtmDialogueFunction(
                      context: context,
                      textMsg: "Something went wrong",
                    );

                  }
                }
              },
            ),
          ],
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: mHeight * .02,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06),
                      decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width * .88,
                      child: BottomSheetTextfeild(
                        validator: (value) {
                          if (value == null || value.isEmpty || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        controller: propertyNameController,
                        hintText: 'Property Name',
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.start,
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        obscureText: false,
                      )),
                  SizedBox(
                    height: mHeight * .02,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06),
                      decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width * .88,
                      child: BottomSheetTextfeild(
                        validator: (value) {
                          if (value == null || value.isEmpty || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        controller: valueController,
                        hintText: 'Value',
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.start,
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.words,
                        obscureText: false,
                      )),
                  SizedBox(
                    height: mHeight * .02,
                  ),
                  Divider(
                    color: Color(0xffE2E2E2),
                    thickness: 1,
                  ),
                  SizedBox(
                    height: mHeight * .01,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xffE31919),
                            radius: 20.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.close, color: Color(0xffE31919)),
                              radius: 18.0,
                            ),
                          ),
                        ),
                        Text(
                          type == "Add" ? 'Add Property' : "Edit Property",
                          style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate() && type == "Add") {
                              var netWork = await checkNetwork();

                              if (netWork) {
                                return BlocProvider.of<PropertyBloc>(context).add(FetchCreatePropertyAssetEvent(
                                    assetMasterId: id, propertyName: propertyNameController.text, value: valueController.text));
                              } else {
                                msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                              }
                            } else if (formKey.currentState!.validate() && type == "Edit") {
                              var netWork = await checkNetwork();

                              if (netWork) {
                                return BlocProvider.of<PropertyBloc>(context).add(FetchEditPropertyEvent(
                                    property_name: propertyNameController.text, property_value: valueController.text, property_id: propertyId!));
                              } else {
                                msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                              }
                            } else {
                              return null;
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xff087A04),
                            radius: 20.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.done, color: Color(0xff087A04)),
                              radius: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.mHeight,
    required this.text,
    required this.text1,
  });

  final double mHeight;
  final String text;
  final String text1;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: mWidth * .07),
      height: mHeight * .065,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: customisedStyle(context, Colors.grey, FontWeight.normal, 12.0),
          ),
          Text(
            text1,
            style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
          )
        ],
      ),
    );
  }
}

List<AccountListModel> searchAccountListShown = [];
List<AccountListModel> accountListShown = [];
List<AccountListModel> accountList = [];

class AccountListModel {
  int accounts_id;
  final String id, account_name, opening_balance, amount, account_type;

  AccountListModel({
    required this.id,
    required this.account_name,
    required this.accounts_id,
    required this.opening_balance,
    required this.account_type,
    required this.amount,
  });

  factory AccountListModel.fromJson(Map<dynamic, dynamic> json) {
    return new AccountListModel(
      id: json['id'],
      account_name: json['account_name'],
      accounts_id: json['accounts_id'],
      opening_balance: json['opening_balance'].toString(),
      account_type: json['account_type'].toString(),
      amount: json['amount'].toString(),
    );
  }
}

class ListItem {
  String title;
  String subtitle;
  String id;

  ListItem(this.title, this.subtitle, this.id);
}

List<FinanceListModelClass> financeListModelClass = [];

class FinanceListModelClass {
  String totalIncome, totalExpense, id;

  FinanceListModelClass({
    required this.totalIncome,
    required this.totalExpense,
    required this.id,
  });

  factory FinanceListModelClass.fromJson(Map<dynamic, dynamic> json) {
    return FinanceListModelClass(
      totalIncome: json['total_income'],
      totalExpense: json['total_expense'],
      id: json['id'],
    );
  }
}
