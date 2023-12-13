import 'package:flutter/material.dart';
import 'package:pds/StoryFile/src/story_button.dart';
import 'package:pds/StoryFile/src/story_page_container_builder.dart';

import 'story_page_transform.dart';

class StoryContainerSettings {
  final StoryButtonData buttonData;
  final List<StoryButtonData> allButtonDatas;
  final Offset tapPosition;
  final Curve? curve;

  /// [pageTransform] defaults to [StoryPage3DTransform]
  /// it affects the way a page transition looks
  final IStoryPageTransform? pageTransform;
  final ScrollController storyListScrollController;

  bool safeAreaTop;
  bool safeAreaBottom;

  StoryContainerSettings({
    required this.buttonData,
    required this.allButtonDatas,
    required this.tapPosition,
    this.curve,
    this.pageTransform,
    required this.storyListScrollController,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
  });
}

class StoryRoute extends ModalRoute {
  final Duration? duration;
  final StoryContainerSettings storyContainerSettings;
  void Function()? onTap;

  StoryRoute({this.duration, required this.storyContainerSettings, this.onTap});

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return StoryPageContainerBuilder(
      onTap: onTap,
      animation: animation,
      settings: storyContainerSettings,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration ?? kThemeAnimationDuration;

  @override
  bool get barrierDismissible => false;

  @override
  bool get opaque => false;
}
