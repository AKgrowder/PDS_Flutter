import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:photo_view/photo_view_gallery.dart';

class ImageViewScreen extends StatefulWidget {
  String? path;
  ImageViewScreen({
    Key? key,
    this.path,
  }) : super(key: key);

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
          child: PhotoView(
        backgroundDecoration: BoxDecoration(),
        imageProvider: CachedNetworkImageProvider(widget.path ?? ''),
        
      )),
    );
  }
}
