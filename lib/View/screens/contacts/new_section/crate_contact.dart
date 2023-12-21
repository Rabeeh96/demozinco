import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Api Helper/Bloc/Contact/contact_bloc.dart';
import '../../../../Api Helper/ModelClasses/contact/CreateContactModelClass.dart';
import '../../../../Api Helper/ModelClasses/contact/EditContactModelClass.dart';
import '../../../../Api Helper/Repository/api_client.dart';
import '../../../../Utilities/Commen Functions/bottomsheet_fucntion.dart';
import '../../../../Utilities/Commen Functions/internet_connection_checker.dart';
import '../../../../Utilities/CommenClass/camera_screen.dart';

import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Utilities/CommenClass/commen_txtfield_widget.dart';
import '../../../../Utilities/CommenClass/custom_overlay_loader.dart';
import '../../../../Utilities/global/text_style.dart';
import '../test_permition.dart';
import 'dio_contact.dart';



class ContactCreateNew extends StatefulWidget {
  String type;
  String? contactName;
  String? phoneNumber;
  String? organisationId;
  String? openingBalance;
  String? countryName;
  String? countryID;
  String? amount;
  String? addressName;
  String? buildingName;
  String? landMark;
  String? state;
  String? pinCode;
  String? imagePath;
  int? transaction;
  String? id;

  ContactCreateNew(
      {super.key,
        this.transaction,
        required this.type,
        this.countryName,
        this.phoneNumber,
        this.organisationId,
        required this.openingBalance,
        this.countryID,
        this.contactName,
        this.amount,
        this.id,
        this.state,
        this.addressName,
        required  this.imagePath,
        this.buildingName,
        this.landMark,
        this.pinCode});

  @override
  State<ContactCreateNew> createState() => _ContactCreateNewState();
}

class _ContactCreateNewState extends State<ContactCreateNew> {
  TextEditingController contactNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController openingBalance = TextEditingController()..text = "0.00";
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  FocusNode contactNameFCNode = FocusNode();
  FocusNode phoneNumberFCNode = FocusNode();
  FocusNode amountFCNode = FocusNode();
  FocusNode buildingNumberFCNode = FocusNode();
  FocusNode landmarkFCNode = FocusNode();
  FocusNode countryFCNode = FocusNode();
  FocusNode cityFCNode = FocusNode();
  FocusNode stateFCNode = FocusNode();
  FocusNode postalCodeFCNode = FocusNode();
  FocusNode saveFCNode = FocusNode();


  var photo = "";
  File path = new File("assets/svg/plus.svg");
  final imgPicker = ImagePicker();
  final ValueNotifier<int> indexValue = ValueNotifier<int>(1);
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

  String countryId = "";


  check() {
    if (double.parse(widget.amount!) >= 0) {
      indexValue.value = 1;
    } else if (double.parse(widget.amount!) < 0) {
      indexValue.value = 2;

    }
  }

  @override
  void initState() {

    super.initState();
    widget.type == "Edit" ? check() : null;
    progressBar = ProgressBar();
    countryId = widget.type == "Edit" ? widget.countryID! : countryId;
    openingBalance = TextEditingController()..text = widget.type == "Edit" ? widget.amount!.replaceAll('-', '') : "0.00";
    contactNameController = TextEditingController()..text = widget.type == "Edit" ? widget.contactName! : "";
    phoneNumberController = TextEditingController()..text = widget.type == "Edit" ? widget.phoneNumber.toString() : "";
    buildingNumberController = TextEditingController()..text = widget.type == "Edit" ? widget.buildingName.toString() : "";
    landmarkController = TextEditingController()..text = widget.type == "Edit" ? widget.landMark.toString() : "";
    cityController = TextEditingController()..text = widget.type == "Edit" ? widget.addressName.toString() : "";
    stateController = TextEditingController()..text = widget.type == "Edit" ? widget.state.toString() : "";
    postalCodeController = TextEditingController()..text = widget.type == "Edit" ? widget.pinCode.toString() : "";

    if (widget.type == "Edit") {
      var myVal = double.parse(widget.openingBalance!);
      if (myVal < 0) {
        indexValue.value = 1;
      } else {
        indexValue.value = 2;
      }
    } else {
      indexValue.value = 1;
    }
  }

  File? _imageFile;


  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> button1Pressed = ValueNotifier(false);
  ValueNotifier<bool> button2Pressed = ValueNotifier(false);
  late CreateContacModelClass createContactModelClass;
  late EditContactModelClass editContactModelClass;
  String pic = "https://www.gravatar.com/avatar/1?s=46&d=identicon&r=PG&f=1";

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final space = SizedBox(
      height: mHeight * .02,
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<ContactBloc, ContactState>(listener: (context, state) {
          if (state is CreateContactLoaded) {
            createContactModelClass = BlocProvider.of<ContactBloc>(context).createContactModelClass;
            if (createContactModelClass.statusCode == 6000) {
              Navigator.pop(context);
              msgBtmDialogueFunction(
                context: context,
                textMsg: createContactModelClass.data.toString(),
              );
            }
            if (createContactModelClass.statusCode == 6001) {
              alreadyCreateBtmDialogueFunction(
                  context: context,
                  textMsg: "Accounts with this account name already exist",
                  buttonOnPressed: () {
                    Navigator.of(context).pop(false);
                  });
            }
          }
        }),
        BlocListener<ContactBloc, ContactState>(listener: (context, state) {
          if (state is EditContactLoading) {
            print(
                "________________________________________________________________________________________________________________________________-loading state");
            const CircularProgressIndicator();
          }
          if (state is EditContactLoaded) {
            print(
                "________________________________________________________________________________________________________________________________-loaded state");
            editContactModelClass = BlocProvider.of<ContactBloc>(context).editContactModelClass;

            if (editContactModelClass.statusCode == 6000) {
              Navigator.pop(context);

            }
            if (editContactModelClass.statusCode == 6001) {
              alreadyCreateBtmDialogueFunction(
                  context: context,
                  textMsg: "Accounts with this account name already exist",
                  buttonOnPressed: () {
                    Navigator.of(context).pop(false);
                  });
            }
          }
          if (state is EditContactError) {
            print(
                "________________________________________________________________________________________________________________________________-error state");
            const Text("Something went wrong");
          }
        }),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 11,

          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          titleSpacing: 0,
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
            widget.type == "Create" ? 'Add Contacts' : "Edit Contact",
            style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 21.0),
          ),

        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                space,


                GestureDetector(
                    onTap: () async {
                      final pickedFile = await Navigator.push(context, (MaterialPageRoute(builder: (context) => const CameraScreen())));
                      if (pickedFile != null) {
                        setState(() {
                          _imageFile = File(pickedFile.path);
                          widget.imagePath = "";
                        });
                      }
                    },
                    child: widget.imagePath== ""
                        ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: _imageFile != null
                          ? ClipOval(
                        child: Image.file(
                          _imageFile!,
                        ),
                      )
                          : Icon(Icons.add),
                    )
                        : Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipOval(
                          child: Image.network(ApiClient.imageBasePath+widget.imagePath!),
                        ))),
                space,
                CommenTextFieldWidget(
                  controller: contactNameController,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactsPage()));
                        result != null ? contactNameController.text = result[0] : Null;
                        result != null ? phoneNumberController.text = result[1] : Null;
                      },
                      icon: Icon(
                        Icons.perm_contact_cal_rounded,
                        color: Color(0xff5728C4),
                      )),

                  validator: (val) {
                    if (val == null || val.isEmpty || val.trim().isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  hintText: 'Contact Name',
                  textInputType: TextInputType.name,
                  textAlign: TextAlign.start,
                  readOnly: false,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                ),

                space,
                CommenTextFieldWidget(
                  controller: phoneNumberController,
                  hintText: 'Phone No',
                  textInputType: TextInputType.phone,
                  textAlign: TextAlign.start,
                  readOnly: false,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                ),
                space,

                ValueListenableBuilder<int>(
                    valueListenable: indexValue,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height / 18,
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                  color: indexValue.value == 1 ? const Color(0xff42BE5B) : Color(0xffF2F5F8), borderRadius: BorderRadius.circular(4)),
                              child: TextButton(
                                  onPressed: () {
                                    indexValue.value = 1;
                                  },
                                  child: Text(
                                    "Payable",
                                    style:
                                    customisedStyle(context, indexValue.value == 1 ? Colors.white : Color(0xff3F39AF), FontWeight.w500, 12.0),
                                  ))),
                          Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: MediaQuery.of(context).size.height / 18,
                              decoration: BoxDecoration(
                                  color: indexValue.value == 2 ? Color(0xff42BE5B) : Color(0xffF2F5F8), borderRadius: BorderRadius.circular(4)),
                              child: TextButton(
                                  onPressed: () {
                                    indexValue.value = 2;
                                  },
                                  child: Text(
                                    "Receivable",
                                    style:
                                    customisedStyle(context, indexValue.value == 2 ? Colors.white : Color(0xff3F39AF), FontWeight.w500, 12.0),
                                  ))),
                        ],
                      );
                    }),



                space,
                TextFormField(
                    style: customisedStyle(context,  Color(0xff13213A), FontWeight.normal, 14.0),

                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                    ],


                    controller: openingBalance,
                    onTap: () =>
                    openingBalance.selection = TextSelection(baseOffset: 0, extentOffset: openingBalance.value.text.length),

                    decoration:  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 1, color: Color(0xffF3F7FC)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 1, color: Color(0xffF3F7FC)),
                        ),
                        labelText: "Amount",
                        labelStyle:customisedStyle(context, Color(0xff778EB8), FontWeight.normal, 15.0,),

                        contentPadding: EdgeInsets.all(7),
                        hintText: "Amount",
                        hintStyle:customisedStyle(context, Color(0xff778EB8),FontWeight.normal,15.0) ,
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xffF3F7FC))),

                space,
                Text(
                  "Address",
                  style: customisedStyle(context, Color(0xff13213A), FontWeight.w400, 13.0),
                ),
                space,
                CommenTextFieldWidget(
                  controller: buildingNumberController,
                  hintText: 'Building No/Name',
                  textInputType: TextInputType.text,
                  textAlign: TextAlign.start,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                ),

                space,
                CommenTextFieldWidget(
                  controller: landmarkController,
                  hintText: 'Land mark',
                  textInputType: TextInputType.text,
                  textAlign: TextAlign.start,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                ),

                space,

                CommenTextFieldWidget(
                  controller: cityController,
                  hintText: 'City',
                  textInputType: TextInputType.text,
                  textAlign: TextAlign.start,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                ),

                space,
                CommenTextFieldWidget(
                  controller: stateController,
                  hintText: 'State/Province',
                  textInputType: TextInputType.text,
                  textAlign: TextAlign.start,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                ),

                space,
                CommenTextFieldWidget(
                  controller: postalCodeController,
                  hintText: 'Postal Code',
                  textInputType: TextInputType.number,
                  textAlign: TextAlign.start,
                  readOnly: false,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                ),

                SizedBox(
                  height: mHeight * .1,
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: GestureDetector(
          child: SvgPicture.asset('assets/svg/save.svg'),
          onTap: () async {



            var amount = "0.00";

            indexValue.value == 2 ? amount = openingBalance.text : amount = "-${openingBalance.text}";

            if (_formKey.currentState!.validate() == true) {

              var imgFile="";

              if(widget.type=="Create"){
                if (_imageFile != null) {
                  if(_imageFile!.path !=""){
                    imgFile = _imageFile!.path;
                  }
                }
              }
              else{
                if(widget.imagePath !=""){
                  var imagePAth = await fileFromImageUrl(ApiClient.imageBasePath+widget.imagePath!, ("profilePic.png"));
                  imgFile = imagePAth;
                }
                else{
                  if (_imageFile != null) {
                    if(_imageFile!.path !=""){
                      imgFile = _imageFile!.path;
                    }
                  }
                }
              }


              progressBar.show(context);
              var res = await crateContact(
                type: widget.type=="Create"?false:true,
                id: widget.id,
                country: countryId,
                accountName: contactNameController.text,
                phone: phoneNumberController.text,
                amount: amount,
                address_name: cityController.text,
                building_name: buildingNumberController.text,
                land_mark: landmarkController.text,
                images: imgFile,
                state: stateController.text,
                pin_code: postalCodeController.text,
              );
              progressBar.hide();
              if (res[0] == 6000) {
                Navigator.pop(context);


              }
              else {

                progressBar.hide();
                msgBtmDialogueFunction(context: context, textMsg: res[1]);
              }

            }
          },
        ),
      ),
    );
  }

  createContactApi(amount) async {
    var netWork = await checkNetwork();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId = prefs.getString("organisation");
    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<ContactBloc>(context).add(CreateContactEvent(
          organisation: organizationId!,
          country: countryId,
          accountName: contactNameController.text,
          amount: amount,
          address_name: buildingNumberController.text,
          building_name: buildingNumberController.text,
          land_mark: landmarkController.text,
          state: stateController.text,
          pin_code: postalCodeController.text,
          photo: path.path,
          phone: phoneNumberController.text));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }

  editContactApi(amount) async {
    var netWork = await checkNetwork();

    if (netWork) {
      if (!mounted) return;
      return BlocProvider.of<ContactBloc>(context).add(EditContactEvent(
          organisation: widget.organisationId!,
          country: countryId,
          accountName: contactNameController.text,
          amount: amount,
          address_name: buildingNumberController.text,
          building_name: buildingNumberController.text,
          land_mark: landmarkController.text,
          state: stateController.text,
          pin_code: postalCodeController.text,
          id: widget.id!,
          phone: widget.phoneNumber!,
          photo: photo));
    } else {
      if (!mounted) return;
      msgBtmDialogueFunction(context: context, textMsg: "Check your network connection");
    }
  }
}

