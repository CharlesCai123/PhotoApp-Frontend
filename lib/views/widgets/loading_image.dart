import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      httpHeaders: {},
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          Center(child: Text('error: ${error.toString()}')),
    );
  }
}
