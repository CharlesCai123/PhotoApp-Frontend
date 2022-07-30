import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/views/router/routes.dart';

import '../home.dart';
import 'auth.dart';

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class LoginAuthApp extends ConsumerWidget {
//class AuthExampleApp extends StatelessWidget {
  const LoginAuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Family Story App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constrains) {
            return Row(
              children: [
                Visibility(
                  visible: constrains.maxWidth >= 1200,
                  child: Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Firebase Auth Desktop',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: constrains.maxWidth >= 1200
                      ? constrains.maxWidth / 2
                      : constrains.maxWidth,
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const MyHomePage();
                      }
                      return const AuthGate();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
