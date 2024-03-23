import 'package:flutter/material.dart';
import 'package:pds/StoryFile/src/story_page_scaffold.dart';

class FullStoryPage extends StatefulWidget {
  final String text;
  final String imageName;
  FullStoryPage({this.text = "", this.imageName = "", key});

  @override
  State<FullStoryPage> createState() => _FullStoryPageState();
}

class _FullStoryPageState extends State<FullStoryPage> {
  @override
  Widget build(BuildContext context) {
    return StoryPageScaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: widget.imageName.contains("car")
              ? DecorationImage(
                  image: AssetImage(
                    "assets/images/expert4.png",
                  ),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: NetworkImage(
                    "${widget.imageName}",
                  ),
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
                widget.text,
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
}
