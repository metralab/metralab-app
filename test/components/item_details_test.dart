import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/components/item_details_view.dart';

import '../factories.dart';

void main() {
  group('An item details view', () {
    testWidgets('shows the date of creation of the item',
        (WidgetTester tester) async {
      final item = itemFactory(2);
      await tester.pumpWidget(MaterialApp(home: ItemDetailsView(item)));
      expect(find.text('creation date: ${item.birth}'), findsOneWidget);
    });

    testWidgets('shows the distances of the inclinometers',
        (WidgetTester tester) async {
      final item = itemFactory(2);
      await tester.pumpWidget(MaterialApp(home: ItemDetailsView(item)));
      item.distances.map(
          (distance) => expect(find.text(distance.toString()), findsOneWidget));
    });

    testWidgets('shows the inclinations of the inclinometers',
        (WidgetTester tester) async {
      final item = itemFactory(2);
      await tester.pumpWidget(MaterialApp(home: ItemDetailsView(item)));
      item.inclinations.map((inclination) =>
          expect(find.text(inclination.toString()), findsOneWidget));
    });

    testWidgets('shows the deflection of the beam',
        (WidgetTester tester) async {
      final item = itemFactory(2);
      await tester.pumpWidget(MaterialApp(home: ItemDetailsView(item)));
      item.deflection
          .map((y) => expect(find.text(y.toString()), findsOneWidget));
    });
  });
}
