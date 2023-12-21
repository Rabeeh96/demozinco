import 'package:flutter/material.dart';

class ListviewScreen extends StatefulWidget {
   ListviewScreen({Key? key}) : super(key: key);

  @override
  State<ListviewScreen> createState() => _ListviewScreenState();
}

class _ListviewScreenState extends State<ListviewScreen> {
  List<DateTime> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5, // number of date pickers to display
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Date ${index + 1}'),
            trailing: Text(selectedDates.length > index ? selectedDates[index].toString() : ''),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2030),
              );
              if (selectedDate != null) {
                setState(() {
                  if (selectedDates.length > index) {
                    selectedDates[index] = selectedDate;
                  } else {
                    selectedDates.add(selectedDate);
                  }
                });
              }
            },
          );
        },
      ),


    );
  }
}
