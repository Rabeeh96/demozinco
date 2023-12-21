import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Account/account_bloc.dart';
import '../../../../Api Helper/ModelClasses/Settings/Account/CreateAccountModelClass.dart';
import '../../../../Api Helper/ModelClasses/Settings/Account/EditAccountModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/date_picker_function.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/custom_class.dart';
import '../../../../Utilities/global/text_style.dart';
import 'countrylist.dart';


class CreateAndEditAccountScreen extends StatefulWidget {
  final String type;
   String? id;
   String? organisation;
   String? accountName;
   String? openingBalance;
   String? country;
   String? date;
   int? accountType;
   String? currency;
   String? countryId;


   CreateAndEditAccountScreen({super.key, required this.type,this.id,this.organisation,
     this.accountName,this.openingBalance,this.country,this.date,this.accountType,this.currency,this.countryId});
  @override
  State<CreateAndEditAccountScreen> createState() => _CreateAndEditAccountScreenState();
}

class _CreateAndEditAccountScreenState extends State<CreateAndEditAccountScreen> {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController openingBalanceController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  FocusNode accNameFcNode = FocusNode();
  FocusNode accTypeFCNode = FocusNode();
  FocusNode openingBalanceFCNode = FocusNode();
  FocusNode countryFCNode = FocusNode();
  FocusNode currencyFCNode = FocusNode();
  String _date = "DD/MM/YYYY";
  String dateFormat = "2022-01-01";
 late int demoValue ;


  DateTime selectedDateAndTime = DateTime.now();
  ValueNotifier<DateTime>    dateNotifier = ValueNotifier(DateTime.now());
  final DateFormat formatter = DateFormat('dd-MM-yyyy');



  @override
  void initState() {
    progressBar = ProgressBar();


    accountNameController = TextEditingController( )..text = widget.type == "Edit"?widget.accountName!:"";
    openingBalanceController = TextEditingController( )..text = widget.type == "Edit"?widget.openingBalance!:"0.00";
    countryController = TextEditingController( )..text = widget.type == "Edit"?widget.country!:"";
    currencyController = TextEditingController( )..text = widget.type == "Edit"?widget.currency!:"";
     dateNotifier = widget.type == "Edit"? ValueNotifier(DateTime.parse(widget.date!)) : ValueNotifier(DateTime.now());
     dropdownValue = widget.type == "Edit"? items[widget.accountType!]: "Contact" ;
    countryID = widget.type == "Edit"? widget.countryId!: countryID ;

    DateTime dt = DateTime.now();

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(dt);
    _date = '$formatted';
    calenderController..text = _date;
  }
 
  var items = [
    'Contact',
    'Cash',
    'Bank',
    'Income',
    'Expense'
  ];

  String dropdownValue = "Contact";

String countryID = "";
  DateFormat apiDateFormat = DateFormat("y-M-d");
  late  CreateAccountModelClass createAccountModelClass ;
  late EditAccountModelClass editAccountModelClass ;
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {


    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return  MultiBlocListener(
      listeners: [
        BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is CreateAccountLoaded) {
                  hideProgressBar();
                createAccountModelClass = BlocProvider
                    .of<AccountBloc>(context)
                    .createAccountModelClass;
                if (createAccountModelClass.statusCode == 6000) {
                  Navigator.pop(context);

                }
                if (createAccountModelClass.statusCode == 6001) {
                  alreadyCreateBtmDialogueFunction(context: context,
                      textMsg: createAccountModelClass.errors.toString(),

                      buttonOnPressed: () {
                        Navigator.of(context)
                            .pop(false);
                      });}
              }}),

        BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is EditAccountLoading) {
                const CircularProgressIndicator();
              }
              if (state is EditAccountLoaded) {
                hideProgressBar();
                editAccountModelClass = BlocProvider.of<AccountBloc>(context).editAccountModelClass;

                if (editAccountModelClass.statusCode == 6000) {
                  Navigator.pop(context);
                }
                if (editAccountModelClass.statusCode == 6001) {
                  msgBtmDialogueFunction(context: context, textMsg: editAccountModelClass.data.toString(),);


                }
              }
              if (state is EditAccountError) {
                const Text("Something went wrong");
              }
            }

        ),

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
        title:  Text(
        widget.type == "Create"?  'Add Account':"Edit Account",
          style:
          customisedStyle(
              context, Color(0xff13213A), FontWeight.w600, 22.0),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: mHeight*.01
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                      textCapitalization: TextCapitalization.words,

                    style: customisedStyle(
                        context,
                        Colors.black,
                        FontWeight.normal,

                        15.0),
                      focusNode: accNameFcNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(accTypeFCNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value.trim().isEmpty) {
                          return 'Please enter account name';
                        }
                        return null;
                      },
                      controller: accountNameController,
                      decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Account Name"))),
              SizedBox(
                height: mHeight*.01
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Account Type"),
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
                            style: customisedStyle(
                                context,
                                Color(0xff778EB8),
                                FontWeight.normal,
                                15.0),
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
                  )
              ),
               SizedBox(
                 height: mHeight*.01,

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: TextFormField(
                          onTap: () {
                            openingBalanceController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: openingBalanceController.value.text.length,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          style: customisedStyle(
                              context,
                              Colors.black,
                              FontWeight.normal,
                              15.0),
                          focusNode: openingBalanceFCNode,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(countryFCNode);
                          },
                          inputFormatters :[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,8}')),
                          ],
                          keyboardType:
                          TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          controller: openingBalanceController,
                          decoration:TextFieldDecoration.defaultStyle(context,hintTextStr: "Opening balance"))),
                  ValueListenableBuilder(
                      valueListenable: dateNotifier,
                      builder:
                          (BuildContext ctx, fromDateNewValue, _) {
                        final String formatted = formatter.format(dateNotifier.value);
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.height / 20,
                        child: TextFormField(
                          style: customisedStyle(
                              context,
                              Color(0xff878787),
                              FontWeight.normal,
                              15.0),
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          controller: calenderController..text = formatted,
                          readOnly: true,
                          textAlign: TextAlign.center,

                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                borderSide:
                                    BorderSide(width: 1, color: Color(0xffF3F7FC)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                borderSide:
                                    BorderSide(width: 1, color: Color(0xffF3F7FC)),
                              ),
                              border: const OutlineInputBorder(),
                              labelText: "",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset("assets/svg/calender.svg"),
                              ),
                              filled: true,
                              fillColor: const Color(0xffF3F7FC)),
                          onTap: () {
                            showDatePickerFunction(
                                context, dateNotifier);
                          },
                        ),
                      );
                    }
                  ),
                ],
              ),
               SizedBox(
               height: mHeight*.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: TextFormField(
                        readOnly: true,
                          style: customisedStyle(
                              context,
                              Colors.black,
                              FontWeight.normal,
                              15.0),
                          focusNode: countryFCNode,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(currencyFCNode);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnlyCountryList()),
                            );

                            result != null
                                ? countryController.text = result[0]
                                : Null;
                            result != null
                                ? currencyController.text = result[1]
                                : Null;
                            result != null
                                ? countryID = result[2]
                                : Null;

                          },
                          controller: countryController,
                          decoration: TextFieldDecoration.defaultStyleWithIcon(context,hintTextStr: "Country"))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: TextFormField(
                        readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          style: customisedStyle(
                              context,
                              Colors.black,
                              FontWeight.normal,
                              15.0),
                          focusNode: currencyFCNode,

                          controller: currencyController,
                          decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Currency"))),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        child: SvgPicture.asset('assets/svg/save.svg'),
        onTap: ()  {

          if (dropdownValue == "Contact") {
            demoValue = 0 ;
          } else if (dropdownValue == "Cash") {
            demoValue = 1;
          }
          else if (dropdownValue == "Bank") {
            demoValue = 2;
          }
          else if (dropdownValue == "Income") {
            demoValue = 3;
          } else{
            demoValue = 4;
          }

          if( _formKey.currentState!.validate()){
            if(widget.type == 'Edit'){
              editAccountApiFunction();
            }
            else{
              createAccountApiFunction();
            }
          }
        },
      ),
    ),
);
  }
  createAccountApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      return  BlocProvider.of<AccountBloc>(context).add(CreateAccountEvent(accountName: accountNameController.text,
          openingBalance: openingBalanceController.text, organisation: organizationId!, country: countryID,
        account_type: demoValue, as_on_date: apiDateFormat.format(dateNotifier.value),));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }
  editAccountApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
     showProgressBar();
      return  BlocProvider.of<AccountBloc>(context).add(EditAccountEvent(id: widget.id!,
          organisation: widget.organisation!,
          accountName: accountNameController.text, openingBalance: openingBalanceController.text,
          country:countryID, date:  apiDateFormat.format(dateNotifier.value), accountType: demoValue.toString()));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

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

}

