import 'package:url_launcher/url_launcher.dart';

class LaunchCall {
  Future makePhoneCall(String url) async {
    // Traitement du numéro de téléphone + au lieu de 00
    if (url.startsWith('0')) {
      // On remplace les 00 par +
      // url = 'tel:+221 776602651' : est le format acceptable par le package
      url = 'tel:+' + url.substring(2, 5) + ' ' + url.substring(5);
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
