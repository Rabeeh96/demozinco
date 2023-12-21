import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Account/account_bloc.dart';
import '../../../../Api Helper/ModelClasses/Settings/Account/DeleteAccountModelClass.dart';
import '../../../../Api Helper/ModelClasses/Settings/Account/DetailAccountModelClass.dart';
import '../../../../Api Helper/ModelClasses/Settings/Account/ListAccountModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/CommenClass/search_commen_class.dart';
import '../../../../Utilities/global/custom_class.dart';
import '../../../../Utilities/global/text_style.dart';
import 'add_account.dart';
import 'countrylist.dart';

class ListAccount extends StatefulWidget {
  const ListAccount({Key? key}) : super(key: key);

  @override
  State<ListAccount> createState() => _ListAccountState();
}

class _ListAccountState extends State<ListAccount> {
  TextEditingController searchController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  late ListAccountModelClass listAccountModelClass;

  String countryID = "";
  TextEditingController countryController = TextEditingController();

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
    super.initState();
    listAccountApiFunction();
  }

  late int demoValue;

  listAccountApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<AccountBloc>(context)
          .add(ListAccountEvent(organisation: organizationId!, page_number: 1, page_size: 50, search: '', country: '', type: [1, 2, 3, 4]));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  ValueNotifier valueNotifier = ValueNotifier(2);
  late String id = "";
  DateFormat dateFormat = DateFormat("dd/MM/yyy");

  deleteCountryApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<AccountBloc>(context).add(DeleteAccountEvent(id: id, organisation: organizationId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  String convertDateFormat(String inputDate) {
    DateTime date = DateTime.parse(inputDate);

    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(date);

    return formattedDate;
  }

  String getNameFromValue(type, String value) {
    var list = [
      {"value": "0", "name": "Contact"},
      {"value": "1", "name": "Cash"},
      {"value": "2", "name": "Bank"},
      {"value": "3", "name": "Income"},
      {"value": "4", "name": "Expense"},
      {"value": "5", "name": "Suspense"},
      {"value": "6", "name": "Asset"},
      {"value": "7", "name": "Loan give"},
      {"value": "8", "name": "Loan take"},
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

  detailCountryApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<AccountBloc>(context).add(DetailAccountEvent(id: id, organisation: organizationId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  late DeleteAccountModelClass deleteAccountModelClass;
  late DetailAccountModelClass detailAccountModelClass;

  ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime.now());

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) async {
            if (state is DetailAccountLoaded) {
              hideProgressBar();
              detailAccountModelClass = BlocProvider.of<AccountBloc>(context).detailAccountModelClass;
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateAndEditAccountScreen(
                            type: 'Edit',
                            id: id,
                            organisation: detailAccountModelClass.data!.organization,
                            accountName: detailAccountModelClass.data!.accountName,
                            openingBalance: roundStringWith(detailAccountModelClass.data!.openingBalance.toString()),
                            country: detailAccountModelClass.data!.country!.countryName,
                            accountType: int.parse(detailAccountModelClass.data!.accountType!),
                            currency: detailAccountModelClass.data!.country!.currencyName,
                            date: detailAccountModelClass.data!.asOnDate,
                            countryId: detailAccountModelClass.data!.country!.id,
                          )));
              print("++++++++))))))))))**************${listAccountModelClass.data!.first.amount!}");
              print("))))))))))))))))))))))))))))))))))))))))${listAccountModelClass.data!.first.accountName!}");

              listAccountApiFunction();
            }
            if (state is DetailAccountError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is DeleteAccountLoading) {
              const CircularProgressIndicator(
                color: Color(0xff5728C4),
              );
            }
            if (state is DeleteAccountLoaded) {
              hideProgressBar();

              listAccountApiFunction();
              deleteAccountModelClass = BlocProvider.of<AccountBloc>(context).deleteAccountModelClass;
              if (deleteAccountModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(context: context, textMsg: deleteAccountModelClass.data!);
              }
            }
            if (state is DeleteAccountError) {
              hideProgressBar();
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
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
          title: Text('Accounts', style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 22.0)),
          actions: [
            IconButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  final organizationId = prefs.getString("organisation");

                  final result = await filterBottomsheet(context: context);

                  result != null ? demoValue = result[0] : Null;
                  result != null ? countryController.text = result[1] : Null;
                  if (listAccountModelClass.statusCode == 6000) {
                    BlocProvider.of<AccountBloc>(context).add(ListAccountEvent(
                        organisation: organizationId!, page_number: 1, page_size: 20, search: "", country: countryController.text, type: demoValue));
                  }
                  if (listAccountModelClass.statusCode == 6001) {
                    alreadyCreateBtmDialogueFunction(
                        context: context,
                        textMsg: "Not Found",
                        buttonOnPressed: () {
                          Navigator.of(context).pop(true);
                          listAccountApiFunction();
                        });
                  }
                },
                icon: SvgPicture.asset("assets/svg/filter.svg")),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
          height: mHeight,
          child: Column(
            children: [
              SizedBox(height: mHeight * .02),
              SearchFieldWidget(
                autoFocus: false,
                mHeight: mHeight,
                hintText: 'Search',
                controller: searchController,
                onChanged: (quary) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  final organizationId = prefs.getString("organisation");

                  if (quary.isNotEmpty) {
                    BlocProvider.of<AccountBloc>(context).add(ListAccountEvent(
                        organisation: organizationId!, page_number: 1, page_size: 40, search: quary, country: '', type: [1, 2, 3, 4]));
                  } else {
                    BlocProvider.of<AccountBloc>(context).add(
                        ListAccountEvent(organisation: organizationId!, page_number: 1, page_size: 40, search: '', country: '', type: [1, 2, 3, 4]));
                  }
                },
              ),

              SizedBox(height: mHeight * .01),
              Container(
                child: BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    if (state is ListAccountLoading) {
                      return CircularProgressIndicator(
                        color: Color(0xff5728C4),
                      );
                    }
                    if (state is ListAccountLoaded) {
                      listAccountModelClass = BlocProvider.of<AccountBloc>(context).listAccountModelClass;

                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [

                            listAccountModelClass.statusCode ==6000?
                            listAccountModelClass.data!.isNotEmpty
                                ? ListView.builder(
                                    padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 80),
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: listAccountModelClass.data!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(

                                        child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(color: Color(0xffDEDEDE), width: 1), borderRadius: BorderRadius.circular(1)),
                                            tileColor: const Color(0xffFFFFFF),
                                            title: Container(
                                              width: mWidth * .02,
                                              margin: EdgeInsets.only(top: mHeight * .01),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: mWidth * .3,
                                                    child: Text(getNameFromValue(1, listAccountModelClass.data![index].accountType!),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: customisedStyle(context, Color(0xff8D8D8D), FontWeight.normal, 13.0)),
                                                  ),
                                                  listAccountModelClass.data![index].country!.countryName != ""
                                                      ? Container(
                                                          child: Text(listAccountModelClass.data![index].country!.countryName ?? "",
                                                              overflow: TextOverflow.ellipsis,
                                                              style: customisedStyle(context, Color(0xff4C6584), FontWeight.normal, 13.0)),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: mWidth * .3,
                                                      child: Text(listAccountModelClass.data![index].accountName!,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0)),
                                                    ),
                                                    listAccountModelClass.data![index].country!.countryCode != ""
                                                        ? Container(
                                                            child: Text(listAccountModelClass.data![index].country!.countryCode ?? '',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.normal, 13.0)),
                                                          )
                                                        : SizedBox()
                                                  ],
                                                ),
                                                Container(
                                                  height: 5,
                                                ),
                                                listAccountModelClass.data![index].amount!.isNotEmpty? Container(
                                                  width: mWidth * .8,
                                                  child: Text(
                                                      listAccountModelClass.data![index].country!.currency_simbol! + " " + roundStringWith(listAccountModelClass.data![index].amount!),
                                                      style: customisedStyle(context, Colors.black, FontWeight.w500, 12.0)),
                                                ):SizedBox(),
                                                Row(
                                                  children: [
                                                    Text("As if on  ",
                                                        style: customisedStyle(context, Color(0xff2BAAFC), FontWeight.normal, 13.0)),
                                                    Text(
                                                        listAccountModelClass.data![index].asOnDate!.isNotEmpty
                                                            ? convertDateFormat(listAccountModelClass.data![index].asOnDate!)
                                                            : "",
                                                        style: customisedStyle(context, Colors.black, FontWeight.normal, 12.0)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            trailing: PopupMenuButton<String>(
                                              icon: SvgPicture.asset("assets/svg/options.svg"),
                                              itemBuilder: (BuildContext context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text('Edit'),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text('Delete'),
                                                  ),
                                                ];
                                              },
                                              onSelected: (String value) {
                                                if (value == 'edit') {
                                                  id = listAccountModelClass.data![index].id!;
                                                  detailCountryApiFunction();
                                                } else if (value == 'delete') {
                                                  btmDialogueFunction(
                                                      isDismissible: true,
                                                      context: context,
                                                      textMsg: 'Are you sure delete ?',
                                                      fistBtnOnPressed: () {
                                                        Navigator.of(context).pop(true);
                                                      },
                                                      secondBtnPressed: () async {
                                                        id = listAccountModelClass.data![index].id!;
                                                        deleteCountryApiFunction();
                                                        Navigator.of(context).pop(true);
                                                      },
                                                      secondBtnText: 'Yes');

                                                }
                                              },
                                            )),
                                      );
                                    })
                                : SizedBox(
                                    height: mHeight * .7,
                                    child: const Center(
                                        child: Text(
                                      "Items not found !",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ))):SizedBox(
                                height: mHeight * .7,
                                child: const Center(
                                    child: Text(
                                      "Items not found !",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )))
                          ],
                        ),
                      );
                    }
                    if (state is ListAccountError) {
                      return Center(
                          child: Text(
                        "Something went wrong",
                        style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                      ));
                    }

                    return const Center(
                      child: SizedBox(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: GestureDetector(
          child: SvgPicture.asset('assets/svg/add_circle.svg'),
          onTap: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateAndEditAccountScreen(
                      type: 'Create',
                    )));
            listAccountApiFunction();
          },
        ),
      ),
    );
  }

  filterBottomsheet({required BuildContext context}) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    var items = ['Contact', 'Cash', 'Bank', 'Income', 'Expense'];

    String dropdownValue = "Contact";
    return showModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(

                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * .3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: mHeight * .01),
                    Container(

                      height: mHeight * .05,
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/svg/filter.svg"),
                          SizedBox(width: mWidth * .04),
                          Text(
                            "Filter",
                            style: customisedStyle(context, Color(0xff13213A), FontWeight.w700, 16.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mHeight * .02),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: TextFieldDecoration.defaultStyle(context, hintTextStr: "Account Type"),
                              isEmpty: dropdownValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  style: customisedStyle(context, Color(0xff778EB8), FontWeight.w500, 13.0),
                                  items: items.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        )),
                    SizedBox(
                      height: mHeight * .01,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextFormField(
                            readOnly: true,
                            style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
                            validator: (value) {
                              if (value == null || value.isEmpty || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            onTap: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OnlyCountryList()),
                              );

                              result != null ? countryController.text = result[0] : Null;

                              result != null ? countryID = result[2] : Null;

                            },
                            controller: countryController,
                            decoration: TextFieldDecoration.defaultStyleWithIcon(context, hintTextStr: "Country"))),
                    Container(
                        alignment: AlignmentDirectional.bottomEnd,
                        height: mHeight * .05,
                        child: TextButton(
                          onPressed: () {
                            if (dropdownValue == "Contact") {
                              demoValue = 0;
                            } else if (dropdownValue == "Cash") {
                              demoValue = 1;
                            } else if (dropdownValue == "Bank") {
                              demoValue = 2;
                            } else if (dropdownValue == "Income") {
                              demoValue = 3;
                            } else {
                              demoValue = 4;
                            }
                            Navigator.pop(context, [demoValue, countryController.text]);
                          },
                          child: Text("Submit", style: customisedStyle(context, Color(0xff13213A), FontWeight.w700, 14.0)),
                        )),
                  ],
                ),
              )),
        );
      },
    );
  }
}
