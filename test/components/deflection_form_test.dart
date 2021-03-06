import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/components/deflection_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities.dart';

void main() {
  EasyLocalization.logger.enableBuildModes = [];

  group('A deflection form', () {
    setUp(() async => EasyLocalization.ensureInitialized());

    testWidgets('shows a form', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const TestHarness(
            child: DeflectionForm(numSensors: 3),
          ),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('shows a known amount of text fields for the distances',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      const numSensors = 5;
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const TestHarness(
            child: DeflectionForm(numSensors: numSensors),
          ),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.decoration.hintText.startsWith('distance')),
          findsNWidgets(numSensors));
    });

    testWidgets('shows a known amount of text fields for the inclinations',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      const numSensors = 6;
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const TestHarness(
            child: DeflectionForm(numSensors: numSensors),
          ),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.decoration.hintText.startsWith('inclination')),
          findsNWidgets(numSensors));
    });

    testWidgets('shows a text field for the number of steps',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const TestHarness(
            child: DeflectionForm(numSensors: 4),
          ),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.decoration.hintText.startsWith('steps')),
          findsOneWidget);
    });

    testWidgets('shows a "submit" button', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const TestHarness(
            child: DeflectionForm(numSensors: 3),
          ),
        );
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
    });
  });
}
