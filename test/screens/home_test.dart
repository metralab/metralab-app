import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metralab/screens/home.dart';

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
  });
}
