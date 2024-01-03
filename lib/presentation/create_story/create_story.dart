import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/CreateStory_Bloc/CreateStory_Cubit.dart';
import 'package:pds/API/Model/storyModel/stroyModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stories_editor/stories_editor.dart';
import '../../API/Bloc/CreateStory_Bloc/CreateStory_state.dart';
import '../../API/Model/CreateStory_Model/CreateStory_model.dart';
import '../../core/utils/color_constant.dart';

class CreateStoryPage extends StatefulWidget {
  double? finalFileSize;
  double? finalvideoSize;
  CreateStoryPage({key, this.finalFileSize, this.finalvideoSize});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  double value2 = 0.0;
  PlatformFile? file12;
  double finalvideoSize = 0;

  double finalFileSize = 0;
  ImageDataPostOne? imageDataPost;
  CreateStoryModel? createForm;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateStoryCubit, CreateStoryState>(
      listener: (context, state) {
        if (state is CreateStoryErrorState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is AddPostImaegState) {
          print("dsfdfhsdhfh");
          dataGetFunction(state);
        }
      },
      builder: (context, state) {
        return StoriesEditor(
          finalFileSize: widget.finalFileSize,
          finalvideoSize: widget.finalvideoSize,
          giphyKey: 'API KEY',
          //fontFamilyList: const ['Shizuru', 'Aladin'],
          galleryThumbnailQuality: 300,
          //isCustomFontList: true,
          onDone: (uri) async {
            print("finalUrlCheck-$uri");

            BlocProvider.of<CreateStoryCubit>(context)
                .UplodeImageAPI(context, 'Demo', uri);
          },
        );
      },
    );
  }

  dataGetFunction(state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? videoduration = prefs.getInt('videoduration');
    print("check video durationGet-${videoduration}");

    imageDataPost = state.imageDataPost;
    print("data Get value Get-${imageDataPost?.object}");
    if (imageDataPost?.object?.split('.').last == 'mp4') {
      print("check condison working on");
      dynamic imageDataPost1 = {
        'imageDataPost': imageDataPost,
        'videoduration': videoduration,
      };
      Navigator.pop(context, imageDataPost1);
    } else {
      Navigator.pop(context, imageDataPost);
    }
    /*  dynamic imageDataPost1 = {
      'imageDataPost': imageDataPost,
      'videoduration': videoduration,
    };
    Navigator.pop(context, imageDataPost1); */
  }

  prepareTestPdf(
    int Index,
  ) async {
    PlatformFile file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    {
      if (result != null) {
        file = result.files.first;

        if ((file.path?.contains(".mp4") ?? false) ||
            (file.path?.contains(".mov") ?? false) ||
            (file.path?.contains(".mp3") ?? false) ||
            (file.path?.contains(".png") ?? false) ||
            (file.path?.contains(".doc") ?? false) ||
            (file.path?.contains(".jpg") ?? false) ||
            (file.path?.contains(".m4a") ?? false)) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Selected File Error",
                textScaleFactor: 1.0,
              ),
              content: Text(
                "Only PDF, PNG, JPG Supported.",
                textScaleFactor: 1.0,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          getFileSize(file.path!, 1, result.files.first, Index);
        }
      } else {}
    }
    return "";
    // "${fileparth}";
  }

  getFileSize(
      String filepath, int decimals, PlatformFile file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);

    print("value2-->$value2");
    switch (i) {
      case 0:
        print("Done file size B");
        switch (Index) {
          case 1:
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              setState(() {
                file12 = file1;
              });
            }

            break;
          default:
        }
        print('xfjsdjfjfilenamecheckKB-${file1.path}');

        break;
      case 1:
        print("Done file size KB");
        switch (Index) {
          case 0:
            print("file1.name-->${file1.name}");
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              setState(() {
                file12 = file1;
              });
            }

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        print("file111.name-->${file1.name}");
        BlocProvider.of<CreateStoryCubit>(context)
            .UplodeImageAPI(context, file1.name, file1.path.toString());

        setState(() {});

        break;
      case 2:
        print("value2check-->$value2");
        print("finalFileSize-->${finalFileSize}");

        if (value2 > finalFileSize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${finalFileSize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          print("Done file Size 12MB");
          print("file1.namedata-->${file1.name}");
          switch (Index) {
            case 1:
              break;
            default:
          }
          print('filecheckPath1111-${file1.name}');
          print("file222.name-->${file1.name}");
          setState(() {
            file12 = file1;
          });

          BlocProvider.of<CreateStoryCubit>(context)
              .UplodeImageAPI(context, file1.name, file1.path.toString());
        }

        break;
      default:
    }

    return STR;
  }
}
