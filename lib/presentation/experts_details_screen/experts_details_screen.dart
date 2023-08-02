import 'package:archit_s_application1/presentation/experts_details_screen/review_scren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';

class ExpertsDetailsScreen extends StatefulWidget {
  const ExpertsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ExpertsDetailsScreen> createState() => _ExpertsDetailsScreenState();
}

var userRating;
double? rateStar = 5.0;

class _ExpertsDetailsScreenState extends State<ExpertsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Expert Details",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 130,
              width: 130,
              margin: getMargin(
                top: 22,
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.experts,
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
            padding: const EdgeInsets.only(left: 36.0, top: 10),
            child: Text(
              "Name",
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
                  "Expert Name",
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
            padding: const EdgeInsets.only(left: 36.0, top: 10),
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
              width: width / 1.2,
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
            padding: const EdgeInsets.only(left: 36.0, top: 10),
            child: Text(
              "Description",
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
              height: height / 5,
              width: width / 1.2,
              decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10),
                child: Text(
                  "Description",
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
            padding: const EdgeInsets.only(left: 36.0, top: 10),
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
              width: width / 1.2,
              decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10),
                child: Text(
                  "Price/ hr",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700,
                      fontFamily: "outfit",
                      fontSize: 15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rateing and Reviews",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: "outfit",
                      fontSize: 18),
                ),
                GestureDetector(onTap: () {
                  Navigator.push(context,  MaterialPageRoute(builder:  (context) => RateingScreen(),));
                },
                  child: Text(
                    "+ Add Rateing Reviw",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFED1C25),
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35,right: 35,top: 10),
            child: Container(
              // height: height,
              // width: width / 1.2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: userRating != null ? userRating : 5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: getSize(60),
                      itemCount: 5,
                      itemPadding: getPadding(left: 6, right: 6),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFED1C25),
                      ),
                      onRatingUpdate: (rating) {
                        rateStar = rating;
                        print(rating);
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "20+Reviws",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.expertdetailimage,
                                    height: 55,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 35.0),
                                          child: RatingBar.builder(
                                            initialRating: userRating != null
                                                ? userRating
                                                : 5,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemSize: getSize(25),
                                            itemCount: 5,
                                            itemPadding:
                                                getPadding(left: 0, right: 0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFED1C25),
                                            ),
                                            onRatingUpdate: (rating) {
                                              rateStar = rating;
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:20.0),
                                          child: Text(
                                            "06/06/2023",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                                fontFamily: "outfit",
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "outfit",
                                          fontSize: 15),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 250,
                                      child: Text(
                                        "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum....",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            fontFamily: "outfit",
                                            fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                            )
                          ],
                        );
                      },
                    )
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
