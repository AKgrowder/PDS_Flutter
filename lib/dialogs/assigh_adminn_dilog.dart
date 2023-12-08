import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:pds/API/Bloc/RoomExists_bloc/RoomExists_cubit.dart';
import 'package:pds/API/Bloc/RoomExists_bloc/RoomExists_state.dart';
import 'package:pds/API/Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/Model/FatchAllMembers/fatchallmembers_model.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/sharedPreferences.dart';
import '../widgets/custom_image_view.dart';

class AssignAdminScreenn extends StatefulWidget {
  String? roomID;
  FatchAllMembersModel? data;
  List<UsersList>? UserList;
  bool? RoomScreenBool;
  int RoomOwnerCount;
  bool? DeleteFlag;
  AssignAdminScreenn({
    Key? key,
    this.data,
    this.roomID,
    this.UserList,
    this.RoomScreenBool,
    required this.DeleteFlag,
    required this.RoomOwnerCount,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AssignAdminScreennState();
}

TextEditingController RateUSController = TextEditingController();

class _AssignAdminScreennState extends State<AssignAdminScreenn>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  // List<String> users = [
  //   "User 1",
  //   "User 2",
  //   "User 3",
  //   "User 4",
  //   "User 5",
  // ];
  double? rateStar = 5.0;
  var IsGuestUserEnabled;
  var GetTimeSplash;
  String? User_ID;
  @override
  void initState() {
    // setUserRating();
    super.initState();
    uuID();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  uuID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
  }

  var userRating;

  @override
  void dispose() {
    // TODO: implement dispose
    RateUSController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: _height / 1.5,
            width: _width / 1.17,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                BlocConsumer<RoomExistsCubit, RoomExistsState>(
                  listener: (context, state) {
                    if (state is RoomExistsErrorState) {
                      SnackBar snackBar = SnackBar(
                        content: Text(state.error),
                        backgroundColor: ColorConstant.primary_color,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    if (state is RoomExistsLoadedState) {
                      if (widget.DeleteFlag == true) {
                        BlocProvider.of<RoomExistsCubit>(context).DeleteRoommin(
                            widget.roomID.toString(), "Deleted", context);
                      } else {
                        SnackBar snackBar = SnackBar(
                          content:
                              Text(state.roomExistsModel.object.toString()),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      }
                    }
                    if (state is DeleteRoomLoadedState) {
                      SnackBar snackBar = SnackBar(
                        content: Text(state.DeleteRoom.object.toString()),
                        backgroundColor: ColorConstant.primary_color,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.red,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Assign Admin",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: CustomImageView(
                                      imagePath: ImageConstant.closeimage,
                                      height: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Container(
                            // height:  (widget.UserList?.length ?? 0) * 70,
                            // height: 400,
                            height: _height / 1.7,
                            width: _width / 1.25,
                            decoration: BoxDecoration(
                              // color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: widget.RoomScreenBool == true
                                ? ListView.builder(
                                    itemCount: widget.UserList?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return User_ID ==
                                              widget.UserList?[index].uuid
                                          ? SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  widget.UserList?[index]
                                                                  .userProfilePic !=
                                                              null &&
                                                          widget
                                                                  .UserList?[
                                                                      index]
                                                                  .userProfilePic
                                                                  ?.isNotEmpty ==
                                                              true
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${widget.UserList?[index].userProfilePic}"),
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 25,
                                                        )
                                                      : CircleAvatar(
                                                          radius: 25,
                                                          backgroundColor:
                                                              Colors.white,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  ImageConstant
                                                                      .tomcruse),
                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      widget.UserList?[index]
                                                              .name
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  RoomExistsCubit>(
                                                              context)
                                                          .RoomExistsAPI(
                                                              widget
                                                                  .UserList?[
                                                                      index]
                                                                  .uuid,
                                                              widget.roomID
                                                                  .toString(),
                                                              context);
                                                    },
                                                    child: Container(
                                                      width: 80,
                                                      height: 20,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Color(0xFFED1C25),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      49.46),
                                                        ),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        "Assign",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 10),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                    },
                                  )
                                : ListView.builder(
                                    itemCount: widget.data?.object?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return User_ID ==
                                              widget
                                                  .data?.object?[index].userUuid
                                          ? SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  widget.data?.object?[index]
                                                                  .userProfilePic !=
                                                              null &&
                                                          widget
                                                                  .data
                                                                  ?.object?[
                                                                      index]
                                                                  .userProfilePic
                                                                  ?.isNotEmpty ==
                                                              true
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${widget.data?.object?[index].userProfilePic}"),
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 25,
                                                        )
                                                      : CircleAvatar(
                                                          radius: 25,
                                                          backgroundColor:
                                                              Colors.white,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  ImageConstant
                                                                      .tomcruse),
                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      widget
                                                              .data
                                                              ?.object?[index]
                                                              .fullName
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  RoomExistsCubit>(
                                                              context)
                                                          .RoomExistsAPI(
                                                              widget
                                                                  .data
                                                                  ?.object?[
                                                                      index]
                                                                  .userUuid,
                                                              widget.roomID
                                                                  .toString(),
                                                              context);
                                                    },
                                                    child: Container(
                                                      width: 80,
                                                      height: 20,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Color(0xFFED1C25),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      49.46),
                                                        ),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        "Assign",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 10),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                    },
                                  ),

                            /* ListView.separated(
                              padding: const EdgeInsets.all(8),
                              itemCount: 100,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 50,
                                  width: _width,
                                  color: Colors.amber,
                                  child: Center(child: Text('Entry')),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            ), */

                            /*   child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Assign Admin",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: CustomImageView(
                                          imagePath: ImageConstant.closeimage,
                                          height: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                widget.RoomScreenBool == true
                                    ? ListView.builder(
                                        itemCount: widget.UserList?.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return User_ID ==
                                                  widget.UserList?[index].uuid
                                              ? SizedBox()
                                              : SingleChildScrollView(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        widget.UserList?[index]
                                                                        .userProfilePic !=
                                                                    null &&
                                                                widget.UserList?[index]
                                                                        .userProfilePic
                                                                        ?.isNotEmpty ==
                                                                    true
                                                            ? CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "${widget.UserList?[index].userProfilePic}"),
                                                                backgroundColor:
                                                                    Colors.white,
                                                                radius: 25,
                                                              )
                                                            : CircleAvatar(
                                                                radius: 25,
                                                                backgroundColor:
                                                                    Colors.white,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        ImageConstant
                                                                            .tomcruse),
                                                              ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                           widget.UserList?[index]
                                                                    .name
                                                                    .toString() ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            BlocProvider.of<
                                                                        RoomExistsCubit>(
                                                                    context)
                                                                .RoomExistsAPI(
                                                                    widget.UserList?[index]
                                                                        .uuid,
                                                                    widget.roomID
                                                                        .toString(),
                                                                    context);
                                                          },
                                                          child: Container(
                                                            width: 80,
                                                            height: 20,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color:
                                                                  Color(0xFFED1C25),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            49.46),
                                                              ),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              "Assign",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: Colors.white,
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 10),
                                                            )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              );
                                        },
                                      )
                                    : ListView.builder(
                                        itemCount: widget.data?.object?.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return User_ID ==
                                                  widget
                                                      .data?.object?[index].userUuid
                                              ? SizedBox()
                                              : SingleChildScrollView(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        widget.data?.object?[index]
                                                                        .userProfilePic !=
                                                                    null &&
                                                                widget
                                                                        .data
                                                                        ?.object?[
                                                                            index]
                                                                        .userProfilePic
                                                                        ?.isNotEmpty ==
                                                                    true
                                                            ? CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "${widget.data?.object?[index].userProfilePic}"),
                                                                backgroundColor:
                                                                    Colors.white,
                                                                radius: 25,
                                                              )
                                                            : CircleAvatar(
                                                                radius: 25,
                                                                backgroundColor:
                                                                    Colors.white,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        ImageConstant
                                                                            .tomcruse),
                                                              ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            widget
                                                                    .data
                                                                    ?.object?[index]
                                                                    .fullName
                                                                    .toString() ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            BlocProvider.of<
                                                                        RoomExistsCubit>(
                                                                    context)
                                                                .RoomExistsAPI(
                                                                    widget
                                                                        .data
                                                                        ?.object?[
                                                                            index]
                                                                        .userUuid,
                                                                    widget.roomID
                                                                        .toString(),
                                                                    context);
                                                          },
                                                          child: Container(
                                                            width: 80,
                                                            height: 20,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color:
                                                                  Color(0xFFED1C25),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            49.46),
                                                              ),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              "Assign",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: Colors.white,
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 10),
                                                            )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              );
                                        },
                                      ),
                                // Center(
                                //   child: Container(
                                //     width: 80,
                                //     height: 23,
                                //     padding: const EdgeInsets.only(
                                //         top: 5, left: 9, right: 8, bottom: 5),
                                //     decoration: ShapeDecoration(
                                //       color: Color(0xFFE4E4E4),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(5)),
                                //     ),
                                //     child: Row(
                                //       mainAxisSize: MainAxisSize.min,
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //       children: [
                                //         Text(
                                //           'Load More',
                                //           style: TextStyle(
                                //             color: Color(0xFFB9B9B9),
                                //             fontSize: 10,
                                //             fontFamily: 'Outfit',
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                    */
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
