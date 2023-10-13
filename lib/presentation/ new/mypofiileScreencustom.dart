// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/stroycommenwoget.dart';
import 'package:pds/presentation/settings/setting_screen.dart';
import 'package:pds/widgets/ImageView_screen.dart';

import 'editproilescreen.dart';
import 'myprofileScreenTabbarCommen.dart';

class MyProfileScreenCustom extends StatefulWidget {
  String userProfile;
  List<String> tabData;

  MyProfileScreenCustom({required this.tabData, required this.userProfile});

  @override
  State<MyProfileScreenCustom> createState() => _MyProfileScreenCustomState();
}

File? _image;
// double documentuploadsize = 0;
var userProfile;

class _MyProfileScreenCustomState extends State<MyProfileScreenCustom> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: _height / 2.7,
          width: _width,
          // color: Colors.amber,
          child: Stack(
            children: [
              Container(
                // color: Colors.red,
                child: Image.asset(
                  ImageConstant.myprofile,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 55, left: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    child: Center(
                      child: Image.asset(
                        ImageConstant.backArrow,
                        fit: BoxFit.fill,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ),
              ),
              // Positioned(
              //     bottom: 70,
              //     right: 5,
              //     child: userProfile != 'soicalScreen'
              //         ? GestureDetector(
              //             onTap: () {
              //               _settingModalBottomSheet(context);
              //             },
              //             child: Container(
              //               height: 45,
              //               width: 45,
              //               decoration: BoxDecoration(
              //                 border: Border.all(
              //                     color: Color(0xffFFFFFF), width: 4),
              //                 shape: BoxShape.circle,
              //                 color: Color(0xffFBD8D9),
              //               ),
              //               child: Icon(
              //                 Icons.camera_alt_outlined,
              //                 color: Colors.red,
              //               ),
              //             ),
              //           )
              //         : SizedBox()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(ImageConstant.palchoder4),
                      ),
                      // userProfile != 'soicalScreen'
                      //     ? Positioned(
                      //         bottom: 7,
                      //         right: -0,
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             _settingModalBottomSheet(context);
                      //           },
                      //           child: Container(
                      //             height: 40,
                      //             width: 40,
                      //             decoration: BoxDecoration(
                      //               border: Border.all(
                      //                   color: Color(0xffFFFFFF), width: 4),
                      //               shape: BoxShape.circle,
                      //               color: Color(0xffFBD8D9),
                      //             ),
                      //             child: Icon(
                      //               Icons.camera_alt_outlined,
                      //               color: Colors.red,
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     : SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'Kriston Watshon',
            style: TextStyle(
                fontSize: 26,
                fontFamily: "outfit",
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            '@Kriston_Watshon',
            style: TextStyle(
                fontFamily: "outfit",
                fontWeight: FontWeight.bold,
                color: Color(0xff444444)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'About...Lorem ipsum dolor sit amet',
            style: TextStyle(
                fontSize: 16,
                fontFamily: "outfit",
                fontWeight: FontWeight.bold,
                color: Color(0xff444444)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        widget.userProfile != 'soicalScreen'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: _width / 3,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffED1C25))),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 18,
                            color: Color(0xffED1C25),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 45,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0XFFED1C25)),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                alignment: Alignment.center,
                height: 45,
                width: _width / 3,
                decoration: BoxDecoration(
                  color: Color(0xffED1C25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Follow',
                  style: TextStyle(
                      fontFamily: "outfit",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
        SizedBox(
          height: 12,
        ),
        Center(
          child: Container(
            height: 80,
            width: _width / 1.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xffD2D2D2),
                )),
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                ),
                Container(
                  // height: 55,
                  width: 55,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '50',
                        style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 25,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Post',
                        style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 16,
                            color: Color(0xff444444),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: VerticalDivider(
                    thickness: 1.5,
                    color: Color(0xffC2C2C2),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  // height: 55,
                  width: 90,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        '5k',
                        style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 25,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 16,
                            color: Color(0xff444444),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: VerticalDivider(
                    thickness: 1.5,
                    color: Color(0xffC2C2C2),
                  ),
                ),
                Container(
                  // height: 55,
                  width: 90,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        '3k',
                        style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 25,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Following',
                        style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 16,
                            color: Color(0xff444444),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: MyAcoountTabbarScreen(
          tabScreen: widget.tabData,
          userProfile: widget.userProfile,
        ))
      ],
    );
  }

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

  Future<void> camerapicker() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    // if (pickedImageFile != null) {
    //   if (!_isGifOrSvg(pickedImageFile!.path)) {
    //     setState(() {
    //       _image = File(pickedImageFile!.path);
    //     });
    //     final sizeInBytes = await _image!.length();
    //     final sizeInMB = sizeInBytes / (1024 * 1024);
        // if (sizeInMB > documentuploadsize) {
        //   // print('documentuploadsize-$documentuploadsize');
        //   showDialog(
        //       context: context,
        //       builder: (context) {
        //         return AlertDialog(
        //           title: Text("Image Size Exceeded"),
        //           content: Text(
        //               "Selected image size exceeds $documentuploadsize MB."),
        //           actions: [
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: Text("OK"),
        //             ),
        //           ],
        //         );
        //       });
        // }
      // } else {
      //   showDialog(
      //     context: context,
      //     builder: (ctx) => AlertDialog(
      //       title: Text(
      //         "Selected File Error",
      //         textScaleFactor: 1.0,
      //       ),
      //       content: Text(
      //         "Only PNG, JPG Supported.",
      //         textScaleFactor: 1.0,
      //       ),
      //       actions: <Widget>[
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(ctx).pop();
      //           },
      //           child: Container(
      //             // color: Colors.green,
      //             padding: const EdgeInsets.all(10),
      //             child: const Text("Okay"),
      //           ),
      //         ),
      //       ],
      //     ),
      //   );
      // }
    }
  }

  Future<void> gallerypicker() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    // if (pickedImageFile != null) {
    //   if (!_isGifOrSvg(pickedImageFile!.path)) {
    //     setState(() {
    //       _image = File(pickedImageFile!.path);
    //     });
    //     final sizeInBytes = await _image!.length();
    //     final sizeInMB = sizeInBytes / (1024 * 1024);
      //   if (sizeInMB > documentuploadsize) {
      //     // print('documentuploadsize-$documentuploadsize');
      //     showDialog(
      //         context: context,
      //         builder: (context) {
      //           return AlertDialog(
      //             title: Text("Image Size Exceeded"),
      //             content: Text(
      //                 "Selected image size exceeds $documentuploadsize MB."),
      //             actions: [
      //               TextButton(
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //                 child: Text("OK"),
      //               ),
      //             ],
      //           );
      //         });
      //   }
      // } else {
        // showDialog(
        //   context: context,
        //   builder: (ctx) => AlertDialog(
        //     title: Text(
        //       "Selected File Error",
        //       textScaleFactor: 1.0,
        //     ),
        //     content: Text(
        //       "Only PNG, JPG Supported.",
        //       textScaleFactor: 1.0,
        //     ),
        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () {
        //           Navigator.of(ctx).pop();
        //         },
        //         child: Container(
        //           // color: Colors.green,
        //           padding: const EdgeInsets.all(10),
        //           child: const Text("Okay"),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      }
  //   }
  // }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 180,
            child: new Wrap(
              children: [
                Container(
                  height: 20,
                  width: 50,
                  color: Colors.transparent,
                ),
                Center(
                    child: Container(
                  height: 5,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),
                )),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: new ListTile(
                      leading: new Image.asset(
                        ImageConstant.uplodimage,
                        height: 45,
                      ),
                      title: new Text('See Profile Picture'),
                      onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageViewScreen(
                                      path: "assets/images/palchoder4.png"),
                                ))
                          }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: new ListTile(
                    leading: new Image.asset(
                      ImageConstant.galleryimage,
                      height: 45,
                    ),
                    title: new Text('Upload Profile Picture'),
                    onTap: () => {
                      gallerypicker(),
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
// }
