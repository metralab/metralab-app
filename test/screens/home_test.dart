import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/components/item_summary.dart';
import 'package:metralab/data/item.dart';
import 'package:metralab/data/items_provider.dart';
import 'package:metralab/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../factories.dart';
import '../utilities.dart';

void main() {
  group('The home screen', () {
    testWidgets('shows a button', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(
        TestHarness(
          withProviderScope: true,
          child: HomeScreen(
            onActionButtonTapped: () {},
            onItemTapped: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('shows a list of items', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      const nItems = 3;
      final items = itemCollectionFactory(nItems);
      await tester.pumpWidget(
        TestHarness(
          providerOverrides: [
            itemsProvider
                .overrideWithProvider(Provider((ref) => ItemsProvider(items)))
          ],
          child: HomeScreen(
            onActionButtonTapped: () {},
            onItemTapped: (_) {},
          ),
        ),
      );
      await tester.idle();
      await tester.pumpAndSettle();
      expect(find.byType(ItemSummary), findsNWidgets(nItems));
    }, skip: true);

    testWidgets('shows a helpful text, if there are no items yet',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      const items = <Item>[];
      await tester.pumpWidget(
        TestHarness(
          providerOverrides: [
            itemsProvider
                .overrideWithProvider(Provider((ref) => ItemsProvider(items)))
          ],
          child: HomeScreen(
            onActionButtonTapped: () {},
            onItemTapped: (_) {},
          ),
        ),
      );
      await tester.idle();
      await tester.pumpAndSettle();
      expect(find.text('Press the + icon to start measuring.'), findsOneWidget);
    }, skip: true);
  });
}
