import 'package:drive/drive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_family_story/views/router/routes.dart';
import 'package:my_family_story/views/settings/settings_menu/notification_settings_page.dart';

void setupTests() {
  group(
    'notification_settings',
    () {
      testWidgets(
        'Test Notification Settings Page',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.

          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                onGenerateRoute: onGenerateRoute,
                home: const NotificationSettingsPage(),
              ),
            ),
            //const Duration(seconds: 10),
          );

          expect(find.text("Email"), findsOneWidget);
          expect(find.text("Text"), findsOneWidget);
          expect(find.text("App"), findsOneWidget);
          expect(find.text("Backup/Storage"), findsOneWidget);
          expect(find.text("Backup Errors"), findsOneWidget);
          expect(find.text("Backup Warnings"), findsOneWidget);
          expect(find.text("Compute"), findsOneWidget);
          expect(find.text("Compute Errors"), findsOneWidget);
          expect(find.text("Compute Warnings"), findsOneWidget);
          expect(find.text("Story"), findsOneWidget);
          expect(find.text("New Story Created"), findsOneWidget);

          expect(find.byType(Checkbox), findsNWidgets(15));

          // Test tapping the specified checkbox only
          //await tester.tap(find.byKey(const Key("backup-errors-email")));
          await tester.pumpAndSettle();

          //expect(actual, matcher)
          await tester.pumpAndSettle(const Duration(seconds: 10));
        },
      );
      /*await FirebaseAuth.instance
          .useAuthEmulator(testEmulatorHost, testEmulatorPort);*/
    },
  );
}

void main() {
  setupTests();
}
