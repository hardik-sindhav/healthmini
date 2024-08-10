// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String query) async {
    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$query";
    final Uri googleMapsUri = Uri.parse(googleMapsUrl);

    if (await canLaunch(googleMapsUri.toString())) {
      await launch(googleMapsUri.toString());
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
