import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/fick_players/flick_video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoListItem1 extends StatefulWidget {
  final String videoUrl;
  String? discrption;
  String? PostID;
  /*  bool? isData; */
  VideoListItem1({required this.videoUrl, this.discrption, required this.PostID
      /* this.isData */
      });

  @override
  State<VideoListItem1> createState() => _VideoListItem1State();
}

class _VideoListItem1State extends State<VideoListItem1> {
  FlickManager? flickManager;
  VideoPlayerController? videoPlayerController;
  String? User_ID;
  DateTime time = DateTime(1990, 1, 1, 0, 0, 0, 0, 0);
  @override
  void initState() {
    super.initState();
    Get_UserToken();
    /*   if (widget.isData == true) { */
    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      ),
    );
    /* } else { */
    /*  videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            super.setState(() {});
          }); */
    /*  } */
  }

  @override
  void dispose() {
    flickManager!.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  Get_UserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    print("User_id-${User_ID}");
  }

  String formatDurationInHhMmSs(Duration duration) {
    final HH = (duration.inHours).toString().padLeft(2, '0');
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$HH:$mm:$ss';
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

          print(formatDurationInHhMmSs(Duration(
              seconds: flickManager?.flickVideoManager?.videoPlayerController
                      ?.value.position.inSeconds ??
                  0))); // 00:00:01

          var timeString = formatDurationInHhMmSs(Duration(
              seconds: flickManager?.flickVideoManager?.videoPlayerController
                      ?.value.position.inSeconds ??
                  0));
          print(
              "video pause!!${flickManager?.flickVideoManager?.videoPlayerController?.value.position.inSeconds}");

          BlocProvider.of<GetGuestAllPostCubit>(context).videowatchdetailAPI(
              context, "${widget.PostID}", "${User_ID}", timeString);
        }
      },
      child: Card(
        margin: EdgeInsets.only(
          left: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.videoUrl.isNotEmpty /*  && widget.isData == true */)
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

              /*    if (/* widget.isData == false && */ widget.videoUrl.isNotEmpty)
                videoPlayerController!.value.isInitialized
                    ? Stack(
                        children: [
                          AspectRatio(
                            aspectRatio:
                                videoPlayerController!.value.aspectRatio,
                            child: VideoPlayer(videoPlayerController!),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    if (videoPlayerController!
                                        .value.isPlaying) {
                                      videoPlayerController!.pause();
                                      super.setState(() {});
                                    } else {
                                      videoPlayerController!.play();
                                      super.setState(() {});
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
                          ),
                        ],
                      )
                    : Container(), */
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
