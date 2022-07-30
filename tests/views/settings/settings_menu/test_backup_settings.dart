import 'package:drive/drive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_family_story/views/router/routes.dart';
import 'package:my_family_story/views/settings/settings_menu/backup_settings_page.dart';

void setupTests() {
  group(
    'backup_settings',
    () {
      testWidgets(
        'Test Backup Settings Page',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.

          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                onGenerateRoute: onGenerateRoute,
                home: const BackupSettingsPage(),
              ),
            ),
            //const Duration(seconds: 10),
          );

          expect(find.text("Backup On/Off"), findsOneWidget);
          expect(find.byIcon(Icons.edit), findsOneWidget);
          await tester.tap(find.byIcon(Icons.edit));
          await tester.pumpAndSettle();

          //await tester.tap(find.byIcon(Icons.edit));

          expect(find.text("Upload on un-metered WiFi only"), findsOneWidget);
          expect(find.text("Upload Source Directory"), findsOneWidget);
          expect(find.text("Upload Filter"), findsOneWidget);
          expect(find.text("Inclusive"), findsOneWidget);
          expect(find.text("Exclusive"), findsOneWidget);
          expect(find.text("Free up Device Space"), findsOneWidget);
          expect(find.byIcon(Icons.info), findsNWidgets(5));

          expect(find.byType(Switch), findsNWidgets(3));

          await tester.pumpAndSettle(const Duration(seconds: 10));
        },
      );
    },
  );
}

void main() {
  setupTests();
}
