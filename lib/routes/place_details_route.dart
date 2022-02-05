import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/routes/maps_route.dart';

class PlaceDetailsRoute extends StatelessWidget {
  static const routeName = '/place-details';

  const PlaceDetailsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            place.location.address ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => MapsRoute(
                  initialMapLocation: place.location,
                ),
              ),
            ),
            child: const Text('View on Map'),
          ),
        ],
      ),
    );
  }
}
