import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item.dart';

final itemsProvider = StateNotifierProvider((_) => ItemsProvider());

class ItemsProvider extends StateNotifier<List<Item>> {
  ItemsProvider([List<Item> items]) : super(items ?? []);

  void add(final Item item) => state = [...state, item];

  void remove(final Item item) {
    final stateCopy = state;
    stateCopy.remove(item);
    state = stateCopy;
  }
}
