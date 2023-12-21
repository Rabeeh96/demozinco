import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Profile/profile_bloc.dart';
import '../../../../Api Helper/Bloc/Settings/settings_bloc.dart';
import '../../../../Api Helper/ModelClasses/Settings/ChangePasswordModelClass.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';


class ProfileBottomSheetClass {
  profileModelBottomSheet(
      {required BuildContext context,
      required String type,
      required String data}) {
    final formKey = GlobalKey<FormState>();

    TextEditingController controller = TextEditingController()..text = data;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ChangeFirstNameLoading) {
                  const CircularProgressIndicator();
                }
                if (state is ChangeFirstNameLoaded) {


                  Navigator.pop(context);
                  BlocProvider.of<SettingsBloc>(context).add(FetchSettingsDetailEvent());


                }
                if (state is ChangeFirstNameError) {
                  const Text("Something went wrong");
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ChangeEmailLoading) {
                  const CircularProgressIndicator();
                }
                if (state is ChangeEmailLoaded) {


                  Navigator.pop(context);
                  BlocProvider.of<SettingsBloc>(context).add(FetchSettingsDetailEvent());


                }
                if (state is ChangeEmailError) {
                  const Text("Something went wrong");
                }
              },
            ),
          ],
          child: Container(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFieldWidget(
                      textInputType: type == "email"
                          ? TextInputType.emailAddress
                          : TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: controller,
                      labelText: "Enter your $type",
                      validator: (val) {
                        if (val == null || val.isEmpty || val.trim().isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    ButtonWidget(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final organizationId =
                            prefs.getString("organisation");

                        if (formKey.currentState!.validate() == true &&
                            type == 'Name') {
                          var netWork = await checkNetwork();
                          if (netWork) {
                            return BlocProvider.of<ProfileBloc>(context).add(
                                FetchChangeFirstName(
                                    organisation: organizationId!,
                                    firstName: controller.text));
                          } else {
                            msgBtmDialogueFunction(
                                context: context,
                                textMsg: "Check your network connection");
                          }
                        }
                        if (formKey.currentState!.validate() == true &&
                            type == "email") {
                          var netWork = await checkNetwork();
                          if (netWork) {
                            return BlocProvider.of<ProfileBloc>(context).add(
                                FetchChangeEmail(organisation: organizationId!, email: controller.text));
                          } else {
                            msgBtmDialogueFunction(
                                context: context,
                                textMsg: "Check your network connection");
                          }

                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  passwordModelBottomSheet(
      {required BuildContext context, required String UserName}) {
    late ChangePasswordModelClass changePasswordModelClass;

    TextEditingController oldPasswordController = TextEditingController();

    TextEditingController newPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ChangePasswordLoading) {
              const CircularProgressIndicator();
            }
            if (state is ChangePasswordLoaded) {
              changePasswordModelClass = BlocProvider.of<ProfileBloc>(context)
                  .changePasswordModelClass;

              if (changePasswordModelClass.statusCode == 6001) {
                alreadyCreateBtmDialogueFunction(
                    context: context,
                    textMsg: changePasswordModelClass.message.toString(),
                    buttonOnPressed: () {
                      Navigator.of(context).pop(false);
                    });
                BlocProvider.of<SettingsBloc>(context).add(FetchSettingsDetailEvent());
              } else {
                Navigator.pop(context);
                BlocProvider.of<SettingsBloc>(context).add(FetchSettingsDetailEvent());
              }
            }
            if (state is ChangePasswordError) {
              const Text("Something went wrong");
            }
          },
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Change Password",
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    TextFieldWidget(
                      textInputAction: TextInputAction.next,
                      controller: oldPasswordController,
                      labelText: "Old Password",
                      validator: (val) {
                        if (val == null || val.isEmpty || val.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (val.length < 6) {
                          return 'Too short';
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                        textInputAction: TextInputAction.done,
                        controller: newPasswordController,
                        labelText: "New Password",
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
                        }),
                    ButtonWidget(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var netWork = await checkNetwork();
                          if (netWork) {
                            return BlocProvider.of<ProfileBloc>(context).add(
                                FetchChangePassword(
                                    userName: UserName,
                                    currentPassword: oldPasswordController.text,
                                    newPassword: newPasswordController.text));
                          } else {
                            msgBtmDialogueFunction(
                                context: context,
                                textMsg: "Check your network connection");
                          }
                        }
                        null;
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      this.onChanged,
      required this.validator,
      required this.textInputAction,
      this.textInputType,
      this.list});

  final TextEditingController controller;
  final String labelText;
  Function(String)? onChanged;
  final String? Function(String?) validator;
  final TextInputAction textInputAction;
  TextInputType? textInputType;
  List<TextInputFormatter>? list;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textCapitalization: TextCapitalization.words,
        textInputAction: textInputAction,
        onChanged: onChanged,
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontWeight: FontWeight.w500)),
        keyboardType: textInputType,
        inputFormatters: list,
        validator: validator,
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Color(0xffA2A2A2))),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE9E9E9)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5728C4)),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE9E9E9)),
          ),
        ));
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("cancel",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Color(0xff5728C4)),
                ))),
        TextButton(
            onPressed: onPressed,
            child: Text("save",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Color(0xff5728C4)),
                ))),
      ],
    );
  }
}
