import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Account/account_bloc.dart';
import '../../../../Api Helper/Bloc/NewDesignBloc/expnse/new_expense_bloc.dart';
import '../../../../Api Helper/ModelClasses/Settings/Account/CreateAccountModelClass.dart';
import '../../../../Api Helper/ModelClasses/Settings/Account/EditAccountModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/global/text_style.dart';

 class CommonBottomSheetClass {
  final formKey = GlobalKey<FormState>();

  ExpenseAddBottomSheet({required context, required String type, required String addOrEdit, String? typeName, String? id, String? organisation}) {
    listExpenseApiFunction() async {
      var netWork = await checkNetwork();

      if (netWork) {
        return BlocProvider.of<NewExpenseBloc>(context).add(FetchNewExpenseOverviewEvent(fromDate: "", toDate: "", pageNumber: 1, pageSize: 50));
      } else {
        msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
      }
    }

    late CreateAccountModelClass createAccountModelClass;
    late EditAccountModelClass editAccountModelClass;

    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController()..text = type =="Edit"? typeName.toString():"";


    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    var idd;

    idd = id!;

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
            BlocListener<AccountBloc, AccountState>(
              listener: (context, state) async {
                if (state is CreateAccountLoaded) {
                  createAccountModelClass = BlocProvider.of<AccountBloc>(context).createAccountModelClass;
                  if (createAccountModelClass.statusCode == 6000) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    final organizationId = prefs.getString("organisation");
                    BlocProvider.of<AccountBloc>(context)
                        .add(ListAccountEvent(organisation: organizationId!, page_number: 1, page_size: 50, search: '', country: '', type: [4]));

                    Navigator.pop(context);
                    listExpenseApiFunction();
                  }
                  if (createAccountModelClass.statusCode == 6001) {
                    alreadyCreateBtmDialogueFunction(
                        context: context,
                        textMsg: createAccountModelClass.errors.toString(),
                        buttonOnPressed: () {
                          Navigator.of(context).pop(false);
                        });
                  }
                }
              },
            ),
            BlocListener<AccountBloc, AccountState>(
              listener: (context, state) async {
                if (state is EditAccountLoaded) {
                  editAccountModelClass = BlocProvider.of<AccountBloc>(context).editAccountModelClass;

                  if (editAccountModelClass.statusCode == 6000) {
                    Navigator.pop(context);


                      var netWork = await checkNetwork();

                      if (netWork) {
                        return BlocProvider.of<NewExpenseBloc>(context)
                            .add(FetchNewExpenseDetailEvent(accountId: idd, pageNumber: 1, pageSize: 50, fromDate: '', toDate: ''));
                      } else {
                        msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                      }

                    listExpenseApiFunction();

                  }
                  if (editAccountModelClass.statusCode == 6001) {
                    msgBtmDialogueFunction(
                      context: context,
                      textMsg: editAccountModelClass.data.toString(),
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
                    Container(
                      height: mHeight * .1,
                      margin: EdgeInsets.only(left: mWidth * .02, right: mWidth * .02, top: mHeight * .04),


                      child: TextFormField(
                        controller:  nameController,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim().isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF3F7FC),
                          filled: true,
                          hintText: "Name",
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xffE2E2E2),
                      thickness: 1,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
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
                            type == "Create" ? 'Create Expense' : "Edit Expense",
                            style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                          ),
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();


                              if (formKey.currentState!.validate() && type == "Create" && addOrEdit == "Add") {
                                if (formKey.currentState!.validate()) {

                                  var netWork = await checkNetwork();

                                  final organizationId = prefs.getString("organisation");

                                  if (netWork) {
                                    return BlocProvider.of<AccountBloc>(context).add(CreateAccountEvent(
                                      accountName: nameController.text,
                                      openingBalance: "0",
                                      organisation: organizationId!,
                                      country: "",
                                      account_type: 4,
                                      as_on_date: formattedDate,
                                    ));
                                  } else {
                                    msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                  }
                                } else {
                                  return null;
                                }
                              }
                              if (formKey.currentState!.validate() && type == "Edit" && addOrEdit == "Edit") {

                                var netWork = await checkNetwork();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                final organizationId = prefs.getString("organisation");
                                if (netWork) {
                                  return BlocProvider.of<AccountBloc>(context).add(EditAccountEvent(
                                      id: id,
                                      organisation: organizationId!,
                                      accountName: nameController.text,
                                      openingBalance: "0",
                                      country: "",
                                      date: formattedDate,
                                      accountType: "4"));
                                } else {
                                  msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                }
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
              )),
        );
      },
    );
  }
}
