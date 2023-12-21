import 'package:flutter/material.dart';



class my_calc extends StatelessWidget {
  final List<String> operators = ['.', '+', '-', '×', '÷'];

  bool isOperator(String value) {
    return operators.contains(value);
  }

  String appendValue(String currentValue, String newValue) {
    if (currentValue.isEmpty) {
      /// The first value can be any number
      return newValue;
    } else if (isOperator(currentValue[currentValue.length - 1])) {
      /// If the last value is an operator, the new value must be a number
      if (!isOperator(newValue)) {
        return currentValue + newValue;
      }
    } else if (!isOperator(newValue)) {
      /// If the last value is a number, the new value can be any number or operator
      return currentValue + newValue;
    }
    return currentValue;
  }

  @override
  Widget build(BuildContext context) {
    String currentValue = '';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 11,

          title: Text('Append Values Example'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  currentValue,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Wrap(
                spacing: 8,
                children: operators
                    .map(
                      (operator) => ElevatedButton(
                    onPressed: () {
                      currentValue = appendValue(currentValue, operator);
                    },
                    child: Text(operator),
                  ),
                )
                    .toList(),
              ),
              Wrap(
                spacing: 8,
                children: List.generate(
                  10,
                      (index) => ElevatedButton(
                    onPressed: () {

                      currentValue = appendValue(currentValue, index.toString());

                    },
                    child: Text(index.toString()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
