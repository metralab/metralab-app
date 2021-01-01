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
  Item selectedItem;
  bool newmeasurementNeeded = false;

  void _showItemDetails(Item item) => setState(() => selectedItem = item);

  void _createNewMeasurement() => setState(() => newmeasurementNeeded = true);

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
            if (selectedItem != null)
              MaterialPage(
                key: ValueKey(selectedItem),
                child: ItemDetailsScreen(selectedItem),
              ),
            if (newmeasurementNeeded)
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

  bool _onPopPage(final Route route, final dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }

    setState(() {
      selectedItem = null;
      newmeasurementNeeded = false;
    });

    return true;
  }
}
