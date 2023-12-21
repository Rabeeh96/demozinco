import 'dart:convert';
import 'dart:io';
import 'package:cuentaguestor_edit/View/screens/login/login_new_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lean_file_picker/lean_file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Api Helper/Bloc/Profile/profile_bloc.dart';
import '../Api Helper/Bloc/Settings/settings_bloc.dart';
import '../Api Helper/ModelClasses/Settings/SettingsModelClass.dart';
import '../Api Helper/ModelClasses/Settings/changeRoundimgModelClass.dart';
import '../Api Helper/Repository/api_client.dart';
import '../Api Helper/Repository/save.dart';
import '../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../Utilities/Commen Functions/internet_connection_checker.dart';
import '../Utilities/Commen Functions/logout_bottomsheet_function.dart';
import '../Utilities/CommenClass/camera_screen.dart';
import '../Utilities/CommenClass/commen_txtfield_widget.dart';
import '../Utilities/CommenClass/custom_overlay_loader.dart';
import '../Utilities/global/text_style.dart';
import '../Utilities/global/variables.dart';
import 'screens/settings/Delete_account/delete_account.dart';
import 'screens/settings/profile_edit_btmsheet/profile_edit_bottomsheet.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SettingsModelClass settingsModelClass;
  ProfileBottomSheetClass profileBottomSheetClass = ProfileBottomSheetClass();
  File? imgFile;
  final imgPicker = ImagePicker();
  var photo = "";
  String defaultCountry = "";
  bool imageSelect = false;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    progressBar = ProgressBar();
    SettingsApiFunction();
  }

  int selectedValue = 1;
  String? selectedValues;

  profilePhotoUpdate(File img, organizationId) async {
    final preference = await SharedPreferences.getInstance();
    final country_id = preference.getString("country_id");
    final token = preference.getString('token');
    final String path = "settings/change-settings/";
    String url = ApiClient.basePath + path;
    var headers = {"authorization": "Bearer $token", 'Cookie': 'csrftoken=dWGY5oYor10HDDuy7vCDdr65oeBwDU1K'};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({'organization': organizationId,'country_id': country_id!, 'type': 'photo'});
    request.files.add(await http.MultipartFile.fromPath('value', img.path));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {}
  }



  String dropdownvalue = '1';
  String dayDropDownValue = '1 day';
  String currencyDropDown = '###,###,##0.';

  SettingsApiFunction() async {
    var netWork = await checkNetwork();
    final preference = await SharedPreferences.getInstance();
    defaultCountry = preference.getString('default_country') ?? "India";
    dropdownvalue = (preference.getInt("rounding_value") ?? 1).toString();
    currencyDropDown = (preference.getString("currency_format") ?? '###,###,##0.').toString();
    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<SettingsBloc>(context).add(FetchSettingsDetailEvent());
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  var items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  var days = [
    '1 day',
    '2 day',
    '3 day',
    '4 day',
    '5 day',
    '6 day',
    '7 day',
  ];
  var currencies = [
    '###,###,##0.',
    '##,##,##0.',
  ];

  late ChangeRoundimgModelClass changeRoundingModelClass;

  changeRoundingValue(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rounding_figure = value;
    prefs.setInt("rounding_value", value);
    addZerosToCurrencyFormat(currencyFormat);
  }

  changeCurrencyValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currencyFormat = value;
    prefs.setString("currency_format", value);
    addZerosToCurrencyFormat(currencyFormat);
  }

  updateShared(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, value);
  }

  addZerosToCurrencyFormat(String currencyFormat) {
    if (rounding_figure < 1) {
      rounding_figure = 1;
    }
    String zeros = '0' * rounding_figure;
    numberFormat2 = currencyFormat;
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(height: mHeight * .01);
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ChangeIsNotificationLoading) {
              const CircularProgressIndicator();
            }
            if (state is ChangeIsNotificationLoaded) {
              SettingsApiFunction();
            }
            if (state is ChangeIsNotificationError) {
              const Text("Something went wrong");
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ChangeIszakathLoading) {
              const CircularProgressIndicator();
            }
            if (state is ChangeIszakathLoaded) {
              SettingsApiFunction();
            }
            if (state is ChangeIszakathError) {
              const Text("Something went wrong");
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ChangeIsinterestLoading) {
              const CircularProgressIndicator();
            }
            if (state is ChangeIsinterestLoaded) {
              SettingsApiFunction();
            }
            if (state is ChangeIsinterestError) {
              const Text("Something went wrong");
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ChangeRoundingLoading) {
              const CircularProgressIndicator();
            }
            if (state is ChangeRoundingLoaded) {
              changeRoundingValue((int.parse(dropdownvalue)));
              SettingsApiFunction();
            }
            if (state is ChangeRoundingError) {
              const Text("Something went wrong");
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ChangeProfilePicLoading) {
              const CircularProgressIndicator();
            }
            if (state is ChangeProfilePicLoaded) {
              SettingsApiFunction();
            }
            if (state is ChangeProfilePicError) {
              const Text("Something went wrong");
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 11,

          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          elevation: 1,
          title: Text(
            'Settings',
            style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 22.0),
          ),
          actions: [
            Container(
                padding: EdgeInsets.all(15),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, (MaterialPageRoute(builder: (context) =>  DeleteAccount())));
                   //   Navigator.push(context, (MaterialPageRoute(builder: (context) => ListContactPageGragable())));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Delete Account",
                          style: customisedStyle(context, Color(0xffFF0000), FontWeight.normal, 13.0),
                        ),
                        Icon(
                          Icons.delete,
                          color: Color(0xffFF0000),
                        )
                      ],
                    ))),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsDetailLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff5728C4),
                  ),
                );
              }
              if (state is SettingsDetailLoaded) {
                settingsModelClass = BlocProvider.of<SettingsBloc>(context).settingsModelClass;

                final ValueNotifier<bool> notificationIsOnNotifier = ValueNotifier(settingsModelClass.data!.isReminder!);
                final ValueNotifier<bool> ZakathIsOnNotifier = ValueNotifier(settingsModelClass.data!.isZakath!);

                final ValueNotifier<bool> biometricIsOnNotifier = ValueNotifier(true);
                final ValueNotifier<bool> interestIsOnNotifier = ValueNotifier(settingsModelClass.data!.isInterest!);

                updateShared('is_zakath', settingsModelClass.data!.isZakath!);
                updateShared('is_intrest', settingsModelClass.data!.isInterest!);
                dropdownvalue = (settingsModelClass.data!.rounding!).toString();



                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color(0xffF3F7FC)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: mWidth * .06,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    final result = await Navigator.push(context, (MaterialPageRoute(builder: (context) => const CameraScreen())));

                                    setState(() {
                                      imageFile = result;
                                    });
                                    var netWork = await checkNetwork();
                                    if (netWork) {
                                      if (!mounted) return;

                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      final organizationId = prefs.getString("organisation");
                                      var netWork = await checkNetwork();

                                      if (netWork) {
                                        profilePhotoUpdate(imageFile!, organizationId!);
                                      } else {
                                        msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                      }
                                    } else {
                                      if (!mounted) return;
                                      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                    }
                                  },
                                  child: imageFile == null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 50,
                                          child: settingsModelClass.data!.profiles!.photo!.isEmpty
                                              ? Icon(
                                                  Icons.add,
                                                  color: Colors.grey,
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 50,
                                                  backgroundImage: NetworkImage(ApiClient.imageBasePath + settingsModelClass.data!.profiles!.photo!),
                                                ))
                                      : CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 50,
                                          backgroundImage: FileImage(imageFile!),
                                        )),
                              SizedBox(
                                width: mWidth * .03,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: mWidth * .03),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: mWidth * .45,
                                          height: mHeight * .03,
                                          child: Text(
                                            settingsModelClass.data!.profiles!.firstName!.isNotEmpty
                                                ? settingsModelClass.data!.profiles!.firstName!
                                                : "",
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(context, Colors.black, FontWeight.w600, 17.0),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              profileBottomSheetClass.profileModelBottomSheet(
                                                  type: 'Name', context: context, data: settingsModelClass.data!.profiles!.firstName!);
                                            },
                                            child: SvgPicture.asset("assets/svg/edit-solid.svg"))
                                      ],
                                    ),

                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: mWidth * .45,
                                          height: mHeight * .03,
                                          child: Text(
                                            settingsModelClass.data!.profiles!.email!.isNotEmpty ? settingsModelClass.data!.profiles!.email! : "",
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(context, Color(0xff08640B), FontWeight.normal, 12.0),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              profileBottomSheetClass.profileModelBottomSheet(
                                                  type: 'email', context: context, data: settingsModelClass.data!.profiles!.email!);
                                            },
                                            child: SvgPicture.asset("assets/svg/edit-solid.svg"))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        profileBottomSheetClass.passwordModelBottomSheet(
                                            context: context, UserName: settingsModelClass.data!.profiles!.username!);
                                      },
                                      child: Text(
                                        "Change Password",
                                        style: customisedStyle(context, Color(0xff007BF9), FontWeight.normal, 13.0),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(),
                        Container(
                          height: mHeight * .06,
                          decoration: BoxDecoration(color: Color(0xff083971), borderRadius: BorderRadius.circular(4)),
                          child: TextButton(
                            onPressed: () {
                              bottomDialogueFunction(
                                  isDismissible: true,
                                  context: context,
                                  textMsg: 'Are you sure Logout ?',
                                  fistBtnOnPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  secondBtnPressed: () async {
                                    SharedPreferences preference = await SharedPreferences.getInstance();
                                    preference.clear();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => NewLoginScreen(),
                                        ),
                                        (route) => false);
                                  },
                                  secondBtnText: 'Yes');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.login_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Log out",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: mHeight * .02,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ValueListenableBuilder(
                                valueListenable: notificationIsOnNotifier,
                                builder: (BuildContext context, bool notificationIsOnValue, _) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        FlutterSwitch(
                                          width: 29.0,
                                          height: 15.0,
                                          valueFontSize: 20.0,
                                          toggleSize: 13.0,
                                          value: notificationIsOnNotifier.value,
                                          borderRadius: 20.0,
                                          padding: 1.0,
                                          activeColor: const Color(0xff0073D8),
                                          activeTextColor: Colors.green,
                                          inactiveTextColor: Colors.grey,
                                          inactiveColor: Colors.grey,
                                          onToggle: (val) async {
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            final organizationId = prefs.getString("organisation");
                                            notificationIsOnNotifier.value = !notificationIsOnNotifier.value;
                                            var netWork = await checkNetwork();
                                            if (netWork) {
                                              return BlocProvider.of<ProfileBloc>(context).add(FetchChangeIsNotification(
                                                  organisation: organizationId!, IsNotification: notificationIsOnNotifier.value));
                                            } else {
                                              msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: mWidth * .04,
                                        ),
                                        Text("Notification", style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0))
                                      ],
                                    ),
                                  );
                                }),
                            DropdownButton(
                              underline: Container(
                                height: 0,
                              ),
                              icon: null,
                              value: dayDropDownValue,
                              items: days.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items + "",
                                    style: customisedStyle(context, Colors.grey, FontWeight.normal, 13.0),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                setState(() {
                                  dayDropDownValue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),



                        space,
                        Container(
                          height: MediaQuery.of(context).size.height / 18,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xffDEDEDE), width: .5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Zakah",
                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: ZakathIsOnNotifier,
                                    builder: (BuildContext context, bool zakathIsOnValue, _) {
                                      return FlutterSwitch(
                                        width: 29.0,
                                        height: 15.0,
                                        valueFontSize: 20.0,
                                        toggleSize: 13.0,
                                        value: ZakathIsOnNotifier.value,
                                        borderRadius: 20.0,
                                        padding: 1.0,
                                        activeColor: const Color(0xff0073D8),
                                        activeTextColor: Colors.green,
                                        inactiveTextColor: Colors.grey,
                                        inactiveColor: Colors.grey,
                                        onToggle: (val) async {
                                          ZakathIsOnNotifier.value = !ZakathIsOnNotifier.value;
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          final organizationId = prefs.getString("organisation");

                                          var netWork = await checkNetwork();
                                          if (netWork) {
                                            return BlocProvider.of<ProfileBloc>(context)
                                                .add(FetchChangeIsZakath(organisation: organizationId!, IsZakath: ZakathIsOnNotifier.value));
                                          } else {
                                            msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                          }
                                        },
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                        space,
                        Container(
                          height: MediaQuery.of(context).size.height / 18,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xffDEDEDE), width: .5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Interest",
                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: interestIsOnNotifier,
                                    builder: (BuildContext context, bool notificationIsOnValue, _) {
                                      return FlutterSwitch(
                                        width: 29.0,
                                        height: 15.0,
                                        valueFontSize: 20.0,
                                        toggleSize: 13.0,
                                        value: interestIsOnNotifier.value,
                                        borderRadius: 20.0,
                                        padding: 1.0,
                                        activeColor: const Color(0xff0073D8),
                                        activeTextColor: Colors.green,
                                        inactiveTextColor: Colors.grey,
                                        inactiveColor: Colors.grey,
                                        onToggle: (val) async {
                                          interestIsOnNotifier.value = !interestIsOnNotifier.value;
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          final organizationId = prefs.getString("organisation");

                                          var netWork = await checkNetwork();
                                          if (netWork) {
                                            return BlocProvider.of<ProfileBloc>(context)
                                                .add(FetchChangeIsInterest(organisation: organizationId!, IsInterest: interestIsOnNotifier.value));
                                          } else {
                                            msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                          }
                                        },
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),

                        space,
                        Container(
                          height: MediaQuery.of(context).size.height / 18,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xffDEDEDE), width: .5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rounding",
                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                ),
                                Row(
                                  children: [
                                    DropdownButton(
                                      underline: Container(
                                        height: 0,
                                      ),
                                      icon: null,
                                      value: dropdownvalue,
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items + "  Digits",
                                            style: customisedStyle(context, Colors.grey, FontWeight.normal, 13.0),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) async {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });

                                        var netWork = await checkNetwork();
                                        if (netWork) {
                                          return updateRoundingValue(newValue);
    } else {
                                          msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                        }
                                      },
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        space,

                        Container(
                          height: MediaQuery.of(context).size.height / 18,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xffDEDEDE), width: .5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Currency Format",
                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                                ),
                                Row(
                                  children: [
                                    DropdownButton(
                                      underline: Container(
                                        height: 0,
                                      ),
                                      icon: null,
                                      value: currencyDropDown,
                                      items: currencies.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: customisedStyle(context, Colors.grey, FontWeight.normal, 13.0),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) async {
                                        setState(() {
                                          currencyDropDown = newValue!;
                                          changeCurrencyValue(newValue);
                                        });
                                      },
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        space,

                      ],
                    ),
                  ),
                );
              }
              if (state is SettingsDetailError) {
                return Center(
                    child: Text(
                  "Something went wrong",
                  style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                ));
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

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

  updateRoundingValue(roundingValue) async {
    try {
      showProgressBar();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = ApiClient.basePath;
      var accessToken = prefs.getString('token') ?? '';
      final organizationId = prefs.getString("organisation");
      final url = baseUrl + 'settings/change-settings/';
      final country_id = prefs.getString("country_id");

      Map data = {"organization": organizationId, "type": "rounding", "country_id": country_id, "value": roundingValue};
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          },
          body: body);
      Map n = json.decode(utf8.decode(response.bodyBytes));
      var statusCode = n["StatusCode"];

      if (statusCode == 6000) {
        setState(() {
          dropdownvalue = roundingValue;
        });
        hideProgressBar();

        changeRoundingValue(int.parse(roundingValue));
        SettingsApiFunction();
      } else {
        hideProgressBar();
      }
    } catch (e) {
      hideProgressBar();
      print(e.toString());
    }
  }

  addPropertyBtmSheet({required context, required String id}) {
    final formKey = GlobalKey<FormState>();

    TextEditingController propertyNameController = TextEditingController();

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
                    margin: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06),
                    decoration: BoxDecoration(color: Color(0xffF3F7FC), borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width * .88,
                    child: BottomSheetTextfeild(
                      onTap: () {
                        alterItem(1, 0);
                      },
                      controller: propertyNameController,
                      hintText: 'Pick file',
                      textInputType: TextInputType.name,
                      textAlign: TextAlign.start,
                      readOnly: true,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                    )),
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
                        'Add Douments',
                        style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            var netWork = await checkNetwork();

                            if (netWork) {
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
        );
      },
    );
  }

  var fileList = [];

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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var basePath = ApiClient.basePath;
    final organizationId = prefs.getString("organisation");
    final token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie': 'csrftoken=pDlni6xLaHEpMDmxAucCWYOG8lWA6LUMwgJquwOVwuHNI5tXNv5fg0zCAoke4Cdg; sessionid=jexiiec5tdb5rk11fs0jkmr3433xez78'
    };

    String url = '';

    url = basePath + 'assets/add-document/';
    if (type) {
      url = basePath + 'assets/add-document/';
    }

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({'organization': organizationId!, 'asset_master_id': '3202f623-8d0e-4956-8689-7a4c6792c9b7'});
    request.files.add(await http.MultipartFile.fromPath('documents', filePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {}
  }
}

class SettingsItems extends StatelessWidget {
  SettingsItems({super.key, required this.context, required this.onTap, required this.itemsName, this.text});

  final BuildContext context;
  final void Function() onTap;
  final String itemsName;
  String? text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 18,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xffDEDEDE), width: .5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemsName,
                style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
              ),
              Row(
                children: [
                  Text(
                    text != null ? text! : "",
                    style: customisedStyle(context, Colors.grey, FontWeight.normal, 13.0),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
