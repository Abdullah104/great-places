import 'location_api_credentials.dart';

import 'package:http/http.dart';

import 'dart:convert';

class LocationHelper {
  static String generateLocationPreviewImage(
          double latitude, double longitude) =>
      '''https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7C%7C$latitude,$longitude&key=$key''';

  static Future<String> getLocationAddress(
    double latitude,
    double longitude,
  ) async {
    final response = await get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$key',
      ),
    );

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
