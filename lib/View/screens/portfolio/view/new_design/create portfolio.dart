import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path/path.dart' as p;

import '../../../../../Api Helper/Repository/api_client.dart';
import '../../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../../Utilities/Commen Functions/date_picker_function.dart';
import '../../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../../Utilities/CommenClass/commen_txtfield_widget.dart';
import '../../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../../Utilities/global/text_style.dart';
import '../../../../../Utilities/global/variables.dart';
import '../../create_portfolio/api/dio_method.dart';

class CreateAssetScreen extends StatefulWidget {
  String? id;
  bool? isEdit;


  CreateAssetScreen({
    super.key,
    this.id,
    this.isEdit,

  });

  @override
  State<CreateAssetScreen> createState() => _CreateAssetScreenState();
}

class _CreateAssetScreenState extends State<CreateAssetScreen> {
  late ProgressBar progressBar;
  int selectedCard = 0;
  int selectedCardAccount = 0;

  void showProgressBar() {
    progressBar.show(context);
  }
  TextEditingController searchController = TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  DateFormat dateFormat = DateFormat("dd/MM/yyy");





  var types = ['Organization', 'Building', 'Land', 'Share market',  'Rental building'];
  String dropdownValue = 'Organization';
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> preOwned = ValueNotifier(true);
  TextEditingController assetNameController = TextEditingController();

  TextEditingController calenderController = TextEditingController();
  TextEditingController calenderIndexController = TextEditingController();
  TextEditingController shareController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController fieldNameController = TextEditingController();
  TextEditingController value1Controller = TextEditingController();

  @override
  void initState() {
    progressBar = ProgressBar();
    super.initState();



    Future.delayed(const Duration(seconds: 0), ()async {
     await loadInitial();

    });

  }

  String _date = "DD/MM/YYYY";
  String selectedAccountID = "";
  String selectedAccountName = "";

  DateFormat apiDateFormat = DateFormat("y-M-d");
  ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime> dateIndexNotifier = ValueNotifier(DateTime.now());

  loadInitial() {
    preOwned = ValueNotifier(false);
    progressBar = ProgressBar();

    if (widget.isEdit!) {
      imageList.clear();

      loadSingleData();
    } else {

      returnAccountListFrom("");
      DateTime dt = DateTime.now();
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(dt);
      _date = '$formatted';
      calenderController..text = _date;
    }



  }

  returnAccountListFrom(selectedID) async {
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

        setState(() {
          searchAccountListShownFrom = [];
          accountListShownFrom = [];
          accountListFrom = [];

          for (Map user in responseJson) {
            final account = AccountListModel.fromJson(user);
            accountListFrom.add(account);
            accountListShownFrom.add(account);
            searchAccountListShownFrom.add(account);
          }

          if (accountListShownFrom.isNotEmpty) {
            if (widget.isEdit == false) {
              selectedAccountID = accountListShownFrom[0].id;
              selectedAccountName = accountListShownFrom[0].account_name;
            } else {

              int indexToDelete = accountListShownFrom.indexWhere((item) => item.id == selectedID);
              AccountListModel newItem = AccountListModel(
                id: accountListShownFrom[indexToDelete].id,
                account_name: accountListShownFrom[indexToDelete].account_name,
                accounts_id: accountListShownFrom[indexToDelete].accounts_id,
                opening_balance: '0.00',
                account_type: accountListShownFrom[indexToDelete].account_type,
                amount: accountListShownFrom[indexToDelete].amount,
              );


              accountListShownFrom.removeAt(indexToDelete);
              accountListShownFrom.insert(0, newItem);
              setState(() {});
            }
          } else {
            selectedAccountID = "";
            selectedAccountName = "";
          }
        });
      } else {

        setState(() {
          searchAccountListShownFrom = [];
          accountListShownFrom = [];
          accountListFrom = [];
        });
      }
    } catch (e) {

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
        "account_type": [1,2]
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

          searchAccountListShownFrom.clear();
          setStater(() {
            for (Map user in responseJson) {
              searchAccountListShownFrom.add(AccountListModel.fromJson(user));
            }
          });

      }
    } catch (e) {
      print(e.toString());
    }
  }


  String assetTypeID = "0";

  String? getNameFromValue(type, String value) {
    var list = [
      {"value": "0", "name": "Organization"},
      {"value": "1", "name": "Building"},
      {"value": "2", "name": "Land"},
      {"value": "3", "name": "Share market"},
      {"value": "4", "name": "Rental building"},
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

  var addressID = "";
  var detailsID = "";


  loadSingleData() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      progressBar.show(context);
      try {
        var result = await getPortfolioDetails(context: context, portfolioID: widget.id);
        progressBar.hide();
        if (result[0] == 6000) {
          progressBar.hide();
          var data = result[1];

          assetNameController.text = data["asset_name"];

          calenderController.text = "";
          calenderIndexController.text = "";

          var assetDetails  = data["asset_details"]??[];

          if(assetDetails.length !=0){
            shareController.text = roundStringWithOnlyDigit(assetDetails[0]["share"].toString());
            valueController.text = roundStringWithOnlyDigit(assetDetails[0]["value"].toString());
            preOwned.value = assetDetails[0]["pre_owned"]??false;
            detailsID = assetDetails[0]["id"];
            selectedAccountID = assetDetails[0]["from_account"]??"";
          }




          var building = data["address"][0];


          assetTypeID = data["asset_type"];
          dropdownValue =  getNameFromValue(1, data["asset_type"])!;
          buildingNameController.text = building["building_name"];
          landMarkController.text = building["land_mark"];
          addressID = building["id"];
          countryController.text = building["country"]["country_name"];
          cityController.text = building["address_name"];
          stateController.text = building["state"];
          postalCodeController.text = building["pin_code"];
          await returnAccountListFrom(selectedAccountID);
          var img = data["images"] ?? [];

          for (var i = 0; i < img.length; i++) {
            var data = img[i]["image"];
            var imagePath = await fileFromImageUrl(data, ("${extractFileName(img[i]["image"])}$i.png"));
            imageList.add(imagePath);
          }

          setState(() {});
        } else {}
      } catch (e) {
        progressBar.hide();
      }
    });
  }



  String extractFileName(String filePath) {
    return path.basename(filePath);
  }

  final _formKey = GlobalKey<FormState>();

  void hideProgressBar() {
    progressBar.hide();
  }

  @override
  void dispose() {
    progressBar.hide();

    super.dispose();
  }

  var imageList = [];
  final imgPicker = ImagePicker();



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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Asset',
              style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 21.0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                  alignment: Alignment.center,
                  height: mHeight * .05,
                  width: mWidth * .3,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF3F7FC)),
                  child: Text(
                    default_country_name+" - "+countryShortCode,
                    style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),
                  )),
            )



          ],
        ),
      ),
      body: Container(
        height: mHeight,
        color: Colors.white,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              Divider(
                color: Color(0xffE2E2E2),
                thickness: 1,
              ),
              space,
              Row(
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
                          itemCount: imageList.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return returnImageListItem(index);
                          }))
                ],
              ),
              space,
              Container(
                padding: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: assetNameController,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                    validator: (val) {
                      if (val == null || val.isEmpty || val.trim().isEmpty) {
                        return 'This field is required';
                      }

                      return null;
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "Asset Name",
                      hintStyle: customisedStyle(context, Color(0xffA2A2A2), FontWeight.normal, 16.0),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2BAAFC)),
                      ),
                      disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    )),
              ),
              space,
              Container(
                margin: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),

                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(10)),
                height: mHeight * .07,
                child: DropdownButton(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: dropdownValue,
                  items: types.map((String types) {
                    return DropdownMenuItem(
                      value: types,
                      child: Text(types, style: customisedStyle(context, Color(0xff778EB8), FontWeight.w500, 15.0)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      assetTypeID = getNameFromValue(2, dropdownValue)!;
                    });
                  },
                ),
              ),
              space,
              Container(
                padding: EdgeInsets.only(left: mWidth * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: preOwned,
                            builder: (BuildContext context, bool newCheckValue, _) {
                              return Container(
                                  height: mHeight/20,
                                  width: mWidth * .06,
                                  decoration: BoxDecoration(
                                    color: newCheckValue == true ? const Color(0xff067834) : const Color(0xffE6E6E6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Checkbox(
                                      checkColor: const Color(0xffffffff),
                                      activeColor: Colors.transparent,
                                      fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                      value: newCheckValue,
                                      onChanged: (value) {
                                        setState(() {
                                          preOwned.value = !preOwned.value;
                                          selectedAccountID = "";
                                          selectedAccountName = "";
                                        });

                                      }));
                            }),
                        SizedBox(
                          width: mWidth * .02,
                        ),
                        Text(
                          "Pre owned",
                          style: customisedStyle(context, Color(0xff000000), FontWeight.normal, 14.0),
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                        valueListenable: dateNotifier,
                        builder: (BuildContext ctx, dateNewValue, _) {
                          final String formatted = formatter.format(dateNotifier.value);
                          return GestureDetector(
                            onTap: () {
                              showDatePickerFunction(context, dateNotifier);
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * .39,
                                height: MediaQuery.of(context).size.height * .05,
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/svg/calender.svg",color: Color(0xff2BAAFC),),
                                    SizedBox(
                                      width: mWidth * .03,
                                    ),
                                    Text(
                                      dateFormat.format(dateNewValue),
                                    )
                                  ],
                                )),
                          );
                        }),
                  ],
                ),
              ),
              space,
              Container(
                margin: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child:  TextFormField(
                            style: customisedStyle(context,  Color(0xff13213A), FontWeight.normal, 14.0),
                            controller: shareController,
                            onTap: () => shareController.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: shareController.value.text.length),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                            ],

                            focusNode: focusNodeShare,
                            onChanged: (value) {
                              if (value.isNotEmpty) {

                                if(value =="."){

                                }
                                else{
                                  final intValue = double.tryParse(value);
                                  if (intValue != null) {
                                    if (intValue > 100.00) {

                                      shareController.text = '100';
                                      focusNodeShare.unfocus();
                                    }
                                  } else {

                                    shareController.clear();
                                  }
                                }


                              }
                            },
                            textAlign: TextAlign.start,
                            readOnly: false,
                            textInputAction: TextInputAction.done,

                            obscureText: false,

                            decoration:  InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xffF3F7FC)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xffF3F7FC)),
                                ),

                                labelStyle:customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 15.0,),
                                contentPadding: EdgeInsets.all(7),
                                hintText: "Share %",
                                labelText: "Share %",
                                hintStyle:customisedStyle(context, Color(0xff778EB8),FontWeight.normal,15.0) ,
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xffF3F7FC)))),


                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child:  TextFormField(
                            style: customisedStyle(context,  Color(0xff13213A), FontWeight.normal, 14.0),
                            controller: valueController,
                             keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                            ],

                            textAlign: TextAlign.start,
                            readOnly: false,
                            textInputAction: TextInputAction.done,

                            obscureText: false,
                            onTap: () => valueController.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: valueController.value.text.length),
                            decoration:  InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xffF3F7FC)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xffF3F7FC)),
                                ),

                                labelStyle:customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 15.0,),
                                contentPadding: EdgeInsets.all(7),
                                hintText: "Value",
                                labelText: "Value",
                                hintStyle:customisedStyle(context, Color(0xff778EB8),FontWeight.normal,15.0) ,
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xffF3F7FC)))),

                  ],
                ),
              ),
              space,

              preOwned.value ==false?
              Container(
                margin: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account',
                      style: customisedStyle(context, Colors.black, FontWeight.w500, 17.0),
                    ),
                    IconButton(
                      onPressed: () {
                        accountBtmSheet(context,selectedAccountID);
                      },
                      icon: SvgPicture.asset(
                        "assets/menu/search-normal.svg",color: Color(0xff2BAAFC),
                      ),
                    )
                  ],
                ),
              ):Container(),
              preOwned.value ==false? accountListShownFrom.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 15),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: accountListShownFrom.length > 4 ? 4 : accountListShownFrom.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 40,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAccountID = accountListShownFrom[index].id;
                                  selectedAccountName = accountListShownFrom[index].account_name;
                                });
                              },
                              child: Container(
                                height: mHeight * .01,

                                decoration: BoxDecoration(
                                    color: selectedAccountID == accountListShownFrom[index].id ? Color(0xff2BAAFC) : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Color(0xffD6E0F6))),
                                child: Row(
                                   children: [
                                    SizedBox(
                                      width: mWidth * .03,
                                    ),
                                     SizedBox(
                                      width: mWidth * .03,
                                    ),
                                    Expanded(
                                      child: Text(
                                        accountListShownFrom[index].account_name,
                                        style: customisedStyle(
                                            context,
                                            selectedAccountID == accountListShownFrom[index].id ? Colors.white : Colors.black,
                                            FontWeight.normal,
                                            14.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mWidth * .06,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  : Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 18),
                      child: Container(
                        child: Center(child: Text("No Items", style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0))),
                      ),
                    ):Container(),

              space,
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                child: Text(
                  "Address",
                  style: customisedStyle(context, Colors.black, FontWeight.w500, 17.0),
                ),
              ),
              space,
              Container(
                margin: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
                child: Column(
                  children: [
                    CommenTextFieldWidget(
                      controller: buildingNameController,

                      hintText: 'Building No/Name',
                      textInputType: TextInputType.name,
                      textAlign: TextAlign.start,
                      readOnly: false,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                    ),
                    space,
                    CommenTextFieldWidget(
                      controller: landMarkController,
                      hintText: 'Landmark',
                      textInputType: TextInputType.name,
                      textAlign: TextAlign.start,
                      readOnly: false,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                    ),
                    space,
                    CommenTextFieldWidget(
                      controller: cityController,
                      hintText: 'City',
                      textInputType: TextInputType.name,
                      textAlign: TextAlign.start,
                      readOnly: false,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                    ),
                    space,
                    CommenTextFieldWidget(
                      controller: stateController,
                      hintText: 'State/Province',
                      textInputType: TextInputType.name,
                      textAlign: TextAlign.start,
                      readOnly: false,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                    ),
                    space,
                    CommenTextFieldWidget(
                      controller: postalCodeController,
                      hintText: 'Postal Code',
                      textInputType: TextInputType.number,
                      textAlign: TextAlign.start,
                      readOnly: false,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mHeight * .1,
              ),
            ]),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        child: SvgPicture.asset('assets/svg/save.svg'),
        onTap: () async {



      if (formKey.currentState!.validate()) {
        var netWork = await checkNetwork();
        if (netWork) {
          if (!mounted) return;

          try {

            bool permission = returnValidation();
            if(permission){

              progressBar.show(context);

              var assetDetailsList;

              var addressDetails = {
                "id": addressID,
                "address_name": cityController.text == "" ? "" : cityController.text,
                "building_name": buildingNameController.text,
                "land_mark": landMarkController.text == "" ? "" : landMarkController.text,
                "state": stateController.text == "" ? "" : stateController.text,
                "pin_code": postalCodeController.text == "" ? "" : postalCodeController.text,
              };

              var value = '0';
              var share = '0';

              if(shareController.text !=""){
                share = shareController.text;
              }

              if(valueController.text !=""){
                value = valueController.text;
              }

              if(widget.isEdit==true){

                assetDetailsList =  [{
                  "id":detailsID,
                  "as_on_date": apiDateFormat.format(dateNotifier.value),
                  "share": share,
                  "value": value,
                  "pre_owned": preOwned.value,
                  "from_account": selectedAccountID,
                }];
              }
              else{

                assetDetailsList =  {
                  "id":"",
                  "as_on_date": apiDateFormat.format(dateNotifier.value),
                  "share": share,
                  "value": value,
                  "pre_owned": preOwned.value,
                  "from_account": selectedAccountID,
                };
              }


              var res = await cratePortFolio(
                type: widget.isEdit!,
                id: widget.id,
                address_details: addressDetails,
                date: apiDateFormat.format(dateNotifier.value),
                total_share: share,
                asset_type: int.parse(assetTypeID),
                total_value: value,
                asset_name: assetNameController.text,
                asset_details: assetDetailsList,
                CustomProperties: [],
                images: imageList,
                documents: [],
              );
              progressBar.hide();
              if (res[0] == 6000) {
                Navigator.pop(context);

              } else {
                progressBar.hide();
                msgBtmDialogueFunction(context: context, textMsg: res[1]);
              }
            }
            else{
              msgBtmDialogueFunction(context: context, textMsg:"select account");

            }




          } catch (e) {
            progressBar.hide();
          }
        } else {
          if (!mounted) return;
          msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
        }
      }
        },
      ),
    );
  }


  final FocusNode focusNodeShare = FocusNode();
  final FocusNode focusNodeValue = FocusNode();
returnValidation(){
  if(preOwned.value ==false){
    if(selectedAccountID ==""){
      return false;
    }
    else{
      return true;
    }

  }
  else{
    return true;
  }
}


  returnImageListItem(index) {
    if (imageList.isEmpty) {
      return GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 7,
          decoration:
              BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(13), border: Border.all(color: Colors.white, width: 2)),
          child: Center(
            child: GestureDetector(
              child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    openCamera(index);
                  }),
              onTap: () {
                openCamera(index);
              },
            ),
          ),
        ),
      );
    } else {
      if (index == imageList.length) {
        return GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 7,
            decoration:
                BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(13), border: Border.all(color: Colors.white, width: 1)),
            child: Center(
              child: GestureDetector(
                child: IconButton(
                    icon: Icon(Icons.add),

                    onPressed: () {
                      openCamera(index);
                    }),
                onTap: () {
                  openCamera(index);
                },
              ),
            ),
          ),
        );
      } else {
        return displayImage(imageList[index],index);
      }
    }
  }

  void openCamera(index) async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.gallery);

    if (imgCamera != null) {
      if (imgCamera.path != "") {
        setState(() {
          imageList.add(imgCamera.path);
        });
      }

    }
  }

  Widget displayImage(imagePath,index) {
    if (imagePath == null) {
      return const Text("No Image Selected!");
    } else {
      var imgFile = File(imagePath);

      return GestureDetector(
        onLongPress: ()async{
          return await btmDialogueFunction(
              isDismissible: true,
              context: context,
              textMsg: 'Remove this image ?',
              fistBtnOnPressed: () {
                Navigator.of(context).pop(false);
              },
              secondBtnPressed: () async {
                Navigator.of(context).pop(true);
                imageList.removeAt(index);

                setState(() {

                });


              },
              secondBtnText: 'Remove');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13.0),
          child: Image.file(
            imgFile,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 8,
          ),
        ),
      );
    }
  }

  accountBtmSheet(context, String selectedCardAccount) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStater) {
            return Container(
              color: Colors.white,
              height: mHeight * .7,
              child: Center(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    SizedBox(
                      height: mHeight * .02,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                              color: Color(0xff2BAAFC),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(color: const Color(0xffF6F6F6), borderRadius: BorderRadius.circular(20)),
                            height: mHeight * .06,
                            width: mWidth * .8,
                            child: Center(
                              child: TextField(
                                controller: searchController,
                                onChanged: (val) {

                                  setStater(() {
                                    searchAccountListApi(val, setStater);
                                  });
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: mHeight * .015),
                                    hintText: 'Search',
                                    helperStyle: customisedStyle(context, Color(0xff929292), FontWeight.normal, 15.0),
                                    prefixIcon: Icon(Icons.search),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mHeight * .02),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 10000, minHeight: 0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount:searchAccountListShownFrom.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 40,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  searchController.clear();
                                    AccountListModel newItem = AccountListModel(
                                      id: searchAccountListShownFrom[index].id,
                                      account_name: searchAccountListShownFrom[index].account_name,
                                      accounts_id: searchAccountListShownFrom[index].accounts_id,
                                      opening_balance: '0.00',
                                      account_type: searchAccountListShownFrom[index].account_type,
                                      amount: searchAccountListShownFrom[index].amount,
                                    );

                                    selectedAccountID = searchAccountListShownFrom[index].id;
                                    selectedAccountName = searchAccountListShownFrom[index].account_name;

                                    bool exists = isItemWithIdExists(searchAccountListShownFrom[index].id);
                                    if (exists) {
                                      int indexToDelete = accountListShownFrom.indexWhere((item) => item.id == searchAccountListShownFrom[index].id);
                                      accountListShownFrom.removeAt(indexToDelete);
                                    }
                                    accountListShownFrom.insert(0, newItem);
                                    searchAccountListShownFrom = accountListFrom;


                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  height: mHeight * .01,

                                  decoration: BoxDecoration(
                                      color:selectedCardAccount == searchAccountListShownFrom[index].id ? Color(0xff2BAAFC) : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffD6E0F6)))

                                  ,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          searchAccountListShownFrom[index].account_name,
                                          style: customisedStyle(
                                              context,
                                              selectedCardAccount == searchAccountListShownFrom[index].id ? Colors.white : Colors.black,
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
                      height: mHeight * .19,
                    ),
                    Divider(
                      color: Color(0xffE2E2E2),
                      thickness: 1,
                    ),
                    Center(
                      child: Text(
                        'Accounts',
                        style: customisedStyle(context, Colors.black, FontWeight.normal, 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
      });
    });
  }

  bool isItemWithIdExists(String id) {

      return accountListShownFrom.any((item) => item.id == id);


  }

}


List<AccountListModel> searchAccountListShownFrom = [];
List<AccountListModel> accountListShownFrom = [];
List<AccountListModel> accountListFrom = [];

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
