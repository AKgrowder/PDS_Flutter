import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_image_view.dart';

class MPProductdetailsScreen extends StatefulWidget {
  const MPProductdetailsScreen({Key? key}) : super(key: key);

  @override
  State<MPProductdetailsScreen> createState() => _MPProductStatedetailsScreen();
}

class _MPProductStatedetailsScreen extends State<MPProductdetailsScreen> {
  bool isSaved = false;
  var userRating;
  double? rateStar = 5.0;
  int _number = 0;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "PRODUCT",
          style: TextStyle(
            fontFamily: 'outfit',
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: ColorConstant.primary_color,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: ColorConstant.primary_color,
                )),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Home/ Boxes/ Tuck in boxes/",
                style: TextStyle(
                  fontFamily: 'outfit',
                  color: Colors.grey,
                ),
              ),
              Text(
                "4cm x 5cm Tuck in Box",
                style: TextStyle(
                    fontFamily: 'outfit',
                    color: ColorConstant.primary_color,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Paper Sheets",
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹990",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 25,
                            color: ColorConstant.primary_color,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹2400",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 20,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (isSaved) {
                    setState(() {
                      isSaved = false;
                    });
                  } else {
                    setState(() {
                      isSaved = true;
                    });
                  }
                },
                child: isSaved
                    ? Container(
                        height: 35,
                        child: CustomImageView(
                          svgPath: ImageConstant.mpsaveimage,
                        ),
                      )
                    : Container(
                        height: 35,
                        child: CustomImageView(
                          svgPath: ImageConstant.mpproductunsaveimage,
                        ),
                      ),
              )
            ],
          ),
          Row(
            children: [
              RatingBar.builder(
                initialRating: userRating != null ? userRating : 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 15,
                itemCount: 5,
                itemPadding: EdgeInsets.only(left: 1, right: 1),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color(0xFFFFC41F),
                ),
                onRatingUpdate: (rating) {
                  rateStar = rating;
                  print(rating);
                },
              ),
              Text(
                "4.6 / 5.0 (556)",
                style: TextStyle(
                    fontFamily: 'outfit', fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_number > 0) {
                      _number--;
                    }
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Icon(
                    Icons.remove,
                    color: Colors.grey,
                  )),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  "${_number}",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                )),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _number++;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.grey,
                  )),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 45,
                width: _width / 3,
                decoration: BoxDecoration(
                    color: ColorConstant.primary_color,
                    border: Border.all(color: ColorConstant.primary_color),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Card(
                  color: ColorConstant.primary_color,
                  child: Center(
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(
                          fontFamily: 'outfit',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: ColorConstant.primaryLight_color,
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Seller Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'outfit',
                      ),
                    ),
                    Text(
                      "Min. Order",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'outfit',
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "InPacking",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'outfit',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "100 pic",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'outfit',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // color: Colors.amber,
            child: Card(
              child: ExpansionTile(
                title: Text(
                  "OverView",
                  style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                children: [
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
