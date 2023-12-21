import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Utilities/CommenClass/search_commen_class.dart';
import '../../../Utilities/global/text_style.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);
  @override
  _ContactsPageState createState() => _ContactsPageState();
}
class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts=[];
  List<Contact> searchList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }


  _contactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.restricted;
    } else {
      return permission;
    }
  }
///check permission is granted or not before func wrks


  void  getContact() async {

      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
        setState(() {});
      }
 }

  TextEditingController searchController = TextEditingController();


  onSearchTextChanged(String text) async {
    searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    contacts.forEach((userDetail) {
      if (userDetail.name.toString().toLowerCase().contains(text.toLowerCase())) searchList.add(userDetail);
    });
    setState(() {});
  }

  void filterSearchResults(String query) {
    List<Contact> demoList = [];
    demoList.addAll(contacts);
   if (query.isNotEmpty) {
      List<Contact> dummyListData = [];
      demoList.forEach((item) {
        if (item.displayName.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      setState(() {
        searchList.clear();
        searchList.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        searchList.clear();
        searchList.addAll(contacts);
      });
    }
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.restricted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }
  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
      SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 11,

        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title:  Text(
            "Contact List",
            style:customisedStyle(
                context, Color(0xff13213A), FontWeight.w600, 22.0),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                onChanged: (text) {
                  filterSearchResults(searchController.text);
                },
              ),
              SizedBox(
                height: mHeight * .02,
              ),



              new Expanded(
                child: searchList.length != 0 || searchController.text.isNotEmpty
                    ? searchList.isEmpty
                    ?  Center(child: Text("No search data",style: customisedStyle(context, Colors.black, FontWeight.w600, 12.0),))
                    :  ListView.builder(
                  itemCount: searchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Uint8List? image = searchList[index].photo;
                    String num = (searchList[index].phones.isNotEmpty) ? (searchList[index].phones.first.number) : "--";
                    String displayName = "${searchList[index].displayName}";
                    return ListTile(
                        leading: (searchList[index].photo == null)
                            ? const CircleAvatar(child: Icon(Icons.person))
                            : CircleAvatar(backgroundImage: MemoryImage(image!)),
                        title: Text(
                            "${searchList[index].displayName}"),
                        subtitle: Text(num),
                        onTap: () {
                          Navigator.pop(context,[displayName,num]);

                        });
                  },
                )

                    : contacts.isEmpty
                    ? Center(child: Text("No Contact",style: customisedStyle(context, Colors.black, FontWeight.w600 ,12.0,),))
                    : ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Uint8List? image = contacts[index].photo;
                    String num = (contacts[index].phones.isNotEmpty) ? (contacts[index].phones.first.number) : "--";
                    String displayName = "${contacts[index].displayName}";
                    return ListTile(
                        leading: (contacts[index].photo == null)
                            ? const CircleAvatar(child: Icon(Icons.person))
                            : CircleAvatar(backgroundImage: MemoryImage(image!)),
                        title: Text("${contacts[index].displayName}"),
                        subtitle: Text(num),
                        onTap: () {

                          Navigator.pop(context,[displayName,num]);

                        });
                  },
                ),
              ),



            ],
          ),
        ));
  }
}