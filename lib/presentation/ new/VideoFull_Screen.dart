import 'package:flutter/material.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:video_player/video_player.dart';

class VideoFullScreen extends StatefulWidget {
  List? postData;
  VideoFullScreen({Key? key, this.postData}) : super(key: key);

  @override
  State<VideoFullScreen> createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  VideoPlayerController? _controllers;
  Duration? _startDuration = Duration();
  Duration? _endDuration = Duration();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < widget.postData!.length; i++) {
      _controllers =
          VideoPlayerController.networkUrl(Uri.parse('${widget.postData?[i]}'));

      _controllers?.initialize().then((value) => setState(() {
            _endDuration = _controllers?.value.duration;
          }));
      setState(() {
        _controllers?.play();
        _controllers?.pause();
        _controllers?.setLooping(true);
        _controllers?.videoPlayerOptions?.allowBackgroundPlayback;

        _controllers?.addListener(() => setState(() {
              if (_controllers?.value.isPlaying ?? false) {
                setState(() {
                  _startDuration = _controllers?.value.position;
                  _endDuration = _controllers?.value.duration;
                });
              } else {
                setState(() {
                  _startDuration = _controllers?.value.position;
                  _endDuration = _controllers?.value.duration;
                  ;
                });
              }
            }));
      });
    }
    print("video list -- ${_controllers}");
  }

  @override
  void dispose() {
    _controllers!.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Video",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controllers!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controllers!.value.aspectRatio,
                      child: VideoPlayer(_controllers!),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: VideoProgressIndicator(
                  _controllers!,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.black,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_formatDuration(_startDuration!)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${_formatDuration(_endDuration!)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // _playPause(index);
                  if (_controllers!.value.isPlaying) {
                    setState(() {
                      _controllers?.pause();
                    });
                  } else {
                    setState(() {
                      _controllers?.play();
                    });
                  }
                },
                child: _controllers!.value.isPlaying
                    ? Icon(
                        Icons.pause_circle_outline,
                        size: 50,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.play_circle_outline,
                        size: 50,
                        color: Colors.black,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
