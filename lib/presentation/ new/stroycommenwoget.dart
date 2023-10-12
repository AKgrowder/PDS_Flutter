import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';
import 'package:image_picker/image_picker.dart';

class StoryPage extends StatefulWidget {
  const StoryPage();

  @override
  State<StoryPage> createState() => _StoryPageState();
}

ImagePicker picker = ImagePicker();
XFile? pickedImageFile;

class _StoryPageState extends State<StoryPage> {
  Widget _createDummyPage({
    required String text,
    required String imageName,
    bool addBottomBar = true,
  }) {
    return StoryPageScaffold(
      bottomNavigationBar: addBottomBar
          ? SizedBox(
              width: double.infinity,
              height: kBottomNavigationBarHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/expert4.png",
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
                text,
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
  //-------------------------------------------------------------------------Gellery uplod_images-------------------------------------------------------

  bool _isGifOrSvg(String imagePath) {
    // Check if the image file has a .gif or .svg extension
    final lowerCaseImagePath = imagePath.toLowerCase();
    return lowerCaseImagePath.endsWith('.gif') ||
        lowerCaseImagePath.endsWith('.svg') ||
        lowerCaseImagePath.endsWith('.pdf') ||
        lowerCaseImagePath.endsWith('.doc') ||
        lowerCaseImagePath.endsWith('.mp4') ||
        lowerCaseImagePath.endsWith('.mov') ||
        lowerCaseImagePath.endsWith('.mp3') ||
        lowerCaseImagePath.endsWith('.m4a');
  }

  File? _image;
  Future<void> pickProfileImage() async {
    pickedImageFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImageFile != null) {
      if (!_isGifOrSvg(pickedImageFile!.path)) {
        setState(() {
          _image = File(pickedImageFile!.path);
        });
        final sizeInBytes = await _image!.length();
        final sizeInMB = sizeInBytes / (1024 * 1024);
        // print('documentuploadsize-$documentuploadsize');
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Selected File Error",
              textScaleFactor: 1.0,
            ),
            content: Text(
              "Only PNG, JPG Supported.",
              textScaleFactor: 1.0,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(10),
                  child: const Text("Okay"),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  Widget _buildButtonText(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildButtonDecoration(
    String imageName,
  ) {
    return BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: AssetImage(
          'assets/images/expert3.png',
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  BoxDecoration _buildBorderDecoration(Color color) {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(60.0),
      ),
      border: Border.fromBorderSide(
        BorderSide(
          color: color,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      /* appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        /*  title: const Text(
          'Story Example',
          style: TextStyle(color: Colors.black),
        ), */
        backgroundColor: Colors.white,
      ), */
      body: Column(
        children: [
          StoryListView(
            buttonDatas: [
              StoryButtonData(
                timelineBackgroundColor: Colors.grey,
                buttonDecoration: _buildButtonDecoration('car'),
                child: _buildButtonText(''),
                borderDecoration: _buildBorderDecoration(Colors.red),
                storyPages: [
                  _createDummyPage(
                    text:
                        'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: 'car',
                  ),
                  _createDummyPage(
                    text:
                        'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: 'car',
                  ),
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
              StoryButtonData(
                timelineBackgroundColor: Colors.grey,
                buttonDecoration: _buildButtonDecoration('travel_1'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                child: _buildButtonText(' '),
                storyPages: [
                  _createDummyPage(
                    text: 'Get a loan',
                    imageName: 'travel_1',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Select a place where you want to go',
                    imageName: 'travel_2',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Dream about the place and pay our interest',
                    imageName: 'travel_3',
                    addBottomBar: false,
                  ),
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
              StoryButtonData(
                timelineBackgroundColor: Colors.grey,
                buttonDecoration: _buildButtonDecoration('travel_1'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                child: _buildButtonText(' '),
                storyPages: [
                  _createDummyPage(
                    text: 'Get a loan',
                    imageName: 'travel_1',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Select a place where you want to go',
                    imageName: 'travel_2',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Dream about the place and pay our interest',
                    imageName: 'travel_3',
                    addBottomBar: false,
                  ),
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
              StoryButtonData(
                timelineBackgroundColor: Colors.grey,
                buttonDecoration: _buildButtonDecoration('travel_1'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                child: _buildButtonText(' '),
                storyPages: [
                  _createDummyPage(
                    text: 'Get a loan',
                    imageName: 'travel_1',
                    addBottomBar: true,
                  ),
                  _createDummyPage(
                    text: 'Select a place where you want to go',
                    imageName: 'travel_2',
                    addBottomBar: true,
                  ),
                  _createDummyPage(
                    text: 'Dream about the place and pay our interest',
                    imageName: 'travel_3',
                    addBottomBar: true,
                  ),
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
            ],
          ),
          /*      SizedBox(
            height: 550,
          ),
          GestureDetector(
            onTap: () {
              pickProfileImage();
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Icon(
                Icons.add,
                size: 50,
                color: Colors.white,
              )),
            ),
          ) */
        ],
      ),
    );
  }
}
