import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPicker extends StatefulWidget {
  @override
  _CustomPickerState createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  int selectedType = 1;
  String selectedValue = 'Monday'; // Default value for type 1

  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  List<String> daysOfMonth = List.generate(31, (index) => (index + 1).toString());

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Picker Example'),
        ),
        body:Column(
          children: [
            DropdownButton<int>(
              value: selectedType,
              items: [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Weekdays'),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text('Days of Month'),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text('Months'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value!;

                  if(value ==1){
                    selectedValue = 'Monday';
                  }
                  else if (value ==2){
                    selectedValue = '1';
                  }
                  else{
                    selectedValue = 'January';
                  }


                  // Reset selected value
                });
              },
            ),
            SizedBox(height: 10),
            buildPicker(),
          ],
        ),
      ),
    );

  }
  Widget buildPicker() {
  return CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedValue = weekdays[index];
        });
      },
      children: weekdays.map((day) {
        return Text(day);
      }).toList(),
    );

  }


  Widget buildPicker1() {
    switch (selectedType) {
      case 1:
        return DropdownButton<String>(
          value: selectedValue,
          items: weekdays.map((day) {
            return DropdownMenuItem<String>(
              value: day,
              child: Text(day),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
        );
      case 2:
        return DropdownButton<String>(
          value: selectedValue,
          items: daysOfMonth.map((day) {
            return DropdownMenuItem<String>(
              value: day,
              child: Text(day),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
        );
      case 3:
        return Row(
          children: [

            DropdownButton<String>(
              value: selectedValue,
              items: months.map((month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }



}
