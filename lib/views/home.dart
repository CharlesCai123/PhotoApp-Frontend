// ignore: import_of_legacy_library_into_null_safe
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_family_story/data/photo.dart';
import 'package:my_family_story/data/photos_filter.dart';
import 'package:my_family_story/models/providers/filter_providers.dart';
import 'package:my_family_story/models/providers/storage_config_provider.dart';
import 'package:my_family_story/views/settings/settings_page.dart';
import 'package:my_family_story/views/widgets/button_menu/album_page.dart';
import 'package:my_family_story/views/widgets/button_menu/filter_page.dart';
import 'package:my_family_story/views/widgets/button_menu/photo_page.dart';
import 'package:my_family_story/views/widgets/loading_image.dart';

// import 'package:my_family_story/models/';
part 'home.freezed.dart';

/// Displayed as a profile image if the user doesn't have one.
const placeholderImage =
    'https://upload.wikimedia.org/wikipedia/commons/c/cd/Portrait_Placeholder_Square.png';

const kCharactersPageLimit = 50;
int _count = 0;

@freezed
class ThumbnailIdentifier with _$ThumbnailIdentifier {
  factory ThumbnailIdentifier({
    required PhotosFilters filters,
    required int index,
  }) = _ThumbnailIdentifier;
}

class AbortedException implements Exception {}

final photosProvider =
    FutureProvider.autoDispose.family<PhotoList, PhotosFilters>(
  (ref, filter) async {
    // Cancel the page request if the UI no longer needs it before the request
    // is finished.
    // This typically happen if the user scrolls very fast
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    // Debouncing the request. By having this delay, it leaves the opportunity
    // for consumers to subscribe to a different `meta` parameters. In which
    // case, this request will be aborted.
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (cancelToken.isCancelled) throw AbortedException();

    final photoRepo = ref.watch(photoRepoProvider);
    return photoRepo.fetchPhotoList(ref: ref, filters: filter);
  },
  // When a page is no-longer use, keep it in cache for up to 5 minutes.
  // After this point, if the list of characters is requested again, a new fetch
  // will be performed.
  cacheTime: const Duration(minutes: 5),
);

final photoThumbnailsProvider =
    FutureProvider.autoDispose.family<Thumbnail, ThumbnailIdentifier>(
  (ref, thumbnailIdentifier) async {
    // Cancel the page request if the UI no longer needs it before the request
    // is finished.
    // This typically happen if the user scrolls very fast
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    // Debouncing the request. By having this delay, it leaves the opportunity
    // for consumers to subscribe to a different `meta` parameters. In which
    // case, this request will be aborted.
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (cancelToken.isCancelled) throw AbortedException();
    var accessor = DummyStorageAccessor();
    final photoList =
        await ref.watch(photosProvider(thumbnailIdentifier.filters).future);
    final thumbnail = accessor.getPhoto(
        ref, photoList.photos[thumbnailIdentifier.index], '', '');
    return thumbnail;
  },
  // When a page is no-longer use, keep it in cache for up to 5 minutes.
  // After this point, if the list of characters is requested again, a new fetch
  // will be performed.
  cacheTime: const Duration(minutes: 5),
);

class MyHomePage extends ConsumerStatefulWidget {
  final int index;

  //const MyHomePage( {Key? key}) : super(key: key);
  const MyHomePage([this.index = 0]);

  @override
  MyHomePageState createState() => MyHomePageState(index);
}

class MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  final int _index;

  MyHomePageState(this._index);

  late User user;
  late TextEditingController controller;
  late TabController _tabController;

  String? photoURL;

  bool showSaveButton = false;
  bool isLoading = false;

  late int _selectedIndex;

  final List _pageList = [
    const PhotoPage(),
    const AlbumPage(),
    const FilterPage(),
    const SettingsPage()
  ];

  @override
  void initState() {
    _selectedIndex = _index;

    user = FirebaseAuth.instance.currentUser!;
    print(user);
    controller = TextEditingController(text: user.displayName);

    controller.addListener(_onNameChanged);

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    log(user.toString());

    super.initState();
  }

  void _onNameChanged() {
    setState(() {
      if (controller.text == user.displayName || controller.text.isEmpty) {
        showSaveButton = false;
      } else {
        showSaveButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var filter = const PhotosFilters(filters: []);

    /// Bottom Navigation Bar
    const List<BottomNavigationBarItem> bottomNavItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.photo),
        label: "Photo",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.auto_stories),
        label: "Album",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.filter_alt_sharp),
        label: "Filter",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings",
      ),
    ];

    return ref.watch(photosProvider(filter)).when(
          loading: () => Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                child: Text('$err'),
              ),
            );
          },
          data: (photoList1) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('MyPhoto App'),
              ),
              body: _pageList[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                type: BottomNavigationBarType.fixed,
                items: bottomNavItems,
                onTap: (int index) {
                  setState(
                    () {
                      _selectedIndex = index;
                    },
                  );
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              drawer: Drawer(
                elevation: 20.0,
                child: Column(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(user.displayName ?? "Charlescai"),
                      accountEmail: Text(user.email ?? ""),
                      currentAccountPicture: CircleAvatar(
                        maxRadius: 60,
                        backgroundImage: NetworkImage(
                          user.photoURL ?? placeholderImage,
                        ),
                      ),
                    ),
                    const ListTile(
                      title: Text("Inbox"),
                      leading: Icon(Icons.mail),
                    ),
                    const Divider(
                      height: 0.1,
                    ),
                    const ListTile(
                      title: Text("My profile"),
                      leading: Icon(Icons.home),
                    ),
                    const ListTile(
                      title: Text("Photos"),
                      leading: Icon(Icons.photo),
                    ),
                    const ListTile(
                      title: Text("Story"),
                      leading: Icon(Icons.people),
                    ),
                    const ListTile(
                      title: Text("Trip"),
                      leading: Icon(Icons.flight),
                    ),
                    ListTile(
                      title: const Text("Sign Out"),
                      leading: const Icon(Icons.logout),
                      onTap: _signOut,
                      //leading: Icon(Icons.),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }

  /// sign out
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    print("sign out!");
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}

class ThumbnailView extends ConsumerWidget {
  const ThumbnailView(
      {required PhotosFilters photosFilters, required int index, Key? key})
      : photosFilters = photosFilters,
        index = index,
        super(key: key);

  final PhotosFilters photosFilters;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var identifier = ThumbnailIdentifier(filters: photosFilters, index: index);
    final photoThumbnail = ref.watch(photoThumbnailsProvider(identifier));

    return photoThumbnail.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error $err'),
      data: (thumbnail) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.pushNamed(context, '/characters/${character.id}');
          // },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: 'character-${thumbnail.uuid}',
                    child: LoadingImage(url: thumbnail.url),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(thumbnail.uuid),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
