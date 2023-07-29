import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';

class ViewDetailsScreen extends StatefulWidget {
  const ViewDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ViewDetailsScreen> createState() => _ViewDetailsScreenState();
}

class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        centerTitle: true,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ),
        title: Text(
          "View detailS",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: getSize(
                130,
              ),
              width: getSize(
                130,
              ),
              margin: getMargin(
                top: 22,
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.viewdetailsimage,
                    height: getSize(
                      130,
                    ),
                    width: getSize(
                      130,
                    ),
                    radius: BorderRadius.circular(
                      getHorizontalSize(
                        65,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  CustomIconButton(
                    height: 33,
                    width: 33,
                    padding: getPadding(
                      all: 8,
                    ),
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
              width: width / 1.2,
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
              width: width / 1.2,
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
              width: width / 1.2,
              decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10),
                child: Text(
                  "Email Address  ",
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
              width: width / 1.2,
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
          )
        ]),
      ),
    );
  }
}
