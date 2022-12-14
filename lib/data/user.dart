import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'user.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'user.g.dart';

@freezed
class UserConfig with _$UserConfig {
  const factory UserConfig({
    int? userId,
    int? familyId,
    bool? authenticated,
    bool? localAuthenticated,
    String? displayName,
    String? plan,
    String? country,
    String? locale,
    String? language,
    DateTime? planExpires,
    String? trialPlan,
    DateTime? trialStarted,
    Map<String, Object?>? data,
  }) = _UserConfig;

  factory UserConfig.fromJson(Map<String, Object?> json) =>
      _$UserConfigFromJson(json);
}
