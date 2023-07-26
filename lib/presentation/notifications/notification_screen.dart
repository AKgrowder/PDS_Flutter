import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';
import 'notification_demo.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

var categorySelectedValue = 0;
var sliderCurrentPosition = 0;
var arrNotiyTypeList = [
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
Map userData = {
  "userData": [
    {
      "image": "assets/images/Group 1171274865.png",
      "title": "Invitation Received!",
      "text": "You have a invite from User 1 , so connect with him/her now.",
      "datetime": "Today | 03:30 PM  !",
    },
    {
      "image": "assets/images/Group 1171274866.png",
      "title": "Payment!",
      "text": "Woah! You recieved the payment.",
      "datetime": "01, June, 2023 | 10:12 AM",
    },
    {
      "image": "assets/images/Group 1171274867.png",
      "title": "Rooms Start!",
      "text": "User 1 sent a new update on xx Rooms, check now.",
      "datetime": "19, May, 2023 | 08:25 AM",
    },
    {
      "image": "assets/images/Group 1171274868.png",
      "title": "Removal/ Switch!",
      "text": "You are Removed/Switched by User 1 , connect with other users.",
      "datetime": "Yesterday | 12:15 PM",
    },
    {
      "image": "assets/images/Group 1171274869.png",
      "title": "Exit of Member!",
      "text": "A Member exited form the xyz room/Rooms.",
      "datetime": "01, June, 2023 | 10:12 AM",
    },
    {
      "image": "assets/images/Group 1171274870.png",
      "title": "Rooms Closed!",
      "text": "Woah! xx Rooms is closed by User 1, connect with other users.",
      "datetime": "Today | 03:30 PM",
    },
    {
      "image": "assets/images/Group 1171274871.png",
      "title": "Room/Rooms Deletion!",
      "text": "You have a invite from User 1 , so connect with him/her now.",
      "datetime": "19, May, 2023 | 08:25 AM",
    },
    {
      "image": "assets/images/Group 1171274872.png",
      "title": "New Update!",
      "text": "User 1 sent a new update on xx Rooms, check now.",
      "datetime": "19, May, 2023 | 08:25 AM",
    },
  ],
};

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontFamily: 'outfit',
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        // leading: Icon(
        //   Icons.arrow_back,
        //   color: Colors.black,
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade200)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: getVerticalSize(50),
                      decoration: BoxDecoration(
                        color: arrNotiyTypeList[0].isSelected
                            ? Color(0xFFED1C25)
                            : Colors.white,
                        // border: Border.all(color: Colors.grey)
                      ),
                      child: Center(
                          child: Text("All",
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: arrNotiyTypeList[0].isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: getFontSize(18),
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.bold))),
                    ),
                    onTap: () {
                      setState(() {
                        updateType();
                        arrNotiyTypeList[0].isSelected = true;
                        print("abcd");
                      });
                    },
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black12,
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                        width: double.maxFinite,
                        height: getVerticalSize(50),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: arrNotiyTypeList[2].isSelected
                              ? Color(0xFFED1C25)
                              : Colors.white,
                          // border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              const Spacer(),
                              Text("Chat ",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: arrNotiyTypeList[0].isSelected
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: getFontSize(18),
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                            ],
                          ),
                        )),
                    onTap: () {
                      setState(() {
                        updateType();
                        arrNotiyTypeList[2].isSelected = true;
                      });
                      print("abcd");
                    },
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 90,
                      width: width / 1.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 10),
                            child: Image.asset(
                              userData["userData"][index]["image"],
                              height: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 15),
                                child: Text(
                                  userData["userData"][index]["title"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "outfit",
                                      fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, left: 15),
                                child: Container(
                                    // color: Colors.amber,
                                    height: 30,
                                    width: width / 2,
                                    child: Text(
                                      userData["userData"][index]["text"],
                                      style: TextStyle(
                                          // overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 13),
                                    )),
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // SizedBox(width: 120,),

                                  Container(
                                    child: Text(
                                      userData["userData"][index]["datetime"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontFamily: "outfit",
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              )
                              
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ]),
      ),
    );
  }

  updateType() {
    arrNotiyTypeList.forEach((element) {
      element.isSelected = false;
    });
  }
}
