import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

openWhatsupp(number) async {
  final link = WhatsAppUnilink(
    phoneNumber: number,
    text: "",
  );
  await launch(link.toString());

}