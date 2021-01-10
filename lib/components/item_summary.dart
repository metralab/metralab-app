import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/items_provider.dart';
import '../data/item.dart';

class ItemSummary extends StatelessWidget {
  const ItemSummary(
    this.item, {
    Key key,
    @required this.onTap,
    this.selected = false,
    this.onDelete,
  }) : super(key: key);

  final Item item;
  final bool selected;
  final void Function(Item) onTap;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) => Card(
        color: selected ? Theme.of(context).selectedRowColor : null,
        child: ListTile(
          title: Text(tr('itemSummary', args: [item.birth.toString()])),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            tooltip: tr('delete'),
            onPressed:
                onDelete ?? () => context.read(itemsProvider).remove(item),
          ),
          onTap: () => onTap(item),
        ),
      );
}
