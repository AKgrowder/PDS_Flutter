// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_editor/src/gallery_media_picker/gallery_media_picker.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/scroll_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/domain/sevices/save_as_image.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';

bool isDataGet = true;
bool isData = false;

class BottomTools extends StatelessWidget {
  final GlobalKey contentKey;
  final Function(String imageUri) onDone;
  final BuildContext context1;
  final Widget? onDoneButtonStyle;

  /// editor background color
  final Color? editorBackgroundColor;
  BottomTools(
      {Key? key,
      required this.contentKey,
      required this.onDone,
      this.onDoneButtonStyle,
      required this.context1,
      this.editorBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<ControlNotifier, ScrollNotifier, DraggableWidgetNotifier>(
      builder: (_, controlNotifier, scrollNotifier, itemNotifier, __) {
        final editorNotifier =
            Provider.of<TextEditingNotifier>(context1, listen: false);
        // editorNotifier..textController.text = editorNotifier.text;
        print(
            "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        print(editorNotifier.text);
        if (editorNotifier.text != "" ||
            editorNotifier.text.isEmpty != true ||
            controlNotifier.mediaPath.isEmpty != true) {
          isData = true;
        } /* else{
          isData = false;
        } */
        return Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
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
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap: () {
                                    controlNotifier.isDataGet = true;
                                    if (controlNotifier.mediaPath.isEmpty) {
                                      scrollNotifier.pageController
                                          .animateToPage(1,
                                              duration: const Duration(
                                                  milliseconds: 300),
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
                                  itemNotifier.draggableWidget.removeAt(0);
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
                          child: controlNotifier.middleBottomWidget),
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
                            print(
                                "editprofile Screen check-${editorNotifier.text}");
                            print(
                                "editorNotifier.text-${editorNotifier.text.isEmpty}");
                            print(
                                "controlNotifier.mediaPath-${controlNotifier.mediaPath}");
                            if (isData == false &&
                                controlNotifier.mediaPath.isEmpty == true) {
                              print("Now this condiosn is working");
                            } else {
                              isData = false;
                              print("else consion is working");
                              print(
                                  "else condiosn is -${controlNotifier.mediaPath}");
                              String pngUri;

                              await takePicture(
                                      isTextEditing:
                                          controlNotifier.isTextEditing,
                                      SelectPath: controlNotifier.mediaPath,
                                      contentKey: contentKey,
                                      context: context,
                                      saveToGallery: false)
                                  .then((bytes) {
                                if (bytes != null) {
                                  pngUri = bytes;
                                  print("asdfasdasdasdasdasdad-$pngUri");
                                  print(pngUri);

                                  print(pngUri);

                                  onDone(pngUri);
                                } else {}
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 12, right: 5, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: isData == false &&
                                            controlNotifier.mediaPath.isEmpty ==
                                                true
                                        ? Colors.grey
                                        : Colors.white,
                                    width: 1.5)),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                'Share',
                                style: TextStyle(
                                    color: isData == false &&
                                            controlNotifier.mediaPath.isEmpty ==
                                                true
                                        ? Colors.grey
                                        : Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
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
        );
      },
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
}
