import 'package:flutter/material.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:video_player/video_player.dart';

class VideoFullScreen extends StatefulWidget {
  List<String>? postData;
  VideoFullScreen({Key? key, this.postData}) : super(key: key);

  @override
  State<VideoFullScreen> createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  VideoPlayerController? _controllers;

  double _currentSliderValue = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < widget.postData!.length; i++) {
      _controllers =
          VideoPlayerController.networkUrl(Uri.parse('${widget.postData?[i]}'));

      _controllers?.initialize().then((value) => setState(() {}));
      setState(() {
        _controllers?.play();
        _controllers?.pause();
        _controllers?.setLooping(true);
        _controllers.seekTo(position)
      });
    }
    print("video list -- ${_controllers}");
  }

  @override
  void dispose() {
    _controllers!.dispose();
    super.dispose();
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
              // Slider(
              //   value: _currentSliderValue,
              //   min: 0.0,
              //   max: _controllers!.value.duration.inMilliseconds.toDouble(),
              //   onChanged: (value) {
              //     final Duration duration = _controllers!.value.duration;
              //     final newPosition = value * duration.inMilliseconds;
              //     _controllers!
              //         .seekTo(Duration(milliseconds: newPosition.toInt()));
              //   },
              // ),
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
