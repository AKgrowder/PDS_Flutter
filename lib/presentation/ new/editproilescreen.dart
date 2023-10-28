import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/stroycommenwoget.dart';
import 'package:pds/presentation/rooms/rooms_screen.dart';
import 'package:pds/widgets/ImageView_screen.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  NewProfileScreen_Model? newProfileData;
  EditProfileScreen({this.newProfileData});
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
  double value2 = 0.0;
  String? User_Module;
  double documentuploadsize = 0;
  dataSetUpMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_Module = prefs.getString(PreferencesKey.module);
    int? a = prefs.getInt(PreferencesKey.mediaSize);
    documentuploadsize = double.parse("${a}");
    nameController.text = widget.newProfileData?.object?.name?.toString() ?? '';
    userNameController.text =
        widget.newProfileData?.object?.userName?.toString() ?? '';
    emailController.text =
        widget.newProfileData?.object?.email?.toString() ?? '';
    contactController.text =
        widget.newProfileData?.object?.mobileNo?.toString() ?? '';

    setState(() {});
  }
  void initState() {
    dataSetUpMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocConsumer<MyAccountCubit, MyAccountState>(
          listener: (context, state) {
            
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: _height / 2.6,
                  width: _width,
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      widget.newProfileData?.object?.userProfilePic != null
                          ? Container(
                              height: _height / 3,
                              width: _width,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${widget.newProfileData?.object?.userProfilePic?.toString()}',
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.fill,
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
                              widget.newProfileData?.object?.userProfilePic !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipOval(
                                        child: FittedBox(
                                          child: CachedNetworkImage(
                                            height: 150,
                                            width: 150,
                                            imageUrl:
                                                '${widget.newProfileData?.object?.userProfilePic?.toString()}',
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.fill,
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
                                                color: Color(0xffFFFFFF),
                                                width: 4),
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
                        GestureDetector(
                          onTap: () {
                            print("sdghsdgfgfgg0-$User_Module");
                            if (User_Module == 'COMPANY') {}
                          },
                          child: Padding(
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DocumentViewScreen1(
                                      path:
                                          '${widget.newProfileData?.object?.userProfilePic}',
                                      title: 'Pdf',
                                    )))
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
    _image1 = File(pickedImageFile?.path ?? '');
    setState(() {});

    if (_image1 != null) {
      if (!_isGifOrSvg(_image1!.path)) {
        _image1 = File(_image1!.path);
        setState(() {});
        getUploadeProfile(_image1!.path, 1, _image1!, 0);
      }
    }

    print("image selcted Path set-->$_image");
  }

  getUploadeProfile(
      String filepath, int decimals, File file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);
    print(file1);
    print(value2);
    switch (i) {
      case 0:
        BlocProvider.of<MyAccountCubit>(context)
            .upoldeProfilePic(_image1!, context);
        break;
      case 1:
        print("Done file size KB");

        print('filenamecheckKB-${file1.path}');
        BlocProvider.of<MyAccountCubit>(context)
            .upoldeProfilePic(_image1!, context);
        setState(() {});

        break;
      case 2:
        if (value2 > documentuploadsize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${documentuploadsize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB"),
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
        } else {
          print("Done file Size 12MB");
          print('filecheckPath-${file1.path}');
          print('filecheckPath-${file1.path}');
          BlocProvider.of<MyAccountCubit>(context)
              .upoldeProfilePic(_image1!, context);
        }

        break;
      default:
    }

    return STR;
  }
}
