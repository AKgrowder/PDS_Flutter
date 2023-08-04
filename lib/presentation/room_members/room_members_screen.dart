// import 'package:archit_s_application1/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class RoomMembersScreen extends StatefulWidget {
  const RoomMembersScreen({Key? key}) : super(key: key);

  @override
  State<RoomMembersScreen> createState() => _RoomMembersScreenState();
}

Map userData = {
  "userData": [
    {
      "image": "assets/images/Ellipse 6 (1).png",
    },
    {
      "image": "assets/images/Ellipse 6 (2).png",
    },
    {
      "image": "assets/images/Ellipse 6 (3).png",
    },
    {
      "image": "assets/images/Ellipse 6 (4).png",
    },
    {
      "image": "assets/images/Ellipse 6 (5).png",
    },
    {
      "image": "assets/images/Ellipse 6 (6).png",
    },
    {
      "image": "assets/images/Ellipse 6 (7).png",
    },
  ],
};

// final List infoBank = [
//   "assets/images/Ellipse 6 (1).png",
//   "assets/images/Ellipse 6 (2).png",
//   "assets/images/Ellipse 6 (3).png",
//   "assets/images/Ellipse 6 (4).png",
//   "assets/images/Ellipse 6 (5).png",
//   "assets/images/Ellipse 6 (6).png",
//   "assets/images/Ellipse 6 (7).png",
// ];

class _RoomMembersScreenState extends State<RoomMembersScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.onPrimary,
        title: Text(
          "Room Members",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: _height / 9,
                width: _width / 1.2,
                decoration: BoxDecoration(
                  color: Color(0xFFFFE7E7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Room Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 15),
                            ),
                            Container(
                              width: 99,
                              height: 28.87,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 28.88,
                                      height: 28.87,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.expertone,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 22.56,
                                    top: 0,
                                    child: Container(
                                      width: 28.88,
                                      height: 28.87,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.experttwo,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 45.12,
                                    top: 0,
                                    child: Container(
                                      width: 28.88,
                                      height: 28.87,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.expertthree,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 78,
                                    top: 7,
                                    child: SizedBox(
                                      width: 21,
                                      height: 16,
                                      child: Text(
                                        '+5',
                                        style: TextStyle(
                                          color: Color(0xFF2A2A2A),
                                          fontSize: 12,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Description of the problem/Topic to be discussed here......lorem ipsum.....",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: "outfit",
                              fontSize: 13),
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 7,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
                  child: Container(
                    height: _height / 12,
                    width: _width / 1.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            userData["userData"][index]["image"],
                            height: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "User ID",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "outfit",
                                fontSize: 15),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTapDown: (details) {
                              _showPopupMenu(details.globalPosition, context);
                            },
                            child: Container(
                              height: 50,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  child: CustomImageView(
                                    imagePath: ImageConstant.popupimage,
                                    height: 20,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(
    Offset offset,
    BuildContext context,
  ) async {
    double right = offset.dx;
    double top = offset.dy;

    await showMenu(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      position: RelativeRect.fromLTRB(
        right,
        top,
        50,
        10,
      ),
      items: [
        PopupMenuItem(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ViewDetailsScreen(),
              //     ));
            },
            enabled: true,
            child: Container(
              width: 150,
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.infoimage,
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "View Details",
                      style: TextStyle(color: Colors.black),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ],
              ),
            )),
        PopupMenuItem(
            // onTap: () {},
            enabled: true,
            child: Container(
              width: 100,
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.arrowleftimage,
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Leave",
                      style: TextStyle(color: Colors.black),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
