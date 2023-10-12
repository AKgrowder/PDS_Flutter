import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/image_constant.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class NotificationModel {
  int id;
  String title;
  bool isSelected;

  NotificationModel(this.id, this.title, {this.isSelected = false});
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List arrNotiyTypeList = [
    NotificationModel(
      1,
      " ",
      isSelected: true,
    ),
    NotificationModel(
      2,
      " ",
    ),
    NotificationModel(
      3,
      " ",
    )
  ];

  String customFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$day$month $year $time';
    return formattedDate;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'st January';
      case 2:
        return 'nd February';
      case 3:
        return 'rd March';
      case 4:
        return 'th April';
      case 5:
        return 'th May';
      case 6:
        return 'th June';
      case 7:
        return 'th July';
      case 8:
        return 'th August';
      case 9:
        return 'th September';
      case 10:
        return 'th October';
      case 11:
        return 'th November';
      case 12:
        return 'th December';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: _height / 1,
                        child: ListView.builder(
                            primary: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) => index % 2 == 0
                                ? Transform.translate(
                                    offset: Offset(index == 0 ? -300 : -350,
                                        index == 0 ? -90 : 150),
                                    child: Container(
                                      height: 240,
                                      width: 150,
                                      margin: EdgeInsets.only(
                                          top: index == 0 ? 0 : 600),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: TabBar(
                              unselectedLabelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              unselectedLabelColor: Colors.black,
                              indicator: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(8.0),
                                  color: Color(0xFFED1C25)),
                              tabs: [
                                Container(
                                  width: 150,
                                  height: 50,
                                  // color: Color(0xFFED1C25),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Text(
                                          "All",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Outfit',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  // color: Color(0xFFED1C25),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Requests",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Outfit',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  // color: Color(0xFFED1C25),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Invitations",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Outfit',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: _height / 1.15,
                            child: TabBarView(
                              children: [
                                Center(child: Text('Tab 1 Content')),
                                SingleChildScrollView(
                                    child: Column(children: [
                                  requestsection_today(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Previous Requests",
                                          style: TextStyle(
                                            fontFamily: 'outfit',
                                            fontSize: 20,fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  requestsection_previous_request(),
                                ])),
                                Center(child: Text('Tab 3 Content')),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  requestsection_today() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        // itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Image.asset(
                            ImageConstant.expertone,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Karennne Watsaon",
                                    style: TextStyle(
                                        fontFamily: "outfit",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "started following you.",
                                    style: TextStyle(
                                        fontFamily: "outfit",
                                        fontWeight: FontWeight.w200,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFED1C25),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Accept",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            color: Colors.white),
                                      )),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Color(0xFFED1C25))),
                                      child: Center(
                                          child: Text(
                                        "Reject",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            color: Color(0xFFED1C25)),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 85),
                                child: Text(
                                  customFormat(DateTime.now()),
                                  maxLines: 2,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontFamily: "outfit",
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  requestsection_previous_request() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        // itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            color: Colors.white.withOpacity(1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Image.asset(
                            ImageConstant.expertone,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Karennne Watsaon",
                                    style: TextStyle(
                                        fontFamily: "outfit",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "started following you.",
                                    style: TextStyle(
                                        fontFamily: "outfit",
                                        fontWeight: FontWeight.w200,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFED1C25),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Accept",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            color: Colors.white),
                                      )),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Color(0xFFED1C25))),
                                      child: Center(
                                          child: Text(
                                        "Reject",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            color: Color(0xFFED1C25)),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 85),
                                child: Text(
                                  customFormat(DateTime.now()),
                                  maxLines: 2,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontFamily: "outfit",
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  updateType() {
    arrNotiyTypeList.forEach((element) {
      element.isSelected = false;
    });
  }
}
