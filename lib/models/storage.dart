import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:my_family_story/example_app/data/photo_model.dart';
import 'package:my_family_story/data/photo.dart';

abstract class StorageAccessor {
  Map<String, Object?> getAuthData();
  // Map<String, Object?> getFile();
  Future<Thumbnail> getPhoto(
      dynamic ref, Photo photo, String? targetPath, String? resolution);
}
