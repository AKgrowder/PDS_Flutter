import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

Future takePicture(
    {required contentKey,
    required SelectPath,
    required BuildContext context,
    required saveToGallery}) async {
  try {
    /// converter widget to image
         print("slected pathe check-$SelectPath");


     if(SelectPath
            .toString()
            .split('/')
            .last
            .toString()
            .split('.')
            .last ==
        'mp4'){
          print("this condison is working");
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
  final filePath = SelectPath;
      // saveFile("${SelectPath}stories_creator${DateTime.now()}.mp4"); 
      
      // ImageGallerySaver.saveFile("${SelectPath}stories_creator${DateTime.now()}.mp4"); 
      print("Resultcheck-$filePath");
      return filePath;

     }else{
      RenderRepaintBoundary boundary =
        contentKey.currentContext.findRenderObject();

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    /// create file
    final String dir = (await getApplicationDocumentsDirectory()).path;
    print("sdfsdf=========================================");
    print(dir);

    String imagePath = '$dir/stories_creator${DateTime.now()}.png';
    File capturedFile = File(imagePath);
    await capturedFile.writeAsBytes(pngBytes);

    // final String dir1= (await getApplicationDocumentsDirectory()).path;
    // print("sdfsdf=========================================");
    // print(dir1);
    // String imagePath1 = '$dir1/stories_creator${DateTime.now()}.mp4';
    // File capturedFile1 = File(imagePath1);
    // await capturedFile1.writeAsBytes(pngBytes);

    if (saveToGallery) {
      final result = await ImageGallerySaver.saveImage(pngBytes,
          quality: 100, name: "stories_creator${DateTime.now()}.png");

      if (result != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return imagePath;
    }
     }    
    
  } catch (e) {
    debugPrint('exception => $e');
    return false;
  }
}
