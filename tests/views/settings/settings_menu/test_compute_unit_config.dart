import 'package:drive/drive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_family_story/views/router/routes.dart';
import 'package:my_family_story/views/settings/settings_menu/compute_unit_config_page.dart';

void setupTests() {
  group(
    'compute_unit_config',
    () {
      testWidgets(
        'Test Compute Unit Config Page',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.

          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                onGenerateRoute: onGenerateRoute,
                home: const ComputeUnitConfigPage(),
              ),
            ),
            //const Duration(seconds: 10),
          );

          expect(find.text("My Laptop"), findsOneWidget);
          expect(find.byIcon(Icons.edit), findsOneWidget);
          await tester.tap(find.byIcon(Icons.edit));
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.close), findsOneWidget);

          await tester.enterText(find.byType(TextFormField), "Test Laptop");
          await tester.testTextInput.receiveAction(TextInputAction.done);

          await tester.pumpAndSettle();
          expect(find.text("Test Laptop"), findsOneWidget);
          //await tester.tap(find.byIcon(Icons.edit));

          expect(find.byIcon(Icons.computer), findsOneWidget);
          expect(find.text("Status :"), findsOneWidget);
          //expect(find.text("Active"), findsOneWidget);

          expect(find.byIcon(Icons.refresh), findsOneWidget);
          expect(find.text("Last Refresh Time :"), findsOneWidget);
          //expect(find.text("Active"), findsOneWidget);

          expect(find.byIcon(Icons.memory_rounded), findsOneWidget);
          expect(find.text("CPU Usage :"), findsOneWidget);
          //expect(find.text("Active"), findsOneWidget);

          //expect(find.byIcon(Icons.memory_rounded), findsNWidgets(12));

          await tester.pumpAndSettle(const Duration(seconds: 10));
        },
      );
    },
  );
}

void main() {
  setupTests();
}
