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
import 'detail_page.dart';


class SearchContactList extends StatefulWidget {
  const SearchContactList({Key? key}) : super(key: key);

  @override
  State<SearchContactList> createState() => _SearchContactListState();
}

class _SearchContactListState extends State<SearchContactList> {
  listSearchContactFunction() async {
    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final organizationId = prefs.getString("organisation");

      return BlocProvider.of<ContactBloc>(context).add(ListContactEvent(
          organisation: organizationId!,
          page_number: 1,
          page_size: 30,
          search: ""));
    } else {
      if (!mounted) return;

      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  late ListContactModelClass listContactModelClass;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    listSearchContactFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              style: customisedStyle(
                  context, Color(0xff13213A), FontWeight.w500, 21.0),
            ),
            Row(
              children: [
                Container(
                    alignment: Alignment.center,
                    height: mHeight * .05,
                    width: mWidth * .3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF3F7FC)),
                    child: Text(
                      default_country_name + "-" + countryShortCode,
                      style: customisedStyle(
                          context, Color(0xff0073D8), FontWeight.w500, 14.0),
                    )),
                IconButton(
                    onPressed: () async {},
                    icon: SvgPicture.asset("assets/svg/search-normal (1).svg",color:  Color(0xff0073D8),))
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: mHeight,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
              ),
              height: mHeight * .06,
              width: mWidth,
              child: TextField(
                onChanged: (quary) async {

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final organizationId = prefs.getString("organisation");
                  if (quary.isNotEmpty) {
                    BlocProvider.of<ContactBloc>(context).add(ListContactEvent(
                        organisation: organizationId!,
                        page_number: 1,
                        page_size: 40,
                        search: quary));
                  } else {
                    BlocProvider.of<ContactBloc>(context).add(ListContactEvent(
                        organisation: organizationId!,
                        page_number: 1,
                        page_size: 40,
                        search: ""));
                  }
                },
                controller: searchController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                       searchController.clear();
                      },
                      icon: Icon(Icons.close),
                      color: Color(0xff2BAAFC),
                    ),

                    contentPadding: EdgeInsets.only(left: mWidth * .07,top: 15),
                    hintText: 'Search',
                    helperStyle: customisedStyle(
                        context, Color(0xff9A9A9A), FontWeight.normal, 15.0),
                    border: InputBorder.none),
              ),
            ),
            Expanded(child: BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                if (state is ListContactLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff5728C4),
                    ),
                  );
                }
                if (state is ListContactLoaded) {
                  listContactModelClass = BlocProvider.of<ContactBloc>(context)
                      .listContactModelClass;
                  return listContactModelClass.data!.isNotEmpty
                      ? Container(
                          color: Colors.white,
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listContactModelClass.data!.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 5,
                                mainAxisExtent:
                                    100,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                double highestReceived = 0.00;
                                double highestPaid = 0.00;
                                double difference = 0.00;
                                String amount = '0.00';

                                highestReceived = double.parse(
                                    listContactModelClass
                                            .data![index].totalReceived ??
                                        '0.00');
                                highestPaid = double.parse(listContactModelClass
                                        .data![index].totalPaid ??
                                    '0.00');
                                difference =
                                    (highestReceived - highestPaid).abs();
                                amount = difference.toString();

                                Color returnColor = Color(0xff0E7D02);
                                if (highestPaid > highestReceived) {
                                  returnColor = Color(0xffCC0000);
                                } else {
                                  returnColor = Color(0xff0E7D02);
                                }

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
                                              listContactModelClass
                                                  .data![index].accountName!,
                                              overflow: TextOverflow.ellipsis,
                                              style: customisedStyle(
                                                  context,
                                                  Colors.black,
                                                  FontWeight.w500,
                                                  10.0),
                                            )),
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[300],
                                          backgroundImage: listContactModelClass
                                                      .data![index].photo ==
                                                  ''
                                              ? const AssetImage(
                                                  'assets/contact/imgcontact.png')
                                              : AssetImage(
                                                  "${ApiClient.imageBasePath}${listContactModelClass.data![index].photo}"),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                            alignment: Alignment.center,

                                            width: mWidth * .3,
                                            child: Text(
                                              countryCurrencyCode +
                                                  "." +
                                                  "${(roundStringWith(amount))}",
                                              overflow: TextOverflow.ellipsis,
                                              style: customisedStyle(
                                                  context,
                                                  returnColor,
                                                  FontWeight.w500,
                                                  10.0),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : SizedBox(
                          height: mHeight * .7,
                          child: const Center(
                              child: Text(
                            "Not found !",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )));
                }
                if (state is ListContactError) {
                  return Center(
                      child: Text(
                    "Something went wrong",
                    style: customisedStyle(
                        context, Colors.black, FontWeight.w500, 13.0),
                  ));
                }
                return SizedBox();
              },
            )),
          ],
        ),
      ),
    );
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

    listSearchContactFunction();
  }
}
