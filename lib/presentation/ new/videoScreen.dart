import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pds/fick_players/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoListItem1 extends StatefulWidget {
  final String videoUrl;
  String? discrption;
  bool? isData;
  VideoListItem1({required this.videoUrl, this.discrption, this.isData});

  @override
  State<VideoListItem1> createState() => _VideoListItem1State();
}

class _VideoListItem1State extends State<VideoListItem1> {
  FlickManager? flickManager;
  VideoPlayerController? videoPlayerController;
  @override
  void initState() {
    super.initState();
    if (widget.isData == true) {
      flickManager = FlickManager(
        autoPlay: false,
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(widget.videoUrl),
        ),
      );
    } else {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {});
            });
    }

   
  }

  @override
  void dispose() {
    flickManager!.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visiblityInfo) {
        if (visiblityInfo.visibleFraction > 0.50) {
          flickManager?.flickControlManager?.play();
        } else {
          flickManager?.flickControlManager?.pause();
        }
      },
      child: Card(
        margin: EdgeInsets.only(
          left: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.videoUrl.isNotEmpty && widget.isData == true)
                FlickVideoPlayer(
                  preferredDeviceOrientationFullscreen: [
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ],
                  flickManager: flickManager!,
                  flickVideoWithControls: FlickVideoWithControls(
                    controls: FlickPortraitControls(),
                  ),
                ),
    
              if (widget.isData == false && widget.videoUrl.isNotEmpty)
                videoPlayerController!.value.isInitialized
                    ? Stack(
                        children: [
                          AspectRatio(
                            aspectRatio:
                                videoPlayerController!.value.aspectRatio,
                            child: VideoPlayer(videoPlayerController!),
                          ),
                          Positioned(
                            top: 50,
                            right: 50,
                            left: 50,
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  if (videoPlayerController!.value.isPlaying) {
                                    videoPlayerController!.pause();
                                    setState(() {});
                                  } else {
                                    videoPlayerController!.play();
                                    setState(() {});
                                  }
                                },
                                child: Icon(
                                  videoPlayerController!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              // Add other information or controls as needed
            ],
          ),
        ),
      ),
    );
  }
}

class CenterPlayPauseButton extends StatelessWidget {
  final VideoPlayerController videoController;

  const CenterPlayPauseButton({required this.videoController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (videoController.value.isPlaying) {
          videoController.pause();
        } else {
          videoController.play();
        }
      },
      child: Icon(
        videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        size: 50.0,
        color: Colors.white,
      ),
    );
  }
}
