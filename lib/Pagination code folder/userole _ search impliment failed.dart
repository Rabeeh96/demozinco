import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Api Helper/Bloc/Userole/userole_bloc.dart';
import '../Api Helper/ModelClasses/Userole/ListUseroleModelClass.dart';
import '../Utilities/CommenClass/search_commen_class.dart';
import '../Utilities/global/text_style.dart';
import '../View/screens/settings/user_role/add_user_role.dart';

class PagiantionUseroleList extends StatefulWidget {
  @override
  State<PagiantionUseroleList> createState() => _PagiantionUseroleListState();
}

class _PagiantionUseroleListState extends State<PagiantionUseroleList> {
  TextEditingController searchController = TextEditingController();
  var photo = "";

  @override
  void initState() {
    super.initState();
  }

  String search = "";

  late ListUseroleModelClass listUseroleModelClass;

  List<CustomUseroleListModelClass> useroleList = [];
  ValueNotifier valueNotifier = ValueNotifier(2);
  late Response response;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text(
          'Users Role',
          style: customisedStyle(
              context, Color(0xff13213A), FontWeight.bold, 22.0),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: mWidth * .04, right: mWidth * .04),
        child: Column(
          children: [
            SearchFieldWidget(
              autoFocus: false,
              mHeight: mHeight,
              hintText: 'Search',
              controller: searchController,
              onChanged: (quary) {},
            ),
            SizedBox(
              height: mHeight * .02,
            ),
            Expanded(
              child: BlocBuilder<UseroleBloc, UseroleState>(
                builder: (context, state) {
                  if (state is UseroleListSearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff5728C4),
                      ),
                    );
                  }
                  if (state is UseroleListSearchLoaded) {
                    Map n = json.decode(utf8.decode(response.bodyBytes));
                    var status = n["StatusCode"];
                    var responseJson = n["data"];
                    var itemCount = n["total_count"];

                    for (Map user in responseJson) {
                      useroleList
                          .add(CustomUseroleListModelClass.fromJson(user));
                    }

                    _refreshController.loadComplete();

                    return ValueListenableBuilder(
                        valueListenable: valueNotifier,
                        builder: (context, value, child) {
                          return SmartRefresher(
                              enablePullUp: true,
                              onLoading: () async {
                                final value = valueNotifier.value++;
                                if (mounted) {
                                  await Future.delayed(
                                      const Duration(milliseconds: 3));
                                }
                              },
                              controller: _refreshController,
                              child: useroleList.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: useroleList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Color(0xffDEDEDE),
                                                  width: .5),
                                              borderRadius:
                                                  BorderRadius.circular(1)),
                                          tileColor: const Color(0xffFFFFFF),
                                          title: Text(
                                            useroleList[index].userTypeName,
                                            style: customisedStyle(
                                                context,
                                                Colors.black,
                                                FontWeight.bold,
                                                15.0),
                                          ),
                                          trailing: SvgPicture.asset(
                                              "assets/svg/options.svg"),
                                        );
                                      })
                                  : SizedBox(
                                      height: mHeight * .7,
                                      child: const Center(
                                          child: Text(
                                        "Not found !",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))));
                        });
                  }
                  if (state is UseroleListSearchError) {
                    return Center(child: Text("Something went wrong"));
                  }
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        child: SvgPicture.asset('assets/svg/add_circle.svg'),
        onTap: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateAndEditUserole(
                    type: 'Create',
                  )));
        },
      ),
    );
  }
}

/// custom model class
class CustomUseroleListModelClass {
  String id, userTypeName, organization;
  int userTypeId;

  CustomUseroleListModelClass(
      {required this.id,
      required this.userTypeName,
      required this.organization,
      required this.userTypeId});

  factory CustomUseroleListModelClass.fromJson(Map<dynamic, dynamic> json) {
    return CustomUseroleListModelClass(
        id: json['id'],
        userTypeName: json['user_type_name'],
        organization: json['organization'],
        userTypeId: json['user_type_id']);
  }
}
