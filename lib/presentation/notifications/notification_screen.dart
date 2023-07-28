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
      "image": "assets/images/plus.png",
      "title": "Invitation Received!",
      "text": "You have a invite from User 1 , so connect with him/her now.",
      "datetime": "Today | 03:30 PM  !",
    },
    {
      "image": "assets/images/rupeee.png",
      "title": "Payment!",
      "text": "Woah! You recieved the payment.",
      "datetime": "01, June, 2023 | 10:12 AM",
    },
    {
      "image": "assets/images/rightorange.png",
      "title": "Rooms Start!",
      "text": "User 1 sent a new update on xx Rooms, check now.",
      "datetime": "19, May, 2023 | 08:25 AM",
    },
    {
      "image": "assets/images/swap.png",
      "title": "Removal/ Switch!",
      "text": "You are Removed/Switched by User 1 , connect with other users.",
      "datetime": "Yesterday | 12:15 PM",
    },
    {
      "image": "assets/images/cross.png",
      "title": "Exit of Member!",
      "text": "A Member exited form the xyz room/Rooms.",
      "datetime": "01, June, 2023 | 10:12 AM",
    },
    {
      "image": "assets/images/blueright.png",
      "title": "Rooms Closed!",
      "text": "Woah! xx Rooms is closed by User 1, connect with other users.",
      "datetime": "Today | 03:30 PM",
    },
    {
      "image": "assets/images/deleten.png",
      "title": "Room/Rooms Deletion!",
      "text": "You have a invite from User 1 , so connect with him/her now.",
      "datetime": "19, May, 2023 | 08:25 AM",
    },
    {
      "image": "assets/images/notn.png",
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
          SizedBox(
            height: 20,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ListTile(
                  contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 5),
                  leading: Image.asset(
                    userData["userData"][index]["image"],
                  ),
                  title: Text(
                    userData["userData"][index]["title"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // width: width / 1.3,
                          child: Text(
                            userData["userData"][index]["text"],
                            style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: "outfit",
                                fontSize: 13),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
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
                        ),
                      ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(padding: EdgeInsets.only(top: 10));
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
