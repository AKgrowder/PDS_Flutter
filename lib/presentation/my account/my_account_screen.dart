import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../settings/setting_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

TextEditingController uplopdfile = TextEditingController();

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
          height: 100,
          leadingWidth: 74,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 50.58,
                // width: getHorizontalSize(139),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 21, right: 22, bottom: 24),
                            child: Text(
                              'My Account',
                              textScaleFactor: 1.0,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black),
                            ))),
                    IsGuestUserEnabled == "true"
                        ? SizedBox.shrink()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: 22),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Status:",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w400)),
                                    Text("Approved",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w400))
                                  ]),
                            ),
                          ),
                  ],
                ),
              ),
              Icon(
                Icons.edit,
                color: Colors.grey,
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: _height / 8,
                width: _width / 3.7,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.viewdetailsimage,
                      height: 130,
                      width: 130,
                      radius: BorderRadius.circular(65),
                      alignment: Alignment.center,
                    ),
                    CustomIconButton(
                      height: 33,
                      width: 33,
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: CustomImageView(
                          svgPath: ImageConstant.imgCamera,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 10),
              child: Text(
                "User ID",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "Enter User ID",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 20),
              child: Text(
                "Your Name",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "Enter Name",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 20),
              child: Text(
                "Email",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "Email Address",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 20),
              child: Text(
                "Contact no.",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "Contact no.",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 20),
              child: Text(
                "Job Profile",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "Job profile",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 20),
              child: Text(
                "Expertise in",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "Expertise in",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 20),
              child: Text(
                "Fees",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "Price / hr",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 20),
              child: Text(
                "Working Hours",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "00:00-00:00",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, top: 20),
              child: Text(
                "Working Hours",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Text(
                    "00:00-00:00",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 35, bottom: 5),
              child: Text(
                "Document",
                style: TextStyle(
                  fontFamily: 'outfit',
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: _width / 1.65,
                    decoration: BoxDecoration(
                        color: Color(0XFFF6F6F6),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    child: Padding(
                        padding: const EdgeInsets.only(top:13.0,left: 10),
                        child: Text(
                          "xxx.jpg",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: _width / 4.5,
                      decoration: BoxDecoration(
                          color: Color(0XFF777777),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      child: Center(
                        child: Text(
                          "Change",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 50,
                width: _width / 3,
                decoration: BoxDecoration(
                    color: Color(0xFFED1C25),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ]),
        ),
      ),
    );
  }
}
