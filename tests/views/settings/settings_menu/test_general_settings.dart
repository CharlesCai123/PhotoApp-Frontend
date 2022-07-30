import 'package:drive/drive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_family_story/views/router/routes.dart';
import 'package:my_family_story/views/settings/settings_menu/general_settings_page.dart';

void setupTests() {
  group(
    'general_settings',
    () {
      testWidgets(
        'Test General Settings Page',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.

          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                onGenerateRoute: onGenerateRoute,
                home: const GeneralSettingsPage(),
              ),
            ),
          );

          expect(find.text("Enable Cache"), findsOneWidget);

          await tester.pumpAndSettle();
          expect(find.text("Max Cache Size"), findsOneWidget);
          expect(find.text("Current Cache Size"), findsOneWidget);
          //await tester.tap(find.byIcon(Icons.edit));

          expect(find.byIcon(Icons.info), findsNWidgets(2));
          expect(find.byType(Slider), findsOneWidget);

          await tester.pumpAndSettle(const Duration(seconds: 10));
        },
      );
    },
  );
}

void main() {
  setupTests();
}
