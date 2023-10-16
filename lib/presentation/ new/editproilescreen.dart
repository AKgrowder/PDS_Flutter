import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/stroycommenwoget.dart';
import 'package:pds/widgets/ImageView_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

var userProfile;

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  File? _image;
  File? _image1;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //   ),
      //   title: Column(
      //     children: [
      //       Text(
      //         "Edit Profile",
      //         style: TextStyle(
      //           fontSize: 22,
      //           fontWeight: FontWeight.w600,
      //           color: Colors.black,
      //         ),
      //       ),
      //       RichText(
      //         text: TextSpan(
      //           children: [
      //             TextSpan(
      //               text: "Approved",
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.w400,
      //                 color: Color(0xff019801),
      //               ),
      //             )
      //           ],
      //           text: "Status:",
      //           style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.w400,
      //               color: Colors.black),
      //         ),
      //       ),
      //     ],
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _height / 2.6,
              width: _width,
              decoration: BoxDecoration(
                  // color: Colors.amber,
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  _image1 != null
                      ? Container(
                          height: _height / 3,
                          width: _width,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Image.file(
                            _image1!, fit: BoxFit.cover,
                            height: 150,
                            width: 150,

                            // placeholder: (context, url) =>
                            //     CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          height: _height / 3,
                          width: _width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          // color: Colors.red,
                          child: Image.asset(
                            ImageConstant.placeholder,
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,

                            // placeholder: (context, url) =>
                            //     CircularProgressIndicator(),
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
                  Positioned(
                      bottom: 70,
                      right: 5,
                      child: userProfile != 'soicalScreen'
                          ? GestureDetector(
                              onTap: () {
                                _settingModalBottomSheet1(context);
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xffFFFFFF), width: 4),
                                  shape: BoxShape.circle,
                                  color: Color(0xffFBD8D9),
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : SizedBox()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Stack(
                        children: [
                          _image != null
                              ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipOval(
                                    child: FittedBox(
                                      child: Image.file(
                                        _image!, fit: BoxFit.cover,
                                        height: 150,
                                        width: 150,

                                        // placeholder: (context, url) =>
                                        //     CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipOval(
                                    child: FittedBox(
                                      child: Image.asset(
                                        ImageConstant.placeholder2,
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 150,

                                        // placeholder: (context, url) =>
                                        //     CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                          userProfile != 'soicalScreen'
                              ? Positioned(
                                  bottom: 7,
                                  right: -0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _settingModalBottomSheet(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffFFFFFF), width: 4),
                                        shape: BoxShape.circle,
                                        color: Color(0xffFBD8D9),
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Approved",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff019801),
                    ),
                  )
                ],
                text: "Status:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    customTextFeild(
                      controller: nameController,
                      width: _width / 1.1,
                      hintText: "Enter Name",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "User Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    customTextFeild(
                      controller: userNameController,
                      width: _width / 1.1,
                      hintText: "Enter User Name",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    customTextFeild(
                      controller: emailController,
                      width: _width / 1.1,
                      hintText: "Email Address",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Contact no.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    customTextFeild(
                      controller: contactController,
                      width: _width / 1.1,
                      hintText: "Contact no.",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              color: ColorConstant.primary_color,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  customTextFeild(
      {double? width, TextEditingController? controller, String? hintText}) {
    return Container(
      // height: 50,
      width: width,
      decoration: BoxDecoration(
          color: Color(0xffFFF3F4),
          border: Border.all(
            color: Color(0xffFFC8CA),
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.only(left: 12),
        child: TextFormField(
          controller: controller,
          autofocus: false, 
          cursorColor: ColorConstant.primary_color,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff565656)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

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

  void _settingModalBottomSheet1(context) {
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
                      gallerypicker1(),
                    },
                  ),
                ),
              ],
            ),
          );
        });
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

  Future<void> gallerypicker() async {
    var pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImageFile?.path ?? '');
    });
    if (_image != null) {
      Navigator.pop(context);
    }
    print("image selcted Path set-->$_image");
  }

  Future<void> gallerypicker1() async {
    var pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image1 = File(pickedImageFile?.path ?? '');
      if (_image != null) {
        Navigator.pop(context);
      }
    });
    print("image selcted Path set-->$_image");
  }
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
