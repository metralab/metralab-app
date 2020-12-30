import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/item_summary.dart';
import '../data/items_provider.dart';
import '../data/item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
    @required this.onItemTapped,
    @required this.onActionButtonTapped,
  }) : super(key: key);

  final void Function(Item) onItemTapped;
  final void Function() onActionButtonTapped;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Consumer(
          builder: (context, watch, child) => watch(itemsProvider.state).isEmpty
              ? Center(
                  child: const Text(
                      'Press the + icon to start a new measurement.'),
                )
              : ListView(
                  children: watch(itemsProvider.state)
                      .map((item) => ItemSummary(item, onTapped: onItemTapped))
                      .toList(),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onActionButtonTapped,
          tooltip: 'New measurement',
          child: const Icon(Icons.add),
        ),
      );
}
