import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider((ref) => Dio());

final localDatabaseProvider =
    Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage());

class MyCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'myPhotoCache';

  static final MyCacheManager _instance = MyCacheManager._();
  factory MyCacheManager() {
    return _instance;
  }

  MyCacheManager._() : super(Config(key));
}

final cacheProvider = Provider((ref) => MyCacheManager());
