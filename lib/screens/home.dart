import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/item_details_view.dart';
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
        body: LayoutBuilder(
            builder: (context, constraints) => constraints.maxWidth > 768
                ? _WideHomeScreen()
                : _CompactHomeScreen(onItemTapped: onItemTapped)),
        floatingActionButton: FloatingActionButton(
          onPressed: onActionButtonTapped,
          tooltip: 'New measurement',
          child: const Icon(Icons.add),
        ),
      );
}

class _CompactHomeScreen extends StatelessWidget {
  const _CompactHomeScreen({Key key, @required this.onItemTapped})
      : super(key: key);

  final void Function(Item) onItemTapped;

  @override
  Widget build(BuildContext context) => _ItemsList(onItemTapped: onItemTapped);
}

class _WideHomeScreen extends StatefulWidget {
  @override
  _WideHomeScreenState createState() => _WideHomeScreenState();
}

class _WideHomeScreenState extends State<_WideHomeScreen> {
  static const detailsEmptyHint = 'Choose an item on the left.';
  static const detailsScreenIntroduction =
      'Press the + icon. Once you have taken a measurement, come back '
      'here to see details about the results.';

  Item selectedItem;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 300,
            child: _ItemsList(
                onItemTapped: (item) => setState(() => selectedItem = item)),
          ),
          VerticalDivider(),
          Expanded(
            child: selectedItem == null
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      constraints: BoxConstraints(maxWidth: 400.0),
                      child: Consumer(
                        builder: (context, watch, child) =>
                            watch(itemsProvider.state).isEmpty
                                ? Text(
                                    detailsScreenIntroduction,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )
                                : Text(
                                    detailsEmptyHint,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                      ),
                    ),
                  )
                : ItemDetailsView(selectedItem),
          ),
        ],
      );
}

class _ItemsList extends StatelessWidget {
  const _ItemsList({Key key, @required this.onItemTapped}) : super(key: key);

  final void Function(Item) onItemTapped;

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (context, watch, child) => watch(itemsProvider.state).isEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Press the + icon to start measuring.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              )
            : ListView(
                children: watch(itemsProvider.state)
                    .map((item) => ItemSummary(item, onTapped: onItemTapped))
                    .toList(),
              ),
      );
}
