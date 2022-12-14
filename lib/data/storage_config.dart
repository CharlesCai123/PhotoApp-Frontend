import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'storage_config.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'storage_config.g.dart';

@freezed
class StorageConfig with _$StorageConfig {
  const factory StorageConfig({
    required int id,
    required String name,
    required Map<String, Object?> data,
  }) = _StorageConfig;

  factory StorageConfig.fromJson(Map<String, Object?> json) =>
      _$StorageConfigFromJson(json);
}

@freezed
class JSONData with _$JSONData {
  const factory JSONData({
    required Map<String, Object?> data,
  }) = _JSONData;

  factory JSONData.fromJson(Map<String, Object?> json) =>
      _$JSONDataFromJson(json);
}
