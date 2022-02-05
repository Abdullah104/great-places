import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_location.dart';

class MapsRoute extends StatefulWidget {
  final PlaceLocation initialMapLocation;
  final bool isSelecting;
  static const routeName = '/maps';

  const MapsRoute({
    Key? key,
    this.initialMapLocation = const PlaceLocation(
      latitude: 24.4848895,
      longitude: 39.5747283,
      address: '',
    ),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  _MapsRouteState createState() => _MapsRouteState();
}

class _MapsRouteState extends State<MapsRoute> {
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _selectedLocation == null
                  ? null
                  : () {
                      Navigator.pop(context, _selectedLocation);
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialMapLocation.latitude,
            widget.initialMapLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _selectedLocation == null && widget.isSelecting
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('marker'),
                  position: _selectedLocation ??
                      LatLng(
                        widget.initialMapLocation.latitude,
                        widget.initialMapLocation.longitude,
                      ),
                ),
              },
      ),
    );
  }

  void _selectLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }
}
