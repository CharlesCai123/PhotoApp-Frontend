import 'package:dio/dio.dart';
import 'package:my_family_story/data/photo.dart';
import 'package:my_family_story/models/providers/base_providers.dart';
import 'package:my_family_story/models/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DummyStorageAccessor extends StorageAccessor {
  @override
  Map<String, Object?> getAuthData() {
    return {'auth': 'fake_auth_data'};
  }

  @override
  Future<Thumbnail> getPhoto(
      dynamic ref, Photo photo, String? targetPath, String? resolution) async {
    // var resp = await _dio.get(photo.url);
    var _cacheManager = ref.watch(cacheProvider);
    try {
      // var file = await _cacheManager.downloadFile(photo.url);
      return Future(() => Thumbnail(
          uuid: photo.uuid,
          // filePath: file.file.absolute.toString().substring(12),
          filePath: '',
          url: photo.url));
    } on Exception catch (exception, stack) {
      print(exception);
      print(stack);
      throw exception;
    }
  }
}
