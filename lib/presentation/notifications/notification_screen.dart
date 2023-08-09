import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import '../../API/Bloc/Invitation_Bloc/Invitation_state.dart';
import '../../API/Model/InvitationModel/Invitation_Model.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import 'notification_demo.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

var categorySelectedValue = 0;
var sliderCurrentPosition = 0;
InvitationModel? InvitationRoomData;
var Show_NoData_Image = false;

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
  void initState() {
    // Show_NoData_Image = true;
    GetData();

    super.initState();
  }

  GetData() async {
    await BlocProvider.of<InvitationCubit>(context).InvitationAPI();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
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
        body: BlocConsumer<InvitationCubit, InvitationState>(
            listener: (context, state) async {
          if (state is InvitationErrorState) {
            print('error state');
            if (state.error == "not found") {
              print("Show Image");
              Show_NoData_Image = true;
            } else {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }

          if (state is InvitationLoadingState) {
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                ),
              ),
            );
          }
          if (state is InvitationLoadedState) {
            InvitationRoomData = state.InvitationRoomData;
            print(InvitationRoomData?.message);
            if (InvitationRoomData?.object?.length == null ||
                InvitationRoomData?.object?.length == 0) {
              Show_NoData_Image = true;
            } else {
              Show_NoData_Image = false;
            }
            // setState(() {});
          }
          if (state is AcceptRejectInvitationModelLoadedState) {
            SnackBar snackBar = SnackBar(
              content:
                  Text(state.acceptRejectInvitationModel.message.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            BlocProvider.of<InvitationCubit>(context).InvitationAPI();
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200)),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: 50,
                            color: arrNotiyTypeList[0].isSelected
                                ? Color(0xFFED1C25)
                                : Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.black,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    "All",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: arrNotiyTypeList[0].isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ),
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
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                              height: 50,
                              color: arrNotiyTypeList[1].isSelected
                                  ? Color(0xFFED1C25)
                                  : Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : Colors.black,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text("Chat ",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: arrNotiyTypeList[1].isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  Container(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  )
                                  // Spacer(),
                                ],
                              )),
                          onTap: () {
                            setState(() {
                              updateType();
                              arrNotiyTypeList[1].isSelected = true;
                              print("abcd");
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              color: arrNotiyTypeList[2].isSelected
                                  ? Color(0xFFED1C25)
                                  : Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : Colors.black,
                              child: Center(
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Text("Invitations",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            color:
                                                arrNotiyTypeList[2].isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: 18,
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
              ),
              SizedBox(
                height: 20,
              ),
              arrNotiyTypeList[0].isSelected == true
                  ? ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.only(top: 10, left: 10, bottom: 5),
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
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          userData["userData"][index]
                                              ["datetime"],
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
                  : SizedBox(),
              arrNotiyTypeList[1].isSelected == true
                  ? Container(
                      height: 100,
                      width: 100,
                      // color: Colors.red,
                    )
                  : SizedBox(),
              arrNotiyTypeList[2].isSelected == true
                  ? Container(
                      child: state is InvitationLoadedState
                          ? Show_NoData_Image == false
                              ? SingleChildScrollView(
                                  child: ListView.builder(
                                    // itemCount: aa.length,
                                    itemCount:
                                        InvitationRoomData?.object?.length,
                                    /* (image?.contains(index) ?? false)
                        ? aa.length
                        : aa.length, */
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 35, vertical: 5),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            // height: demo.contains(index) ? null: height / 16,
                                            width: _width / 1.2,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        const Color(0XFFED1C25),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0,
                                                      top: 10,
                                                      right: 10,
                                                      bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Create Date",
                                                        maxLines: 2,
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        "${InvitationRoomData?.object?[index].companyName}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        "${InvitationRoomData?.object?[index].roomQuestion}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    "${InvitationRoomData?.object?[index].description}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontFamily: "outfit",
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          print(
                                                              'chek data get-${InvitationRoomData?.object?[index].invitationLink.toString()}');
                                                          BlocProvider.of<
                                                                      InvitationCubit>(
                                                                  context)
                                                              .GetRoomInvitations(
                                                                  false,
                                                                  InvitationRoomData
                                                                          ?.object?[
                                                                              index]
                                                                          .invitationLink
                                                                          .toString() ??
                                                                      "");
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: _width / 2.48,
                                                          decoration:
                                                              BoxDecoration(
                                                                  // color: Color(0XFF9B9B9B),
                                                                  color: Color(
                                                                      0XFF9B9B9B),
                                                                  borderRadius:
                                                                      BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(4))),
                                                          child: Center(
                                                            child: Text(
                                                              "Reject",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          BlocProvider.of<
                                                                      InvitationCubit>(
                                                                  context)
                                                              .GetRoomInvitations(
                                                                  true,
                                                                  InvitationRoomData
                                                                          ?.object?[
                                                                              index]
                                                                          .invitationLink
                                                                          .toString() ??
                                                                      "");
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: _width / 2.48,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                            color: Color(
                                                                0xFFED1C25),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Accept",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "No Invitations For Now",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 20,
                                      color: Color(0XFFED1C25),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                          : Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 100),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(ImageConstant.loader,
                                      fit: BoxFit.cover,
                                      height: 100.0,
                                      width: 100),
                                ),
                              ),
                            ))
                  : SizedBox()
            ]),
          );
        }));
  }

  updateType() {
    arrNotiyTypeList.forEach((element) {
      element.isSelected = false;
    });
  }
}
