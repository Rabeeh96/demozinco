
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/variables.dart';
/// working
String roundStringWith(String amount) {
  double convertedTodDouble = double.parse(amount);

  /// un wanted
  // print("rounding_figure  $rounding_figure");
  // final roundedAmount = double.parse(convertedTodDouble.toStringAsFixed(rounding_figure));
  String format = 'en_US';
  if(currencyFormat=="###,###,##0."){
    format ="en_US";
  }
  else{
    format ="en_IN";
  }

  final indiaFormat = NumberFormat.currency(locale: format,symbol: '',decimalDigits:rounding_figure);
  //   final indiaFormat = NumberFormat.currency(locale: format,symbol: countryCurrencyCode);
  return indiaFormat.format(convertedTodDouble);
}




String roundStringWithOnlyDigit(String val){

  double convertedTodDouble = double.parse(val);
  var number = convertedTodDouble.toStringAsFixed(rounding_figure);

  var format = currencyFormat+"$numberFormat2";
  // print(format);
  // var numberFor =  NumberFormat(format, "en_US");
  // var number = numberFor.format(convertedTodDouble);

  return "$number";
}

String roundStringWithVal(String val){

  double convertedTodDouble = double.parse(val);
  var number = convertedTodDouble.toStringAsFixed(rounding_figure);


  return "$number";
}


//12341.4.ToString("##,#0.00")


String roundStringWithValue(String val,round) {
  double convertedTodDouble = double.parse(val);
  var number = convertedTodDouble.toStringAsFixed(round);
  return number;
}


