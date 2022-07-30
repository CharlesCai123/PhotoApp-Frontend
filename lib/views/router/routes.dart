import 'package:flutter/material.dart';
import 'package:my_family_story/views//settings/settings_menu/compute_unit_config_page.dart';
import 'package:my_family_story/views//settings/settings_menu/encryption_settings_page.dart';
import 'package:my_family_story/views//settings/settings_menu/general_settings_page.dart';
import 'package:my_family_story/views/settings/settings_menu/backup_settings_page.dart';
import 'package:my_family_story/views/settings/settings_menu/notification_settings_page.dart';
import 'package:my_family_story/views/settings/settings_menu/privacy_settings_page.dart';
import 'package:my_family_story/views/settings/settings_menu/storage_unit_config_page.dart';
import 'package:my_family_story/views/widgets/filter_settings.dart';

import '../home.dart';

/// Configure Router
final routes = {
  /// Home Page
  '/home': (context) => MyHomePage(),

  /// Home Button Menu
  '/home/photo': (context) => MyHomePage(0),
  '/home/album': (context) => MyHomePage(1),
  '/home/filter': (context) => MyHomePage(2),
  '/home/settings': (context) => MyHomePage(3),

  /// Filter Settings
  '/filter/filter_settings': (context, {arguments}) =>
      FilterSettingsPage(arguments),

  /// Settings
  '/storage_unit_config': (context) => const StorageUnitConfigPage(),
  '/compute_unit_config': (context) => const ComputeUnitConfigPage(),
  '/backup_settings': (context) => const BackupSettingsPage(),
  '/encryption_settings': (context) => const EncryptionSettingsPage(),
  '/general_settings': (context) => const GeneralSettingsPage(),
  '/privacy_settings': (context) => const PrivacySettingsPage(),
  '/notification_settings': (context) => const NotificationSettingsPage(),
};

// Route Generator Callback
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  print(settings.name);
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      //print(settings.arguments);
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  } else {
    return null;
  }
};
