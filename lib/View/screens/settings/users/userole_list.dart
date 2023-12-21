


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Api Helper/Bloc/Userole/userole_bloc.dart';
import '../../../../Api Helper/ModelClasses/Userole/DeleteUseroleModelClass.dart';
import '../../../../Api Helper/ModelClasses/Userole/DetailUseroleModelClass.dart';
import '../../../../Api Helper/ModelClasses/Userole/ListUseroleModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/CommenClass/search_commen_class.dart';
import '../../../../Utilities/global/text_style.dart';





class ListUserole extends StatefulWidget {

  @override
  State<ListUserole> createState() => _ListUseroleState();
}

class _ListUseroleState extends State<ListUserole> {
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
    progressBar = ProgressBar();
    listUseroleFunction();



    super.initState();
  }
  String search = "";

  late ListUseroleModelClass listUseroleModelClass ;

  ValueNotifier valueNotifier = ValueNotifier(2);





  late  DetailUseroleModelClass detailUseroleModelClass ;
  late DeleteUseroleModelClass deleteUseroleModelClass ;
  int customIndex = 0;





  String id = "";
  int userTypeId = 0;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  BlocProvider.of<UseroleBloc>(context).add(ListUseroleGetEvent(search: quary, pageNo: 1, items_per_page: 20));
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

                          return GestureDetector(
                            onTap: (){
                              Navigator.pop(context, [listUseroleModelClass.data![index].userTypeName,
                                listUseroleModelClass.data![index].id],);
                            },
                            child: ListTile(

                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xffDEDEDE), width: .5),
                                  borderRadius: BorderRadius.circular(1)),
                              tileColor: const Color(0xffFFFFFF),
                              title: Text(listUseroleModelClass.data![index].userTypeName!, style: customisedStyle(
                                  context,
                                  Colors.black,
                                  FontWeight.bold,
                                  15.0),),



                            ),
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

    );
  }






}
