// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/newsettingScreen.dart';

import 'customcamerawiget.dart';
import 'editproilescreen.dart';
import 'myprofileScreenTabbarCommen.dart';

class MyProfileScreenCustom extends StatelessWidget {
  String userProfile;
  List<String> tabData;
  MyProfileScreenCustom({required this.tabData, required this.userProfile});

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
              Image.asset(
                ImageConstant.myprofile,
                fit: BoxFit.contain,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15, top: 25),
                  height: 40,
                  width: 35,
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                  child: Image.asset(ImageConstant.backArrow),
                ),
              ),
              Positioned(
                  bottom: 70,
                  right: 5,
                  child: userProfile != 'soicalScreen'
                      ? cameraPicture()
                      : SizedBox()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Stack(
                    children: [
                      Image.asset(ImageConstant.palchoder4),
                      userProfile != 'soicalScreen'
                          ? Positioned(
                              bottom: 5,
                              right: -5,
                              child: Container(
                                height: 50,
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
                          : SizedBox()
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
        userProfile != 'soicalScreen'
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
                              builder: (context) => SettingScreenNew()));
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
          tabScreen: tabData,
          userProfile: userProfile,
        ))
      ],
    );
  }
}
