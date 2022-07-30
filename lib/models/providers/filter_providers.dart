import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/data/photo.dart';
import 'package:my_family_story/data/photos_filter.dart';
import 'package:my_family_story/data/storage_config.dart';
import 'package:my_family_story/models/providers/base_providers.dart';
import 'package:my_family_story/models/providers/fake_photo_source.dart';
import 'package:my_family_story/models/providers/storage_config_provider.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

List imageList = [
  "https://image.shutterstock.com/image-photo/beverly-hills-street-palm-trees-600w-1207682896.jpg",
  "https://image.shutterstock.com/image-photo/untouched-tropical-beach-sri-lanka-600w-109674992.jpg",
  "https://image.shutterstock.com/image-photo/typical-generic-suburban-single-family-600w-1728736828.jpg",
  "https://image.shutterstock.com/image-photo/typical-home-suburbs-los-angeles-600w-633846803.jpg",
  "https://image.shutterstock.com/image-photo/california-dream-houses-estates-santa-600w-403847389.jpg",
  "https://image.shutterstock.com/image-photo/view-swimming-pool-modern-home-600w-150192419.jpg",
];

final photoRepoProvider = StateProvider((ref) => PhotosRepository());

class PhotosRepository {
  PhotosRepository({int Function()? getCurrentTimestamp})
      : _getCurrentTimestamp = getCurrentTimestamp ??
            (() => DateTime.now().millisecondsSinceEpoch);

  final int Function() _getCurrentTimestamp;

  // MyCacheManager _cacheManager;

  Future<PhotoList> fetchPhotoList({
    required dynamic ref,
    required PhotosFilters filters,
    int? limit,
    int? offset,
    String? nameStartsWith,
    CancelToken? cancelToken,
  }) async {
    var _dio = ref.watch(dioProvider);

    var list = [for (var i = 100; i <= 130; i++) i];
    var photos = [for (var i in list) await get_photo(i)];
    return PhotoList(photos: photos, filterHash: filters.hashCode);

    // final cleanNameFilter = nameStartsWith?.trim();
    // final response = await _get(
    //   'characters',
    //   queryParameters: <String, Object?>{
    //     'offset': offset,
    //     if (limit != null) 'limit': limit,
    //     if (cleanNameFilter != null && cleanNameFilter.isNotEmpty)
    //       'nameStartsWith': cleanNameFilter,
    //   },
    //   cancelToken: cancelToken,
    // );
    //
    // final result = MarvelListCharactersReponse(
    //   characters: response.data.results.map((e) {
    //     return Photo.fromJson(e);
    //   }).toList(growable: false),
    //   totalCount: response.data.total,
    // );
    //
    // for (final character in result.characters) {
    //   _characterCache[character.id.toString()] = character;
    // }
    //
    // return result;
  }

  Future<Thumbnail> _fetchThumbnail(
    dynamic ref,
    Photo photo, {
    CancelToken? cancelToken,
  }) async {
    // Don't fetch the Character if it was already obtained previously, either
    // in the home page or in the detail page.
    // if (_characterCache.containsKey(id)) {
    //   return _characterCache[id]!;
    // }

    // final response = await _get('characters/$id', cancelToken: cancelToken);
    var acc = DummyStorageAccessor();
    return acc.getPhoto(ref, photo, null, null);
    // return Photo.fromJson(response.data.results.single);
  }

  Future<JSONData> _get(
    String path, {
    Map<String, Object?>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return JSONData.fromJson(Map<String, Object>());

    // final configs = await _read(configurationsProvider.future);
    //
    // final timestamp = _getCurrentTimestamp();
    // final hash = md5
    //     .convert(
    //       utf8.encode('$timestamp${configs.privateKey}${configs.publicKey}'),
    //     )
    //     .toString();
    //
    // final result = await _read(dioProvider).get<Map<String, Object?>>(
    //   'https://gateway.marvel.com/v1/public/$path',
    //   cancelToken: cancelToken,
    //   queryParameters: <String, Object?>{
    //     'apikey': configs.publicKey,
    //     'ts': timestamp,
    //     'hash': hash,
    //     ...?queryParameters,
    //   },
    //   // TODO deserialize error message
    // );
    // return JSONData.fromJson(Map<String, Object>.from(result.data!));
  }
}

final filtersProvider = ChangeNotifierProvider((ref) => Filters());
int filterCnt = 1;

class Filters extends ChangeNotifier {
  List<Filter> filters = [
    Filter("Jason", imageList[0]),
    Filter("Big Mountains", imageList[1]),
    Filter("Cats", imageList[2]),
    Filter("In California", imageList[3]),
    Filter("Anna Laughing", imageList[4]),
    Filter("Sunset", imageList[5]),
  ];
}

/// Settings for filter
class Filter extends ChangeNotifier {
  String photoUrl;
  late DateTime time;
  String filterName;
  List<String> peopleName = [];
  List<FilterGroup> filterGroup = [];

  Filter([
    this.filterName = "Filter",
    this.photoUrl =
        "https://upload.wikimedia.org/wikipedia/commons/e/e4/Color-blue.JPG",
  ]);

  void addFilterGroup(_) {
    filterGroup.add(_);
    filterGroup[0].logicOperator = null;
    notifyListeners();
  }

  void removeFilterGroup(_) {
    filterGroup.remove(_);
    if (filterGroup.isNotEmpty) filterGroup[0].logicOperator = null;
    notifyListeners();
  }

  /// Deepcopy a Filter instance
  Filter deepCopy() {
    late Filter _newFilter = Filter();
    _newFilter.photoUrl = photoUrl;
    _newFilter.filterName = filterName;

    // deep copy list element
    List<FilterGroup> _filterGrp = [];
    for (int i = 0; i < filterGroup.length; i++) {
      _filterGrp.add(filterGroup[i].deepCopy());
    }

    List<String> _peopleName = [];
    for (int i = 0; i < peopleName.length; i++) {
      _peopleName.add(peopleName[i]);
    }

    _newFilter.peopleName = _peopleName;
    _newFilter.filterGroup = _filterGrp;
    //_newFilter.time = time;
    return _newFilter;
  }
}

/// Settings for filter group
class FilterGroup extends ChangeNotifier {
  bool? logicOperator = true;
  String filterGroupName;
  List<FilterRule> filterRule = [];

  FilterGroup([this.filterGroupName = "Filter Group"]);

  void changeLogicOperator(_) {
    logicOperator = _;
    notifyListeners();
  }

  void addFilterRule(_) {
    filterRule.add(_);
    filterRule[0].logicOperator = null;
    notifyListeners();
  }

  void removeFilterRule(_) {
    filterRule.remove(_);
    if (filterRule.isNotEmpty) filterRule[0].logicOperator = null;
    notifyListeners();
  }

  /// Deepcopy a Filter Group instance
  FilterGroup deepCopy() {
    late FilterGroup _filterGrp = FilterGroup(filterGroupName);
    _filterGrp.logicOperator = logicOperator;
    _filterGrp.filterGroupName = filterGroupName;
    List<FilterRule> _filterRule = [];
    for (int i = 0; i < filterRule.length; i++) {
      _filterRule.add(filterRule[i].deepCopy());
    }
    _filterGrp.filterRule = _filterRule;
    return _filterGrp;
  }
}

/// Defined for Filter Rule ( Subject -- Predicate -- Object )
enum Subjects {
  people,
  source,
  createTime,
}

enum Predicates {
  in_,
  before,
  contains,
}

enum Objects {
  place,
  value,
  person,
  timeLine,
}

/// Settings for filter rule
class FilterRule extends ChangeNotifier {
  bool? logicOperator = true;

  Subjects subject = Subjects.people;
  Predicates predicate = Predicates.contains;
  Objects object = Objects.person;

  void changeLogicOperator(_) {
    logicOperator = _;
    notifyListeners();
  }

  /// Deepcopy a Filter Rule instance
  FilterRule deepCopy() {
    FilterRule _filterRule = FilterRule();
    _filterRule.logicOperator = logicOperator;
    _filterRule.subject = subject;
    _filterRule.predicate = predicate;
    _filterRule.object = object;
    return _filterRule;
  }
}
