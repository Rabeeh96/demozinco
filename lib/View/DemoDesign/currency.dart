import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatAmount(double amount, String pattern) {
  final numberFormat = NumberFormat(pattern);
  return numberFormat.format(amount);
}


class currency extends StatefulWidget {
  @override
  State<currency> createState() => _currencyState();
}

class _currencyState extends State<currency> {
  @override
  Widget build(BuildContext context) {
    final amount = 1234567.89;
    final patterns = [
      "###,###,##",
      "##,##,##",
      "###.###.##",
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 11,

          title: Text('Amount Formatting'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: patterns.map((pattern) {
              final formattedAmount = formatAmount(amount, pattern);
              return Text(
                '$pattern: $formattedAmount',
                style: TextStyle(fontSize: 18),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
