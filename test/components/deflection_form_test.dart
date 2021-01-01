import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/components/deflection_form.dart';

void main() {
  group('A deflection form', () {
    testWidgets('shows a form', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DeflectionForm(
          onSubmit: (_) {},
          numSensors: 3,
        ),
      ));

      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('shows a known amount of text fields for the distances',
        (WidgetTester tester) async {
      const numSensors = 5;
      await tester.pumpWidget(MaterialApp(
        home: DeflectionForm(
          onSubmit: (_) {},
          numSensors: numSensors,
        ),
      ));

      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.decoration.hintText.startsWith('distance')),
          findsNWidgets(numSensors));
    });

    testWidgets('shows a known amount of text fields for the inclinations',
        (WidgetTester tester) async {
      const numSensors = 6;
      await tester.pumpWidget(MaterialApp(
        home: DeflectionForm(
          onSubmit: (_) {},
          numSensors: numSensors,
        ),
      ));

      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.decoration.hintText.startsWith('inclination')),
          findsNWidgets(numSensors));
    });

    testWidgets('shows a "submit" button', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DeflectionForm(
          onSubmit: (_) {},
          numSensors: 3,
        ),
      ));

      expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
    });
  });
}
