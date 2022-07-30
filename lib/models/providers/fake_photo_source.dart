import 'package:my_family_story/data/photo.dart';
import 'package:dio/dio.dart';

// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sprintf/sprintf.dart';

import 'package:my_family_story/data/storage_config.dart';

// This two URL are not the offical XKCD URL, since on Chrome, we'll get CORS
// errors.
// So I have to manually download 300 images from XKCD and put them on github.
// Only limited to the images with index of 1 to 300 for now.
var XKCD_url = 'https://getxkcd.vercel.app/api/comic?num=%i';
var XKCD_img_url =
    'https://raw.githubusercontent.com/cuixiongyi/xkcd/master/xkcd_imgs/%s';

Future<Photo> get_photo(int idx) async {
  var dio = Dio();
  var options = Options(method: 'GET');
  var response = await dio.request(
    sprintf(XKCD_url, [idx]),
    data: {},
    options: options,
  );
  // print(response);
  var img_name = response.data['img'].toString().split('/').last;
  return Future<Photo>(() => Photo(
      id: idx,
      name: response.data['title'],
      blurhash: 'blurhash',
      url: sprintf(XKCD_img_url, [img_name]),
      uuid: 'xvcd-$idx',
      storageId: 1));
}

// class FakeDio implements Dio {
//   FakeDio([this._apiKey = '42']);
//
//   final String? _apiKey;
//
//   @override
//   Future<Response<T>> get<T>(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     print('hello $_apiKey $queryParameters');
//     if (_apiKey != null && queryParameters?['apikey'] != _apiKey) {
//       throw StateError('Missing api key');
//     }
//
//     switch (path) {
//       case 'https://gateway.marvel.com/v1/public/characters/1009368':
//         return FakeResponse(_character1009368) as Response<T>;
//       case 'https://gateway.marvel.com/v1/public/characters':
//         if (queryParameters?['nameStartsWith'] == 'Iron man') {
//           return FakeResponse(_charactersIronMan) as Response<T>;
//         }
//         if (queryParameters?['nameStartsWith'] == 'Iron man (') {
//           return FakeResponse(_charactersIronMan2) as Response<T>;
//         }
//         if (queryParameters?['offset'] == 0) {
//           return FakeResponse(_characters) as Response<T>;
//         }
//         if (queryParameters?['offset'] == 20) {
//           return FakeResponse(_characters20) as Response<T>;
//         }
//         break;
//     }
//     if (path == '?apikey=$_apiKey') {}
//     throw UnimplementedError();
//   }
//
//   @override
//   void noSuchMethod(Invocation invocation) {
//     throw UnimplementedError();
//   }
// }
//
// class FakeResponse implements Response<Map<String, Object?>> {
//   FakeResponse(this.data);
//
//   @override
//   final Map<String, Object?> data;
//
//   @override
//   void noSuchMethod(Invocation invocation) {
//     throw UnimplementedError();
//   }
// }
main() {
  get_photo(1);
}
