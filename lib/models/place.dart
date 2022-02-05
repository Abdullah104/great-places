import 'dart:io';

import 'place_location.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  const Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
