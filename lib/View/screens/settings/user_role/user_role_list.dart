


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../../Api Helper/Bloc/Userole/userole_bloc.dart';
import '../../../../Api Helper/ModelClasses/Userole/DeleteUseroleModelClass.dart';
import '../../../../Api Helper/ModelClasses/Userole/DetailUseroleModelClass.dart';
import '../../../../Api Helper/ModelClasses/Userole/ListUseroleModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/delete_permission function.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/CommenClass/search_commen_class.dart';
import '../../../../Utilities/global/text_style.dart';
import 'add_user_role.dart';



class UsersRoleList extends StatefulWidget {

  @override
  State<UsersRoleList> createState() => _UsersRoleListState();
}

class _UsersRoleListState extends State<UsersRoleList> {
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
  listUseroleFunction() async {

    var netWork = await checkNetwork();
    if (netWork) {
      if (!mounted) return;

      return
        BlocProvider.of<UseroleBloc>(context).add(ListUseroleGetEvent(search: "", pageNo: 1, items_per_page: 20));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }
@override
  void initState() {
  listUseroleFunction();
  progressBar = ProgressBar();



    super.initState();
  }
   String search = "";



  ValueNotifier valueNotifier = ValueNotifier(2);
  detailUseroleApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<UseroleBloc>(context).add(DetailUseroleGetEvent(id: id));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }



  deleteUseroleApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      showProgressBar();
      return BlocProvider.of<UseroleBloc>(context).add(DeleteUseroleGetEvent(organisationId: organizationId!, userTypeId: userTypeId));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context:context, textMsg: "Check your network connection");
    }

  }
  late  DetailUseroleModelClass detailUseroleModelClass ;
  late DeleteUseroleModelClass deleteUseroleModelClass ;
  int customIndex = 0;
  late ListUseroleModelClass listUseroleModelClass ;





  String id = "";
int userTypeId = 0;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<UseroleBloc, UseroleState>(
          listener: (context, state)async {
            if (state is DetailUseroleLoaded) {

              hideProgressBar();
              detailUseroleModelClass =
                  BlocProvider.of<UseroleBloc>(context).detailUseroleModelClass;
              print("_____________________________${detailUseroleModelClass.data![customIndex].name.toString()}");

              final result =     await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  CreateAndEditUserole(type: 'Edit',
                    organisation: detailUseroleModelClass.data![customIndex].organization,
                   userTypeId: detailUseroleModelClass.data![customIndex].userType!.userTypeId!,
                   userTypeName: detailUseroleModelClass.data![customIndex].userType!.userTypeName!,
                    permissionData: detailUseroleModelClass.data,
                  )));



                  listUseroleFunction();

            }
            if (state is DetailUseroleError) {
              hideProgressBar();
            }
          },
        ),
        BlocListener<UseroleBloc, UseroleState>(
          listener: (context, state) {
            if (state is DeleteUseroleLoading) {
              const CircularProgressIndicator(
                color: Color(0xff5728C4),
              );
            }
            if (state is DeleteUseroleLoaded) {
              hideProgressBar();
              listUseroleFunction();
              deleteUseroleModelClass =
                  BlocProvider.of<UseroleBloc>(context).deleteUseroleModelClass;
              if (deleteUseroleModelClass.statusCode == 6001) {
                msgBtmDialogueFunction(
                    context: context,
                    textMsg: "Something went wrong");
              }
            }
            if (state is DeleteUseroleError) {
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
            'Users Role',
            style:customisedStyle(
                context, Color(0xff13213A), FontWeight.w600, 22.0),

          ),

        ),
        body: Container(
          padding:  EdgeInsets.only(left: mWidth*.04, right: mWidth*.04),
          child: Column(
            children: [
              SearchFieldWidget(
                autoFocus: false,
                mHeight: mHeight,
                hintText: 'Search',
                controller: searchController,
                onChanged: (quary) {
                  if (quary.isNotEmpty) {
                    BlocProvider.of<UseroleBloc>(context).add(ListUseroleGetEvent(search:quary, pageNo: 1, items_per_page: 20));
                  } else {
                    BlocProvider.of<UseroleBloc>(context).add(ListUseroleGetEvent(search: "", pageNo: 1, items_per_page: 20));
                  }
                },

              ),
              SizedBox(
                height: mHeight * .02,),
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
        listUseroleModelClass  = BlocProvider.of<UseroleBloc>(context).listUseroleModelClass;
        return  listUseroleModelClass.data!.isNotEmpty ? ListView.builder(shrinkWrap: true,
            physics: const BouncingScrollPhysics(),

            itemCount: listUseroleModelClass.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var name = listUseroleModelClass.data![index];
              return ListTile(

                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xffDEDEDE), width: .5),
                    borderRadius: BorderRadius.circular(1)),
                tileColor: const Color(0xffFFFFFF),
                title: Text(listUseroleModelClass.data![index].userTypeName!, style: customisedStyle(
                    context,
                    Colors.black,
                    FontWeight.bold,
                    15.0),),

                trailing: PopupMenuButton<String>(
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
                      id = listUseroleModelClass.data![index].id!;
                      detailUseroleApiFunction();

                    } else if (value == 'delete') {

                      btmDialogueFunction(
                          isDismissible: true,
                          context: context,
                          textMsg: 'Are you sure delete ?',
                          fistBtnOnPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          secondBtnPressed: () async {
                            userTypeId = listUseroleModelClass.data![index].userTypeId!;
                            deleteUseroleApiFunction();
                            Navigator.of(context).pop(true);
                          },
                          secondBtnText: 'Yes');


                    }
                  },
                )

              );
            }):SizedBox(
            height: mHeight * .7,
            child: const Center(
                child: Text(
                  "Not found !",
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                )));
      }
      if(state is UseroleListSearchError){
        return Center(child:
        Text("Something went wrong",style: customisedStyle(
            context, Colors.black, FontWeight.w500, 13.0),));
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
          onTap: () async{
         final result = await Navigator.of(context).push(   MaterialPageRoute(builder: (context) => CreateAndEditUserole(type: 'Create',)));
         listUseroleFunction();
         },
        ),
      ),
    );
  }






}
