import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';
import 'experts_details_screen.dart';

class RateingScreen extends StatefulWidget {
  const RateingScreen({Key? key}) : super(key: key);

  @override
  State<RateingScreen> createState() => _RateingScreenState();
}

class _RateingScreenState extends State<RateingScreen> {
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Ratings",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: width / 1.2,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: RatingBar.builder(
                    initialRating: userRating != null ? userRating : 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: getSize(65),
                    itemCount: 5,
                    itemPadding: getPadding(left: 0, right: 0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFED1C25),
                    ),
                    onRatingUpdate: (rating) {
                      rateStar = rating;
                      print(rating);
                    },
                  ),
                ),
              ),
              Text(
                "Add Reviews",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 20),
              ),
              Container(
                height: height / 6,
                width: width / 1.2,
                decoration: BoxDecoration(
                    // color: Color(0xFFF6F6F6),
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Text Here', border: InputBorder.none),
                      maxLines: 5,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 15,
                          color: Color(0xFFED1C25),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Color(0xFFED1C25),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0XFFED1C25))),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
