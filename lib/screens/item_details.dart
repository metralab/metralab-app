import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../components/item_details_view.dart';
import '../data/item.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen(this.item, {Key key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(tr('itemDetails'))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ItemDetailsView(item),
        ),
      );
}
