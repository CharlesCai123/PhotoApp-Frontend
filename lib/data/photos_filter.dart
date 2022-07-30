import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'photos_filter.freezed.dart';
part 'photos_filter.g.dart';

enum FilterOperator {
  none,
  equal,
  notEqual,
  contain,
  notContain,
}

@freezed
class PhotosFilter with _$PhotosFilter {
  const factory PhotosFilter({
    required String fieldName,
    required FilterOperator lastName,
    required String value,
  }) = _PhotosFilter;

  factory PhotosFilter.fromJson(Map<String, Object?> json) =>
      _$PhotosFilterFromJson(json);
}

@freezed
class PhotosFilters with _$PhotosFilters {
  const factory PhotosFilters({
    required List<PhotosFilter> filters,
  }) = _PhotosFilters;

  factory PhotosFilters.fromJson(Map<String, Object?> json) =>
      _$PhotosFiltersFromJson(json);
}
