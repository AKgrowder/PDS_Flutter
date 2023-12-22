// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:photo_view/photo_view.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.all(10),
                child: Image.asset(ImageConstant.backArrow))),
      ),
      body: Container(
          child: PhotoView(
        backgroundDecoration: BoxDecoration(),
        imageProvider: CachedNetworkImageProvider(widget.path ?? ''),
      )),
    );
  }
}
