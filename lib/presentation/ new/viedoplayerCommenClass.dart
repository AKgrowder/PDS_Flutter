import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoListItem extends StatefulWidget {
  final VideoPlayerController controller;

  VideoListItem({required this.controller});

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  @override
  void initState() {
    widget.controller.initialize().then((value) => super.setState(() {}));
    super.setState(() {
      widget.controller.play();
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller;
    super.dispose();
    widget.controller.play();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
        ElevatedButton(
          onPressed: () {
            super.setState(() {
              if (widget.controller.value.isPlaying) {
                widget.controller.pause();
              } else {
                widget.controller.play();
              }
            });
          },
          child: Icon(
            widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ],
    );
  }
}
