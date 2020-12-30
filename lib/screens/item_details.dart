import 'package:flutter/material.dart';

import '../components/item_details_view.dart';
import '../data/item.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen(this.item, {Key key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Item details')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemDetailsView(item),
        ),
      );
}
