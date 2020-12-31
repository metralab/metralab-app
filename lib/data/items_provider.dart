import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item.dart';

final itemsProvider = StateNotifierProvider((_) => ItemsProvider());

class ItemsProvider extends StateNotifier<List<Item>> {
  ItemsProvider([items]) : super(items ?? []);

  void add(Item item) => state = [...state, item];

  void remove(Item item) {
    final stateCopy = state;
    stateCopy.remove(item);
    state = stateCopy;
  }
}
