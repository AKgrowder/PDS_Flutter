// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../core/utils/color_constant.dart';
// import 'package:dio/dio.dart';

class DocumentViewScreen extends StatefulWidget {
  String? path;
  String? title;

  DocumentViewScreen({
    Key? key,
    this.path,
    this.title,
  }) : super(key: key);

  @override
  State<DocumentViewScreen> createState() => _DocumentViewScreenState();
}

class _DocumentViewScreenState extends State<DocumentViewScreen> {
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
          child: widget.path!.contains('.jpg') ||
                  widget.path!.contains('.png') ||
                  widget.path!.contains('.jpeg') ||
                  widget.path!.contains('.webp')
              ? Container(
                  child: PhotoView(
                    backgroundDecoration: BoxDecoration(),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    imageProvider: CachedNetworkImageProvider(
                      widget.path!,
                      cacheKey: widget.path,
                    ),
                  ),
                )
              : Container(
                  child: SfPdfViewer.network(widget.path!,
                      key: Key(widget.path!),
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

  late String _localPath;
  late bool _permissionReady;
  int? version;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
              onTap: () {
                shareImageDownload(context);
              },
              child: Icon(Icons.download_sharp, color: Colors.black)),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: path != null
          ? Container(
              color: Colors.white,
              margin:
                  EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0, bottom: 8.0),
              child: path!.contains('.jpg') ||
                      path!.contains('.png') ||
                      path!.contains('.jpeg') ||
                      path!.contains('.webp')
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

  shareImageDownload(BuildContext context) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = path;

    if (url!.isNotEmpty) {
      _permissionReady = await _checkPermission();
      await _prepareSaveDir();

      if (_permissionReady) {
        print("Downloading");
        print("${url}");

        try {
          await Dio().download(
            url.toString(),
            _localPath +
                "/" +
                "Inpackaging_${DateTime.now().toIso8601String().replaceAll(":", "-")}.pdf",
          );

          print("Download Completed.");
          SnackBar snackBar = SnackBar(
            content: Text("Download Successfully !!"),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } catch (e) {
          print("Download Failed.\n\n" + e.toString());
        }
      }
    } else {
      print('No Invoice Available');
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
      print('first vvvvvvvvvvvvvvvvvvv');
    }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator;
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = await DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final status = (int.parse(androidInfo.version.release)) < 13
          ? await Permission.storage.status
          : await Permission.mediaLibrary.status;
      if (status != PermissionStatus.granted) {
        final result = (int.parse(androidInfo.version.release)) < 13
            ? await Permission.storage.request()
            : await Permission.mediaLibrary.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
