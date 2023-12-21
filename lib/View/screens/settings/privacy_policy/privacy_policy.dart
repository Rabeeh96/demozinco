
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../Utilities/global/text_style.dart';



class PrivacyPolicy extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<PrivacyPolicy> {
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
        title:  Text('Privacy Policy',style: customisedStyle(
            context, Color(0xff13213A), FontWeight.w600, 22.0),),
      ),
      body: SfPdfViewer.asset(
        'assets/pdf/privacy_policy.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}