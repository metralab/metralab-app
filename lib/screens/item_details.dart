import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/item_details_view.dart';
import '../data/item.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen(this.item, {Key key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).itemDetails)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemDetailsView(item),
        ),
      );
}
