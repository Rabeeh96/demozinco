import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';


import '../../../Api Helper/Bloc/Account/account_bloc.dart';
import '../../../Api Helper/Bloc/DashBoard/dash_board_bloc.dart';
import '../../../Api Helper/Bloc/dash_detail/dash_detail_bloc.dart';
import '../../../Api Helper/Bloc/dash_detail/dash_detail_event.dart';
import '../../../Api Helper/ModelClasses/Settings/Account/CreateAccountModelClass.dart';
import '../../../Api Helper/ModelClasses/Settings/Account/EditAccountModelClass.dart';
import '../../../Api Helper/ModelClasses/dashboard/ModelClassDashboard.dart';
import '../../../Api Helper/ModelClasses/dashboard_detail_model/DashboardDEtailModel.dart';
import '../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../Utilities/global/text_style.dart';
import '../../../Utilities/global/variables.dart';
import '../expenses/expense_new_design/expense_list_overview.dart';
import '../expire/expire_page.dart';
import '../login/Country/new_setup_acnt_country.dart';
import '../login/login_new_screen.dart';
import 'Interest/interest_list.dart';
import 'Payable_Recievable/payable_recievable_list.dart';
import 'Zakah/Zakah_list.dart';
import 'dashboard_detail_screen.dart';

class NewDashboard extends StatefulWidget {
  const NewDashboard({Key? key}) : super(key: key);

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
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

  var items = [
    'India - INR',
    'Dubai - AED',
    'Qatar - QR',
  ];
  bool zakath = false;
  bool isIntrest = false;

  late ModelClassDashboard modelClassDashboard;
  DashboardDEtailModel? dashboardDEtailModel;




  dashBoardApiFunction() async {
    var netWork = await checkNetwork();
    final prefs = await SharedPreferences.getInstance();

    zakath = prefs.getBool("is_zakath") ?? false;
    isIntrest = prefs.getBool("is_intrest") ?? false;

    countryCurrencyCode = prefs.getString('currency_symbol') ?? 'RS';
    default_country_name = prefs.getString('default_country') ?? 'India';
    default_country_id = prefs.getString('default_country_id') ?? '';
    countryShortCode = prefs.getString('default_country_code') ?? '';

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<DashBoardBloc>(context).add(FetchDashBoardEvent());
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }



  @override
  void initState() {
    progressBar = ProgressBar();
    super.initState();
    dashBoardApiFunction();
  }



  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  bool noItems = false;


  Widget _contentView (){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(color: Colors.white),
          child: SkeletonItem(
              child: Column(

                children: [

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      color: Colors.green,
                      height: 80,),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .1,
                    decoration: BoxDecoration(
                        color: Color(0xffF9F9F9),
                        border: Border.all(
                          color: Color(0xffE2E2E2),
                        )),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .4,
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .02, bottom: MediaQuery.of(context).size.height * .02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "",
                                style: customisedStyle(context, Color(0xff0D4A95), FontWeight.normal, 13.0),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "",
                                  overflow: TextOverflow.ellipsis,
                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .08,
                        ),
                        Container(color: Color(0xffE2E2E2), height: MediaQuery.of(context).size.height * .1, width: 1),
                        Container(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .02, bottom: MediaQuery.of(context).size.height * .02, left: MediaQuery.of(context).size.width * .04),
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "",
                                    style: customisedStyle(context, Color(0xffC91010), FontWeight.normal, 13.0),
                                  ),
                                  Text(
                                    "",
                                    style: customisedStyle(context, Color(0xff606060), FontWeight.normal, 9.0),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "",
                                  overflow: TextOverflow.ellipsis,
                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: MediaQuery.of(context).size.height * .07,
                    alignment: AlignmentDirectional.centerStart,

                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * .028,
                    ),

                  ),
                  Container(

                      padding: EdgeInsets.only( bottom: 20,top: 20),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 11,
                          mainAxisSpacing: 2,
                          mainAxisExtent: 100, // here set custom Height You Want
                        ),
                        itemBuilder: (BuildContext context, int index) {

                          return  SvgPicture.asset("assets/svg/wallet.svg");


                        },
                      )
                  ),
                  Divider(
                    color: Color(0xffE2E2E2),
                    thickness: 1,
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(

                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.height * .09,
                          decoration: BoxDecoration(
                            color: const Color(0xffF2FDFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .02),
                                child: Text(
                                  "",
                                  style: customisedStyle(context, Color(0xff1F7682), FontWeight.w600, 16.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .01),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .37,
                                  child: Text(
                                    "",
                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.height * .09,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF2F2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .02),
                                child: Text(
                                  "",
                                  style: customisedStyle(context, Color(0xffC34C4C), FontWeight.w600, 16.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .01),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .37,
                                  child: Text(
                                    "",
                                    overflow: TextOverflow.ellipsis,
                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  zakath
                      ? Container(
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                        child: ListTile(
                          tileColor: Color(0xffF3F7FC),
                          title: Text(
                            "",
                            style: customisedStyle(context, Color(0xff00744C), FontWeight.w500, 16.0),
                          ),
                          trailing: Text(
                            "",
                            style: customisedStyle(context, Colors.black, FontWeight.w600, 15.0),
                          ),
                        ),
                      )
                      : SizedBox(),
                  isIntrest
                      ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                          child: ListTile(
                            tileColor: Color(0xffF3F7FC),
                            title: Text(
                              "",
                              style: customisedStyle(context, Color(0xff00744C), FontWeight.w500, 16.0),
                            ),
                            trailing: Text(
                              "",
                              style: customisedStyle(context, Colors.black, FontWeight.w600, 15.0),
                            ),
                          ),
                        ),
                      )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.height * .09,
                          decoration: BoxDecoration(
                            color: const Color(0xffF2FDFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .02),
                                child: Text(
                                  "",
                                  style: customisedStyle(context, Color(0xff1F7682), FontWeight.w600, 16.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .01),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .37,
                                  child: Text(
                                    "",
                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.height * .09,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF2F2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .02),
                                child: Text(
                                  "",
                                  style: customisedStyle(context, Color(0xffC34C4C), FontWeight.w600, 16.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .04, top: MediaQuery.of(context).size.height * .01),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .37,
                                  child: Text(
                                    "",
                                    overflow: TextOverflow.ellipsis,
                                    style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  )
                ],
              )),
        ),
      ),
    );
  }


  checkExpire(productExpiryDate)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ProductExpiryDate',productExpiryDate);
    print(productExpiryDate);
    var expiryDate = prefs.getString('ProductExpiryDate') ?? '';
    print(expiryDate);
    var dt = DateTime.parse(productExpiryDate);

    var now = new DateTime.now();
    if (dt.compareTo(now) < 0) {

      Navigator.push(context, MaterialPageRoute(builder: (context) => ExpireScreen()));

    } else {
     }

  }



  void showMyDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(

            content: SingleChildScrollView(
              child: Container(
                padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 15),
                        child: SvgPicture.asset("assets/svg/userExpired.svg"),
                      ),
                    ),
                    Text(
                      "Contact us",
                      style: customisedStyle(context, Color(0xff5346BD), FontWeight.w500, 14.0),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "+91 9037444800",
                      style: customisedStyle(context, Colors.black, FontWeight.w400, 14.0),
                      textAlign: TextAlign.center,
                    ),

                    TextButton(
                      onPressed: () async{
                        SharedPreferences preference = await SharedPreferences.getInstance();
                        Navigator.pop(context);
                        preference.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => NewLoginScreen(),
                            ),
                                (route) => false);

                      },
                      child: Text(
                        "Okay",
                        style: customisedStyle(context, Color(0xff5728C4), FontWeight.w600, 15.0),
                      ),
                    ),

                  ],
                ),
              )
            ),

          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<DashBoardBloc, DashBoardState> (
      builder: (context, state) {
        if (state is DashBoardLoading) {

          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff5728C4),
            ),
          );


        }
        if (state is DashBoardLoaded)  {


          modelClassDashboard = BlocProvider.of<DashBoardBloc>(context).modelClassDashboard;

          if (modelClassDashboard.data!.accountsList!.isEmpty) {
            showTabBar = false;
            noItems = true;
          } else {
            showTabBar = true;
            noItems = false;
          }



           checkExpire(modelClassDashboard.data!.expiryDate!);


            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xffffffff),
              appBar: AppBar(
                toolbarHeight: MediaQuery.of(context).size.height / 11,

                backgroundColor: const Color(0xffffffff),
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dashboard',
                      style: customisedStyle(
                          context, Color(0xff13213A), FontWeight.w600, 22.0),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences
                            .getInstance();

                        final result = await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                                NewSetupAccountCountry()));
                        print(
                            "_______________________________________${result}");

                        dashBoardApiFunction();
                      },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: mWidth * .15,
                            child: Text(
                              default_country_name + "-" + countryShortCode,
                              overflow: TextOverflow.ellipsis,
                              style: customisedStyle(
                                  context, Color(0xff0073D8), FontWeight.w500,
                                  13.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.black,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: noItems
                  ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                  height: mHeight * .09,
                ),
                Container(

                  alignment: Alignment.center,
                  height: mHeight * .28,

                  child: SvgPicture.asset("assets/svg/add_accnt.svg"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: SvgPicture.asset("assets/svg/Hello!.svg"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: SvgPicture.asset("assets/svg/logout.svg"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Create an cash/bank account for \nthis country to continue.",style: customisedStyle(context, Color(0xff585858), FontWeight.normal, 16.0),textAlign:  TextAlign.center,),
                )
                ,

                Container(
                  height: mHeight * .06,
                  width: mWidth *.54,
                  child: ElevatedButton(
                    onPressed: () {
                      btmSheetFunction(context: context, type: "Create");

                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2BAAFC)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ))),
                    child: Row(

                      children: [
                        Icon(Icons.add,color: Colors.white,),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Add an account',
                            style: customisedStyle(context, Colors.white, FontWeight.normal, 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])
                  : Container(
                height: mHeight,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(

                    children: [

                      Container(
                        height: mHeight * .1,
                        decoration: BoxDecoration(
                            color: Color(0xffF9F9F9),
                            border: Border.all(
                              color: Color(0xffE2E2E2),
                            )),
                        child: Row(
                          children: [
                            Container(
                              width: mWidth * .4,
                              padding: EdgeInsets.only(left: mWidth * .04,
                                  top: mHeight * .02,
                                  bottom: mHeight * .02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Balance",
                                    style: customisedStyle(
                                        context, Color(0xff0D4A95),
                                        FontWeight.normal, 13.0),
                                  ),
                                  Container(
                                    width: mWidth,
                                    child: Text(
                                      "$countryCurrencyCode ${roundStringWith(
                                          modelClassDashboard.data!
                                              .totalBalance!)}",
                                      overflow: TextOverflow.ellipsis,
                                      style: customisedStyle(
                                          context, Colors.black,
                                          FontWeight.w500, 15.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: mWidth * .08,
                            ),
                            Container(color: Color(0xffE2E2E2),
                                height: mHeight * .1,
                                width: 1),
                            GestureDetector(
                              onTap: () async{




                             var result =await   Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ListExpenseScreen()));


                             dashBoardApiFunction();

                              },
                              child: Container(
                                color: Color(0xffF9F9F9),
                                padding: EdgeInsets.only(top: mHeight * .02,
                                    bottom: mHeight * .02,
                                    left: mWidth * .04),
                                width: mWidth * .4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Expense",
                                          style: customisedStyle(
                                              context, Color(0xffC91010),
                                              FontWeight.normal, 13.0),
                                        ),
                                        Text(
                                          "- This month",
                                          style: customisedStyle(
                                              context, Color(0xff606060),
                                              FontWeight.normal, 9.0),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: mWidth,
                                      child: Text(
                                        "$countryCurrencyCode ${roundStringWith(
                                            modelClassDashboard.data!
                                                .monthExpense!)}",
                                        overflow: TextOverflow.ellipsis,
                                        style: customisedStyle(
                                            context, Colors.black,
                                            FontWeight.w500, 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: mHeight * .07,
                        alignment: AlignmentDirectional.centerStart,
                        padding: EdgeInsets.only(
                          left: mHeight * .028,
                        ),
                        child: Text(
                          "Accounts",
                          style: customisedStyle(
                              context, Colors.black, FontWeight.w500, 17.0),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, bottom: 20),
                          child: modelClassDashboard.data!.accountsList!
                              .isNotEmpty
                              ? GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: modelClassDashboard.data!.accountsList!
                                .length + 1,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 5,
                              mainAxisExtent: 100, // here set custom Height You Want
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              if (index <
                                  modelClassDashboard.data!.accountsList!
                                      .length) {
                                return GestureDetector(
                                  onTap: () async {
                                    final result = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                            DashboardDetailScreen(
                                                accountId: modelClassDashboard.data!.accountsList![index].id!,
                                                accountType: modelClassDashboard.data!.accountsList![index].accountType)));
                                    dashBoardApiFunction();
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            width: mWidth * .2,
                                            height: mHeight * .03,
                                            child: Text(
                                              modelClassDashboard.data!
                                                  .accountsList![index]
                                                  .accountName!,
                                              overflow: TextOverflow.ellipsis,
                                              style: customisedStyle(
                                                  context, Color(0xff003D88),
                                                  FontWeight.w500, 10.0),
                                            )),
                                        modelClassDashboard.data!
                                            .accountsList![index].accountType ==
                                            "2"
                                            ? SvgPicture.asset(
                                            "assets/svg/bank.svg")
                                            : SvgPicture.asset(
                                            "assets/svg/wallet.svg"),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                            alignment: Alignment.center,

                                            child: Text(
                                              countryCurrencyCode +
                                                  " " +
                                                  "${roundStringWith(
                                                    modelClassDashboard.data!
                                                        .accountsList![index]
                                                        .balance!,
                                                  )}",
                                              overflow: TextOverflow.ellipsis,
                                              style: customisedStyle(
                                                  context, Colors.black,
                                                  FontWeight.w500, 10.0),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              } else {


                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        width: mWidth * .2,
                                        height: mHeight * .02,
                                        child: Text(
                                          "",
                                          overflow: TextOverflow.ellipsis,
                                          style: customisedStyle(context, Color(0xff003D88), FontWeight.w500, 10.0),
                                        )),

                                    Container(
                                      height: mHeight * .060,
                                      width: mWidth * .5,
                                      child:    Container(

                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffF9F9F9),
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () async {

                                            btmSheetFunction(context: context,
                                                type: 'Create',
                                                id: "");
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            width: mWidth * .3,
                                            child: Text(
                                              "",
                                              overflow: TextOverflow.ellipsis,
                                              style: customisedStyle(context, Colors.black, FontWeight.w500, 9.0),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
                                            width: mWidth * .3,
                                            child: Text(
                                              "",
                                              overflow: TextOverflow.ellipsis,
                                              style: customisedStyle(context, Color(0xffC91919), FontWeight.w500, 9.0),
                                            )),
                                      ],
                                    ),
                                  ],
                                );

                              }
                            },
                          )
                              : SizedBox(
                              height: mHeight * .7,
                              child: const Center(
                                  child: Text(
                                    "Not found !",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )))),
                      Divider(
                        color: Color(0xffE2E2E2),
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: mWidth * .04,
                        ),
                        height: mHeight * .12,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: mHeight * .1,
                              width: mWidth * .45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xffE2E2E2),
                                  )),
                              child: Row(
                                children: [
                                  ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                50))),
                                    child: Container(
                                      height: mHeight * .1,
                                      width: mWidth * .02,
                                      color: Color(0xff3C7CCA),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mWidth * .05,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        height: mHeight * .02,
                                      ),
                                      Text(
                                        "Bank Balance",
                                        style: customisedStyle(
                                            context, Color(0xff003D88),
                                            FontWeight.normal, 10.0),
                                      ),
                                      Container(
                                        width: mWidth * .37,
                                        child: Text(
                                          "$countryCurrencyCode ${roundStringWith(
                                              modelClassDashboard.data!
                                                  .totalBankBalance!)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: customisedStyle(
                                              context, Colors.black,
                                              FontWeight.w500, 14.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: mWidth * .03,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: mHeight * .1,
                              width: mWidth * .45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xffE2E2E2),
                                  )),
                              child: Row(
                                children: [
                                  ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20))),
                                    child: Container(
                                      height: mHeight * .1,
                                      width: mWidth * .02,
                                      color: Color(0xff4CC569),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mWidth * .05,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        height: mHeight * .02,
                                      ),
                                      Text(
                                        "Cash Balance",
                                        style: customisedStyle(
                                            context, Color(0xff016E1B),
                                            FontWeight.normal, 10.0),
                                      ),
                                      Container(
                                        width: mWidth * .37,
                                        child: Text(
                                          "$countryCurrencyCode ${roundStringWith(
                                              modelClassDashboard.data!
                                                  .totalCashBalance!)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: customisedStyle(
                                              context, Colors.black,
                                              FontWeight.w500, 14.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      zakath
                          ? GestureDetector(
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ZakahList()));

                          dashBoardApiFunction();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: mWidth * .04,
                            right: mWidth * .04,
                          ),
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xffF9F9F9),
                                borderRadius: BorderRadius.circular(5)),
                            child: ListTile(
                              tileColor: Color(0xffF3F7FC),
                              title: Text(
                                "Zakah",
                                style: customisedStyle(
                                    context, Color(0xff00744C), FontWeight.w500,
                                    16.0),
                              ),
                              trailing: Text(
                                "$countryCurrencyCode ${roundStringWith(
                                    modelClassDashboard.data!.totalZakath!)}",
                                style: customisedStyle(
                                    context, Colors.black, FontWeight.w600,
                                    15.0),
                              ),
                            ),
                          ),
                        ),
                      )
                          : SizedBox(),
                      isIntrest
                          ? GestureDetector(
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => InterestList()));

                          dashBoardApiFunction();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: mWidth * .04,
                              right: mWidth * .04,
                              top: mHeight * .02),
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xffF9F9F9),
                                borderRadius: BorderRadius.circular(5)),
                            child: ListTile(
                              tileColor: Color(0xffF3F7FC),
                              title: Text(
                                "Interest",
                                style: customisedStyle(
                                    context, Color(0xff007051), FontWeight.w500,
                                    16.0),
                              ),
                              trailing: Text(
                                "$countryCurrencyCode ${roundStringWith(
                                    modelClassDashboard.data!.totalInterest!)}",
                                style: customisedStyle(
                                    context, Colors.black, FontWeight.w600,
                                    15.0),
                              ),
                            ),
                          ),
                        ),
                      )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.only(left: mWidth * .04,
                            right: mWidth * .04,
                            top: mHeight * .02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        PayableRecievaleList(
                                          type: 'Receivable',)));

                                dashBoardApiFunction();
                              },
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .45,
                                height: mHeight * .13,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF2FDFF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: mWidth * .04,
                                          top: mHeight * .02),
                                      child: Text(
                                        "Receivables",
                                        style: customisedStyle(
                                            context, Color(0xff007051),
                                            FontWeight.w600, 16.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: mWidth * .04,
                                          top: mHeight * .01),
                                      child: Container(
                                        width: mWidth * .37,
                                        child: Text(
                                          "$countryCurrencyCode ${roundStringWith(
                                              modelClassDashboard.data!
                                                  .totalRecievable!)}",
                                          style: customisedStyle(
                                              context, Colors.black,
                                              FontWeight.w500, 15.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        PayableRecievaleList(
                                          type: 'Payable',)));

                                dashBoardApiFunction();
                              },
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .43,
                                height: mHeight * .13,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFF2F2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: mWidth * .04,
                                          top: mHeight * .02),
                                      child: Text(
                                        "Payables",
                                        style: customisedStyle(
                                            context, Color(0xffC34C4C),
                                            FontWeight.w600, 16.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: mWidth * .04,
                                          top: mHeight * .01),
                                      child: Container(
                                        width: mWidth * .37,
                                        child: Text(
                                          "$countryCurrencyCode ${roundStringWith(
                                              modelClassDashboard.data!
                                                  .totalPayable!)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: customisedStyle(
                                              context, Colors.black,
                                              FontWeight.w500, 15.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mHeight * .1,
                      )
                    ],
                  ),
                ),
              ),
            );

        }
        if (state is DashBoardError) {
          return Center(
            child: Text(
              "Something went wrong",
              style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

btmSheetFunction({required context, required String type, String? id, String? accountName, String? openingBalance , int? BankOrCash}) {
  final ValueNotifier<int> selectedIndex = ValueNotifier(type == "Create" ? 0 :BankOrCash!);
  DateTime currentDate = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
  TextEditingController nameController = TextEditingController()..text = type != "Create" ?accountName.toString():"";
  late CreateAccountModelClass createAccountModelClass;
  late EditAccountModelClass editAccountModelClass;
  late int openingBalanceValue;
  final formKey = GlobalKey<FormState>();
  TextEditingController openingBalanceController = TextEditingController()..text = type != "Create" ?roundStringWithValue(openingBalance.toString(),2):"0.00";

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
                  BlocProvider.of<DashBoardBloc>(context).add(FetchDashBoardEvent());

                  Navigator.pop(context);
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
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final organizationId = prefs.getString("organisation");
                editAccountModelClass = BlocProvider.of<AccountBloc>(context).editAccountModelClass;

                if (editAccountModelClass.statusCode == 6000) {
                  Navigator.pop(context);
                  var netWork = await checkNetwork();
                  if (netWork) {
                    return BlocProvider.of<Dash_detailBloc>(context).add(DashDetailEvent(organisationId: organizationId!, id: id!));
                  } else {
                    msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                  }

                  BlocProvider.of<DashBoardBloc>(context).add(FetchDashBoardEvent());

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
                    padding: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06, top: mHeight * .03, bottom: mWidth * .03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                          type == "Create"?  selectedIndex.value = 0: null;
                          },
                          child: ValueListenableBuilder<int>(
                              valueListenable: selectedIndex,
                              builder: (context, value, _) {
                                return Container(
                                  alignment: Alignment.center,
                                  height: mHeight * .05,
                                  width: mWidth * .43,
                                  decoration: BoxDecoration(
                                      color: selectedIndex.value == 0 ? Color(0xff4485D4) : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffD6E0F6))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/bankpicture.svg",
                                        color: value == 0 ? Colors.white : Colors.black,
                                      ),
                                      Text(
                                        'Bank',
                                        style: customisedStyle(context, value == 0 ? Colors.white : Color(0xff39424E), FontWeight.normal, 16.0),
                                      ),
                                      SizedBox(
                                        width: mWidth * .033,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                        GestureDetector(
                          onTap: () {
                            type == "Create"?  selectedIndex.value = 1:null;
                          },
                          child: ValueListenableBuilder<int>(
                              valueListenable: selectedIndex,
                              builder: (context, value, _) {
                                return Container(
                                  height: mHeight * .05,
                                  width: mWidth * .43,
                                  decoration: BoxDecoration(
                                      color: value == 1 ? Colors.green : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffD6E0F6))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/amount.svg",
                                        color: value == 1 ? Colors.white : Colors.black,
                                      ),
                                      Text(
                                        'Cash',
                                        style: customisedStyle(context, value == 1 ? Colors.white : Color(0xff39424E), FontWeight.normal, 16.0),
                                      ),
                                      SizedBox(
                                        width: mWidth * .05,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 60.0,
                        minHeight: 60.0,
                      ),
                      child: TextFormField(
                        controller: nameController,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim().isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        onTap: () =>
                        nameController.selection = TextSelection(baseOffset: 0, extentOffset: nameController.value.text.length),

                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF3F7FC),
                          filled: true,
                          hintText: "Account Name",
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 50.0,
                        minHeight: 50.0,
                      ),
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                        ],
                        controller:  openingBalanceController,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim().isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        onTap: () =>
                        openingBalanceController.selection = TextSelection(baseOffset: 0, extentOffset: openingBalanceController.value.text.length),
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF3F7FC),
                          filled: true,
                          hintText: "Opening Balance",
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xffE2E2E2),
                    thickness: 1,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: mWidth * .06, right: mWidth * .06, bottom: mWidth * .03),
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
                          type == "Create" ? 'Add Account' : "Edit Account",
                          style: customisedStyle(context, Colors.black, FontWeight.w500, 16.0),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (selectedIndex.value == 0) {
                              openingBalanceValue = 2;
                            } else {
                              openingBalanceValue = 1;
                            }
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            final organizationId = prefs.getString("organisation");

                            if (formKey.currentState!.validate() && type == "Create") {
                              if (formKey.currentState!.validate()) {
                                var netWork = await checkNetwork();

                                if (netWork) {
                                  return BlocProvider.of<AccountBloc>(context).add(CreateAccountEvent(
                                    accountName: nameController.text,
                                    openingBalance: openingBalanceController.text,
                                    organisation: organizationId!,
                                    country: "",
                                    account_type: openingBalanceValue,
                                    as_on_date: formattedDate,
                                  ));
                                } else {
                                  msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
                                }
                              } else {
                                return null;
                              }
                            }
                            if (formKey.currentState!.validate() && type == "Edit") {
                              var netWork = await checkNetwork();

                              if (netWork) {
                                return BlocProvider.of<AccountBloc>(context).add(EditAccountEvent(
                                    id: id!,
                                    organisation: organizationId!,
                                    accountName: nameController.text,
                                    openingBalance: openingBalanceController.text,
                                    country: "",
                                    date: formattedDate,
                                    accountType: openingBalanceValue.toString()));
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
