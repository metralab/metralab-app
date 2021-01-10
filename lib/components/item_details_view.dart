import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../data/item.dart';
import 'deflection_results_card.dart';
import 'input_data_card.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView(this.item, {Key key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('${tr('creationDate')}: ${item.birth}'),
            ),
          ),
          DeflectionResultsCard(item.deflection),
          InputDataCard(item.inclinometersData),
        ],
      );
}
