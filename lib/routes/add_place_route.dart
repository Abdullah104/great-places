import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place_location.dart';
import '../providers/great_places_provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceRoute extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceRoute({Key? key}) : super(key: key);

  @override
  _AddPlaceRouteState createState() => _AddPlaceRouteState();
}

class _AddPlaceRouteState extends State<AddPlaceRoute> {
  late final TextEditingController _titleController;
  File? _imageFile;
  PlaceLocation? _placeLocation;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ImageInput(
                    imageSelector: _selectImage,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  LocationInput(
                    locationSelectionHandler: _selectPlace,
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add place'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void _selectImage(File imageFile) => _imageFile = imageFile;

  void _savePlace() {
    if (_titleController.text.isNotEmpty &&
        _imageFile != null &&
        _placeLocation != null) {
      context.read<GreatPlacesProvider>().addPlace(
            _titleController.text,
            _imageFile!,
            _placeLocation!,
          );

      Navigator.pop(context);
    }
  }

  void _selectPlace(double latitude, double longitude) =>
      _placeLocation = PlaceLocation(latitude: latitude, longitude: longitude);
}
