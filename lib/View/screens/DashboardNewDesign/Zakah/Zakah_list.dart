import 'package:cuentaguestor_edit/Api%20Helper/Bloc/Dashboard_Zakath_Interest_bloc/zakath_interest_list_bloc.dart';
import 'package:cuentaguestor_edit/View/screens/DashboardNewDesign/Zakah/zakah_detail_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Api Helper/ModelClasses/dashboard/ZakathorInterestListModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/Commen Functions/roundoff_function.dart';
import '../../../../Utilities/global/text_style.dart';
import '../../../../Utilities/global/variables.dart';


class ZakahList extends StatefulWidget {
  const ZakahList({Key? key}) : super(key: key);

  @override
  State<ZakahList> createState() => _ZakahListState();
}

class _ZakahListState extends State<ZakahList> {
  late ZakathorInterestListModelClass zakathorInterestListModelClass;

  listZakahFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;

      return BlocProvider.of<ZakathInterestListBloc>(context).add(FetchInterestZakathListEvent(filter: "Z"));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  @override
  void initState() {
    listZakahFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
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
        elevation: 1,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Zakah List',
              style: customisedStyle(context, Color(0xff13213A), FontWeight.w500, 21.0),
            ),
            Container(
                alignment: Alignment.center,
                height: mHeight * .05,
                width: mWidth * .3,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF3F7FC)),
                child: Text(
                  default_country_name + " - " + countryShortCode,
                  style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),
                ))
          ],
        ),
      ),
      body: Container(
        height: mHeight,
        child: Container(
          child: BlocBuilder<ZakathInterestListBloc, ZakathInterestListState>(
            builder: (context, state) {
              if (state is ZakathInterestListLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff5728C4),
                  ),
                );
              }
              if (state is ZakathInterestListLoaded) {
                zakathorInterestListModelClass = BlocProvider.of<ZakathInterestListBloc>(context).zakathorInterestListModelClass;
                return zakathorInterestListModelClass.data!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: zakathorInterestListModelClass.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ZakahDetailList(
                                        id: zakathorInterestListModelClass.data![index].id!,
                                        accountName: zakathorInterestListModelClass.data![index].accountName!,
                                      )));

                              listZakahFunction();
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: mHeight * .01,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: mWidth * .07, right: mWidth * .07),
                                    color: Colors.white,
                                    height: mHeight * .08,
                                    width: mWidth,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              zakathorInterestListModelClass.data![index].accountName!,
                                              style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                            ),
                                            Text(
                                              countryCurrencyCode + " " + roundStringWith(zakathorInterestListModelClass.data![index].amount!),
                                              style: customisedStyle(context, Colors.black, FontWeight.w600, 14.0),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              zakathorInterestListModelClass.data![index].accountType == 1 ? "Cash" : "Bank",
                                              style: customisedStyle(context, Colors.black, FontWeight.w500, 15.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(height: 1, color: Color(0xffE2E2E2), width: mWidth * .99),
                                ],
                              ),
                            ),
                          );
                        })
                    : SizedBox(
                        height: mHeight * .7,
                        child: const Center(
                            child: Text(
                          "Not found !",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )));
              }
              if (state is ZakathInterestListError) {
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
}
