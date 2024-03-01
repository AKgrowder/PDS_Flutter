import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pds/StoryFile/controller/story_controller.dart';
import 'package:pds/StoryFile/src/story_button.dart';
import 'package:pds/StoryFile/widgets/story_view.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewStoryViewPage extends StatefulWidget {
  final StoryButtonData data;
  final List<StoryButtonData> datas;
  final int index;
  const NewStoryViewPage(this.data,this.datas,this.index,{key});

  @override
  State<NewStoryViewPage> createState() => _NewStoryViewPageState();
}

class _NewStoryViewPageState extends State<NewStoryViewPage> {
  final StoryController controller = StoryController();
  String? User_ID;

  dataFunctionSetup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    if (mounted) {
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: StoryView(
          controller: controller,
          storyItems: List.generate(widget.data.images.length, (index) {
            return widget.data.images[index].image!.endsWith(".mp4") ? StoryItem.pageVideo(widget.data.images[index].image!,controller: controller,duration:Duration(seconds: widget.data.images[index].duration!),caption:
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    // onTap: widget.onTap,
                                    child: widget.data.images[index].profileImage != null &&
                                        widget.data.images[index].profileImage != ""
                                        ? CustomImageView(
                                      url:
                                      "${widget.data.images[index].profileImage}",
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.fill,
                                      radius: BorderRadius.circular(25),
                                    )
                                        : CustomImageView(
                                      imagePath: ImageConstant.tomcruse,
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.fill,
                                      radius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  GestureDetector(
                                    // onTap: widget.onTap,
                                    child: Text(
                                      '${widget.data.images[index].username}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'outfit',
                                        fontWeight: FontWeight.w400,
                                        height: 0.08,
                                        letterSpacing: -0.17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Opacity(
                                    opacity: 0.50,
                                    child: Text(
                                      '${formatDateTime(DateTime.parse(widget.data.images[index].date!))}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0.08,
                                        letterSpacing: -0.17,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )
            ):StoryItem.pageImage(url:widget.data.images[index].image!,controller: controller);
          }),
          onStoryShow: (storyItem, index) {
            print("Showing a story");
          },
          onComplete: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return NewStoryViewPage(widget.datas[widget.index +1 ],widget.datas,widget.index+1);
                }));
          },
          progressPosition: ProgressPosition.top,
          repeat: false,
        ))
      ],
    );
  }

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));
    final formatter = DateFormat('h:mm a');

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // Today
      return 'Today, ${formatter.format(dateTime)}';
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      // Yesterday
      return 'Yesterday, ${formatter.format(dateTime)}';
    } else {
      // A different day, you can format it as you wish
      return '${DateFormat('MMMM d').format(dateTime)}, ${formatter.format(dateTime)}';
    }
  }
}
