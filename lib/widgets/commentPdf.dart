import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentViewScreen extends StatelessWidget {
  String? path;
  String? title;
  bool? dataHowToDislay;
  DocumentViewScreen({Key? key, this.path, this.title, this.dataHowToDislay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("if the DocumentViewScreen");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        elevation: 0,
        title: Text(
          "Document",
          style: TextStyle(color: Colors.black),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
          color: Colors.white,
          margin: EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0, bottom: 8.0),
          child: path!.contains('.jpg') ||
                  path!.contains('.png') ||
                  path!.contains('.jpeg')
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

class DocumentViewScreen1 extends StatelessWidget {
  String? path;
  String? title;

  bool? dataHowToDislay;
  DocumentViewScreen1({
    Key? key,
    this.path,
    this.title,
    this.dataHowToDislay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("dsfgdhfhfbgh-${path}");
    return Scaffold(
      body: path != null
          ? Container(
              color: Colors.white,
              margin:
                  EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0, bottom: 8.0),
              child: path!.contains('.jpg') ||
                      path!.contains('.png') ||
                      path!.contains('.jpeg')
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
                      child: SfPdfViewer.network(
                        path!,
                        key: Key(path!),
                        pageLayoutMode: PdfPageLayoutMode.continuous,
                      ),
                    ))
          : GFLoader(type: GFLoaderType.ios),
    );
  }
}
