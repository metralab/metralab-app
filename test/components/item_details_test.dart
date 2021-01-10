import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/components/item_details_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../factories.dart';
import '../utilities.dart';

void main() {
  group('An item details view', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    testWidgets('shows the date of creation of the item',
        (WidgetTester tester) async {
      final item = itemFactory(2);
      await tester.pumpWidget(TestHarness(child: ItemDetailsView(item)));
      await tester.pumpAndSettle();
      expect(find.text('creation date: ${item.birth}'), findsOneWidget);
    });

    testWidgets('shows the distances of the inclinometers',
        (WidgetTester tester) async {
      final item = itemFactory(2);
      await tester.pumpWidget(TestHarness(child: ItemDetailsView(item)));
      await tester.pumpAndSettle();
      item.distances.map(
          (distance) => expect(find.text(distance.toString()), findsOneWidget));
    });

    testWidgets('shows the inclinations of the inclinometers',
        (WidgetTester tester) async {
      final item = itemFactory(2);
      await tester.pumpWidget(TestHarness(child: ItemDetailsView(item)));
      await tester.pumpAndSettle();
      item.inclinations.map((inclination) =>
          expect(find.text(inclination.toString()), findsOneWidget));
    });

    testWidgets('shows the deflection of the beam',
        (WidgetTester tester) async {
      final item = itemFactory(2);
      await tester.pumpWidget(TestHarness(child: ItemDetailsView(item)));
      await tester.pumpAndSettle();
      item.deflection
          .map((y) => expect(find.text(y.toString()), findsOneWidget));
    });
  });
}
