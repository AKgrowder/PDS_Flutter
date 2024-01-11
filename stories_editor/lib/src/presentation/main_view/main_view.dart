// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stories_editor/src/domain/models/editable_items.dart';
import 'package:stories_editor/src/domain/models/painting_model.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/gradient_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/scroll_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/domain/sevices/save_as_image.dart';
import 'package:stories_editor/src/gallery_media_picker/gallery_media_picker.dart';
import 'package:stories_editor/src/presentation/bar_tools/bottom_tools.dart';
import 'package:stories_editor/src/presentation/bar_tools/top_tools.dart';
import 'package:stories_editor/src/presentation/draggable_items/delete_item.dart';
import 'package:stories_editor/src/presentation/draggable_items/draggable_widget.dart';
import 'package:stories_editor/src/presentation/main_view/trimervideo.dart';
import 'package:stories_editor/src/presentation/painting_view/painting.dart';
import 'package:stories_editor/src/presentation/painting_view/widgets/sketcher.dart';
import 'package:stories_editor/src/presentation/text_editor_view/TextEditor.dart';
import 'package:stories_editor/src/presentation/utils/constants/app_enums.dart';
import 'package:stories_editor/src/presentation/utils/modal_sheets.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';
import 'package:stories_editor/src/presentation/widgets/scrollable_pageView.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_trimmer/video_trimmer.dart';

class MainView extends StatefulWidget {
  /// editor custom font families
  final List<String>? fontFamilyList;

  /// editor custom font families package
  final bool? isCustomFontList;

  /// giphy api key
  final String giphyKey;

  /// editor custom color gradients
  final List<List<Color>>? gradientColors;

  /// editor custom logo
  final Widget? middleBottomWidget;

  /// on done
  final Function(String)? onDone;

  /// on done button Text
  final Widget? onDoneButtonStyle;

  /// on back pressed
  final Future<bool>? onBackPress;

  /// editor background color
  Color? editorBackgroundColor;

  /// gallery thumbnail quality
  final int? galleryThumbnailQuality;
  double? finalFileSize;
  double? finalvideoSize;

  /// editor custom color palette list
  List<Color>? colorList;

  MainView(
      {Key? key,
      required this.giphyKey,
      required this.onDone,
      this.middleBottomWidget,
      this.colorList,
      this.isCustomFontList,
      this.fontFamilyList,
      this.gradientColors,
      this.onBackPress,
      this.onDoneButtonStyle,
      this.editorBackgroundColor,
      this.galleryThumbnailQuality,
      this.finalFileSize,
      this.finalvideoSize})
      : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// content container key
  final GlobalKey contentKey = GlobalKey();

  ///Editable item
  EditableItem? _activeItem;
  VideoPlayerController? _controller;

  /// Gesture Detector listen changes
  Offset _initPos = const Offset(0, 0);
  Offset _currentPos = const Offset(0, 0);
  double _currentScale = 1;
  double _currentRotation = 0;
  double value2 = 0.0;
  // Initialize your trimmer instance

  /// delete position
  ///
  dynamic data;
  bool _isDeletePosition = false;
  bool _inAction = false;
  bool nodatainTextfiled = false;
  Duration? duration;
  int? totalhoures;
  int? totalminuert;
  int? totalSeconds;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var _control = Provider.of<ControlNotifier>(context, listen: false);
      _control.giphyKey = widget.giphyKey;
      _control.middleBottomWidget = widget.middleBottomWidget;
      _control.isCustomFontList = widget.isCustomFontList ?? false;
      if (widget.gradientColors != null) {
        _control.gradientColors = widget.gradientColors;
      }
      if (widget.fontFamilyList != null) {
        _control.fontList = widget.fontFamilyList;
      }
      if (widget.colorList != null) {
        _control.colorList = widget.colorList;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.pause();
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    final ScreenUtil screenUtil = ScreenUtil();
    return WillPopScope(
      onWillPop: _popScope,
      child: Material(
        // color: widget.editorBackgroundColor == Colors.transparent
        //     ? Colors.black
        //     : widget.editorBackgroundColor ?? Colors.black,
        child: Consumer6<
            ControlNotifier,
            DraggableWidgetNotifier,
            ScrollNotifier,
            GradientNotifier,
            PaintingNotifier,
            TextEditingNotifier>(
          builder: (context, controlNotifier, itemProvider, scrollProvider,
              colorProvider, paintingProvider, editingProvider, child) {
            return SafeArea(
              //top: false,
              child: Container(
                        color:Colors.black,
                child: ScrollablePageView(
                  scrollPhysics: controlNotifier.mediaPath.isEmpty &&
                      itemProvider.draggableWidget.isEmpty &&
                      !controlNotifier.isPainting &&
                      !controlNotifier.isTextEditing,
                  pageController: scrollProvider.pageController,
                  gridController: scrollProvider.gridController,
                  mainView: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onScaleStart: _onScaleStart,
                              onScaleUpdate: _onScaleUpdate,
                              onTap: () {
                                controlNotifier.isTextEditing =
                                    !controlNotifier.isTextEditing;
                              },
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: SizedBox(
                                    width: screenUtil.screenWidth,
                                    child: RepaintBoundary(
                                      key: contentKey,
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        decoration: BoxDecoration(
                                            gradient: controlNotifier
                                                    .mediaPath.isEmpty
                                                ? LinearGradient(
                                                    colors: controlNotifier
                                                            .gradientColors![
                                                        controlNotifier
                                                            .gradientIndex],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  )
                                                : LinearGradient(
                                                    colors: [
                                                      colorProvider.color1,
                                                      colorProvider.color2
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  )),
                                        child: GestureDetector(
                                          onScaleStart: _onScaleStart,
                                          onScaleUpdate: _onScaleUpdate,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              /// in this case photo view works as a main background container to manage
                                              /// the gestures of all movable items.
                                              controlNotifier.mediaPath
                                                          .endsWith('.mp4') &&
                                                      _controller != null &&
                                                      _controller!
                                                          .value.isInitialized
                                                  ? AspectRatio(
                                                      aspectRatio: _controller!
                                                          .value.aspectRatio,
                                                      child: VideoPlayer(
                                                          _controller!),
                                                    )
                                                  : PhotoView.customChild(
                                                      child: Container(),
                                                      backgroundDecoration:
                                                          const BoxDecoration(
                                                              color: Colors
                                                                  .transparent),
                                                    ),
                    
                                              ///list items
                                              ...itemProvider.draggableWidget
                                                  .map((editableItem) {
                                                return DraggableWidget(
                                                  context: context,
                                                  draggableWidget: editableItem,
                                                  onPointerDown: (details) {
                                                    _updateItemPosition(
                                                      editableItem,
                                                      details,
                                                    );
                                                  },
                                                  onPointerUp: (details) {
                                                    _deleteItemOnCoordinates(
                                                      editableItem,
                                                      details,
                                                    );
                                                  },
                                                  onPointerMove: (details) {
                                                    _deletePosition(
                                                      editableItem,
                                                      details,
                                                    );
                                                  },
                                                );
                                              }),
                    
                                              /// finger paint
                                              IgnorePointer(
                                                ignoring: true,
                                                child: Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: RepaintBoundary(
                                                      child: SizedBox(
                                                        width: screenUtil
                                                            .screenWidth,
                                                        child: StreamBuilder<
                                                            List<PaintingModel>>(
                                                          stream: paintingProvider
                                                              .linesStreamController
                                                              .stream,
                                                          builder: (context,
                                                              snapshot) {
                                                            return CustomPaint(
                                                              painter: Sketcher(
                                                                lines:
                                                                    paintingProvider
                                                                        .lines,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    
                            /// middle text
                            if (itemProvider.draggableWidget.isEmpty &&
                                !controlNotifier.isTextEditing &&
                                paintingProvider.lines.isEmpty)
                              IgnorePointer(
                                ignoring: true,
                                child: Align(
                                  alignment: const Alignment(0, -0.1),
                                  child: Text('Tap to type',
                                      style: TextStyle(
                                          fontFamily: 'Alegreya',
                                          package: 'stories_editor',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 30,
                                          color: Colors.white.withOpacity(0.5),
                                          shadows: <Shadow>[
                                            Shadow(
                                                offset: const Offset(1.0, 1.0),
                                                blurRadius: 3.0,
                                                color: Colors.black45
                                                    .withOpacity(0.3))
                                          ])),
                                ),
                              ),
                    
                            /// top tools
                            Visibility(
                              visible: !controlNotifier.isTextEditing &&
                                  !controlNotifier.isPainting,
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: TopTools(
                                    contentKey: contentKey,
                                    context: context,
                                  )),
                            ),
                    
                            /// delete item when the item is in position
                            DeleteItem(
                              activeItem: _activeItem,
                              animationsDuration:
                                  const Duration(milliseconds: 300),
                              isDeletePosition: _isDeletePosition,
                            ),
                    
                            /// show text editor
                            Visibility(
                              visible: controlNotifier.isTextEditing,
                              child: TextEditor(
                                context: context,
                              ),
                            ),
                    
                            /// show painting sketch
                            Visibility(
                              visible: controlNotifier.isPainting,
                              child: const Painting(),
                            ),
                          ],
                        ),
                      ),
                    
                      /// bottom tools
                      if (!kIsWeb)
                        /* BottomTools(
                          contentKey: contentKey,
                          onDone: (bytes) {
                            print("this is the new data set-$bytes");
                            print(
                                "check the Data-${controlNotifier.isTextEditing}");
                            setState(() {
                              widget.onDone!(bytes);
                            });
                          },
                          onDoneButtonStyle: widget.onDoneButtonStyle,
                          editorBackgroundColor: widget.editorBackgroundColor,
                          context1: context,
                        ), */
                        Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 40.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// preview gallery
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      child: _preViewContainer(
                                        /// if [model.imagePath] is null/empty return preview image
                                        child: controlNotifier.mediaPath.isEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print("hey i am comming!!");
                                                    controlNotifier.isDataGet =
                                                        true;
                                                    if (controlNotifier
                                                        .mediaPath.isEmpty) {
                                                      scrollProvider
                                                          .pageController
                                                          .animateToPage(0,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              curve:
                                                                  Curves.easeIn);
                                                      scrollProvider
                                                          .pageController
                                                          .animateToPage(1,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              curve: Curves.ease);
                                                    }
                                                  },
                                                  child: const CoverThumbnail(
                                                    thumbnailQuality: 150,
                                                  ),
                                                ))
                    
                                            /// return clear [imagePath] provider
                                            : GestureDetector(
                                                onTap: () {
                                                  /// clear image url variable
                                                  controlNotifier.mediaPath = '';
                                                  itemProvider.draggableWidget
                                                      .removeAt(0);
                                                  _controller?.dispose();
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 45,
                                                  color: Colors.transparent,
                                                  child: Transform.scale(
                                                    scale: 0.7,
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                    
                                /// center logo
                                if (controlNotifier.middleBottomWidget != null)
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                          alignment: Alignment.bottomCenter,
                                          child:
                                              controlNotifier.middleBottomWidget),
                                    ),
                                  ),
                    
                                /// save final image to gallery
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Transform.scale(
                                      scale: 0.9,
                                      child: AnimatedOnTapButton(
                                          onTap: () async {
                                            if (controlNotifier
                                                    .mediaPath.isEmpty ==
                                                true) {
                                            } else {
                                              // isData = false;
                    
                                              String pngUri;
                                              print("check else condison");
                                              await takePicture(
                                                      isTextEditing:
                                                          controlNotifier
                                                              .isTextEditing,
                                                      SelectPath: controlNotifier
                                                          .mediaPath,
                                                      contentKey: contentKey,
                                                      context: context,
                                                      saveToGallery: false)
                                                  .then((bytes) {
                                                if (bytes != null) {
                                                  pngUri = bytes;
                                                  print(
                                                      "asdfasdasdasdasdasdad-$pngUri");
                                                  print(pngUri);
                    
                                                  print(pngUri);
                                                  widget.onDone!(pngUri);
                                                } else {}
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 12,
                                                right: 5,
                                                top: 4,
                                                bottom: 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: isData == false &&
                                                            controlNotifier
                                                                    .mediaPath
                                                                    .isEmpty ==
                                                                true
                                                        ? Colors.grey
                                                        : Colors.white,
                                                    width: 1.5)),
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Share',
                                                    style: TextStyle(
                                                        color: isData == false &&
                                                                controlNotifier
                                                                        .mediaPath
                                                                        .isEmpty ==
                                                                    true
                                                            ? Colors.grey
                                                            : Colors.white,
                                                        letterSpacing: 1.5,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.only(left: 5),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ]),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                  gallery: GalleryMediaPicker(
                    gridViewController: scrollProvider.gridController,
                    thumbnailQuality: widget.galleryThumbnailQuality,
                    singlePick: true,
                    appBarColor: widget.editorBackgroundColor ?? Colors.black,
                    // gridViewPhysics: itemProvider.draggableWidget.isEmpty
                    //     ? const NeverScrollableScrollPhysics()
                    //     : const ScrollPhysics(),
                    
                    pathList: (path) {
                      setState(() {
                        data = path;
                    
                        if (data == null || data.isEmpty) {
                          print("this condsion is working");
                    
                          itemProvider.draggableWidget = [];
                          controlNotifier.mediaPath = '';
                        }
                      });
                    
                      print("value Get Check222-${path}");
                      print("path-$data");
                      print("value GetCheck-${path}");
                      if (path.first.path
                              .toString()
                              .split('/')
                              .last
                              .toString()
                              .split('.')
                              .last ==
                          'mp4') {
                        print('this is the Get');
                        getVideo(path.first.path.toString(), 1, context,
                            controlNotifier, itemProvider);
                      } else {
                        if (path.first.path.toString().isNotEmpty) {
                          getFileSize(path.first.path.toString(), 1, context,
                              controlNotifier, itemProvider);
                          Navigator.of(context);
                        }
                      }
                    },
                    appBarLeadingWidget: Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 15),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: AnimatedOnTapButton(
                          onTap: () async {
                            print("dataaaa-${data}");
                            print(
                                "check  controller  pathh -${controlNotifier.mediaPath}");
                            if (controlNotifier.mediaPath.endsWith('.mp4')) {
                              if ((duration?.inSeconds ?? 0) <= 30) {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                print(
                                    "check video duration -${duration?.inSeconds}");
                                prefs.setInt(
                                    "videoduration", duration?.inSeconds ?? 0);
                                scrollProvider.pageController.animateToPage(0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                                setState(() {
                                  _controller?.play();
                                  _controller?.setLooping(true);
                                });
                              } else {
                                _controller = null;
                                duration = null;
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                File file = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoEditor(
                                              file:
                                                  File(controlNotifier.mediaPath),
                                            )));
                                if (file.path.isNotEmpty) {
                                  controlNotifier.mediaPath = file.path;
                    
                                  _controller =
                                      VideoPlayerController.file(File(file.path));
                    
                                  setState(() {});
                                  _controller
                                      ?.initialize()
                                      .then((value) => setState(() {
                                            duration =
                                                _controller!.value.duration;
                                            controlNotifier.durationofvideo =
                                                duration!;
                                            prefs.setInt("videoduration",
                                                duration?.inSeconds ?? 0);
                                            print(
                                                "check durationDataSet -${duration}");
                                          }));
                    
                                  setState(() {
                                    _controller?.play();
                                    _controller?.setLooping(true);
                                  });
                                  scrollProvider.pageController.animateToPage(0,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                }
                              }
                            } else {
                              scrollProvider.pageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.2,
                                )),
                            child: Text(
                              data == null || data.isEmpty ? 'Cancel' : 'Select',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _preViewContainer({child}) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.4, color: Colors.white)),
      child: child,
    );
  }

  String _formatDuration(Duration duration) {
    return duration.toString().split('.').first;
  }

  getVideo(
      // this is the me ankur is working
      String filepath,
      int decimals,
      context,
      ControlNotifier controlNotifier,
      DraggableWidgetNotifier itemProvider) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    value2 = double.parse(STR);
    print("viedo check-${widget.finalvideoSize}");
    print(value2);

    switch (i) {
      case 0:
        print("Done file size B");
        controlNotifier.mediaPath = filepath;
        itemProvider.draggableWidget.insert(
            0,
            EditableItem()
              ..type = ItemType.video
              ..position = const Offset(0.0, 0));
        _controller =
            VideoPlayerController.file(File(controlNotifier.mediaPath));

        _controller?.initialize().then((value) => setState(() {
              duration = _controller!.value.duration;
              print("check duration-${duration}");

              print(
                  "check data-${totalhoures}-${totalminuert}-${totalSeconds}");
            }));
        /*  if (duration!.inSeconds <= 30) {
          _controller =
              VideoPlayerController.file(File(controlNotifier.mediaPath));

          setState(() {
            _controller?.play();
            _controller?.setLooping(true);
          });
        } */

        break;
      case 1:
        print("Done file size KB");

        controlNotifier.mediaPath = filepath;
        itemProvider.draggableWidget.insert(
            0,
            EditableItem()
              ..type = ItemType.video
              ..position = const Offset(0.0, 0));
        _controller =
            VideoPlayerController.file(File(controlNotifier.mediaPath));

        _controller?.initialize().then((value) => setState(() {
              duration = _controller!.value.duration;
              // print("check duration -${duration}");

              print(
                  "check data-${totalhoures}-${totalminuert}-${totalSeconds}");
            }));

        break;
      case 2:
        if (value2 > widget.finalvideoSize!) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${widget.finalvideoSize!}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${widget.finalvideoSize!}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${widget.finalvideoSize!}MB allowed."),
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
          print("Done file Size 10 MB");
          controlNotifier.mediaPath = filepath;
          itemProvider.draggableWidget.insert(
              0,
              EditableItem()
                ..type = ItemType.video
                ..position = const Offset(0.0, 0));
          _controller =
              VideoPlayerController.file(File(controlNotifier.mediaPath));

          _controller?.initialize().then((value) => setState(() {
                duration = _controller!.value.duration;
                print("check duration-${duration}");
              }));

          /*  if (duration!.inSeconds <= 30) {
            _controller =
                VideoPlayerController.file(File(controlNotifier.mediaPath));

            setState(() {
              _controller?.play();
              _controller?.setLooping(true);
            });
          } */
        }

        break;
      default:
    }
  }

  getFileSize(
      String filepath,
      int decimals,
      context,
      ControlNotifier controlNotifier,
      DraggableWidgetNotifier itemProvider) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    value2 = double.parse(STR);

    print(value2);
    switch (i) {
      case 0:
        print("Done file size B");
        controlNotifier.mediaPath = filepath;

        itemProvider.draggableWidget.insert(
            0,
            EditableItem()
              ..type = ItemType.image
              ..position = const Offset(0.0, 0));

        print("value _controller-$_controller");
        setState(() {});

        break;
      case 1:
        print("Done file size KB");

        controlNotifier.mediaPath = filepath;
        itemProvider.draggableWidget.insert(
            0,
            EditableItem()
              ..type = ItemType.image
              ..position = const Offset(0.0, 0));

        print("value _controller-$_controller");

        setState(() {});

        break;
      case 2:
        if (value2 > widget.finalFileSize!) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${widget.finalFileSize!}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${widget.finalFileSize!}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${widget.finalFileSize!}MB allowed."),
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
          print("Done file Size 10 MB");
          controlNotifier.mediaPath = filepath;
          itemProvider.draggableWidget.insert(
              0,
              EditableItem()
                ..type = ItemType.image
                ..position = const Offset(0.0, 0));

          print("value _controller-$_controller");

          setState(() {});
        }

        break;
      default:
    }

    return STR;
  }

  /// validate pop scope gesture
  Future<bool> _popScope() async {
    final controlNotifier =
        Provider.of<ControlNotifier>(context, listen: false);

    /// change to false text editing
    if (controlNotifier.isTextEditing) {
      controlNotifier.isTextEditing = !controlNotifier.isTextEditing;
      return false;
    }

    /// change to false painting
    else if (controlNotifier.isPainting) {
      controlNotifier.isPainting = !controlNotifier.isPainting;
      return false;
    }

    /// show close dialog
    else if (!controlNotifier.isTextEditing && !controlNotifier.isPainting) {
      return widget.onBackPress ??
          exitDialog(context: context, contentKey: contentKey);
    }
    return false;
  }

  /// start item scale
  void _onScaleStart(ScaleStartDetails details) {
    if (_activeItem == null) {
      return;
    }
    _initPos = details.focalPoint;
    _currentPos = _activeItem!.position;
    _currentScale = _activeItem!.scale;
    _currentRotation = _activeItem!.rotation;
  }

  /// update item scale
  void _onScaleUpdate(ScaleUpdateDetails details) {
    final ScreenUtil screenUtil = ScreenUtil();
    if (_activeItem == null) {
      return;
    }
    final delta = details.focalPoint - _initPos;

    final left = (delta.dx / screenUtil.screenWidth) + _currentPos.dx;
    final top = (delta.dy / screenUtil.screenHeight) + _currentPos.dy;

    setState(() {
      _activeItem!.position = Offset(left, top);
      _activeItem!.rotation = details.rotation + _currentRotation;
      _activeItem!.scale = details.scale * _currentScale;
    });
  }

  /// active delete widget with offset position
  void _deletePosition(EditableItem item, PointerMoveEvent details) {
    if (item.type == ItemType.text &&
        item.position.dy >= 0.75.h &&
        item.position.dx >= -0.4.w &&
        item.position.dx <= 0.2.w) {
      setState(() {
        _isDeletePosition = true;
        item.deletePosition = true;
      });
    } else if (item.type == ItemType.gif &&
        item.position.dy >= 0.62.h &&
        item.position.dx >= -0.35.w &&
        item.position.dx <= 0.15) {
      setState(() {
        _isDeletePosition = true;
        item.deletePosition = true;
      });
    } else {
      setState(() {
        _isDeletePosition = false;
        item.deletePosition = false;
      });
    }
  }

  /// delete item widget with offset position
  void _deleteItemOnCoordinates(EditableItem item, PointerUpEvent details) {
    var _itemProvider =
        Provider.of<DraggableWidgetNotifier>(context, listen: false)
            .draggableWidget;
    _inAction = false;
    if (item.type == ItemType.image) {
    } else if (item.type == ItemType.text &&
            item.position.dy >= 0.75.h &&
            item.position.dx >= -0.4.w &&
            item.position.dx <= 0.2.w ||
        item.type == ItemType.gif &&
            item.position.dy >= 0.62.h &&
            item.position.dx >= -0.35.w &&
            item.position.dx <= 0.15) {
      setState(() {
        _itemProvider.removeAt(_itemProvider.indexOf(item));
        HapticFeedback.heavyImpact();
      });
    } else {
      setState(() {
        _activeItem = null;
      });
    }
    setState(() {
      _activeItem = null;
    });
  }

  /// update item position, scale, rotation
  void _updateItemPosition(EditableItem item, PointerDownEvent details) {
    if (_inAction) {
      return;
    }

    _inAction = true;
    _activeItem = item;
    _initPos = details.position;
    _currentPos = item.position;
    _currentScale = item.scale;
    _currentRotation = item.rotation;

    /// set vibrate
    HapticFeedback.lightImpact();
  }
}
