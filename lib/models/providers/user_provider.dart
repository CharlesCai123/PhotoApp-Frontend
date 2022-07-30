import 'dart:convert';

import 'package:my_family_story/models/providers/base_providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:my_family_story/data/user.dart';
import 'package:my_family_story/constants/keys.dart';

final activeUserProvider =
    StateNotifierProvider<ActiveUserNotifier, UserConfig>((ref) {
  return ActiveUserNotifier();
});

class ActiveUserNotifier extends StateNotifier<UserConfig> {
  ActiveUserNotifier() : super(const UserConfig());

  void loadLatestLocalUser({required ProviderElement ref}) async {
    var database = ref.read(localDatabaseProvider);
    var activeUserID = await database.read(key: kActiveUserID);
    var jsonStr = await database.read(key: kActiveUsersJSON).catchError(
        (error, stackTrace) => throw NoActiveUserException(
            'Loading local user. Can\'t find key : $kActiveUsersJSON'));
    var userJson = jsonDecode(jsonStr!);
    if (!userJson.contains(activeUserID)) {
      throw NoActiveUserException(
          'Loading local user. No user found in local config : $kActiveUsersJSON');
    }
    var activeUser = UserConfig.fromJson(userJson[activeUserID]);
    if (!activeUser.authenticated!) {
      throw LocalUserUnauthenticatedException(
          "The local user is not authenticated. Need to re-authenticated");
    }
    activeUser = activeUser.copyWith(localAuthenticated: false);
    state = activeUser;
  }

  void addActiveUser(UserConfig user) {}
}

class NoActiveUserException implements Exception {
  String cause;
  NoActiveUserException(this.cause);
}

class LocalUserUnauthenticatedException implements Exception {
  String cause;
  LocalUserUnauthenticatedException(this.cause);
}
