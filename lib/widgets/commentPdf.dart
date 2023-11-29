import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class DocumentViewScreen extends StatefulWidget {
  String? path;
  String? title;
  bool? dataHowToDislay;

  DocumentViewScreen({Key? key, this.path, this.title, this.dataHowToDislay})
      : super(key: key);

  @override
  State<DocumentViewScreen> createState() => _DocumentViewScreenState();
}

class _DocumentViewScreenState extends State<DocumentViewScreen> {
  late bool _permissionReady;
  late String _localPath;
  late TargetPlatform? platform;
  bool pathExists = false;
  int? version;
  String? nameUrl;

  @override
  void initState() {
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    // Platform.isAndroid ? getVersion() : SizedBox();

    super.initState();
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
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

  // getVersion() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   version =
  //       await int.parse(prefs.getString(PreferencesKey.version).toString());

  //   print('version ${version}');
  // }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
      print('first vvvvvvvvvvvvvvvvvvv');
      setState(() {
        pathExists = false;
      });
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/storage/emulated/0/Download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator;
    }
  }

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
        actions: [
          /* GestureDetector(
              onTap: () async {
                _permissionReady = await _checkPermission();
                await _prepareSaveDir();

                if (_permissionReady) {
                  print("Downloading");

                  try {
                    await Dio().download(
                      widget.path.toString(),
                      _localPath + "/" + "images",
                      /* Invoice.pdf */
                      onReceiveProgress: (receivedBytes, totalBytes) {
                        if (totalBytes != -1) {
                          final progress =
                              ((receivedBytes / totalBytes) * 100).toInt();
                        }
                      },
                    );

                    print("Download Completed.");
                  } catch (e) {
                    print("Download Failed.\n\n" + e.toString());
                  }
                }
              },
              child: Icon(Icons.download_sharp, color: Colors.black)), */
          SizedBox(
            width: 20,
          )
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
          color: Colors.white,
          margin: EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0, bottom: 8.0),
          child: widget.path!.contains('.jpg') ||
                  widget.path!.contains('.png') ||
                  widget.path!.contains('.jpeg')
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
