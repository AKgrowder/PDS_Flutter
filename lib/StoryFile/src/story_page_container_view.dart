import 'dart:async';
import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_cubit.dart';
import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_state.dart';
import 'package:pds/API/Model/ViewStoryModel/StoryViewList_Model.dart';
import 'package:pds/StoryFile/src/first_build_mixin.dart';
import 'package:pds/StoryFile/src/story_button.dart';
import 'package:pds/StoryFile/src/story_page_scaffold.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../widgets/custom_image_view.dart';

class StoryPageContainerView extends StatefulWidget {
  final StoryButtonData buttonData;
  final VoidCallback onStoryComplete;
  final PageController? pageController;
  final VoidCallback? onClosePressed;

  const StoryPageContainerView({
    Key? key,
    required this.buttonData,
    required this.onStoryComplete,
    this.pageController,
    this.onClosePressed,
  }) : super(key: key);

  @override
  State<StoryPageContainerView> createState() => _StoryPageContainerViewState();
}

class _StoryPageContainerViewState extends State<StoryPageContainerView>
    with FirstBuildMixin {
  StoryTimelineController? _storyController;
  final Stopwatch _stopwatch = Stopwatch();
  Offset _pointerDownPosition = Offset.zero;
  int _pointerDownMillis = 0;
  double _pageValue = 0.0;
  List<bool> imageLoads = [];
  bool? StoryView = false;
  int DummyStoryView = -1;
  bool? DummyStoryViewBool = false;
  String? User_ID = "";
  StoryViewListModel? StoryViewListModelData;
  late PointerUpEvent event1;

  @override
  void initState() {
    _storyController =
        widget.buttonData.storyController ?? StoryTimelineController();
    _stopwatch.start();
    GetUserID();
    _storyController!.addListener(_onTimelineEvent);
    imageLoads =
        List.generate(widget.buttonData.images.length, (index) => false);
    BlocProvider.of<ViewStoryCubit>(context).StoryViewList(
        context, "${widget.buttonData.images[_curSegmentIndex].storyUid}");
    super.initState();
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
    }
    setState(() {});
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
                    widget.buttonData.images[0].profileImage != null &&
                            widget.buttonData.images[0].profileImage != ""
                        ? CustomImageView(
                            url: "${widget.buttonData.images[0].profileImage}",
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
                    SizedBox(
                      width: 12,
                    ),
                    Text(
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
            )
          : SizedBox(),
    );
  }

  int get _curSegmentIndex {
    return widget.buttonData.currentSegmentIndex;
  }

  Widget _buildPageContent() {
    bool imageLoaded = false;
    _storyController!.pause();
    NetworkImage networkImage =
        NetworkImage(widget.buttonData.images[_curSegmentIndex].image ?? "");
    print(_curSegmentIndex);

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
            setState(() {});
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
        print(
            "View_User_Story View_User_Story View_User_Story View_User_Story View_User_Story View_User_Story View_User_Story View_User_Story ");
        print(widget.buttonData.images[_curSegmentIndex].storyUid);
        print(User_ID);
        if (User_ID != widget.buttonData.images[_curSegmentIndex].userUid) {
          BlocProvider.of<ViewStoryCubit>(context).ViewStory(
              context,
              "${User_ID}",
              "${widget.buttonData.images[_curSegmentIndex].storyUid}");
        }
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
            body: Container(
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
            ),
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
      onPointerDown: (PointerDownEvent event) {
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
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            _buildPageContent(),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTimeline(),
                  _buildCloseButton(),
                  // print(widget.buttonData.images[_curSegmentIndex].storyUid);
                  Spacer(),
                  widget.buttonData.images[_curSegmentIndex].userUid == User_ID
                      ? GestureDetector(
                          onTapDown: (details) {
                            _pointerDownMillis = _stopwatch.elapsedMilliseconds;
                            _pointerDownPosition = details.localPosition;
                            _storyController?.pause();
                            showModalBottomSheet(
                                isScrollControlled: true,
                                useSafeArea: true,
                                isDismissible: true,
                                showDragHandle: true,
                                enableDrag: true,
                                constraints:
                                    BoxConstraints.tight(Size.infinite),
                                context: context,
                                builder: (BuildContext bc) {
                                  return ListView.separated(
                                      itemCount: StoryViewListModelData
                                              ?.object?.length ??
                                          0,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          // height: 40,
                                          width: _width,
                                          // color: Colors.green,
                                          child: ListTile(
                                            leading: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileScreen(
                                                              User_ID:
                                                                  "${StoryViewListModelData?.object?[index].userUid}",
                                                              isFollowing:
                                                                  "${StoryViewListModelData?.object?[index].isFollowing}",
                                                            )));
                                              },
                                              child: StoryViewListModelData
                                                              ?.object?[index]
                                                              .profilePic !=
                                                          null &&
                                                      StoryViewListModelData
                                                              ?.object?[index]
                                                              .profilePic !=
                                                          ""
                                                  ? CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      backgroundImage: NetworkImage(
                                                          "${StoryViewListModelData?.object?[index].profilePic}"),
                                                      radius: 25,
                                                    )
                                                  : CustomImageView(
                                                      imagePath: (ImageConstant
                                                          .tomcruse)),
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  "${StoryViewListModelData?.object?[index].userName}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "outfit",
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                        ?.object?[index].userUid
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
                                                          Alignment.center,
                                                      width: 65,
                                                      margin: EdgeInsets.only(
                                                          bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .primary_color,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
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
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : StoryViewListModelData
                                                                      ?.object?[
                                                                          index]
                                                                      .isFollowing ==
                                                                  'REQUESTED'
                                                              ? Text(
                                                                  'Requested',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : Text(
                                                                  'Following ',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                    ),
                                                  ),
                                          ),
                                        );
                                      });
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
                                    (position - _pointerDownPosition).distance;
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
                            });
                          },
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
                                  "${StoryViewListModelData?.object?.length}",
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
            _storyController == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.primary_color,
                      strokeWidth: 2,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.pageController?.removeListener(_onPageControllerUpdate);
    _stopwatch.stop();
    _storyController!.removeListener(_onTimelineEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        if (state is ViewStoryLoadedState) {
          print(state.ViewStoryModelData.object);
        }
        if (state is StoryViewListLoadedState) {
          StoryViewListModelData = state.StoryViewListModelData;
        }
      }, builder: (context, state) {
        return _buildPageStructure();
      }),

      ///  Show Count API Data
    );
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
    _state?.unpause();
  }

  void dispose() {
    _listeners.clear();
  }
}

class StoryTimeline extends StatefulWidget {
  final StoryTimelineController controller;
  final StoryButtonData buttonData;

  const StoryTimeline({
    Key? key,
    required this.controller,
    required this.buttonData,
  }) : super(key: key);

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
    _maxAccumulator = widget.buttonData.segmentDuration.inMilliseconds;
    _timer = Timer.periodic(
      const Duration(
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
      setState(() {});
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
