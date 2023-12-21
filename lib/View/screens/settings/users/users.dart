import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../../Api Helper/Bloc/User/user_bloc.dart';
import '../../../../Api Helper/ModelClasses/User/DeleteUserModelClass.dart';
import '../../../../Api Helper/ModelClasses/User/DetailUserModelClass.dart';
import '../../../../Api Helper/ModelClasses/User/ListUserModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/CommenClass/search_commen_class.dart';
import '../../../../Utilities/global/text_style.dart';
import 'add_new_user.dart';

class UsersList extends StatefulWidget {
  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
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

  TextEditingController searchController = TextEditingController();
  var photo = "";

  @override
  void initState() {
    listUserApiFunction();
    progressBar = ProgressBar();

    super.initState();
  }

  late ListUserModelClass listUserModelClass;

  listUserApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<UserBloc>(context).add(ListUserEvent(search: ""));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  deleteUserApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<UserBloc>(context)
          .add(DeleteUserEvent(id: userId));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  detailUserApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<UserBloc>(context)
          .add(DetailUserEvent(id: userId));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  late DeleteUserModelClass deleteUserModelClass;

  late DetailUserModelClass detailUserModelClass;

  int userId = 0;
  int customIndex = 0;
  String imageBasePath = "https://www.api.zinco.vikncodes.com";

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) async {
            if (state is DetailUserLoaded) {
              hideProgressBar();
              detailUserModelClass =
                  BlocProvider.of<UserBloc>(context).detailUserModelClass;

              final result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateAndEditUser(
                        type: 'Edit',
                        firstName: detailUserModelClass.data!.firstName,
                        phone: detailUserModelClass
                            .data!.phoneNumbers!.first.phone,
                        useroleName: detailUserModelClass.data!.userTypeName,
                        useroleTypeID: detailUserModelClass.data!.userType,
                        email: detailUserModelClass.data!.email,
                        userName: detailUserModelClass.data!.username,
                        password: detailUserModelClass.data!.password,
                        id: detailUserModelClass.data!.id.toString(),
                        organisation: detailUserModelClass
                            .data!.phoneNumbers!.first.organization,
                        photo: imageBasePath + detailUserModelClass.data!.photo,
                      )));
              listUserApiFunction();
            }
            if (state is DetailUserError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is DeleteUserLoading) {
              const CircularProgressIndicator(
                color: Color(0xff5728C4),
              );
            }
            if (state is DeleteUserLoaded) {
              hideProgressBar();
              listUserApiFunction();
              deleteUserModelClass =
                  BlocProvider.of<UserBloc>(context).deleteUserModelClass;
              if (deleteUserModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(
                    context: context, textMsg: "Something went wrong");
              }
            }
            if (state is DeleteUserError) {
              hideProgressBar();
            }
          },
        )
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
            'Users',
            style: customisedStyle(
                context, Color(0xff13213A), FontWeight.w600, 22.0),
          ),

        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              SearchFieldWidget(
                autoFocus: false,
                mHeight: mHeight,
                hintText: 'Search',
                controller: searchController,
                onChanged: (quary) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final organizationId = prefs.getString("organisation");

                  if (quary.isNotEmpty) {
                    BlocProvider.of<UserBloc>(context)
                        .add(ListUserEvent(search: quary));
                  } else {
                    BlocProvider.of<UserBloc>(context)
                        .add(ListUserEvent(search: ""));
                  }
                },
              ),
              SizedBox(
                height: mHeight * .01,
              ),
              Expanded(
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserListSearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff5728C4),
                        ),
                      );
                    }
                    if (state is UserListSearchLoaded) {
                      listUserModelClass =
                          BlocProvider.of<UserBloc>(context).listUserModelClass;
                       return listUserModelClass.data!.isNotEmpty
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listUserModelClass.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: mHeight * .15,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Color(0xffDEDEDE),
                                            width: .5),
                                        borderRadius: BorderRadius.circular(1)),
                                    tileColor: const Color(0xffFFFFFF),
                                    title: Container(
                                      width: mWidth * .8,
                                      child: Text(
                                        listUserModelClass
                                            .data![index].firstName!,
                                        style: customisedStyle(
                                            context,
                                            Color(0xff8D8D8D),
                                            FontWeight.bold,
                                            15.0),
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: mWidth * .8,
                                            child: Text(
                                              listUserModelClass
                                                  .data![index].username!,
                                              style: customisedStyle(
                                                  context,
                                                  Color(0xff000000),
                                                  FontWeight.bold,
                                                  15.0),
                                            )),
                                        Container(
                                          width: mWidth * .8,
                                          child: Text(
                                            listUserModelClass
                                                .data![index].email!,
                                            overflow: TextOverflow.ellipsis,
                                            style: customisedStyle(
                                                context,
                                                Color(0xff9974EF),
                                                FontWeight.bold,
                                                14.0),
                                          ),
                                        ),
                                        Text(
                                          listUserModelClass.data![index]
                                                  .phoneNumbers!.isNotEmpty
                                              ? listUserModelClass.data![index]
                                                  .phoneNumbers!.first.phone!
                                              : "",
                                          style: customisedStyle(
                                              context,
                                              Color(0xff8D8D8D),
                                              FontWeight.bold,
                                              15.0),
                                        ),
                                      ],
                                    ),
                                    trailing:PopupMenuButton<String>(
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
                                          customIndex = index;
                                          userId = listUserModelClass
                                              .data![index].id!;
                                          detailUserApiFunction();

                                        } else if (value == 'delete') {

                                          btmDialogueFunction(
                                              isDismissible: true,
                                              context: context,
                                              textMsg: 'Are you sure delete ?',
                                              fistBtnOnPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              secondBtnPressed: () async {
                                                userId = listUserModelClass
                                                    .data![index].id!;
                                                deleteUserApiFunction();
                                                Navigator.of(context).pop(true);
                                              },
                                              secondBtnText: 'Yes');


                                        }
                                      },
                                    )
                                  ),
                                );
                              })
                          : SizedBox(
                              height: mHeight * .7,
                              child: const Center(
                                  child: Text(
                                "Items not found !",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )));
                    }
                    if (state is UserListSearchError) {
                      return Center(
                          child: Text(
                        "Something went wrong",
                        style: customisedStyle(
                            context, Colors.black, FontWeight.w500, 13.0),
                      ));
                    }
                    return SizedBox();
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
                builder: (context) => CreateAndEditUser(
                      type: 'Create',
                    )));
            listUserApiFunction();
          },
        ),
      ),
    );
  }
}
