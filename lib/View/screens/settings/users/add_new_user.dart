import 'package:cuentaguestor_edit/View/screens/settings/users/userole_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:io';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/User/user_bloc.dart';
import '../../../../Api Helper/ModelClasses/User/EditUserModelClass.dart';
import '../../../../Api Helper/ModelClasses/User/UserCreateModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/commen_imgeFile.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/camera_screen.dart';
import '../../../../Utilities/CommenClass/commen_txtfield_widget.dart';
import '../../../../Utilities/global/text_style.dart';

class CreateAndEditUser extends StatefulWidget {
  CreateAndEditUser(
      {super.key,
      required this.type,
      this.firstName,
      this.phone,
      this.useroleName,
      this.useroleTypeID,
      this.email,
      this.userName,
      this.password,
      this.id,
      this.organisation,
      this.photo});

  final String type;
  String? firstName;
  String? phone;
  String? useroleName;
  String? useroleTypeID;
  String? email;
  String? userName;
  String? password;
  String? id;
  String? organisation;
  String? photo;

  @override
  State<CreateAndEditUser> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<CreateAndEditUser> {
  TextEditingController contactNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController userRoleController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String pic = "";
  final _formKey = GlobalKey<FormState>();
  var password;

  String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    final length = 8;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';
    String chars = "";

    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  final ValueNotifier<bool> passwordVisible = ValueNotifier(true);
  String passwordText = "";
  String userTypeId = "";
  late UserCreateModelClass userCreateModelClass;

  late EditUserModelClass editUserModelClass;

  File? image;
  File? path;

  @override
  void initState() {
    userTypeId =
        widget.type == "Edit" ? widget.useroleTypeID.toString() : userTypeId;
    contactNameController = TextEditingController()
      ..text = (widget.type == "Edit" ? widget.firstName : "")!;
    phoneNoController = TextEditingController()
      ..text = (widget.type == "Edit" ? widget.phone : "")!;
    userRoleController = TextEditingController()
      ..text = (widget.type == "Edit" ? widget.useroleName : "")!;
    emailController = TextEditingController()
      ..text = (widget.type == "Edit" ? widget.email : "")!;
    userNameController = TextEditingController()
      ..text = (widget.type == "Edit" ? widget.userName : "")!;
    passwordController = TextEditingController()
      ..text = (widget.type == "Edit" ? widget.password : "")!;
    pic = widget.type == "Edit" ? widget.photo! : pic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .02,
    );
    final sizedBox = SizedBox(
      height: mHeight * .03,
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(listener: (context, state) {
          if (state is UserCreateLoaded) {
            userCreateModelClass =
                BlocProvider.of<UserBloc>(context).userCreateModelClass;
            if (userCreateModelClass.statusCode == 6000) {
              Navigator.pop(context);
              msgBtmDialogueFunction(
                  context: context, textMsg: "Successfully create");
            }
            if (userCreateModelClass.statusCode == 6001) {
              alreadyCreateBtmDialogueFunction(
                  context: context,
                  textMsg: userCreateModelClass.message.toString(),
                  buttonOnPressed: () {
                    Navigator.of(context).pop(false);
                  });
            }
          }
        }),
        BlocListener<UserBloc, UserState>(listener: (context, state) {
          if (state is EditUserLoading) {
            const CircularProgressIndicator();
          }
          if (state is EditUserLoaded) {
            editUserModelClass =
                BlocProvider.of<UserBloc>(context).editUserModelClass;
            if (editUserModelClass.statusCode == 6000) {
              Navigator.pop(context);
              msgBtmDialogueFunction(
                context: context,
                textMsg: editUserModelClass.message.toString(),
              );
            }
            if (editUserModelClass.statusCode == 6001) {
              alreadyCreateBtmDialogueFunction(
                  context: context,
                  textMsg: "Something went wrong",
                  buttonOnPressed: () {
                    Navigator.of(context).pop(false);
                  });
            }
          }
          if (state is EditUserError) {
            const Text("Something went wrong");
          }
        }),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
          title: Text(
            'Add User',
            style: customisedStyle(
                context, Color(0xff13213A), FontWeight.w600, 22.0),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: mWidth * .05, right: mWidth * .05),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                space,
                widget.type != "Edit"
                    ? GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => const CameraScreen())));
                          setState(() {
                            path = result;
                            image = result;
                          });

                        },
                        child: path == null
                            ? CircleAvatar(
                                backgroundColor: Color(0xffF3F7FC),
                                radius: 60,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 60,
                                backgroundImage: FileImage(path!),
                              ))
                    : GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => const CameraScreen())));
                          setState(() {
                            path = result;
                            image = result;
                          });

                        },
                        child: path == null
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 60,
                                backgroundImage: NetworkImage(pic),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 60,
                                backgroundImage: FileImage(path!),
                              ),
                      ),
                sizedBox,
                space,
                CommenTextFieldWidget(
                  controller: contactNameController,
                  validator: (val) {
                    if (val == null || val.isEmpty || val.trim().isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  hintText: 'Contact name',
                  readOnly: false,
                  textAlign: TextAlign.start,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      "assets/svg/phone_contact.svg",
                      height: 10,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  textInputType: TextInputType.text,
                  obscureText: false,
                ),
                space,
                CommenTextFieldWidget(
                  controller: phoneNoController,
                  validator: (val) {
                    if (val == null || val.isEmpty || val.trim().isEmpty) {
                      return 'Please enter phone no';
                    }
                    return null;
                  },
                  hintText: "Phone No",
                  readOnly: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  textInputType: TextInputType.phone,
                  obscureText: false,
                ),
                space,
                CommenTextFieldWidget(
                  controller: userRoleController,
                  validator: (val) {
                    if (val == null || val.isEmpty || val.trim().isEmpty) {
                      return 'Please select user role';
                    }
                    return null;
                  },
                  hintText: "User Role",
                  readOnly: true,
                  textAlign: TextAlign.start,
                  onTap: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListUserole()),
                    );
                    result != null ? userRoleController.text = result[0] : Null;
                    result != null ? userTypeId = result[1] : Null;
                  },
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  textInputType: TextInputType.text,
                  obscureText: false,
                ),
                space,
                CommenTextFieldWidget(
                  controller: emailController,
                  validator: (val) {
                    if (val == null || val.isEmpty || val.trim().isEmpty) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  hintText: "Email Address",
                  readOnly: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                ),
                space,
                CommenTextFieldWidget(
                  controller: userNameController,
                  validator: (val) {
                    if (val == null || val.isEmpty || val.trim().isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                  hintText: "Username",
                  readOnly: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  textInputType: TextInputType.name,
                  obscureText: false,
                ),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: passwordVisible,
                        builder:
                            (BuildContext context, bool passwordNewValue, _) {
                          return Expanded(
                            flex: 8,
                            child: CommenTextFieldWidget(
                              controller: passwordController,
                              validator: (val) {
                                if (val == null ||
                                    val.isEmpty ||
                                    val.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                if (val.length < 6) {
                                  return 'Too short';
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    passwordVisible.value =
                                        !passwordVisible.value;
                                  },
                                  icon: passwordNewValue
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: const Color(0xff5346BD),
                                        )
                                      : const Icon(
                                          Icons.remove_red_eye,
                                          color: const Color(0xff5346BD),
                                        )),
                              obscureText: passwordNewValue,
                              hintText: "Password",
                              readOnly: false,
                              textAlign: TextAlign.start,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.none,
                              textInputType: TextInputType.visiblePassword,
                              onChanged: (String value) => setState(() {
                                passwordText = value;
                              }),
                            ),
                          );
                        }),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () async {
                          passwordController.clear();
                          await Future.delayed(const Duration(milliseconds: 10),
                              () {
                            passwordText = generatePassword();

                            passwordController.text = passwordText;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: mHeight * .02),
                          child: SvgPicture.asset("assets/svg/reload.svg"),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: mHeight * .5,
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: GestureDetector(
          child: SvgPicture.asset('assets/svg/save.svg'),
          onTap: () async {

            if (_formKey.currentState!.validate() && widget.type == "Create") {
              createUserApiFunction();
            } else {
              EditUserApiFunction();
            }
          },
        ),
      ),
    );
  }

  createUserApiFunction() async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<UserBloc>(context).add(CreateUserEvent(
          firstName: contactNameController.text,
          userName: userNameController.text,
          email: emailController.text,
          passwordOne: passwordController.text,
          passwordTwo: passwordController.text,
          phone: phoneNoController.text,
          userTypeId: userTypeId,
          organization_id: organizationId!,
          filePath: path!.path));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

  EditUserApiFunction() async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      final pics = await fileFromImageUrl(pic, "pic");
      return BlocProvider.of<UserBloc>(context).add(EditUserEvent(
          firstName: contactNameController.text,
          userName: userNameController.text,
          email: emailController.text,
          passwordOne: passwordController.text,
          passwordTwo: passwordController.text,
          phone: phoneNoController.text,
          userTypeId: userTypeId,
          organization_id: widget.organisation!,
          id: widget.id!,
          filePath: path!.path));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(
          context: context, textMsg: "Check your network connection");
    }
  }

}

class TextfelidWidgetUser extends StatelessWidget {
  const TextfelidWidgetUser({
    super.key,
    required this.contactNameController,
    required this.hintText,
  });

  final TextEditingController contactNameController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.1,
        child: TextFormField(
            style: customisedStyle(
                context, Colors.black, FontWeight.bold, 12.0),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
            controller: contactNameController,
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    "assets/svg/phone_contact.svg",
                    height: 10,
                  ),
                ),
                contentPadding: const EdgeInsets.all(7),
                hintText: "Contact name",
                hintStyle: const TextStyle(color: Color(0xff778EB8)),
                border: InputBorder.none,
                filled: true,
                fillColor: const Color(0xffF3F7FC))));
  }
}
