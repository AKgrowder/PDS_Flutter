// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBarScreen extends StatefulWidget {
  dynamic value2;
  SearchBarScreen({required this.value2});

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  int sliderCurrentPosition = 0;
  dynamic dataSetup;
  TextEditingController searchController = TextEditingController();
  List text = ["For You", "Trending"];
  List imageList = [
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
  ];
  int? indexxx;

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dataSetup = prefs.getInt(
      "tabSelction",
    );
    if (dataSetup != null) {
      dataSetup = await dataSetup;
    } else {
      dataSetup = await widget.value2;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                controller: searchController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    hintText: "Search....",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    )),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
              // height: 40,
              width: double.infinity,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (index) {
                    return GestureDetector(
                      onTap: () {
                        indexxx = index;
                        dataSetup = null;

                        SharedPreferencesFunction(indexxx ?? 0);
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 25,
                        width: 120,
                        decoration: BoxDecoration(
                            color: indexxx == index
                                ? Color(0xffED1C25)
                                : dataSetup == index
                                    ? Color(0xffED1C25)
                                    : Color(0xffFBD8D9),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          text[index],
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: indexxx == index
                                  ? Colors.white
                                  : dataSetup == index
                                      ? Colors.white
                                      : Color(0xffED1C25)),
                        )),
                      ),
                    );
                  }),
                )
              ])),
          Divider(
            color: Colors.grey,
          ),
          TopSlider(),
          NavagtionPassing()
        ],
      ),
    );
  }

  Widget TopSlider() {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExcludeSemantics(
                  child: CarouselSlider.builder(
                      options: CarouselOptions(
                          height: 350.00,
                          initialPage: 0,
                          autoPlay: true,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                sliderCurrentPosition = index;
                              });
                            });
                          }),
                      itemCount: 5,
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () {},
                          child: Image.asset(imageList[index]),
                        );
                      }),
                ),
              ),
            ),
            Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    height: 20,
                    child: DotsIndicator(
                      dotsCount: 5,
                      position: 0,
                      decorator: DotsDecorator(
                        size: const Size(10.0, 7.0),
                        activeSize: const Size(10.0, 10.0),
                        spacing: const EdgeInsets.symmetric(horizontal: 2),
                        activeColor: Color(0xffED1C25),
                        color: Color(0xff6A6A6A),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }

  SharedPreferencesFunction(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("tabSelction", value);
  }

  Widget NavagtionPassing() {
    if (dataSetup != null) {
      if (dataSetup == 0) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trending in India",
                            style: TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "#EcofriendlyPackaingDesign",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "2.64M posts",
                            style: TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      } else {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trending in India",
                            style: TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "#EcofriendlyPackaingDesign",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "2.64M posts",
                            style: TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }
    } else {
      if (indexxx != null) {
        if (indexxx == 0) {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Divider(
                      height: 3,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trending in India",
                              style: TextStyle(
                                color: Color(0xff808080),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "#EcofriendlyPackaingDesign",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "2.64M posts",
                              style: TextStyle(
                                color: Color(0xff808080),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Divider(
                      height: 3,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trending in India",
                              style: TextStyle(
                                color: Color(0xff808080),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "#EcofriendlyPackaingDesign",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "2.64M posts",
                              style: TextStyle(
                                color: Color(0xff808080),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      }
    }
    return Expanded(
        child: Container(
      color: Colors.white,
    ));
  }
}
