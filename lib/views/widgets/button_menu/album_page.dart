import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlbumPage extends ConsumerStatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  AlbumPageState createState() => AlbumPageState();
}

class AlbumPageState extends ConsumerState<AlbumPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("AlbumPage"),
    );
  }
}
