import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api Helper/Bloc/Account/account_bloc.dart';
import '../Api Helper/ModelClasses/Settings/Account/DeleteAccountModelClass.dart';
import '../Api Helper/ModelClasses/Settings/Account/DetailAccountModelClass.dart';
import '../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../Utilities/Commen Functions/internet_connection_checker.dart';
import '../Utilities/Commen Functions/roundoff_function.dart';
import '../Utilities/CommenClass/custom_overlay_loader.dart';
import '../Utilities/CommenClass/search_commen_class.dart';
import '../Utilities/global/text_style.dart';
import '../View/screens/settings/account/add_account.dart';

/// account pagination  code
class PagiantionAccountList extends StatefulWidget {
  PagiantionAccountList({Key? key}) : super(key: key);

  @override
  State<PagiantionAccountList> createState() => _PagiantionAccountListState();
}

class _PagiantionAccountListState extends State<PagiantionAccountList> {
  TextEditingController searchController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

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
  }
  List items = ["D","E"];
  listAccountApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organizationUuid");
    if (netWork) {
      if (!mounted) return;
      //showProgressBar();
     // return BlocProvider.of<AccountBloc>(context).add(InitialListAccountEvent(search: "", organisation: organizationId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }
  List<AccountListModelClass> orderDetailsTable = [];
  ValueNotifier valueNotifier = ValueNotifier(2);
  late  Response response ;
  late String id ="";
  DateFormat dateFormat = DateFormat("dd/MM/yyy");


  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  deleteCountryApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organizationUuid");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return  BlocProvider.of<AccountBloc>(context).add(DeleteAccountEvent(id: id, organisation: organizationId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }

  detailCountryApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organizationUuid");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return  BlocProvider.of<AccountBloc>(context).add(DetailAccountEvent(id: id, organisation: organizationId!));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }

  late DeleteAccountModelClass deleteAccountModelClass;
  late DetailAccountModelClass detailAccountModelClass ;
  ValueNotifier<DateTime>    dateNotifier = ValueNotifier(DateTime.now());

  final DateFormat formatter = DateFormat('dd-MM-yyyy');


  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) async{
            if (state is DetailAccountLoaded) {
              hideProgressBar();
              detailAccountModelClass =
                  BlocProvider.of<AccountBloc>(context).detailAccountModelClass;
              final result =     await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>CreateAndEditAccountScreen(type: 'Edit',id: id,
                    organisation:detailAccountModelClass.data!.organization ,
                    accountName: detailAccountModelClass.data!.accountName,
                    openingBalance: roundStringWith(detailAccountModelClass.data!.openingBalance.toString()),
                    country: detailAccountModelClass.data!.country!.countryName,
                    accountType: int.parse(detailAccountModelClass.data!.accountType!),
                    currency:detailAccountModelClass.data!.country!.currencyName ,
                    date:detailAccountModelClass.data!.asOnDate ,
                    countryId:detailAccountModelClass.data!.country!.id,

                  )));

              orderDetailsTable.clear();
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
              orderDetailsTable.clear();
              listAccountApiFunction();
              deleteAccountModelClass =
                  BlocProvider.of<AccountBloc>(context).deleteAccountModelClass;
              if (deleteAccountModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(
                    context: context,
                    textMsg: "Something went wrong");
              }
            }
            if (state is DeleteAccountError) {
              hideProgressBar();
            }
          },
        )

      ],
      child: Scaffold(
        appBar: AppBar(
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
          title: Text('Accounts',
              style: customisedStyle(
                  context, Color(0xff13213A), FontWeight.w700, 22.0)),
          actions: [
            IconButton(
                onPressed: () {


                },
                icon: SvgPicture.asset("assets/svg/filter.svg")),
          ],
        ),
        body: Container(

            padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
            child: Column(
                children: [  SizedBox(
                  height: mHeight * .02,
                ),

                  SearchFieldWidget(
                    autoFocus: false,
                    mHeight: mHeight,
                    hintText: 'Search',
                    controller: searchController,
                    onChanged: (quary) {

                    },
                  ),
                  SizedBox(
                    height: mHeight * .01,
                  ),
                  Expanded(
                    child: BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        if (state is ListAccountLoading) {
                          return CircularProgressIndicator(
                            color: Color(0xff5728C4),
                          );
                        }
                        if (state is ListAccountLoaded) {

                          response  = BlocProvider.of<AccountBloc>(context).response;


                          Map n = json.decode(utf8.decode(response.bodyBytes));
                          var status = n["StatusCode"];
                          var responseJson = n["data"];
                          var count =n["count"];


                          for (Map user in responseJson) {
                            orderDetailsTable.add(AccountListModelClass.fromJson(user));

                          }

                          _refreshController.loadComplete();




                          return  orderDetailsTable.isNotEmpty ?ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: orderDetailsTable.length,
                              itemBuilder: (BuildContext context, int index) {
                              //  print("_________________________________________$value");
                                String time = orderDetailsTable[index].date
                                    .toString();
                                DateTime dateTime = DateTime.parse(time);
                                return
                                  Slidable(
                                    key:  ValueKey(orderDetailsTable.length),
                                    endActionPane:  ActionPane(
                                      motion: ScrollMotion(),
                                      children: [

                                        SlidableAction(
                                          onPressed: (context)async{
                                            id = orderDetailsTable[index].id;

                                            detailCountryApiFunction();
                                          },
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.blue,
                                          icon: Icons.edit,
                                          label: 'Edit',
                                        ),
                                        SlidableAction(
                                          onPressed: (context)async{
                                            id = orderDetailsTable[index].id;
                                            deleteCountryApiFunction();

                                          },
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.red,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      height: mHeight * .15,
                                      // color: Colors.blue,
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Color(0xffDEDEDE), width: 1),
                                            borderRadius: BorderRadius.circular(1)),
                                        tileColor: const Color(0xffFFFFFF),
                                        title: Container(
                                          width: mWidth * .02,
                                          //  color: Colors.grey,
                                          margin: EdgeInsets.only(top: mHeight * .01),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: mWidth * .5,

                                                child: Text("contact",

                                                    overflow: TextOverflow.ellipsis,
                                                    style: customisedStyle(context,
                                                        Color(0xff8D8D8D), FontWeight.w500, 13.0)),
                                              ),
                                              Text(orderDetailsTable[index].country['country_name'],
                                                  overflow: TextOverflow.ellipsis,
                                                  style: customisedStyle(context,
                                                      Color(0xff4C6584), FontWeight.w500, 13.0)),
                                            ],
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Row(
                                              children: [
                                                Container(


                                                  width: mWidth * .65,
                                                  child: Text(orderDetailsTable[index].accountName,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: customisedStyle(
                                                          context,
                                                          Colors.black,
                                                          FontWeight.bold,
                                                          13.0)),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(left: mWidth * .02),
                                                  child: Text(orderDetailsTable[index].country['country_code'],
                                                      overflow: TextOverflow.ellipsis,
                                                      style: customisedStyle(context,
                                                          Color(0xff2BAAFC), FontWeight.bold, 13.0)),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: mHeight * .01,),
                                            Container(
                                              width: mWidth * .8,

                                              child: Text(orderDetailsTable[index].amount,
                                                  style: customisedStyle(
                                                      context,
                                                      Colors.black,
                                                      FontWeight.bold,
                                                      13.0)),
                                            ),
                                            Row(
                                              children: [
                                                Text("As if on ",
                                                    style: customisedStyle(
                                                        context,
                                                        Color(0xff2BAAFC),
                                                        FontWeight.bold,
                                                        13.0)),
                                                Text(dateFormat.format(dateTime),
                                                    style: customisedStyle(
                                                        context,
                                                        Colors.black,
                                                        FontWeight.bold,
                                                        13.0)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        trailing: TextButton(
                                          child: Text('Edit'),
                                          onPressed: () async {
                                            final String newText = await _asyncInputDialog(context);

                                          },
                                        ),
                                      ),
                                    ),
                                  );
                              }):SizedBox(
                              height: mHeight * .7,
                              child: const Center(
                                  child: Text(
                                    "Items not found !",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  )));
                        }
                        if(state is ListAccountError){
                          return Center(
                            child: Text("Something went wrong"),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ]
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: GestureDetector(
          child: SvgPicture.asset('assets/svg/add_circle.svg'),
          onTap: () async {
            final result = await    Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) =>  CreateAndEditAccountScreen(type: 'Create',)));
            orderDetailsTable.clear();
            listAccountApiFunction();
          },
        ),


      ),
    );
  }
  _asyncInputDialog(BuildContext context) async {
    String sampleText = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
      false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Text'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Text Here', hintText: 'eg. ABCD'),
                    onChanged: (value) {
                      sampleText = value;
                    },
                  ))
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(sampleText);
              },
            ),
          ],
        );
      },
    );
  }
}
class AccountListModelClass {
  String accountName, amount, date,id;
  var country;




  AccountListModelClass(
      {required this.accountName,
        required this.id,
        required this.amount,
        required this.date,
        required this.country});

  factory AccountListModelClass.fromJson(Map<dynamic, dynamic> json) {
    return AccountListModelClass(
        accountName: json['account_name'],
        id: json['id'],
        amount: json['amount'] ?? "0",
        date: json['as_on_date'],
        country: json['country']);
  }
}
