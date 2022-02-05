import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place_location.dart';

import '../helpers/database_helper.dart';
import '../models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  Future<void> addPlace(
    String title,
    File image,
    PlaceLocation placeLocation,
  ) async {
    final address = await LocationHelper.getLocationAddress(
      placeLocation.latitude,
      placeLocation.longitude,
    );

    final updatedLocation = PlaceLocation(
      latitude: placeLocation.latitude,
      longitude: placeLocation.longitude,
      address: address,
    );

    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      location: updatedLocation,
      image: image,
    );

    _items.add(place);

    notifyListeners();

    DatabaseHelper.insert('places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'location_latitude': updatedLocation.latitude,
      'location_longitude': updatedLocation.longitude,
      'address': updatedLocation.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DatabaseHelper.getData('places');

    final places = data
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: PlaceLocation(
              latitude: place['location_latitude'],
              longitude: place['location_longitude'],
              address: place['address'],
            ),
            image: File(
              place['image'],
            ),
          ),
        )
        .toList();

    _items = places;

    notifyListeners();
  }
}
