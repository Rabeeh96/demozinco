import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../Utilities/global/text_style.dart';



class TermsAndCondition extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<TermsAndCondition> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 11,

        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff2BAAFC),
          ),
        ),
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title:  Text('Terms And Condition',style: customisedStyle(
            context, Color(0xff13213A), FontWeight.w600, 22.0),),
      ),
      body: SfPdfViewer.asset(
        'assets/pdf/terms_condition.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}