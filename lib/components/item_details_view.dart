import 'package:flutter/material.dart';

import '../data/item.dart';
import 'deflection_results_card.dart';

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
                      Text(
                        'Distances',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      ...item.distances
                          .map((distance) => Text(distance.toString()))
                          .toList(),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Inclinations',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      ...item.inclinations
                          .map((inclination) => Text(inclination.toString()))
                          .toList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          DeflectionResultsCard(item.deflection),
        ],
      );
}
