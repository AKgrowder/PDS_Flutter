import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerController {
  ImagePicker picker = ImagePicker();
  XFile? pickedImageFile;
  List<File>? imageFileList = [];
  List<File>? imageThumbList = [];
  Future<void> pickProfileImage(BuildContext context) async {
    final galleryPermission =
        await permissionHandler(context, Permission.camera);
    if (galleryPermission == true) {
      pickedImageFile = await picker.pickImage(source: ImageSource.camera);
      // Get.back();
    }
  }

  Future<void> selectProfileImage(BuildContext context) async {
    print(Platform.isIOS);

    final galleryPermission = await permissionHandler(
        context, Platform.isIOS ? Permission.photos : Permission.storage);

    if (galleryPermission == true) {
      pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
      // Get.back();
    }
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

Future<bool?> permissionHandler(
    BuildContext context, Permission? permission) async {
  bool cameraAccess = false;
  try {
    Map<Permission, PermissionStatus> statues = await [permission!].request();
    String? name = permission.toString().replaceAll("Permission.", "");
    String? title = name.replaceAll("Permission.", "").toCapitalized();
    PermissionStatus? statusPhotos = statues[permission];
    bool isGranted = (statusPhotos == PermissionStatus.granted ||
        statusPhotos == PermissionStatus.limited);
    if (isGranted) {
      cameraAccess = true;
    } else {
      showCupertinoModalPopup<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('${title} Permission'),
          content: Text(
            '${name} permission should Be granted to use this feature, would you like to go to app settings to give ${name}   permission?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                // Get.back();
                openAppSettings();
              },
              child: Text('Yes'),
            )
          ],
        ),
      );
    }
  } on Exception catch (e) {
    print(e);
  }
  return cameraAccess;
}
