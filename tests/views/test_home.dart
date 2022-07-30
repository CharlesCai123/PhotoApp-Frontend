// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_family_story/data/photo.dart';
import 'package:my_family_story/data/photos_filter.dart';
import 'package:my_family_story/models/providers/filter_providers.dart';
import 'package:my_family_story/views/home.dart';
import 'package:my_family_story/views/login/login.dart';

var fake_filter_hash1 = 112233;
var filter = PhotosFilters(filters: []);
final photoList1 = PhotoList(photos: [
  for (var i = 0; i < 10; i++)
    Photo(
        id: -1,
        name: 'fake_photo-$i',
        blurhash: 'blurhash',
        url: 'url',
        uuid: 'uuid',
        storageId: 1)
], filterHash: filter.hashCode);

class FakePhotosRepository extends PhotosRepository {
  FakePhotosRepository(this._list) : super();
  final PhotoList _list;

  @override
  Future<PhotoList> fetchPhotoList({
    required dynamic ref,
    required PhotosFilters filters,
    int? limit,
    int? offset,
    String? nameStartsWith,
    CancelToken? cancelToken,
  }) async {
    return _list;
  }
}

// @GenerateMocks([ThumbnailView])
void main() {
  // group("Home widget test", (){});
  testWidgets('Test home widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        child: const MaterialApp(
          home: LoginAuthApp(),
        ),
        overrides: [
          photosProvider(filter).overrideWithValue(AsyncValue.data(photoList1))
        ],
      ),
      const Duration(seconds: 10),
    );

    // Verify that our counter starts at 0.
    // expect(find.byType(ThumbnailView), findsNWidgets(2));
    await tester.pumpAndSettle(const Duration(seconds: 10));
  });
}
