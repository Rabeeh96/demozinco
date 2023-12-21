

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Userole/userole_bloc.dart';
import '../../../../Api Helper/ModelClasses/Userole/CreateUseroleModelClass.dart';
import '../../../../Api Helper/ModelClasses/Userole/EditUseroleModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/commen_txtfield_widget.dart';
import '../../../../Utilities/global/text_style.dart';





class CreateAndEditUserole extends StatefulWidget {
  final String type;
   String? organisation;
   int? userTypeId;
   String? userTypeName;
   var permissionData;


   CreateAndEditUserole({super.key, required this.type,this.organisation,this.userTypeId,this.userTypeName,this.permissionData});
  @override
  State<CreateAndEditUserole> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<CreateAndEditUserole> {

  TextEditingController userTypeNameController = TextEditingController();


  final ValueNotifier<bool> portfolioCreateNotifier = ValueNotifier(false);
    ValueNotifier<bool> portfolioEditNotifier= ValueNotifier(false);
     ValueNotifier<bool> portfolioDeleteNotifier  = ValueNotifier(false);
     ValueNotifier<bool> portfolioViewNotifier  = ValueNotifier(false);
     ValueNotifier<bool> contactCreateNotifier = ValueNotifier(false);
      ValueNotifier<bool> contactEditNotifier = ValueNotifier(false);
      ValueNotifier<bool> contactDeleteNotifier = ValueNotifier(false);

  ValueNotifier<bool> contactViewNotifier  = ValueNotifier(false);
  ValueNotifier<bool> ExpensesCreateNotifier = ValueNotifier(false);
  ValueNotifier<bool> ExpensesEditNotifier = ValueNotifier(false);
  ValueNotifier<bool> ExpensesDeleteNotifier = ValueNotifier(false);
  ValueNotifier<bool> ExpensesViewNotifier  = ValueNotifier(false);

  ValueNotifier<bool> IncomeCreateNotifier = ValueNotifier(false);
  ValueNotifier<bool> IncomeEditNotifier = ValueNotifier(false);
  ValueNotifier<bool> IncomeDeleteNotifier = ValueNotifier(false);
  ValueNotifier<bool> IncomeViewNotifier  = ValueNotifier(false);

  ValueNotifier<bool> LoanCreateNotifier = ValueNotifier(false);
  ValueNotifier<bool> LoanEditNotifier = ValueNotifier(false);
  ValueNotifier<bool> LoanDeleteNotifier = ValueNotifier(false);
  ValueNotifier<bool> LoanViewNotifier  = ValueNotifier(false);

  ValueNotifier<bool> TransactionsCreateNotifier = ValueNotifier(false);
  ValueNotifier<bool> TransactionsEditNotifier = ValueNotifier(false);
  ValueNotifier<bool> TransactionsDeleteNotifier = ValueNotifier(false);
  ValueNotifier<bool> TransactionViewNotifier  = ValueNotifier(false);

  ValueNotifier<bool> PaymentNotificationCreateNotifier = ValueNotifier(false);
  ValueNotifier<bool> PaymentNotificationEditNotifier = ValueNotifier(false);
  ValueNotifier<bool> PaymentNotificationDeleteNotifier = ValueNotifier(false);
  ValueNotifier<bool> paymentViewNotifier  = ValueNotifier(false);

  ValueNotifier<bool> DashboardNotifier = ValueNotifier(false);
  ValueNotifier<bool> SettingsNotifier = ValueNotifier(false);


  final _formKey = GlobalKey<FormState>();
  bool isCreate =false;
  bool isEdit= false;
  bool isDelete=false;
  @override

  void initState() {
    userTypeNameController = TextEditingController()..text = (widget.type == "Edit"? widget.userTypeName :"")!;


    super.initState();
  }
  late CreateUseroleModelClass createUseroleModelClass;


  add(data){
  }
  late  EditUseroleModelClass editUseroleModelClass ;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(height: mHeight*.02,);
    final sizedBox = SizedBox(height: mHeight*.03,);
    return MultiBlocListener(listeners:[
        BlocListener<UseroleBloc, UseroleState>(
            listener: (context, state) {


        if (state is UseroleCreateLoaded) {
        createUseroleModelClass =
        BlocProvider
            .of<UseroleBloc>(context)
            .createUseroleModelClass;
        if (createUseroleModelClass.statusCode == 6001) {
        alreadyCreateBtmDialogueFunction(context: context,
        textMsg: createUseroleModelClass.message.toString(),
        buttonOnPressed: () {
        Navigator.of(context)
            .pop(false);
        });

        }
        if (createUseroleModelClass.statusCode == 6000) {
        Navigator.pop(context);

        msgBtmDialogueFunction(
        context: context,
        textMsg: createUseroleModelClass.message.toString(),);



        }
        }
        if (state is UseroleCreateError) {

        }
        },
        ),
      BlocListener<UseroleBloc, UseroleState>(
          listener: (context, state) {
            if (state is EditUseroleLoading) {
              const CircularProgressIndicator();
            }
            if (state is EditUseroleLoaded) {
              editUseroleModelClass = BlocProvider
                  .of<UseroleBloc>(context)
                  .editUseroleModelClass;
              if (editUseroleModelClass.statusCode == 6000) {
                Navigator.pop(context);
                msgBtmDialogueFunction(
                  context: context,
                  textMsg: editUseroleModelClass.message.toString(),);
              }
              if (editUseroleModelClass.statusCode == 6001) {
                alreadyCreateBtmDialogueFunction(context: context,
                    textMsg: "Something went wrong",
                    buttonOnPressed: () {
                      Navigator.of(context)
                          .pop(false);
                    });
              }
            }
            if (state is EditUseroleError) {
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
          'Create User Type',
          style: customisedStyle(
              context, Color(0xff13213A), FontWeight.w600, 22.0),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: mWidth*.05, right:  mWidth*.05),
       child: Form(
         key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children:  [
              space,
              CommenTextFieldWidget(
                controller: userTypeNameController,
    validator: (val) {
      if (val == null || val.isEmpty || val
          .trim()
          .isEmpty) {
        return 'This field is required';
      }
      return null;
    },
            hintText: 'User Type Name', textInputType:TextInputType.name,
            textAlign: TextAlign.start, readOnly: false,
            textInputAction: TextInputAction.done, textCapitalization: TextCapitalization.words, obscureText: false,),
              space,
            Text("Portfolio",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: portfolioCreateNotifier,
                  builder: (BuildContext context, bool createNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Create', toggleButtonBoolValue: createNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = portfolioCreateNotifier.value;
                      portfolioCreateNotifier.value = !portfolioCreateNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: portfolioEditNotifier,
                  builder: (BuildContext context, bool editNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Edit', toggleButtonBoolValue: editNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = portfolioEditNotifier.value;
                      portfolioEditNotifier.value = !portfolioEditNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: portfolioDeleteNotifier,
                  builder: (BuildContext context, bool deleteNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Delete', toggleButtonBoolValue: deleteNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = portfolioDeleteNotifier.value;
                      portfolioDeleteNotifier.value = !portfolioDeleteNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: portfolioViewNotifier,
                  builder: (BuildContext context, bool portfolioViewNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'View', toggleButtonBoolValue: portfolioViewNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = portfolioViewNotifier.value;
                      portfolioViewNotifier.value = !portfolioViewNotifier.value;
                    });
                  }),
              sizedBox,


              Text("Contacts",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: contactCreateNotifier,
                  builder: (BuildContext context, bool contactCreateNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Create', toggleButtonBoolValue: contactCreateNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = contactCreateNotifier.value;
                      contactCreateNotifier.value = !contactCreateNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: contactEditNotifier,
                  builder: (BuildContext context, bool contactEditNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Edit', toggleButtonBoolValue: contactEditNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = contactEditNotifier.value;
                      contactEditNotifier.value = !contactEditNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: contactDeleteNotifier,
                  builder: (BuildContext context, bool contactDeleteNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Delete', toggleButtonBoolValue: contactDeleteNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = contactDeleteNotifier.value;
                      contactDeleteNotifier.value = !contactDeleteNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: contactViewNotifier,
                  builder: (BuildContext context, bool contactViewNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'View', toggleButtonBoolValue: contactViewNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = contactViewNotifier.value;
                      contactViewNotifier.value = !contactViewNotifier.value;
                    });
                  }),
              sizedBox,
              Text("Expenses",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: ExpensesCreateNotifier,
                  builder: (BuildContext context, bool ExpensesCreateNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Create', toggleButtonBoolValue: ExpensesCreateNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = ExpensesCreateNotifier.value;
                      ExpensesCreateNotifier.value = !ExpensesCreateNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: ExpensesEditNotifier,
                  builder: (BuildContext context, bool ExpensesEditNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Edit', toggleButtonBoolValue: ExpensesEditNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = ExpensesEditNotifier.value;
                      ExpensesEditNotifier.value = !ExpensesEditNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: ExpensesDeleteNotifier,
                  builder: (BuildContext context, bool ExpensesDeleteNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Delete', toggleButtonBoolValue: ExpensesDeleteNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = ExpensesDeleteNotifier.value;
                      ExpensesDeleteNotifier.value = !ExpensesDeleteNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: ExpensesViewNotifier,
                  builder: (BuildContext context, bool ExpensesViewNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'View', toggleButtonBoolValue: ExpensesViewNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = ExpensesViewNotifier.value;
                      ExpensesViewNotifier.value = !ExpensesViewNotifier.value;
                    });
                  }),
              sizedBox,
              Text("Income",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: IncomeCreateNotifier,
                  builder: (BuildContext context, bool IncomeCreateNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Create', toggleButtonBoolValue: IncomeCreateNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = IncomeCreateNotifier.value;
                      IncomeCreateNotifier.value = !IncomeCreateNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: IncomeEditNotifier,
                  builder: (BuildContext context, bool IncomeEditNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Edit', toggleButtonBoolValue: IncomeEditNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = IncomeEditNotifier.value;
                      IncomeEditNotifier.value = !IncomeEditNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: IncomeDeleteNotifier,
                  builder: (BuildContext context, bool IncomeDeleteNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Delete', toggleButtonBoolValue: IncomeDeleteNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = IncomeDeleteNotifier.value;
                      IncomeDeleteNotifier.value = !IncomeDeleteNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: IncomeViewNotifier,
                  builder: (BuildContext context, bool IncomeViewNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'View', toggleButtonBoolValue: IncomeViewNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = IncomeViewNotifier.value;
                      IncomeViewNotifier.value = !IncomeViewNotifier.value;
                    });
                  }),
              sizedBox,
              Text("Loans",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: LoanCreateNotifier,
                  builder: (BuildContext context, bool LoanCreateNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Create', toggleButtonBoolValue: LoanCreateNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = LoanCreateNotifier.value;
                      LoanCreateNotifier.value = !LoanCreateNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: LoanEditNotifier,
                  builder: (BuildContext context, bool LoanEditNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Edit', toggleButtonBoolValue: LoanEditNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = LoanEditNotifier.value;
                      LoanEditNotifier.value = !LoanEditNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: LoanDeleteNotifier,
                  builder: (BuildContext context, bool LoanDeleteNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Delete', toggleButtonBoolValue: LoanDeleteNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = LoanDeleteNotifier.value;
                      LoanDeleteNotifier.value = !LoanDeleteNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: LoanViewNotifier,
                  builder: (BuildContext context, bool LoanViewNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'View', toggleButtonBoolValue: LoanViewNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = LoanViewNotifier.value;
                      LoanViewNotifier.value = !LoanViewNotifier.value;
                    });
                  }),
              sizedBox,
              Text("Transactions",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: TransactionsCreateNotifier,
                  builder: (BuildContext context, bool TransactionsCreateNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Create', toggleButtonBoolValue: TransactionsCreateNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = TransactionsCreateNotifier.value;
                      TransactionsCreateNotifier.value = !TransactionsCreateNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: TransactionsEditNotifier,
                  builder: (BuildContext context, bool TransactionsEditNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Edit', toggleButtonBoolValue: TransactionsEditNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = TransactionsEditNotifier.value;
                      TransactionsEditNotifier.value = !TransactionsEditNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: TransactionsDeleteNotifier,
                  builder: (BuildContext context, bool TransactionsDeleteNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Delete', toggleButtonBoolValue: TransactionsDeleteNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = TransactionsDeleteNotifier.value;
                      TransactionsDeleteNotifier.value = !TransactionsDeleteNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: TransactionViewNotifier,
                  builder: (BuildContext context, bool TransactionViewNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'View', toggleButtonBoolValue: TransactionViewNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = TransactionViewNotifier.value;
                      TransactionViewNotifier.value = !TransactionViewNotifier.value;
                    });
                  }),
              sizedBox,
              Text("Payment Notification",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: PaymentNotificationCreateNotifier,
                  builder: (BuildContext context, bool PaymentNotificationCreateNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Create', toggleButtonBoolValue: PaymentNotificationCreateNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = PaymentNotificationCreateNotifier.value;
                      PaymentNotificationCreateNotifier.value = !PaymentNotificationCreateNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: PaymentNotificationEditNotifier,
                  builder: (BuildContext context, bool PaymentNotificationEditNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Edit', toggleButtonBoolValue: PaymentNotificationEditNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = PaymentNotificationEditNotifier.value;
                      PaymentNotificationEditNotifier.value = !PaymentNotificationEditNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: PaymentNotificationDeleteNotifier,
                  builder: (BuildContext context, bool PaymentNotificationDeleteNotifierNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Delete', toggleButtonBoolValue: PaymentNotificationDeleteNotifierNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = PaymentNotificationDeleteNotifier.value;
                      PaymentNotificationDeleteNotifier.value = !PaymentNotificationDeleteNotifier.value;
                    });
                  }),
              sizedBox,
              ValueListenableBuilder(
                  valueListenable: paymentViewNotifier,
                  builder: (BuildContext context, bool paymentViewNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'View', toggleButtonBoolValue: paymentViewNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = paymentViewNotifier.value;
                      paymentViewNotifier.value = !paymentViewNotifier.value;
                    });
                  }),
              sizedBox,
              Text("DashBoard",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: DashboardNotifier,
                  builder: (BuildContext context, bool DashboardNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'DashBoard', toggleButtonBoolValue: DashboardNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = DashboardNotifier.value;
                      DashboardNotifier.value = !DashboardNotifier.value;
                    });
                  }),
              sizedBox,
              Text("Settings",style: customisedStyle(context,  Color(0xff13213A), FontWeight.bold, 18.0)),
              space,
              ValueListenableBuilder(
                  valueListenable: SettingsNotifier,
                  builder: (BuildContext context, bool SettingsNotifierNewValue, _ ) {
                    return useroleToggleFunction(text: 'Settings', toggleButtonBoolValue: SettingsNotifierNewValue, toggleButtonOnChanged: (value ) {
                      value = SettingsNotifier.value;
                      SettingsNotifier.value = !SettingsNotifier.value;
                    });
                  }),
              SizedBox(height: mHeight*.1,)

            ],
          ),
       ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        child: SvgPicture.asset('assets/svg/save.svg'),
        onTap: () async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if(_formKey.currentState!.validate() && widget.type == "Create"){
            createUseroleFunction();

          }
          if( _formKey.currentState!.validate() && widget.type == "Edit"){
            EditUseroleFunction();
          }

          },
      ),
    ),
);
  }
  createUseroleFunction() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 final organizationId =   prefs.getString("organisation");
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
 return BlocProvider.of<UseroleBloc>(context).add(CreateUseroleEvent(organizationId: organizationId!, userTypeName: userTypeNameController.text, notes: "", permissionData: permissionDataFunction()));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }

  EditUseroleFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<UseroleBloc>(context).add(EditUseroleGetEvent(organisationId: organizationId!,
          userTypeId: widget.userTypeId!, userTypeName: userTypeNameController.text, permissionData: permissionDataFunction()));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }
  permissionDataFunction(){
    final List permissionDataList = [
      {
        "name": "Portfolio",
        "view_permission":  portfolioViewNotifier.value,
        "save_permission": portfolioCreateNotifier.value,
        "edit_permission":portfolioEditNotifier.value,
        "delete_permission":portfolioDeleteNotifier.value
      },
      {
        "name": "Contacts",
        "view_permission": contactViewNotifier.value,
        "save_permission": contactCreateNotifier.value,
        "edit_permission": contactEditNotifier.value,
        "delete_permission":contactDeleteNotifier.value
      },
      {
        "name": "Expenses",
        "view_permission": ExpensesViewNotifier.value,
        "save_permission": ExpensesCreateNotifier.value,
        "edit_permission":ExpensesEditNotifier.value,
        "delete_permission":ExpensesDeleteNotifier.value
      },
      {
        "name": "Income",
        "view_permission": IncomeViewNotifier.value,
        "save_permission": IncomeCreateNotifier.value,
        "edit_permission":IncomeEditNotifier.value,
        "delete_permission":IncomeDeleteNotifier.value
      },
      {
        "name": "Loans",
        "view_permission": LoanViewNotifier.value,
        "save_permission": LoanCreateNotifier.value,
        "edit_permission": LoanEditNotifier.value,
        "delete_permission":LoanDeleteNotifier.value
      },
      {
        "name": "Transactions",
        "view_permission": TransactionViewNotifier.value,
        "save_permission": TransactionsCreateNotifier.value,
        "edit_permission":TransactionsEditNotifier.value,
        "delete_permission":TransactionsDeleteNotifier.value
      },
      {
        "name": "PaymentNotification",
        "view_permission": paymentViewNotifier.value,
        "save_permission": PaymentNotificationCreateNotifier.value,
        "edit_permission":PaymentNotificationEditNotifier.value,
        "delete_permission":PaymentNotificationDeleteNotifier.value
      },
      {
        "name": "DashBoard",
        "view_permission": DashboardNotifier.value,
        "save_permission": false,
        "edit_permission":false,
        "delete_permission":false
      },
      {
        "name": "Settings",
        "view_permission": SettingsNotifier.value,
        "save_permission": false,
        "edit_permission":false,
        "delete_permission":false
      },


    ];
    return permissionDataList;
  }


}
Widget useroleToggleFunction({required String text,required bool toggleButtonBoolValue , required void Function(bool) toggleButtonOnChanged}){
  return          Row(

    children: [
      SizedBox(width: 20,),
    toggleButton(value: toggleButtonBoolValue, onChanged: toggleButtonOnChanged  ),
      SizedBox(width: 10,),

      Text(text,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),



    ],
  );
}Widget toggleButton(
    {required bool value, required void Function(bool) onChanged}) {
  return FlutterSwitch(
      width: 40.0,
      height: 20.0,
      valueFontSize: 30.0,
      toggleSize: 15.0,
      borderRadius: 20.0,
      padding: 1.0,
      activeColor: const Color(0xff9974EF),
      activeTextColor: Colors.green,
      inactiveTextColor: Colors.grey,
      inactiveColor: Colors.grey,
      value: value,
      onToggle: onChanged);
}