import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_cubit.dart';
import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_state.dart';
import 'package:pds/API/Model/ViewStoryModel/StoryViewList_Model.dart';
import 'package:pds/API/Model/storyDeleteModel/storyDeleteModel.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/StoryFile/src/first_build_mixin.dart';
import 'package:pds/StoryFile/src/story_button.dart';
import 'package:pds/StoryFile/src/story_page_scaffold.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../../core/utils/image_constant.dart';
import '../../widgets/custom_image_view.dart';

bool isBottomSheetOpen = false;

class StoryPageContainerView extends StatefulWidget {
  final StoryButtonData buttonData;
  final VoidCallback onStoryComplete;
  final PageController? pageController;
  final VoidCallback? onClosePressed;
  final Function()? onTap;
  const StoryPageContainerView(
      {Key? key,
      required this.buttonData,
      required this.onStoryComplete,
      this.pageController,
      this.onClosePressed,
      this.onTap})
      : super(key: key);

  @override
  State<StoryPageContainerView> createState() => _StoryPageContainerViewState();
}

class _StoryPageContainerViewState extends State<StoryPageContainerView>
    with FirstBuildMixin {
  StoryTimelineController? _storyController;
  final Stopwatch _stopwatch = Stopwatch();
  Offset _pointerDownPosition = Offset.zero;
  int _pointerDownMillis = 0;
  VideoPlayerController? _controller;
  double _pageValue = 0.0;
  List<bool> imageLoads = [];
  bool? StoryView = false;
  int DummyStoryView = -1;
  bool? DummyStoryViewBool = false;
  String? User_ID;
  StoryViewListModel? StoryViewListModelData;
  late PointerUpEvent event1;
  DeleteStory? deleteStory;
  bool ifVideoPlayer = false;
  String lastLoggedTime = "";
  Duration? durationOfVideo;
  int countcheck = 0;
  TextEditingController reactionData = TextEditingController();

  dataFunctionSetup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    super.setState(() {});
  }

  FocusNode? _focusNode;
  bool isDataGet = false;
  bool isStoryViewData = false;

  @override
  void initState() {
    // blockFunction();
    _focusNode = FocusNode();
    dataFunctionSetup();
    _storyController =
        widget.buttonData.storyController ?? StoryTimelineController();
    _stopwatch.start();
    // GetUserID();
    _storyController!.addListener(_onTimelineEvent);

    imageLoads =
        List.generate(widget.buttonData.images.length, (index) => false);

    dataSetUpAPi();
    super.initState();
  }

  blockFunction() async {
    print("this is the DataGet-${_curSegmentIndex}");
    await BlocProvider.of<ViewStoryCubit>(context).StoryViewList(
        context, "${widget.buttonData.images[_curSegmentIndex].storyUid}");
  }

  dataSetUpAPi() async {
    if (widget.buttonData.images[_curSegmentIndex].image!.endsWith('.mp4')) {
      _controller = VideoPlayerController.networkUrl(
          (Uri.parse('${widget.buttonData.images[_curSegmentIndex].image}')))
        ..initialize().then((_) {
          super.setState(() {
            ifVideoPlayer = true;
            durationOfVideo = _controller!.value.duration;
            _controller?.play();
          });
        });
    }
  }

  @override
  void didFirstBuildFinish(BuildContext context) {
    widget.pageController?.addListener(_onPageControllerUpdate);
  }

  void _onPageControllerUpdate() {
    if (widget.pageController?.hasClients != true) {
      return;
    }
    _pageValue = widget.pageController?.page ?? 0.0;
    _storyController!._setTimelineAvailable(_timelineAvailable);
  }

  bool get _timelineAvailable {
    return _pageValue % 1.0 == 0.0;
  }

  void _onTimelineEvent(StoryTimelineEvent event) {
    if (event == StoryTimelineEvent.storyComplete) {
      widget.onStoryComplete.call();
    } else if (event == StoryTimelineEvent.segmentComplete) {
      if (widget.buttonData.images[_curSegmentIndex].image!.endsWith('.mp4')) {
        _controller = VideoPlayerController.networkUrl(
            (Uri.parse('${widget.buttonData.images[_curSegmentIndex].image}')))
          ..initialize().then((_) {
            super.setState(() {
              ifVideoPlayer = true;
              durationOfVideo = _controller!.value.duration;
              _controller?.play();
            });
          });
      } else {
        super.setState(() {
          ifVideoPlayer = false;
          _controller?.dispose();
        });
      }
    }
    super.setState(() {});
  }

  Widget _buildCloseButton() {
    Widget closeButton;
    if (widget.buttonData.closeButton != null) {
      closeButton = widget.buttonData.closeButton!;
    } else {
      closeButton = SizedBox(
        height: 40.0,
        width: 40.0,
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (widget.onClosePressed != null) {
              widget.onClosePressed!.call();
            } else {
              _controller?.dispose();
              Navigator.of(context).pop();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              40.0,
            ),
          ),
          child: SizedBox(
            height: 40.0,
            width: 40.0,
            child: Icon(
              Icons.close,
              size: 28.0,
              color: widget.buttonData.defaultCloseButtonColor,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: widget.buttonData.images[0].profileImage != null &&
                              widget.buttonData.images[0].profileImage != ""
                          ? CustomImageView(
                              url:
                                  "${widget.buttonData.images[0].profileImage}",
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
                      onTap: widget.onTap,
                      child: Text(
                        '${widget.buttonData.images[0].username}',
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
                        '${formatDateTime(DateTime.parse(widget.buttonData.images[_curSegmentIndex].date!))}',
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
              closeButton,
            ],
          ),
        ],
      ),
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

  Widget _buildTimeline() {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.buttonData.timlinePadding?.top ?? 15.0,
        left: widget.buttonData.timlinePadding?.left ?? 15.0,
        right: widget.buttonData.timlinePadding?.left ?? 15.0,
        bottom: widget.buttonData.timlinePadding?.bottom ?? 5.0,
      ),
      child: _storyController != null
          ? StoryTimeline(
              controller: _storyController!,
              buttonData: widget.buttonData,
              durationOfVideo:
                  widget.buttonData.images[_curSegmentIndex].duration != null
                      ? Duration(
                          seconds: widget
                              .buttonData.images[_curSegmentIndex].duration!)
                      : durationOfVideo,
            )
          : SizedBox(),
    );
  }

  int get _curSegmentIndex {
    return widget.buttonData.currentSegmentIndex;
  }

  Widget _buildPageContent() {
    dataFunctionSetup();
    bool imageLoaded = false;
    _storyController!.pause();
    NetworkImage networkImage =
        NetworkImage(widget.buttonData.images[_curSegmentIndex].image ?? "");
    //  BlocProvider.of<ViewStoryCubit>(context).StoryViewList(
    //       context, "${widget.buttonData.images[_curSegmentIndex].storyUid}");
    networkImage.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, call) {
        if (mounted) {
          if (DummyStoryView == _curSegmentIndex) {
            DummyStoryViewBool = false;
          } else {
            DummyStoryView = _curSegmentIndex;
            DummyStoryViewBool = true;
          }

          // Image has been loaded
          imageLoaded = true;

          _storyController!.unpause();

          if (DummyStoryViewBool == true) {
            StoryView = true;
            BlocProvider.of<ViewStoryCubit>(context).StoryViewList(context,
                "${widget.buttonData.images[_curSegmentIndex].storyUid}");
            super.setState(() {});
          }
        }
      }),
    );
    if (widget.buttonData.storyPages.isEmpty) {
      return Container(
        color: Colors.orange,
        child: const Center(
          child: Text('No pages'),
        ),
      );
    }
    if (imageLoaded == true) {
      if (StoryView == true) {
        StoryView = false;

        // if (User_ID != widget.buttonData.images[_curSegmentIndex].userUid) {
        print(
            "check ImageData-${widget.buttonData.images[_curSegmentIndex].storyUid}");
        BlocProvider.of<ViewStoryCubit>(context).ViewStory(
            context,
            "${User_ID}",
            "${widget.buttonData.images[_curSegmentIndex].storyUid}");
        // } else {
        //      BlocProvider.of<ViewStoryCubit>(context).ViewStory(
        //       context,
        //       "${User_ID}",
        //       "${widget.buttonData.images[_curSegmentIndex].storyUid}");
        // }
      }
    }
    return imageLoaded == false
        ? Center(
            child: CircularProgressIndicator(
              color: ColorConstant.primary_color,
              strokeWidth: 2,
            ),
          )
        : StoryPageScaffold(
            body: widget.buttonData.images[_curSegmentIndex].image!
                    .contains("car")
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: widget.buttonData.images[_curSegmentIndex].image!
                              .contains("car")
                          ? DecorationImage(
                              image: AssetImage(ImageConstant.pdslogo),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: networkImage,
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : ZoomableImage(
                    imageUrl: widget.buttonData.images[_curSegmentIndex].image!,
                  ));
  }

  Widget _buildPageContent1() {
    dataFunctionSetup();

    bool imageLoaded = false;
    // BlocProvider.of<ViewStoryCubit>(context).StoryViewList(
    //     context, "${widget.buttonData.images[_curSegmentIndex].storyUid}");
    _controller?.addListener(() {
      if (mounted) {
        if (DummyStoryView == _curSegmentIndex) {
          DummyStoryViewBool = false;
        } else {
          DummyStoryView = _curSegmentIndex;
          DummyStoryViewBool = true;
        }

        // Image has been loaded
        imageLoaded = true;
        _storyController!.unpause();

        if (DummyStoryViewBool == true) {
          StoryView = true;
          BlocProvider.of<ViewStoryCubit>(context).StoryViewList(context,
              "${widget.buttonData.images[_curSegmentIndex].storyUid}");
          super.setState(() {});
        }
      }
    });

    _storyController!.pause();

    if (widget.buttonData.storyPages.isEmpty) {
      return Container(
        color: Colors.orange,
        child: const Center(
          child: Text('No pages'),
        ),
      );
    }
    if (imageLoaded == true) {
      if (StoryView == true) {
        StoryView = false;
        print(
            "check ImageData1-${widget.buttonData.images[_curSegmentIndex].storyUid}");

        // if (User_ID != widget.buttonData.images[_curSegmentIndex].userUid) {
        BlocProvider.of<ViewStoryCubit>(context).ViewStory(
            context,
            "${User_ID}",
            "${widget.buttonData.images[_curSegmentIndex].storyUid}");
        // }else{
        //    BlocProvider.of<ViewStoryCubit>(context).ViewStory(
        //       context,
        //       "${User_ID}",
        //       "${widget.buttonData.images[_curSegmentIndex].storyUid}");
        // }
      }
    }
    _storyController!.unpause();
    return StoryPageScaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: _controller?.value.isInitialized != null
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : Container()),
    );
  }

  bool _isLeftPartOfStory(Offset position) {
    if (!mounted) {
      return false;
    }
    final storyWidth = context.size!.width;
    return position.dx <= (storyWidth * .499);
  }

  Widget _buildPageStructure() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Listener(
      onPointerDown: (PointerDownEvent event) async {
        _pointerDownMillis = _stopwatch.elapsedMilliseconds;
        _pointerDownPosition = event.position;
        _storyController?.pause();
      },
      onPointerUp: (PointerUpEvent event) {
        event1 = event;
        final pointerUpMillis = _stopwatch.elapsedMilliseconds;
        final maxPressMillis = kPressTimeout.inMilliseconds * 2;
        final diffMillis = pointerUpMillis - _pointerDownMillis;
        if (diffMillis <= maxPressMillis) {
          final position = event.position;
          final distance = (position - _pointerDownPosition).distance;
          if (distance < 5.0) {
            final isLeft = _isLeftPartOfStory(position);
            if (isLeft) {
              _storyController!.previousSegment();
            } else {
              _storyController!.nextSegment();
            }
          }
        }

        _storyController!.unpause();
      },
      child: GestureDetector(
        onVerticalDragStart: (details) {
          if (User_ID != widget.buttonData.images[_curSegmentIndex].userUid) {
            final pointerUpMillis = _stopwatch.elapsedMilliseconds;
            final maxPressMillis = kPressTimeout.inMilliseconds * 2;
            final diffMillis = pointerUpMillis - _pointerDownMillis;
            if (diffMillis <= maxPressMillis) {
              final position = event1.position;
              final distance = (position - _pointerDownPosition).distance;
              if (distance < 5.0) {
                final isLeft = _isLeftPartOfStory(position);
                if (isLeft) {
                  _storyController!.previousSegment();
                } else {
                  _storyController!.nextSegment();
                }
              }
            }
            FocusScope.of(context).requestFocus(_focusNode);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              super.setState(() {
                isDataGet = true;
                isBottomSheetOpen = true;
              });
            });
          }
        },
        onHorizontalDragCancel: () {
          _pointerDownMillis = _stopwatch.elapsedMilliseconds;
          _pointerDownPosition = event1.position;
          _storyController?.pause();
          _focusNode?.unfocus();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            super.setState(() {
              isDataGet = false;
              isBottomSheetOpen = false;
            });
          });
        },
        /* onVerticalDragEnd: (details) {
           final pointerUpMillis = _stopwatch.elapsedMilliseconds;
        final maxPressMillis = kPressTimeout.inMilliseconds * 2;
        final diffMillis = pointerUpMillis - _pointerDownMillis;
        if (diffMillis <= maxPressMillis) {
          final position = event1.position;
          final distance = (position - _pointerDownPosition).distance;
          if (distance < 5.0) {
            final isLeft = _isLeftPartOfStory(position);
            if (isLeft) {
              _storyController!.previousSegment();
            } else {
              _storyController!.nextSegment();
            }
          }
        }

        _storyController!.unpause();
        FocusScope.of(context).unfocus();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              super.setState(() {
                isDataGet = false;
                
              });
            }); 
      } */
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              ifVideoPlayer == true
                  ? _buildPageContent1()
                  : _buildPageContent(),
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTimeline(),
                    _buildCloseButton(),
                    // print(widget.buttonData.images[_curSegmentIndex].storyUid);
                    Spacer(),
                    widget.buttonData.images[_curSegmentIndex].userUid ==
                            User_ID
                        ? GestureDetector(
                            onTapDown: (details) {
                              _pointerDownMillis =
                                  _stopwatch.elapsedMilliseconds;
                              _pointerDownPosition = details.localPosition;
                              _storyController!.pause();
                              super.setState(() {
                                isBottomSheetOpen = true;
                              });
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  isDismissible: true,
                                  showDragHandle: false,
                                  enableDrag: true,
                                  constraints:
                                      BoxConstraints.tight(Size.infinite),
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          width: _width,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: _width / 2.3,
                                              ),
                                              // Spacer(),
                                              Container(
                                                height: 2,
                                                width: 50,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  await BlocProvider.of<
                                                              ViewStoryCubit>(
                                                          context)
                                                      .delete_story(context,
                                                          "${widget.buttonData.images[_curSegmentIndex].storyUid}");
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: ColorConstant
                                                      .primary_color,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              primary: true,
                                              itemCount: StoryViewListModelData
                                                      ?.object?.length ??
                                                  0,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  // height: 40,
                                                  width: _width,
                                                  // color: Colors.green,
                                                  child: ListTile(
                                                    leading: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return MultiBlocProvider(
                                                              providers: [
                                                                BlocProvider<
                                                                    NewProfileSCubit>(
                                                                  create: (context) =>
                                                                      NewProfileSCubit(),
                                                                ),
                                                              ],
                                                              child:
                                                                  ProfileScreen(
                                                                User_ID:
                                                                    "${StoryViewListModelData?.object?[index].userUid}",
                                                                isFollowing:
                                                                    "${StoryViewListModelData?.object?[index].isFollowing}",
                                                              ));
                                                        }));

                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder: (context) =>
                                                        //             ProfileScreen(
                                                        //               User_ID:
                                                        //                   "${StoryViewListModelData?.object?[index].userUid}",
                                                        //               isFollowing:
                                                        //                   "${StoryViewListModelData?.object?[index].isFollowing}",
                                                        //             )));
                                                      },
                                                      child: StoryViewListModelData
                                                                      ?.object?[
                                                                          index]
                                                                      .profilePic !=
                                                                  null &&
                                                              StoryViewListModelData
                                                                      ?.object?[
                                                                          index]
                                                                      .profilePic !=
                                                                  ""
                                                          ? CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${StoryViewListModelData?.object?[index].profilePic}"),
                                                              radius: 25,
                                                            )
                                                          : CustomImageView(
                                                              imagePath:
                                                                  (ImageConstant
                                                                      .tomcruse)),
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Container(
                                                          // color: Colors.amber,
                                                          child: Text(
                                                            "${StoryViewListModelData?.object?[index].userName}",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "outfit",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   customFormat(
                                                        //       parsedDateTime),
                                                        //   style: TextStyle(
                                                        //     fontSize: 12,
                                                        //     fontFamily: "outfit",
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                    trailing: User_ID ==
                                                            StoryViewListModelData
                                                                ?.object?[index]
                                                                .userUid
                                                        ? SizedBox()
                                                        : GestureDetector(
                                                            onTap: () {
                                                              // followFunction(
                                                              //   apiName: 'Follow',
                                                              //   index: index,
                                                              // );
                                                            },
                                                            child: Container(
                                                              height: 25,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 65,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          5),
                                                              decoration: BoxDecoration(
                                                                  color: ColorConstant
                                                                      .primary_color,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                              child: StoryViewListModelData
                                                                          ?.object?[
                                                                              index]
                                                                          .isFollowing ==
                                                                      'FOLLOW'
                                                                  ? Text(
                                                                      'Follow',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "outfit",
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : StoryViewListModelData
                                                                              ?.object?[index]
                                                                              .isFollowing ==
                                                                          'REQUESTED'
                                                                      ? Text(
                                                                          'Requested',
                                                                          style: TextStyle(
                                                                              fontFamily: "outfit",
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        )
                                                                      : Text(
                                                                          'Following ',
                                                                          style: TextStyle(
                                                                              fontFamily: "outfit",
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        ),
                                                            ),
                                                          ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    );
                                  }).then((value) {
                                final pointerUpMillis =
                                    _stopwatch.elapsedMilliseconds;
                                final maxPressMillis =
                                    kPressTimeout.inMilliseconds * 2;
                                final diffMillis =
                                    pointerUpMillis - _pointerDownMillis;
                                if (diffMillis <= maxPressMillis) {
                                  final position = event1.position;
                                  final distance =
                                      (position - _pointerDownPosition)
                                          .distance;
                                  if (distance < 5.0) {
                                    final isLeft = _isLeftPartOfStory(position);
                                    if (isLeft) {
                                      _storyController!.previousSegment();
                                    } else {
                                      _storyController!.nextSegment();
                                    }
                                  }
                                }
                                print("bottom sheet closed : unpause");
                                super.setState(() {
                                  isBottomSheetOpen = false;
                                });
                                _storyController!.unpause();
                              });
                            },
                            //this is the view counet
                            child: Container(
                              height: 50,
                              width: 150,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Spacer(),
                                  Image.asset(
                                    ImageConstant.StoryViewListeye,
                                    height: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${widget.buttonData.images[_curSegmentIndex].storyViewCount}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "outfit",
                                        fontSize: 14),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
              //this is the sortyViewSetup
              _storyController == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ColorConstant.primary_color,
                        strokeWidth: 2,
                      ),
                    )
                  : SizedBox(),
              if (User_ID != widget.buttonData.images[_curSegmentIndex].userUid)
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.height / 2.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: reactionData,
                              focusNode: _focusNode,
                              minLines: 1,
                              maxLines: null,
                              onChanged: (value) {
                              
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  hintText: 'Send Meesage',
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Repository().reactionMessageAddedOnStory(
                                  context,
                                  reactionData.text,
                                  widget.buttonData.images[_curSegmentIndex]
                                      .storyUid
                                      .toString());

                             
                            },
                            child: Text(
                              'Send',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )),
              if (isDataGet == true)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 200,
                      width: 300,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    handleEmojiSelection('❤️', context);
                                  },
                                  child: Text(
                                    '❤️',
                                    style: TextStyle(fontSize: 30),
                                  )
                                  /* Text('😊', style: TextStyle(fontSize: 30)), */
                                  ),
                              GestureDetector(
                                onTap: () {
                                  handleEmojiSelection('😂', context);
                                },
                                child:
                                    Text('😂', style: TextStyle(fontSize: 30)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  handleEmojiSelection('🔥', context);
                                },
                                child:
                                    Text('🔥', style: TextStyle(fontSize: 30)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  handleEmojiSelection('👏', context);
                                },
                                child:
                                    Text('👏', style: TextStyle(fontSize: 30)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  handleEmojiSelection('😮', context);
                                },
                                child:
                                    Text('😮', style: TextStyle(fontSize: 30)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  handleEmojiSelection('😥', context);
                                },
                                child:
                                    Text('😥', style: TextStyle(fontSize: 30)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.pageController?.removeListener(_onPageControllerUpdate);
    _stopwatch.stop();
    _storyController!.removeListener(_onTimelineEvent);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocConsumer<ViewStoryCubit, ViewStoryState>(
            listener: (context, state) async {
          if (state is ViewStoryErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is ViewStoryLoadingState) {
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                ),
              ),
            );
          }
          if (state is ViewStoryLoadedState) {}
          if (state is StoryViewListLoadedState) {
            StoryViewListModelData = state.StoryViewListModelData;
          }
          if (state is DeleteSotryLodedState) {
            deleteStory = state.deleteStory;

            SnackBar snackBar = SnackBar(
              content: Text(state.deleteStory.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => NewBottomBar(
                          buttomIndex: 0,
                        )),
                (Route<dynamic> route) => false);
          }
        }, builder: (context, state) {
          return _buildPageStructure();
        }),

        ///  Show Count API Data
      ),
    );
  }

  void handleEmojiSelection(String emoji, BuildContext context) {
    print('Selected Emoji: $emoji');
    Repository().reactionMessageAddedOnStory(context, emoji,
        widget.buttonData.images[_curSegmentIndex].storyUid.toString(),
        emojiReaction: true);
    // Navigator.of(context).pop(); // Close the dialog
  }

  GetUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
  }
}

enum StoryTimelineEvent {
  storyComplete,
  segmentComplete,
}

typedef StoryTimelineCallback = Function(StoryTimelineEvent);

class StoryTimelineController {
  _StoryTimelineState? _state;

  final HashSet<StoryTimelineCallback> _listeners =
      HashSet<StoryTimelineCallback>();

  void addListener(StoryTimelineCallback callback) {
    _listeners.add(callback);
  }

  void removeListener(StoryTimelineCallback callback) {
    _listeners.remove(callback);
  }

  void _onStoryComplete() {
    _notifyListeners(StoryTimelineEvent.storyComplete);
  }

  void _onSegmentComplete() {
    _notifyListeners(StoryTimelineEvent.segmentComplete);
  }

  void _notifyListeners(StoryTimelineEvent event) {
    for (var e in _listeners) {
      e.call(event);
    }
  }

  void nextSegment() {
    _state?.nextSegment();
  }

  void previousSegment() {
    _state?.previousSegment();
  }

  void pause() {
    _state?.pause();
  }

  void _setTimelineAvailable(bool value) {
    _state?._setTimelineAvailable(value);
  }

  void unpause() {
    if (!isBottomSheetOpen) {
      _state?.unpause();
    }
  }

  void dispose() {
    _listeners.clear();
  }
}

class StoryTimeline extends StatefulWidget {
  final StoryTimelineController controller;
  final StoryButtonData buttonData;
  Duration? durationOfVideo;
  StoryTimeline(
      {Key? key,
      required this.controller,
      required this.buttonData,
      this.durationOfVideo})
      : super(key: key);

  @override
  State<StoryTimeline> createState() => _StoryTimelineState();
}

class _StoryTimelineState extends State<StoryTimeline> {
  late Timer _timer;
  int _accumulatedTime = 0;
  int _maxAccumulator = 0;
  bool _isPaused = false;
  bool _isTimelineAvailable = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _maxAccumulator = widget.buttonData.images[_curSegmentIndex].duration !=
              null
          ? Duration(
                  seconds:
                      widget.buttonData.images[_curSegmentIndex].duration ?? 0)
              .inMilliseconds
          : widget.buttonData.segmentDuration.inMilliseconds;
      _timer = Timer.periodic(
        Duration(
          milliseconds: kStoryTimerTickMillis,
        ),
        _onTimer,
      );
      widget.controller._state = this;
      super.initState();
      if (widget.buttonData.storyWatchedContract ==
          StoryWatchedContract.onStoryStart) {
        widget.buttonData.markAsWatched();
      }
    });
  }

  void _setTimelineAvailable(bool value) {
    _isTimelineAvailable = value;
  }

  void _onTimer(timer) {
    if (_isPaused || !_isTimelineAvailable) {
      return;
    }
    if (_accumulatedTime + kStoryTimerTickMillis <= _maxAccumulator) {
      _accumulatedTime += kStoryTimerTickMillis;
      if (_accumulatedTime >= _maxAccumulator) {
        if (_isLastSegment) {
          _onStoryComplete();
        } else {
          _accumulatedTime = 0;
          _curSegmentIndex++;
          _onSegmentComplete();
        }
      }
      if (mounted) {
        super.setState(() {});
      }
    }
  }

  void _onStoryComplete() {
    if (widget.buttonData.storyWatchedContract ==
        StoryWatchedContract.onStoryEnd) {
      widget.buttonData.markAsWatched();
    }
    widget.controller._onStoryComplete();
  }

  void _onSegmentComplete() {
    if (widget.buttonData.storyWatchedContract ==
        StoryWatchedContract.onSegmentEnd) {
      widget.buttonData.markAsWatched();
    }
    widget.controller._onSegmentComplete();
  }

  bool get _isLastSegment {
    return _curSegmentIndex == _numSegments - 1;
  }

  int get _numSegments {
    return widget.buttonData.storyPages.length;
  }

  set _curSegmentIndex(int value) {
    if (value >= _numSegments) {
      value = _numSegments - 1;
    } else if (value < 0) {
      value = 0;
    }
    widget.buttonData.currentSegmentIndex = value;
  }

  int get _curSegmentIndex {
    return widget.buttonData.currentSegmentIndex;
  }

  void nextSegment() {
    if (_isLastSegment) {
      _accumulatedTime = _maxAccumulator;
      widget.controller._onStoryComplete();
    } else {
      _accumulatedTime = 0;
      _curSegmentIndex++;
      _onSegmentComplete();
    }
  }

  void previousSegment() {
    if (_accumulatedTime == _maxAccumulator) {
      _accumulatedTime = 0;
    } else {
      _accumulatedTime = 0;
      _curSegmentIndex--;
      _onSegmentComplete();
    }
  }

  void pause() {
    _isPaused = true;
  }

  void unpause() {
    _isPaused = false;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2.0,
      width: double.infinity,
      child: CustomPaint(
        painter: _TimelinePainter(
          fillColor: widget.buttonData.timelineFillColor,
          backgroundColor: widget.buttonData.timelineBackgroundColor,
          curSegmentIndex: _curSegmentIndex,
          numSegments: _numSegments,
          percent: _accumulatedTime / _maxAccumulator,
          spacing: widget.buttonData.timelineSpacing,
          thikness: widget.buttonData.timelineThikness,
        ),
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  final Color fillColor;
  final Color backgroundColor;
  final int curSegmentIndex;
  final int numSegments;
  final double percent;
  final double spacing;
  final double thikness;

  _TimelinePainter({
    required this.fillColor,
    required this.backgroundColor,
    required this.curSegmentIndex,
    required this.numSegments,
    required this.percent,
    required this.spacing,
    required this.thikness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thikness
      ..color = backgroundColor
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thikness
      ..color = fillColor
      ..style = PaintingStyle.stroke;

    final maxSpacing = (numSegments - 1) * spacing;
    final maxSegmentLength = (size.width - maxSpacing) / numSegments;

    for (var i = 0; i < numSegments; i++) {
      final start = Offset(
        ((maxSegmentLength + spacing) * i),
        0.0,
      );
      final end = Offset(
        start.dx + maxSegmentLength,
        0.0,
      );

      canvas.drawLine(
        start,
        end,
        bgPaint,
      );
    }

    for (var i = 0; i < numSegments; i++) {
      final start = Offset(
        ((maxSegmentLength + spacing) * i),
        0.0,
      );
      var endValue = start.dx;
      if (curSegmentIndex > i) {
        endValue = start.dx + maxSegmentLength;
      } else if (curSegmentIndex == i) {
        endValue = start.dx + (maxSegmentLength * percent);
      }
      final end = Offset(
        endValue,
        0.0,
      );
      if (endValue == start.dx) {
        continue;
      }
      canvas.drawLine(
        start,
        end,
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ZoomableImage extends StatefulWidget {
  final String imageUrl;
  ZoomableImage({required this.imageUrl});

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  MemoryImage? _memoryImage;
  Uint8List? bytes;
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Future<void> loadImage() async {
    final http.Response response = await http.get(Uri.parse(widget.imageUrl));
    bytes = response.bodyBytes;

    final memoryImage = MemoryImage(Uint8List.fromList(bytes!));

    super.setState(() {
      _memoryImage = memoryImage;
    });
  }

  Widget build(BuildContext context) {
    return _memoryImage != null
        ? PhotoView(
            imageProvider: MemoryImage(bytes!),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration: BoxDecoration(
              color: Colors.black,
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
