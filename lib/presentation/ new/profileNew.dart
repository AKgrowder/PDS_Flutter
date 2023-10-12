import 'package:flutter/material.dart';
import 'package:pds/core/utils/image_constant.dart';

import 'mypofiileScreencustom.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> tabData = ["Details", "Post", "Comments", "Saved"];
  List<String> soicalScreen = ["Details", "Post", "Comments",];

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 300 * 10,
              child: ListView.builder(
                  primary: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) => index % 2 == 0
                      ? Transform.translate(
                          offset: Offset(index == 0 ? -300 : -350,
                              index == 0 ? -50 : 150),
                          child: Container(
                            height: 240,
                            width: 150,
                            margin:
                                EdgeInsets.only(top: index == 0 ? 0 : 600),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //  color: Colors.amber,
                                boxShadow: [
                                  BoxShadow(
                                      // color: Colors.black,
                                      color: Color(0xffFFE9E9),
                                      blurRadius: 70,
                                      spreadRadius: 150),
                                ]),
                          ),
                        )
                      : Transform.translate(
                          offset: Offset(index == 0 ? 50 : 290, 90),
                          child: Container(
                            height: 190,
                            width: 150,
                            margin: EdgeInsets.only(top: 400),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                      // color: Colors.red,
                                      color: Color(0xffFFE9E9),
                                      blurRadius: 70.0,
                                      spreadRadius: 110),
                                ]),
                          ),
                        ))),
            ),
            Container(
                height: 300 * 10,
                child: MyProfileScreenCustom(
                  tabData: tabData,
                  userProfile: 'soicalScreens',
                ))
          ],
        ),
      ],
    )));
  }
}



