// ignore_for_file: unused_import, prefer_const_constructors
// Ignored so that uncommenting the code to mock HTTP requests is simple.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/views/home.dart';
import 'package:my_family_story/views/login/auth.dart';
import 'package:my_family_story/views/login/login.dart';
import 'package:my_family_story/views/login/origin_profile.dart';

//import 'package:my_family_story/views/login/profile.dart';

import 'data/photo.dart';
import 'models/providers/filter_providers.dart';

/// Requires that a Firebase local emulator is running locally.
/// See https://firebase.flutter.dev/docs/auth/start/#optional-prototype-and-test-with-firebase-local-emulator-suite
bool shouldUseFirebaseEmulator = false;

Future<void> main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCtlSv-uaCVaiXDHr26PJU3GfJYqMcjziE",
          authDomain: "my-family-photo-dbfd7.firebaseapp.com",
          projectId: "my-family-photo-dbfd7",
          storageBucket: "my-family-photo-dbfd7.appspot.com",
          messagingSenderId: "90200908205",
          appId: "1:90200908205:web:76c142b02d711e35e44124",
          measurementId: "G-545FCD4Y8L"),
    );
  }

  // Ideal time to initialize
  if (shouldUseFirebaseEmulator) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  runApp(
    ProviderScope(
      // uncomment to mock the HTTP requests

      // overrides: [
      //   dioProvider.overrideWithValue(FakeDio(null))
      // ],
      child: LoginAuthApp(),
    ),
  );
}

/// A widget that unfocus everything when tapped.
///
/// This implements the "Unfocus when tapping in empty space" behavior for the
/// entire application.
class _Unfocus extends HookConsumerWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
