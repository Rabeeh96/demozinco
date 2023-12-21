import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

InputDecoration textFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      borderSide: BorderSide(width: 1, color: Color(0xffF3F7FC)),
    ),
    border: const OutlineInputBorder(),
    labelText: "",
    prefixIcon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset("assets/svg/calender.svg"),
    ),
    filled: true,
    fillColor: const Color(0xffF3F7FC));
