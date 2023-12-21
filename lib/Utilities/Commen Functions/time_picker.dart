import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

timePicker (context,ValueNotifier timeNotifier) async {
  TimeOfDay? pickedTime =  await showTimePicker(
    initialTime: TimeOfDay.now(),
    context: context,
  );

  if(pickedTime != null ){

    timeNotifier.value = DateFormat.jm().parse(pickedTime.format(context).toString());
  }else{
  }
}