import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../core/utils/image_constant.dart';

class ProfileandDocumentScreen extends StatelessWidget {
  String? path;
  String? title;
  ProfileandDocumentScreen({Key? key, this.path, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 30,
            width: 30,
            color: Color.fromRGBO(255, 255, 255, 0.3),
            child: Center(
              child: Image.asset(
                ImageConstant.backArrow,
                fit: BoxFit.fill,
                height: 25,
                width: 25,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        elevation: 0,
        title: Text(
          title ?? '',
          style: TextStyle(color: Colors.black),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
          color: Colors.white,
          margin: EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0, bottom: 8.0),
          child: path!.contains('.jpg') ||
                  path!.contains('.png') ||
                  path!.contains('.jpeg') ||
                  path!.endsWith('.webp')
              ? Container(
                  child: PhotoView(
                    backgroundDecoration: BoxDecoration(),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    imageProvider: CachedNetworkImageProvider(
                      path!,
                      cacheKey: path,
                    ),
                  ),
                )
              : Container(
                  child: SfPdfViewer.network(path!,
                      key: Key(path!),
                      pageLayoutMode: PdfPageLayoutMode.continuous),
                  // child: PDF().cachedFromUrl(
                  //   path,
                  //   placeholder: (progress) =>
                  //       Center(child: Text('$progress %')),
                  //   errorWidget: (error) =>
                  //       Center(child: Text(error.toString())),
                  // ),
                )),
    );
  }
}
