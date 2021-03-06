import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/screens/new_measurement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities.dart';

void main() {
  EasyLocalization.logger.enableBuildModes = [];

  group('The "New Measurement" screen', () {
    setUp(() async => EasyLocalization.ensureInitialized());

    testWidgets('shows a form', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestHarness(child: const NewMeasurementScreen()),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('shows a text field', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestHarness(child: const NewMeasurementScreen()),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('shows a submit button', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestHarness(child: const NewMeasurementScreen()),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
    });

    testWidgets('increases the value in the text field if "+" is tapped',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestHarness(child: const NewMeasurementScreen()),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      final currenValue =
          (tester.widget(find.byType(TextFormField).first) as TextFormField)
              .controller
              .text;
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      final expectedValue = int.parse(currenValue) + 1;
      expect(find.widgetWithText(TextFormField, expectedValue.toString()),
          findsOneWidget);
    });

    testWidgets('decreases the value in the text field if "-" is tapped',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestHarness(child: const NewMeasurementScreen()),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      final currenValue =
          (tester.widget(find.byType(TextFormField).first) as TextFormField)
              .controller
              .text;
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();
      final expectedValue = int.parse(currenValue) - 1;
      expect(find.widgetWithText(TextFormField, expectedValue.toString()),
          findsOneWidget);
    });

    testWidgets('sets the value in the text field to what is typed in it',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestHarness(child: const NewMeasurementScreen()),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      const valueToType = '42';
      await tester.enterText(find.byType(TextFormField), valueToType);
      await tester.pumpAndSettle();
      expect(find.widgetWithText(TextFormField, valueToType), findsOneWidget);
    });
  });
}
