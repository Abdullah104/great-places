import 'package:flutter/material.dart';
import 'package:great_places/routes/place_details_route.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';
import 'add_place_route.dart';

class PlacesListRoute extends StatelessWidget {
  static const routeName = '/';

  const PlacesListRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AddPlaceRoute.routeName,
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: context.read<GreatPlacesProvider>().fetchAndSetPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return Consumer<GreatPlacesProvider>(
              builder: (_, greatPlaces, child) => greatPlaces.items.isEmpty
                  ? child!
                  : ListView.builder(
                      itemCount: greatPlaces.items.length,
                      itemBuilder: (_, index) {
                        final item = greatPlaces.items[index];

                        return ListTile(
                          onTap: () => Navigator.pushNamed(
                            context,
                            PlaceDetailsRoute.routeName,
                            arguments: item,
                          ),
                          leading: CircleAvatar(
                            backgroundImage: FileImage(item.image),
                          ),
                          title: Text(item.title),
                          subtitle: Text(item.location.address ?? ''),
                        );
                      },
                    ),
              child: Center(
                child: ElevatedButton.icon(
                  label: const Text('Got no places yet, start adding some!'),
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AddPlaceRoute.routeName,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
