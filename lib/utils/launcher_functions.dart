import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> sendEmail(
      {String emailAddress, String subject, String message}) async {
    var url = 'mailto:$emailAddress?subject=$subject&body=$message';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
