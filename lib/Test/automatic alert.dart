import 'package:flutter/material.dart';

import '../Utilities/Commen Functions/automatic closing alert.dart';

class AutomaticAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto-Closing Alert'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                showAutoClosingDialog(context: context, content: "alert");
              },
              child: Text('Show Auto-Closing Alert'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showAutoClosingBottomSheet(
                  contextt: context, content: "bottomsheet");
            },
            child: Text('Show Auto-Closing BottomSheet'),
          ),
        ],
      ),
    );
  }
}
