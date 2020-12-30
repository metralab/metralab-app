import 'package:flutter_riverpod/all.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/app.dart';
import 'package:metralab/screens/home.dart';

void main() {
  group('The main app', () {
    testWidgets('shows the home screen', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(child: MetralabApp()));
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
