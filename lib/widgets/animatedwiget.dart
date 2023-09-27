import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/widgets/ImageView_screen.dart';

class AnimatedNetworkImage extends StatefulWidget {
  final String imageUrl;
  final Duration animationDuration;

  AnimatedNetworkImage({
    required this.imageUrl,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  _AnimatedNetworkImageState createState() => _AnimatedNetworkImageState();
}

class _AnimatedNetworkImageState extends State<AnimatedNetworkImage> {
  double _opacity = 0.0;
  bool _mounted = false;
  @override
  void initState() {
    super.initState();
    _mounted = true;
    Future.delayed(Duration(milliseconds: 100), () {
      if (_mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ImageViewScreen(
              path: widget.imageUrl,
            );
          }));
        },
        child: Container(
          height: 90,
          width: 150,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: widget.animationDuration,
            curve: Curves.easeInOut,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
