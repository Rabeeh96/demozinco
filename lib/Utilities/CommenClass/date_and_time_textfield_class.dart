import 'package:flutter/material.dart';

class TextfieldWidgetDateAndTime extends StatelessWidget {
  TextfieldWidgetDateAndTime({
    super.key,
    required this.controller,
    required this.readOnly,
    this.prefixIcon, required this.onTap,
  });

  final TextEditingController controller;


  final bool readOnly;
  Widget? prefixIcon;
  final  void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        readOnly: readOnly,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xff878787),fontSize: 16,fontWeight: FontWeight.normal),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              borderSide:
              BorderSide(width: 1, color: Color(0xffF3F7FC)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              borderSide:
              BorderSide(width: 1, color: Color(0xffF3F7FC)),
            ),
            border: const OutlineInputBorder(),
            labelText: "",
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: const Color(0xffF3F7FC)),
        onTap: onTap
    );
  }
}