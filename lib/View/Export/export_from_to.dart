import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
Future<void> convertToExcelFromTo({required data,required heading,required date}) async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];

  final Range range1 = sheet.getRangeByName('A1:E1');
  range1.merge();
  sheet.getRangeByName('A1').setText(heading);
  range1.cellStyle.fontSize = 13;
  range1.cellStyle.bold = true;
  range1.cellStyle.hAlign = HAlignType.center;
  range1.cellStyle.fontName = "Lexend";

  final Range range2 = sheet.getRangeByName('A2:E2');
  range2.merge();
  sheet.getRangeByName('A2').setText(date);
  range2.cellStyle.fontSize = 11;
  range2.cellStyle.bold = true;

  final headerStyles = sheet.getRangeByName('D3:D${data.length+2}').cellStyle;
  headerStyles.hAlign = HAlignType.right;

  final headerStyleDate = sheet.getRangeByName('A4:A${data.length+2}').cellStyle;
  headerStyleDate.hAlign = HAlignType.center;


  final headerStyle = sheet.getRangeByName('A3:E3').cellStyle;
  headerStyle.bold = true;
  headerStyle.hAlign = HAlignType.center; // Center-align header text
  headerStyle.backColorRgb = const Color.fromRGBO(54, 52, 168, 1); // Blue background color
  headerStyle.fontColorRgb = const Color.fromARGB(255, 255, 255, 255); //

  sheet.getRangeByIndex(1, 1 + 1).columnWidth = 40.00;
  sheet.getRangeByIndex(1, 2 + 1).columnWidth = 40.00;
  sheet.getRangeByIndex(1, 0 + 1).columnWidth = 15.00;
  sheet.getRangeByIndex(1, 3 + 1).columnWidth = 15.00;
  sheet.getRangeByIndex(1, 4 + 1).columnWidth = 40.00;

  sheet.getRangeByIndex(1, 1 + 1).cellStyle.fontName = "Lexend";
  sheet.getRangeByIndex(1, 2 + 1).cellStyle.fontName = "Lexend";
  sheet.getRangeByIndex(1, 0 + 1).cellStyle.fontName = "Lexend";
  sheet.getRangeByIndex(1, 3 + 1).cellStyle.fontName = "Lexend";
  sheet.getRangeByIndex(1, 4 + 1).cellStyle.fontName = "Lexend";
  for (int row = 1; row < data.length; row++) {
    for (int col = 0; col < data[row].length; col++) {
      final String value = data[row][col];
      sheet.getRangeByIndex(row + 1, col + 1).setText(value);
    }
  }
  final List<int> bytes = workbook.saveAsStream();
  final Directory directory = await getTemporaryDirectory();
  final String fileName = '${directory.path}/$heading.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  await Share.shareFiles([fileName]);

}