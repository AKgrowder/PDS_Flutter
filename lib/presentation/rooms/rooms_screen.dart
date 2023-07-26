import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../dialogs/assigh_adminn_dilog..dart';
import '../../dialogs/invite_dilog.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../home/home.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

List? image = [];
List? imagee = [];
List? close = [];
List? closee = [];

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  Widget build(BuildContext context) {
    Object? index;
    int selectedIndex = 0;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Rooms",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              ListView.builder(
                // itemCount: aa.length,
                itemCount:
                    (image?.contains(index) ?? false) ? aa.length : aa.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        // height: demo.contains(index) ? null: height / 16,
                        width: width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0XFFED1C25), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 10, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "09/06/2023",
                                    maxLines: 2,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontFamily: "outfit",
                                        fontSize: 14),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 35.0),
                                    child: CustomImageView(
                                      imagePath: ImageConstant.pen,
                                      height: 15,
                                    ),
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.delete,
                                    height: 20,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Rooms Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Address Specific Packaging Challenges....",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.5),
                                    fontFamily: "outfit",
                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.messageimage,
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Consultancy Stage",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 14),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (imagee?.contains(index) ??
                                              false) {
                                            imagee?.remove(index);
                                          } else {
                                            imagee?.add(index);
                                          }
                                        });
                                      },
                                      child: (imagee?.contains(index) ?? false)
                                          ? Container(
                                              width: 66,
                                              height: 19,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFF9B9B9B)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.46),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Start",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: "outfit",
                                                    fontSize: 13),
                                              )),
                                              //---------------------------------------
                                            )
                                          : Container(
                                              width: 66,
                                              height: 19,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFFED1C25)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.46),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Start",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0XFFED1C25),
                                                    fontFamily: "outfit",
                                                    fontSize: 13),
                                              )),
                                            ),
                                      //------------------------------------------
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (closee?.contains(index) ??
                                              false) {
                                            closee?.remove(index);
                                          } else {
                                            closee?.add(index);
                                          }
                                        });
                                      },
                                      child: (closee?.contains(index) ?? false)
                                          ? Container(
                                              width: 66,
                                              height: 19,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFF9B9B9B)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.46),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Close",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: "outfit",
                                                    fontSize: 13),
                                              )),
                                              //---------------------------------------
                                            )
                                          : Container(
                                              width: 66,
                                              height: 19,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFFED1C25)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.46),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Close",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0XFFED1C25),
                                                    fontFamily: "outfit",
                                                    fontSize: 13),
                                              )),
                                            ),
                                      //------------------------------------------
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.editimage,
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Designing Stage",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 14),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (image?.contains(index) ?? false) {
                                            image?.remove(index);
                                          } else {
                                            image?.add(index);
                                          }
                                        });
                                      },
                                      child: (image?.contains(index) ?? false)
                                          ? Container(
                                              width: 66,
                                              height: 19,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFF9B9B9B)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.46),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Start",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: "outfit",
                                                    fontSize: 13),
                                              )),
                                              //---------------------------------------
                                            )
                                          : Container(
                                              width: 66,
                                              height: 19,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFFED1C25)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.46),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Start",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0XFFED1C25),
                                                    fontFamily: "outfit",
                                                    fontSize: 13),
                                              )),
                                            ),
                                      //------------------------------------------
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (close?.contains(index) ?? false) {
                                            close?.remove(index);
                                          } else {
                                            close?.add(index);
                                          }
                                        });
                                      },
                                      child: (close?.contains(index) ?? false)
                                          ? Container(
                                              width: 66,
                                              height: 19,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFF9B9B9B)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.46),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Close",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: "outfit",
                                                    fontSize: 13),
                                              )),
                                              //---------------------------------------
                                            )
                                          : Container(
                                              width: 66,
                                              height: 19,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFFED1C25)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.46),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "Close",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0XFFED1C25),
                                                    fontFamily: "outfit",
                                                    fontSize: 13),
                                              )),
                                            ),
                                      //------------------------------------------
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                              imagePath:
                                                  ImageConstant.expertone,
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
                                              imagePath:
                                                  ImageConstant.experttwo,
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
                                              imagePath:
                                                  ImageConstant.expertthree,
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
                                  Container(
                                    width: 140,
                                    height: 22.51,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFFFD9DA),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Color(0xFFED1C25),
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Invite User",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFED1C25),
                                          fontFamily: "outfit",
                                          fontSize: 13),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            index == 1 || index == 2 || index == 3
                                ? Divider(color: Colors.grey)
                                : SizedBox(),

                            index == 1 || index == 3
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.workimage,
                                          height: 30,
                                        ),
                                        Text("Expert 1"),
                                        Spacer(),
                                        Container(
                                          width: 80,
                                          height: 20,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFED1C25),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(49.46),
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Switch Expert",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: "outfit",
                                                fontSize: 10),
                                          )),
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: width / 2.43,
                                  decoration: BoxDecoration(
                                      // color: Color(0XFF9B9B9B),
                                      color: Color(0xFFED1C25),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(4))),
                                  child: Center(
                                    child: Text(
                                      "Chat",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontFamily: "outfit",
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AssignAdminScreenn();
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: width / 2.43,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(4),
                                      ),
                                      color: Color(0XFF9B9B9B),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Select Expert",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontFamily: "outfit",
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),

                            // Container(
                            //   color: Colors.amber,
                            //   child: Stack(
                            //     children: [
                            //       Row(
                            //         children: [
                            //           CustomImageView(
                            //             imagePath: ImageConstant.expertone,
                            //             height: 30,
                            //           ),
                            //           CustomImageView(
                            //             imagePath: ImageConstant.experttwo,
                            //             height: 30,
                            //           ),
                            //           CustomImageView(
                            //             imagePath: ImageConstant.expertthree,
                            //             height: 30,
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return InviteDilogScreen();
                  },
                );
              },
              child: CustomImageView(
                imagePath: ImageConstant.addimage,
                height: 60,
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
