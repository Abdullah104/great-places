import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../routes/maps_route.dart';

class LocationInput extends StatefulWidget {
  final void Function(double, double) locationSelectionHandler;

  const LocationInput({
    Key? key,
    required this.locationSelectionHandler,
  }) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Builder(
            builder: (_) {
              late final Widget widget;

              if (_previewImageUrl == null) {
                widget = const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                );
              } else {
                widget = Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }

              return widget;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              label: const Text('Current Location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: _selectLocationOnMap,
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _getCurrentUserLocation() async {
    final location = await Location().getLocation();

    _showPreview(location.latitude!, location.longitude!);

    widget.locationSelectionHandler(location.latitude!, location.longitude!);
  }

  Future<void> _selectLocationOnMap() async {
    final location = await Navigator.of(context).push<LatLng?>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const MapsRoute(
          isSelecting: true,
        ),
      ),
    );

    if (location != null) {
      widget.locationSelectionHandler(location.latitude, location.longitude);

      _showPreview(location.latitude, location.longitude);
    }
  }

  void _showPreview(double latitude, double longitude) { 
    final imageUrl = LocationHelper.generateLocationPreviewImage(
      latitude,
      longitude,
    );

    setState(() {
      _previewImageUrl = imageUrl;
    });
  }
}
