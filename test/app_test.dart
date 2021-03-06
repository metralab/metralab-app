import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/app.dart';
import 'package:metralab/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utilities.dart';

void main() {
  EasyLocalization.logger.enableBuildModes = [];

  group('The main app', () {
    setUp(() async => EasyLocalization.ensureInitialized());

    testWidgets('shows the home screen', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const TestHarness(
            withProviderScope: true,
            child: MetralabApp(),
          ),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
