import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/components/item_summary.dart';
import 'package:metralab/data/item.dart';
import 'package:metralab/data/items_provider.dart';
import 'package:metralab/screens/home.dart';

import '../factories.dart';

void main() {
  group('The home screen', () {
    testWidgets('shows a button', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
          child: MaterialApp(
        home: HomeScreen(
          onActionButtonTapped: () {},
          onItemTapped: (_) {},
        ),
      )));
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('shows a list of items', (WidgetTester tester) async {
      const nItems = 3;
      final items = itemCollectionFactory(nItems);
      await tester.pumpWidget(ProviderScope(
          overrides: [
            itemsProvider
                .overrideWithProvider(Provider((ref) => ItemsProvider(items)))
          ],
          child: MaterialApp(
            home: HomeScreen(
              onActionButtonTapped: () {},
              onItemTapped: (_) {},
            ),
          )));
      expect(find.byType(ItemSummary), findsNWidgets(nItems));
    });

    testWidgets('shows a helpful text, if there are no items yet',
        (WidgetTester tester) async {
      final items = <Item>[];
      await tester.pumpWidget(ProviderScope(
          overrides: [
            itemsProvider
                .overrideWithProvider(Provider((ref) => ItemsProvider(items)))
          ],
          child: MaterialApp(
            home: HomeScreen(
              onActionButtonTapped: () {},
              onItemTapped: (_) {},
            ),
          )));
      expect(find.text('Press the + icon to start measuring.'), findsOneWidget);
    });
  });
}
