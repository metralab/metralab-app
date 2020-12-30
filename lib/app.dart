import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/items_provider.dart';
import 'data/item.dart';
import 'screens/new_measurement.dart';
import 'screens/home.dart';
import 'screens/item_details.dart';

class MetralabApp extends StatefulWidget {
  const MetralabApp({Key key}) : super(key: key);

  @override
  _MetralabAppState createState() => _MetralabAppState();
}

class _MetralabAppState extends State<MetralabApp> {
  Item _selectedItem;
  bool _newmeasurementNeeded = false;

  void _showItemDetails(Item item) => setState(() => _selectedItem = item);

  void _createNewMeasurement() => setState(() => _newmeasurementNeeded = true);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Scout',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Navigator(
          pages: [
            MaterialPage(
              key: const ValueKey('HomeScreen'),
              child: HomeScreen(
                onItemTapped: _showItemDetails,
                onActionButtonTapped: _createNewMeasurement,
              ),
            ),
            if (_selectedItem != null)
              MaterialPage(
                key: ValueKey(_selectedItem),
                child: ItemDetailsScreen(_selectedItem),
              ),
            if (_newmeasurementNeeded)
              MaterialPage(
                key: const ValueKey('DeflectionScreen'),
                child: NewMeasurementScreen(
                  onSubmit: (item) => context.read(itemsProvider).add(item),
                ),
              ),
          ],
          onPopPage: _onPopPage,
        ),
      );

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }

    setState(() {
      _selectedItem = null;
      _newmeasurementNeeded = false;
    });

    return true;
  }
}
