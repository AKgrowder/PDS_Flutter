import 'package:flutter/material.dart';
import 'package:stories_editor/stories_editor.dart';

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({key});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  @override
  Widget build(BuildContext context) {
    return StoriesEditor(
      giphyKey: 'API KEY',
      //fontFamilyList: const ['Shizuru', 'Aladin'],
      galleryThumbnailQuality: 300,
      //isCustomFontList: true,
      onDone: (uri) {
        debugPrint(uri);
        //Share.shareFiles([uri]);
      },
    );
  }
}
