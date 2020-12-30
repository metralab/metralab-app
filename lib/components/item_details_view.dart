import 'package:flutter/material.dart';

import '../data/item.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView(this.item, {Key key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('creation date: ${item.birth}'),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('Distances'),
                      ...item.distances
                          .map((distance) => Text(distance.toString()))
                          .toList(),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Inclinations'),
                      ...item.inclinations
                          .map((inclination) => Text(inclination.toString()))
                          .toList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Deflections'),
                  ...item.deflection
                      .map((deflection) => Text(deflection.toString()))
                      .toList(),
                ],
              ),
            ),
          ),
        ],
      );
}
