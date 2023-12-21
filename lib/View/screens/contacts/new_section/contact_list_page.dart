
import 'package:cuentaguestor_edit/View/screens/contacts/new_section/detail_page.dart';
import 'package:cuentaguestor_edit/View/screens/contacts/new_section/search_contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Contact/contact_bloc.dart';
import '../../../../Api Helper/ModelClasses/contact/ListContactModelClass.dart';
import '../../../../Api Helper/Repository/api_client.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../Utilities/global/text_style.dart';
import '../../../../Utilities/global/variables.dart';
import '../../DashboardNewDesign/dashboard_detail_screen.dart';
import 'crate_contact.dart';


class ListContactPage extends StatefulWidget {
  const ListContactPage({super.key});

  @override
  State<ListContactPage> createState() => _ListContactPageState();
}

class _ListContactPageState extends State<ListContactPage> {
  late int selectedPage;
  PageController? _pageController;

  @override
  void initState() {
    listContactFunction();
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);
    super.initState();
  }

  late ListContactModelClass listContactModelClass;
  listContactFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");
      return BlocProvider.of<ContactBloc>(context).add(ListContactEvent(organisation: organizationId!, page_number: 1, page_size: 40, search: ""));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  transactionPage(index) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ContactDetailPageNew(
              accountName: listContactModelClass.data![index].accountName!,
              accountId: listContactModelClass.data![index].id,
              phone: listContactModelClass.data![index].phone!,
              totalPaid: listContactModelClass.data![index].totalPaid,
              totalReceived: listContactModelClass.data![index].totalReceived,
            )));

    listContactFunction();
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        if (state is ListContactLoading) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff5728C4),
              ),
            ),
          );
        }
        if (state is ListContactLoaded) {
          listContactModelClass = BlocProvider.of<ContactBloc>(context).listContactModelClass;
          return Scaffold(
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
              elevation: 1,
              automaticallyImplyLeading: true,
              titleSpacing: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contacts',
                    style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 21.0),
                  ),
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: mHeight * .05,
                          width: mWidth * .3,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF3F7FC)),
                          child: Text(
                            default_country_name + "-" + countryShortCode,
                            style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),
                          )),
                      IconButton(
                          onPressed: () async {
                            final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchContactList()));
                            listContactFunction();
                          },
                          icon: SvgPicture.asset("assets/svg/search-normal (1).svg",color:  Color(0xff0073D8),))
                    ],
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
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
                              padding: EdgeInsets.only(left: mWidth * .04, top: mHeight * .02, bottom: mHeight * .02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Receivables",
                                    style: customisedStyle(context, Color(0xff1B8407), FontWeight.normal, 12.0),
                                  ),
                                  Container(
                                    width: mWidth,
                                    child: Text(
                                      "$countryCurrencyCode ${roundStringWith(listContactModelClass.totalRecievable!)}",
                                      overflow: TextOverflow.ellipsis,
                                      style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: mWidth * .08,
                            ),
                            Container(color: Color(0xffE2E2E2), height: mHeight * .1, width: 1),
                            Container(
                              padding: EdgeInsets.only(top: mHeight * .02, bottom: mHeight * .02, left: mWidth * .04),
                              width: mWidth * .4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payables",
                                    style: customisedStyle(context, Color(0xffC91010), FontWeight.normal, 12.0),
                                  ),
                                  Container(
                                    width: mWidth,
                                    child: Text(
                                      "$countryCurrencyCode ${roundStringWith(listContactModelClass.totalPayable!)}",
                                      overflow: TextOverflow.ellipsis,
                                      style: customisedStyle(context, Colors.black, FontWeight.w500, 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      Container(
                          color: Color(0xffF9F9F9),

                          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: listContactModelClass.accountsList!.isNotEmpty
                              ? GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listContactModelClass.accountsList!.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5,
                                    mainAxisExtent: 100,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: ()async{



                                        final result = await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardDetailScreen(
                                                    accountId:listContactModelClass.accountsList![index].id!,
                                                    accountType: listContactModelClass.accountsList![index].accountType.toString())));


                                        listContactFunction();





                                      },
                                      child: Container(

                                        child: Column(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                width: mWidth * .2,
                                                height: mHeight * .03,
                                                child: Text(
                                                  listContactModelClass.accountsList![index].accountName!,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: customisedStyle(
                                                      context,
                                                      listContactModelClass.accountsList![index].accountType != 1
                                                          ? Color(0xff003D88)
                                                          : Color(0xff0E7D02),
                                                      FontWeight.w500,
                                                      10.0),
                                                )),
                                            listContactModelClass.accountsList![index].accountType != 1
                                                ? SvgPicture.asset("assets/svg/bank.svg")
                                                : SvgPicture.asset("assets/svg/wallet.svg"),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                width: mWidth * .3,
                                                child: Text(
                                                  countryCurrencyCode +
                                                      "." +
                                                      "${roundStringWith(
                                                        listContactModelClass.accountsList![index].balance!,
                                                      )}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: customisedStyle(context, Colors.black, FontWeight.w500, 10.0),
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : SizedBox(
                                  height: mHeight * .1,
                                  child: const Center(
                                      child: Text(
                                    "Accounts not found !",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )))),

                      Container(
                        color: Color(0xffF9F9F9),
                        height: 16,
                      ),

                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listContactModelClass.data!.length + 1,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 5,
                              mainAxisExtent: 100,
                            ),
                            itemBuilder: (BuildContext context, int index) {

                              double highestReceived = 0.00;
                              double highestPaid = 0.00;
                              double difference = 0.00;
                              String amount = '0.00';
                              if (listContactModelClass.data!.length == index) {
                              } else {
                                highestReceived = double.parse(listContactModelClass.data![index].totalReceived ?? '0.00');
                                highestPaid = double.parse(listContactModelClass.data![index].totalPaid ?? '0.00');
                                difference = (highestReceived - highestPaid).abs();
                                amount = difference.toString();
                              }
                              Color returnColor = Color(0xff0E7D02);
                              if (highestPaid > highestReceived) {
                                returnColor = Color(0xffCC0000);
                              } else {
                                returnColor = Color(0xff0E7D02);
                              }

                              if (listContactModelClass.data!.isEmpty || listContactModelClass.data!.length == index) {

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

                                            final result = await Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => ContactCreateNew(
                                                  openingBalance: "0.00",
                                                  type: 'Create',
                                                  imagePath: '',
                                                )));
                                            listContactFunction();
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
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    transactionPage(index);
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            width: mWidth * .2,
                                            height: mHeight * .03,
                                            child: Text(
                                              listContactModelClass.data![index].accountName!,
                                              overflow: TextOverflow.ellipsis,
                                              style: customisedStyle(context, Colors.black, FontWeight.w500, 10.0),
                                            )),
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[300],
                                          backgroundImage: listContactModelClass.data![index].photo == ''
                                              ?  AssetImage("assets/contact/imgcontact.png")
                                              : AssetImage("${ApiClient.imageBasePath}${listContactModelClass.data![index].photo}"),

                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                            alignment: Alignment.center,

                                            width: mWidth * .3,
                                            child: Text(
                                              countryCurrencyCode + "." + "${(roundStringWith(amount))}",
                                              overflow: TextOverflow.ellipsis,
                                              style: customisedStyle(context, returnColor, FontWeight.w500, 10.0),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (state is ListContactError) {
          return Center(
              child: Text(
            "Something went wrong",
            style: customisedStyle(context, Colors.black, FontWeight.w500, 13.0),
          ));
        }
        return SizedBox();
      },
    );
  }
}
