import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../widgets/custom_image_view.dart';
import '../home/home.dart';

class RecentBlogScren extends StatefulWidget {
  String? title;
  String? description1;
  String? imageURL;
  RecentBlogScren(
      {required this.description1,
      required this.title,
      required this.imageURL});

  @override
  State<RecentBlogScren> createState() => _RecentBlogScrenState();
}

var sliderCurrentPosition = 0;

class _RecentBlogScrenState extends State<RecentBlogScren> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Recent Blog",
      //     style: TextStyle(
      //       fontFamily: 'outfit',
      //       fontSize: 23,
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //   ),
      //   backgroundColor: Colors.white10,
      //   elevation: 0,
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CustomImageView(
                    url: "${widget.imageURL}",
                    height: _height / 2.8,
                    width: _width,
                    fit: BoxFit.fill,
                    // imagePath: ImageConstant.blogimage,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomImageView(
                          imagePath: ImageConstant.RightArrowWithBorder,
                          height: 35,
                          width: 35,
                        ) /* Icon(
                        1
                        Icons.arrow_back,
                        size: 35,
                        color: Colors.white,
                      ), */
                        ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 350, top: 10),
                  //   child: CustomImageView(
                  //     imagePath: ImageConstant.blogsaveimage,
                  //     height: 40,
                  //   ),
                  // ),

                  Container(
                    height: _height / 2.8,
                    // height: _height / 14,
                    // width: _width / 1,
                    // decoration: BoxDecoration(
                    //     color: Colors.white.withOpacity(0.7),
                    //     borderRadius: BorderRadius.circular(0)),
                    child: Column(children: [
                      Spacer(),
                      Container(
                        // height: _height / 2.8,
                        height: _height / 13,
                        // width: _width / 1,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(53, 255, 255, 255),
                            borderRadius: BorderRadius.circular(0)),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Title",
                                style: TextStyle(
                                    fontFamily: 'outfit',
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Container(
                                  // color: Colors.amber,
                                  width: _width / 1.1,
                                  height: 45,
                                  child: Text(
                                    "${widget.title}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontFamily: 'outfit',
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ]),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.expertdetailimage,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Robert Fox",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "12 hours ago ",
                            style: TextStyle(
                                fontFamily: 'outfit',
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "12.3K Views",
                            style: TextStyle(
                                fontFamily: 'outfit',
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.like_image,
                    height: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.arrowleftimage,
                    height: 35,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ), */
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontFamily: 'outfit',
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,bottom: 10),
                child: SingleChildScrollView(
                  child: Text(
                    "${widget.description1} ",// maxLines: ,
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              /* Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20, top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Similar Blogs",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "outfit",
                          fontSize: 23),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              similerblogs() */
            ],
          ),
        ),
      ),
    );
  }

  Widget TopSlider() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CarouselSlider.builder(
                options: CarouselOptions(
                    height: 350,
                    initialPage: 0,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // Your code HERE
                        // Flutter will wait until the current build is completed before executing this code.
                        setState(() {
                          sliderCurrentPosition = index;
                        });
                      });
                    }),
                itemCount: getallBlogdata?.object?.length,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      child: CustomImageView(
                        url: getallBlogdata?.object?[index].image.toString() ??
                            "",
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Container(
            height: 20,
            child: DotsIndicator(
              dotsCount: (getallBlogdata?.object?.length ?? 1),
              position: sliderCurrentPosition,
              decorator: DotsDecorator(
                size: const Size(10.0, 3.0),
                activeSize: const Size(30.0, 3.0),
                spacing: const EdgeInsets.symmetric(horizontal: 2),
                activeColor: ColorConstant.primary_color,
                color: ColorConstant.primary_color.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        )
      ],
    );
  }

  similerblogs() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.red,
      height: _height / 3.5,
      // width: _width / 1.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        width: _width / 2.35,
                        child: CustomImageView(
                          imagePath: ImageConstant.blogimage,
                          // height: 50,
                          // width: _width/1.2,
                          fit: BoxFit.fill,
                          radius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Baluran Wild The",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Savvanah",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("27th june 2020  10:47 PM",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 10,
                              fontWeight: FontWeight.w100)),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        maxRadius: 2,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("12.3K Views",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 10,
                              fontWeight: FontWeight.w100)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        ImageConstant.like_image,
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        ImageConstant.arrowleftimage,
                        height: 30,
                        color: Colors.black,
                      ),
                      SizedBox(width: _width / 4.8),
                      Image.asset(
                        ImageConstant.setting_save,
                        height: 20,
                        color: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
