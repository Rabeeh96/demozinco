import 'package:flutter/material.dart';

void showAutoClosingBottomSheet( {required contextt , required String content}) {
  showModalBottomSheet(
    context: contextt,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        color: Colors.grey[200],
        child: Center(
          child: Column(
            children: [
              Text(content),
              TextButton(onPressed: (){Navigator.pop(contextt);}, child: Text("oky"))
            ],
          ),
        ),
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(contextt).pop(); // Close the BottomSheet
  });
}

void showAutoClosingDialog({required context , required String content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text(content),
      );
    },
  );


  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context).pop();
  });
}