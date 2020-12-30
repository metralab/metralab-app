import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/items_provider.dart';
import '../data/item.dart';

class ItemSummary extends StatelessWidget {
  const ItemSummary(this.item, {Key key, this.onTapped}) : super(key: key);

  final Item item;
  final void Function(Item) onTapped;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text('Item created on ${item.birth}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => context.read(itemsProvider).remove(item),
          ),
          onTap: () => onTapped(item),
        ),
      );
}
