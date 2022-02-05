import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/great_places_provider.dart';
import 'routes/add_place_route.dart';
import 'routes/place_details_route.dart';
import 'routes/places_list_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _theme = ThemeData(
    primarySwatch: Colors.indigo,
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: _theme.copyWith(
          colorScheme: _theme.colorScheme.copyWith(
            secondary: Colors.amber,
          ),
        ),
        routes: {
          PlacesListRoute.routeName: (_) => const PlacesListRoute(),
          AddPlaceRoute.routeName: (_) => const AddPlaceRoute(),
          PlaceDetailsRoute.routeName: (_) => const PlaceDetailsRoute(),
        },
      ),
    );
  }
}
