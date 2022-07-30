// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_family_story/views/router/routes.dart';
import 'package:my_family_story/views/settings/settings_page.dart';

void main() {
  // group("Home widget test", (){});
  testWidgets(
    'Test Settings Page',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            onGenerateRoute: onGenerateRoute,
            home: const SettingsPage(),
          ),
        ),
        //const Duration(seconds: 10),
      );

      expect(find.byType(ElevatedButton), findsNWidgets(7));
      expect(find.text("Storage Unit Config"), findsOneWidget);
      expect(find.text("Compute Unit Config"), findsOneWidget);
      expect(find.text("Backup Settings"), findsOneWidget);
      expect(find.text("Encryption Settings"), findsOneWidget);
      expect(find.text("General Settings"), findsOneWidget);
      expect(find.text("Privacy Settings"), findsOneWidget);
      expect(find.text("Notification Settings"), findsOneWidget);

      //await tester.tap(find.text("Storage Unit Config"));
      await tester.tap(find.text("Compute Unit Config"));
      await tester.pumpAndSettle();
      expect(find.text("My Laptop"), findsOneWidget);

      expect(find.byIcon(Icons.computer), findsOneWidget);
      expect(find.text("Status :"), findsOneWidget);
      //expect(find.text("Active"), findsOneWidget);

      expect(find.byIcon(Icons.refresh), findsOneWidget);
      expect(find.text("Last Refresh Time :"), findsOneWidget);
      //expect(find.text("Active"), findsOneWidget);

      expect(find.byIcon(Icons.memory_rounded), findsOneWidget);
      expect(find.text("CPU Usage :"), findsOneWidget);
      //expect(find.text("Active"), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 10));
    },
  );
}
