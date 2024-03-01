// import 'package:pds/core/utils/size_utils.dart';
// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_cubit.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_state.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_state.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_cubit.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_state.dart';
import 'package:pds/API/Model/FatchAllMembers/fatchallmembers_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/dialogs/assigh_adminn_dilog.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../view_details_screen/view_details_screen.dart';

class RoomMembersScreen extends StatefulWidget {
  bool? MoveNotification;
  String room_Id;
  var roomname;
  var roomdescription;
  bool RoomOwner;
  String? CreateUserID;
  int RoomOwnerCount;

  RoomMembersScreen(
      {Key? key,
      required this.room_Id,
      this.roomname,
      this.roomdescription,
      this.CreateUserID,
      this.MoveNotification,
      required this.RoomOwner,
      required this.RoomOwnerCount})
      : super(key: key);

  @override
  State<RoomMembersScreen> createState() => _RoomMembersScreenState();
}

Map userData = {
  "userData": [
    {
      "image": "assets/images/Ellipse 6 (1).png",
    },
    {
      "image": "assets/images/Ellipse 6 (2).png",
    },
    {
      "image": "assets/images/Ellipse 6 (3).png",
    },
    {
      "image": "assets/images/Ellipse 6 (4).png",
    },
    {
      "image": "assets/images/Ellipse 6 (5).png",
    },
    {
      "image": "assets/images/Ellipse 6 (6).png",
    },
    {
      "image": "assets/images/Ellipse 6 (7).png",
    },
  ],
};

FatchAllMembersModel? _data;
String? uuID;
String? User_ID;

class _RoomMembersScreenState extends State<RoomMembersScreen> {
  @override
  void initState() {
    getUserSavedData();

    super.initState();
    print("RoomOwnerRoomOwner >>> ${widget.RoomOwner}");
  }

  getUserSavedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    BlocProvider.of<FatchAllMembersCubit>(context)
        .FatchAllMembersAPI("${widget.room_Id}", context);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.onPrimary,
          title: Text(
            "Room Members",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
            child: BlocConsumer<FatchAllMembersCubit, FatchAllMembersState>(
                listener: (context, state) {
          if (state is FatchAllMembersErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is FatchAllMembersLoadingState) {
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
          if (state is FatchAllMembersLoadedState) {
            _data = state.FatchAllMembersData;
          }
          if (state is RoomExistsLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.roomExistsModel.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }, builder: (context, state) {
          if (state is FatchAllMembersLoadedState) {
            _data = state.FatchAllMembersData;

            return Column(
              children: [
                Center(
                  child: Container(
                    height: _height / 8,
                    width: _width / 1.2,
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryLight_color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: _width / 1.85,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${widget.roomname}", maxLines: 2,
                                    // "Room Name",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 40,
                              width: _width,
                              // color: Colors.amber,
                              child: Text(
                                "${widget.roomdescription}",
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontFamily: "outfit",
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _data?.object?.roomMemberOutputDTOList?.length,
                  // itemCount: 2,

                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print(
                        'axfhsdfh-${_data?.object?.roomMemberOutputDTOList?.length}');
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 35, right: 35, top: 20),
                      child: Container(
                        height: _height / 12,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  bool? isBlock = _data?.object?.blockedUsers
                                      ?.contains(_data
                                          ?.object
                                          ?.roomMemberOutputDTOList?[index]
                                          .userUuid);

                                  print("this i want to check-${isBlock}");
                                  if (isBlock == true) {
                                    SnackBar snackBar = SnackBar(
                                      content: Text('User Blocked.'),
                                      backgroundColor:
                                          ColorConstant.primary_color,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ProfileScreen(
                                          User_ID:
                                              "${_data?.object?.roomMemberOutputDTOList?[index].userUuid}",
                                          isFollowing: "");
                                    }));
                                  }
                                },
                                child: _data
                                            ?.object
                                            ?.roomMemberOutputDTOList?[index]
                                            .userProfilePic
                                            ?.isNotEmpty ??
                                        false
                                    ? Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          CustomImageView(
                                            url:
                                                "${_data?.object?.roomMemberOutputDTOList?[index].userProfilePic}",
                                            height: 50,
                                            radius: BorderRadius.circular(25),
                                            width: 50,
                                            fit: BoxFit.fill,
                                          ),
                                          _data
                                                      ?.object
                                                      ?.roomMemberOutputDTOList?[
                                                          index]
                                                      .isExpert ==
                                                  true
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30.0),
                                                  child: Image.asset(
                                                    ImageConstant.Star,
                                                    height: 18,
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      )
                                    : Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant.tomcruse,
                                            height: 50,
                                            radius: BorderRadius.circular(25),
                                            width: 50,
                                            fit: BoxFit.fill,
                                          ),
                                          _data
                                                      ?.object
                                                      ?.roomMemberOutputDTOList?[
                                                          index]
                                                      .isExpert ==
                                                  true
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30.0),
                                                  child: Image.asset(
                                                    ImageConstant.Star,
                                                    height: 18,
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  bool? isBlock = _data?.object?.blockedUsers
                                      ?.contains(_data
                                          ?.object
                                          ?.roomMemberOutputDTOList?[index]
                                          .userUuid);

                                  print("this i want to check-${isBlock}");
                                  if (isBlock == true) {
                                    SnackBar snackBar = SnackBar(
                                      content: Text('User Blocked.'),
                                      backgroundColor:
                                          ColorConstant.primary_color,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ProfileScreen(
                                          User_ID:
                                              "${_data?.object?.roomMemberOutputDTOList?[index].userUuid}",
                                          isFollowing: "");
                                    }));
                                  }
                                },
                                child: Container(
                                  child: Text(
                                    "${_data?.object?.roomMemberOutputDTOList?[index].fullName ?? ""}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              // _data?.object?[index].isExpert == true
                              //     ? Container(
                              //         color:ColorConstant.primary_color,
                              //         height: 20,
                              //         width: 20,
                              //       )
                              //     : SizedBox(),
                              Spacer(),
                              _data?.object?.roomMemberOutputDTOList?[index]
                                          .isAdmin ==
                                      true
                                  ? Container(
                                      height: 50,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 3, left: 50),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Admin",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorConstant
                                                        .primary_color,
                                                    // fontFamily: "outfit",
                                                    // fontSize: 15,
                                                  ),
                                                )),
                                          ),
                                          User_ID ==
                                                  _data
                                                      ?.object
                                                      ?.roomMemberOutputDTOList?[
                                                          index]
                                                      .userUuid
                                              ? GestureDetector(
                                                  onTap: () {
                                                    if ((_data
                                                                ?.object
                                                                ?.roomMemberOutputDTOList
                                                                ?.length ??
                                                            0) <=
                                                        1) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Center(
                                                              child: Container(
                                                                color: Colors
                                                                    .white,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                height: 200,
                                                                width: _width,
                                                                // color: Colors.amber,
                                                                child: BlocConsumer<
                                                                    GetAllPrivateRoomCubit,
                                                                    GetAllPrivateRoomState>(
                                                                  listener:
                                                                      (context,
                                                                          state) {
                                                                    if (state
                                                                        is DeleteRoomLoadedState) {
                                                                      SnackBar
                                                                          snackBar =
                                                                          SnackBar(
                                                                        content:
                                                                            Text(state.DeleteRoom.object ??
                                                                                ""),
                                                                        backgroundColor:
                                                                            ColorConstant.primary_color,
                                                                      );
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              snackBar);

                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    return Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          "Exit Room",
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'outfit',
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Center(
                                                                            child:
                                                                                Text(
                                                                          "Are You Sure You Want To Exit This Room",
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'outfit',
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        )),
                                                                        SizedBox(
                                                                          height:
                                                                              50,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () => Navigator.pop(context),
                                                                              child: Container(
                                                                                height: 43,
                                                                                width: _width / 3.5,
                                                                                decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(10)),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "Cancel",
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'outfit',
                                                                                    fontSize: 15,
                                                                                    color: ColorConstant.primary_color,
                                                                                    fontWeight: FontWeight.w400,
                                                                                  ),
                                                                                )),
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                BlocProvider.of<GetAllPrivateRoomCubit>(context).DeleteRoomm(widget.room_Id, 'Exit', context);

                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                height: 43,
                                                                                width: _width / 3.5,
                                                                                decoration: BoxDecoration(color: ColorConstant.primary_color, borderRadius: BorderRadius.circular(10)),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "Exit",
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'outfit',
                                                                                    fontSize: 15,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w400,
                                                                                  ),
                                                                                )),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    } else {
                                                      if (widget
                                                              .RoomOwnerCount >
                                                          1) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Center(
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .white,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                  height: 200,
                                                                  width: _width,
                                                                  // color: Colors.amber,
                                                                  child: BlocConsumer<
                                                                      GetAllPrivateRoomCubit,
                                                                      GetAllPrivateRoomState>(
                                                                    listener:
                                                                        (context,
                                                                            state) {
                                                                      if (state
                                                                          is DeleteRoomLoadedState) {
                                                                        SnackBar
                                                                            snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              Text(state.DeleteRoom.object ?? ""),
                                                                          backgroundColor:
                                                                              ColorConstant.primary_color,
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);

                                                                        Navigator.pop(
                                                                            context);
                                                                      }
                                                                    },
                                                                    builder:
                                                                        (context,
                                                                            state) {
                                                                      return Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "Exit Room",
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'outfit',
                                                                              fontSize: 20,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Center(
                                                                              child: Text(
                                                                            "Are You Sure You Want To Exit This Room",
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'outfit',
                                                                              fontSize: 15,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )),
                                                                          SizedBox(
                                                                            height:
                                                                                50,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () => Navigator.pop(context),
                                                                                child: Container(
                                                                                  height: 43,
                                                                                  width: _width / 3.5,
                                                                                  decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(10)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "Cancel",
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'outfit',
                                                                                      fontSize: 15,
                                                                                      color: ColorConstant.primary_color,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                  )),
                                                                                ),
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  BlocProvider.of<GetAllPrivateRoomCubit>(context).DeleteRoomm(widget.room_Id, 'Exit', context);

                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Container(
                                                                                  height: 43,
                                                                                  width: _width / 3.5,
                                                                                  decoration: BoxDecoration(color: ColorConstant.primary_color, borderRadius: BorderRadius.circular(10)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "Exit",
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'outfit',
                                                                                      fontSize: 15,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                  )),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                AssignAdminScreenn(
                                                                  DeleteFlag:
                                                                      true,
                                                                  roomID: widget
                                                                      .room_Id,
                                                                  data: _data,
                                                                  RoomOwnerCount:
                                                                      widget
                                                                          .RoomOwnerCount,
                                                                ));
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 25,
                                                    alignment: Alignment.center,
                                                    width: 90,
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .primary_color,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child:
                                                              CustomImageView(
                                                            imagePath:
                                                                ImageConstant
                                                                    .delete,
                                                            height: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'Exit Room',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "outfit",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 75),
                                                  child: GestureDetector(
                                                    onTapDown: (details) {
                                                      print("yes i am jinal ");
                                                      _showPopupMenu(
                                                          index,
                                                          details
                                                              .globalPosition,
                                                          context);
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Container(
                                                            child:
                                                                CustomImageView(
                                                              imagePath:
                                                                  ImageConstant
                                                                      .popupimage,
                                                              height: 20,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                    )
                                  : widget.CreateUserID !=
                                          _data
                                              ?.object
                                              ?.roomMemberOutputDTOList?[index]
                                              .userUuid
                                      ? GestureDetector(
                                          onTapDown: (details) {
                                            if (widget.RoomOwner == true) {
                                              print("yes i am ankur ");
                                              _showPopupMenuWithAddOwner(
                                                  index,
                                                  details.globalPosition,
                                                  context);
                                            } else {
                                              print("yes i am meet ");
                                              _showPopupMenu(
                                                  index,
                                                  details.globalPosition,
                                                  context);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            color: Colors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Container(
                                                child: CustomImageView(
                                                  imagePath:
                                                      ImageConstant.popupimage,
                                                  height: 20,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : widget.RoomOwner == true
                                          ? Container(
                                              height: 50,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 3, left: 30),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Admin ",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorConstant
                                                                .primary_color,
                                                            // fontFamily: "outfit",
                                                            // fontSize: 15,
                                                          ),
                                                        )),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        if (widget
                                                                .RoomOwnerCount >
                                                            1) {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Center(
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .white,
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                    height: 200,
                                                                    width:
                                                                        _width,
                                                                    // color: Colors.amber,
                                                                    child: BlocConsumer<
                                                                        GetAllPrivateRoomCubit,
                                                                        GetAllPrivateRoomState>(
                                                                      listener:
                                                                          (context,
                                                                              state) {
                                                                        if (state
                                                                            is DeleteRoomLoadedState) {
                                                                          SnackBar
                                                                              snackBar =
                                                                              SnackBar(
                                                                            content:
                                                                                Text(state.DeleteRoom.object ?? ""),
                                                                            backgroundColor:
                                                                                ColorConstant.primary_color,
                                                                          );
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(snackBar);

                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      },
                                                                      builder:
                                                                          (context,
                                                                              state) {
                                                                        return Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              "Delete Room",
                                                                              style: TextStyle(
                                                                                fontFamily: 'outfit',
                                                                                fontSize: 20,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            Divider(
                                                                              color: Colors.grey,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Center(
                                                                                child: Text(
                                                                              "Are You Sure You Want To Exit This Room",
                                                                              style: TextStyle(
                                                                                fontFamily: 'outfit',
                                                                                fontSize: 15,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            )),
                                                                            SizedBox(
                                                                              height: 50,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () => Navigator.pop(context),
                                                                                  child: Container(
                                                                                    height: 43,
                                                                                    width: _width / 3.5,
                                                                                    decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(10)),
                                                                                    child: Center(
                                                                                        child: Text(
                                                                                      "Cancel",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'outfit',
                                                                                        fontSize: 15,
                                                                                        color: ColorConstant.primary_color,
                                                                                        fontWeight: FontWeight.w400,
                                                                                      ),
                                                                                    )),
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    BlocProvider.of<GetAllPrivateRoomCubit>(context).DeleteRoomm(widget.room_Id, 'Exit', context);

                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 43,
                                                                                    width: _width / 3.5,
                                                                                    decoration: BoxDecoration(color: ColorConstant.primary_color, borderRadius: BorderRadius.circular(10)),
                                                                                    child: Center(
                                                                                        child: Text(
                                                                                      "Exit",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'outfit',
                                                                                        fontSize: 15,
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.w400,
                                                                                      ),
                                                                                    )),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                        } else {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  AssignAdminScreenn(
                                                                    DeleteFlag:
                                                                        true,
                                                                    roomID: widget
                                                                        .room_Id,
                                                                    data: _data,
                                                                    RoomOwnerCount:
                                                                        widget
                                                                            .RoomOwnerCount,
                                                                  )).then((value) =>
                                                              getUserSavedData());
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        alignment:
                                                            Alignment.center,
                                                        width: 120,
                                                        margin: EdgeInsets.only(
                                                            bottom: 5),
                                                        decoration: BoxDecoration(
                                                            color: ColorConstant
                                                                .primary_color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              child:
                                                                  CustomImageView(
                                                                imagePath:
                                                                    ImageConstant
                                                                        .delete,
                                                                height: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              'Delete Room',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )
                                          : SizedBox() /* GestureDetector(
                                              onTapDown: (details) {
                                                /* _ExitRoom(
                                                    index,
                                                    details.globalPosition,
                                                    context); */
                                              },
                                              child: Container(
                                                height: 50,
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Container(
                                                    child: CustomImageView(
                                                      imagePath: ImageConstant
                                                          .popupimage,
                                                      height: 20,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ) */
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                widget.MoveNotification == true
                    ? SizedBox()
                    : widget.RoomOwner == false
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        color: Colors.white,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        height: 200,
                                        width: _width,
                                        // color: Colors.amber,
                                        child: BlocConsumer<ViewDetailsCubit,
                                            ViewDeatilsState>(
                                          listener: (context, state) {
                                            if (state is ExitUserLoadedState) {
                                              SnackBar snackBar = SnackBar(
                                                content: Text(state
                                                        .ExitUserModel
                                                        .object
                                                        ?.message ??
                                                    ""),
                                                backgroundColor:
                                                    ColorConstant.primary_color,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);

                                              Navigator.pop(context);
                                            }
                                          },
                                          builder: (context, state) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Room Exit",
                                                  style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                    child: Text(
                                                  "Are You Sure Exit This Room",
                                                  style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Container(
                                                        height: 43,
                                                        width: _width / 3.5,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                            child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'outfit',
                                                            fontSize: 15,
                                                            color: ColorConstant
                                                                .primary_color,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // BlocProvider.of<GetAllPrivateRoomCubit>(context).DeleteRoomm(widget.room_Id, context);

                                                        print("User removed!!");
                                                        BlocProvider.of<
                                                                    ViewDetailsCubit>(
                                                                context)
                                                            .ExituserAPI(
                                                          widget.room_Id,
                                                          context,
                                                        );

                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: 43,
                                                        width: _width / 3.5,
                                                        decoration: BoxDecoration(
                                                            color: ColorConstant
                                                                .primary_color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                            child: Text(
                                                          "Exit",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'outfit',
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Container(
                                height: _height / 15,
                                width: _width / 1.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomImageView(
                                        imagePath: ImageConstant.ExitRoom,
                                        height: 30,
                                        // radius: BorderRadius.circular(25),
                                        width: 30,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Exit Room",
                                        style: TextStyle(color: Colors.black),
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox()
              ],
            );
          }
          return Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(ImageConstant.loader,
                    fit: BoxFit.cover, height: 100.0, width: 100),
              ),
            ),
          );
        })));
  }

  /*  void _ExitRoom(
    int MemberIndex,
    Offset offset,
    BuildContext context,
  ) async {
    double right = offset.dx;
    double top = offset.dy;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        position: RelativeRect.fromLTRB(
          right,
          top,
          50,
          10,
        ),
        items: [
          PopupMenuItem(
              value: 0,
              onTap: () {
                print("yes i sm comming!!");
              },
              enabled: true,
              child: Container(
                width: 150,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.ExitRoom,
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Exit Room",
                        style: TextStyle(color: Colors.black),
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
              )),
        ]).then((value) async {
      if (value != null) {
        if (kDebugMode) {
          print("selected==>$value");
        }
        if (value == 0) {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 200,
                    width: _width,
                    // color: Colors.amber,
                    child: BlocConsumer<ViewDetailsCubit, ViewDeatilsState>(
                      listener: (context, state) {
                        if (state is ExitUserLoadedState) {
                          SnackBar snackBar = SnackBar(
                            content:
                                Text(state.ExitUserModel.object?.message ?? ""),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Room Exit",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                                child: Text(
                              "Are You Sure Exit This Room",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 43,
                                    width: _width / 3.5,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: ColorConstant.primary_color,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // BlocProvider.of<GetAllPrivateRoomCubit>(context).DeleteRoomm(widget.room_Id, context);

                                    print("User removed!!");
                                    BlocProvider.of<ViewDetailsCubit>(context)
                                        .ExituserAPI(
                                      widget.room_Id,
                                      context,
                                    );

                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 43,
                                    width: _width / 3.5,
                                    decoration: BoxDecoration(
                                        color: ColorConstant.primary_color,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Exit",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              });
         
        }
      }
    });
  }
  */
  void _showPopupMenu(
    int MemberIndex,
    Offset offset,
    BuildContext context,
  ) async {
    print("_showPopupMenu");
    double right = offset.dx;
    double top = offset.dy;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    await showMenu(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      position: RelativeRect.fromLTRB(
        right,
        top,
        50,
        10,
      ),
      items: widget.RoomOwner == true
          ? [
              PopupMenuItem(
                  value: 0,
                  onTap: () {
                    print("yes i sm comming!!");
                  },
                  enabled: true,
                  child: Container(
                    width: 150,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.infoimage,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "View Details",
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )),
              PopupMenuItem(
                  onTap: () {
                    print("yes i sm comming!!");
                  },
                  value: 1,
                  enabled: true,
                  child: Container(
                    width: 100,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.arrowleftimage,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Remove",
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )),
            ]
          : [
              PopupMenuItem(
                  value: 0,
                  onTap: () {
                    print("yes i sm comming!!");
                  },
                  enabled: true,
                  child: Container(
                    width: 150,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.infoimage,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "View Details",
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
    ).then((value) async {
      if (value != null) {
        if (kDebugMode) {
          print("selected==>$value");
        }
        if (value == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewDetailsScreen(
                        uuID: _data?.object
                            ?.roomMemberOutputDTOList?[MemberIndex].userUuid,
                      )));
        }
        if (value == 1) {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 200,
                    width: _width,
                    // color: Colors.amber,
                    child: BlocConsumer<ViewDetailsCubit, ViewDeatilsState>(
                      listener: (context, state) {
                        if (state is RemoveUserLoadedState) {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                                state.removeUserModel.object?.message ?? ""),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Remove",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                                child: Text(
                              "Are You Sure You Want To Remove User!",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("User removed!!");
                                    BlocProvider.of<ViewDetailsCubit>(context)
                                        .ReamoveMemberAPI(
                                      widget.room_Id,
                                      _data
                                          ?.object
                                          ?.roomMemberOutputDTOList?[
                                              MemberIndex]
                                          .userUuid,
                                      context,
                                    );
                                  },
                                  child: Container(
                                    height: 43,
                                    width: _width / 3.5,
                                    decoration: BoxDecoration(
                                        color: ColorConstant.primary_color,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Yes",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 43,
                                    width: _width / 3.5,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "No",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: ColorConstant.primary_color,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              }).then((value) async => await BlocProvider.of<
                  FatchAllMembersCubit>(context)
              .FatchAllMembersAPI("${widget.room_Id}", context));
        }
      }
    });
  }

  void _showPopupMenuWithAddOwner(
    int MemberIndex,
    Offset offset,
    BuildContext context,
  ) async {
    print("sdfjdshfsdhh-${widget.RoomOwner}");
    double right = offset.dx;
    double top = offset.dy;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    await showMenu(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      position: RelativeRect.fromLTRB(
        right,
        top,
        50,
        10,
      ),
      items: widget.RoomOwner == true
          ? [
              PopupMenuItem(
                  value: 0,
                  onTap: () {
                    print("yes i sm comming!!");
                  },
                  enabled: true,
                  child: Container(
                    width: 150,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.infoimage,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "View Details",
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )),
              PopupMenuItem(
                  value: 2,
                  onTap: () {
                    print("yes i sm comming!!");
                  },
                  enabled: true,
                  child: Container(
                    width: 190,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.AddRoomO,
                          height: 22,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Make Room Owner",
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )),
              PopupMenuItem(
                  onTap: () {
                    print("yes i sm comming!!");
                  },
                  value: 1,
                  enabled: true,
                  child: Container(
                    width: 100,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.arrowleftimage,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Remove",
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )),
            ]
          : [
              PopupMenuItem(
                  value: 0,
                  onTap: () {
                    print("yes i sm comming!!");
                  },
                  enabled: true,
                  child: Container(
                    width: 150,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.infoimage,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "View Details",
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
    ).then((value) async {
      if (value != null) {
        if (kDebugMode) {
          print("selected==>$value");
        }
        if (value == 0) {
          print(
              "object object object object object object object object object ");
          print(_data?.object?.roomMemberOutputDTOList?[MemberIndex].userUuid);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewDetailsScreen(
                        uuID: _data?.object
                            ?.roomMemberOutputDTOList?[MemberIndex].userUuid,
                      )));
        }

        if (value == 1) {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 200,
                    width: _width,
                    // color: Colors.amber,
                    child: BlocConsumer<ViewDetailsCubit, ViewDeatilsState>(
                      listener: (context, state) {
                        if (state is RemoveUserLoadedState) {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                                state.removeUserModel.object?.message ?? ""),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Remove",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                                child: Text(
                              "Are You Sure You Want To Remove User!",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("User removed!!");
                                    BlocProvider.of<ViewDetailsCubit>(context)
                                        .ReamoveMemberAPI(
                                      widget.room_Id,
                                      _data
                                          ?.object
                                          ?.roomMemberOutputDTOList?[
                                              MemberIndex]
                                          .userUuid,
                                      context,
                                    );
                                  },
                                  child: Container(
                                    height: 43,
                                    width: _width / 3.5,
                                    decoration: BoxDecoration(
                                        color: ColorConstant.primary_color,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Yes",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 43,
                                    width: _width / 3.5,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "No",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: ColorConstant.primary_color,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              }).then((value) async => await BlocProvider.of<
                  FatchAllMembersCubit>(context)
              .FatchAllMembersAPI("${widget.room_Id}", context));
        }

        if (value == 2) {
          print(
              "object object object object object object object object object ");

          BlocProvider.of<FatchAllMembersCubit>(context)
              .RoomExistsAPI(
                  _data?.object?.roomMemberOutputDTOList?[MemberIndex].userUuid,
                  widget.room_Id,
                  context)
              .then((value) async =>
                  await BlocProvider.of<FatchAllMembersCubit>(context)
                      .FatchAllMembersAPI("${widget.room_Id}", context));

          // showDialog(
          //     context: context,
          //     builder: (_) => AssignAdminScreenn(
          //           DeleteFlag: false,
          //           roomID: widget.room_Id,
          //           data: _data,
          //           RoomOwnerCount: widget.RoomOwnerCount,
          //         )).then((value) => getUserSavedData());
        }
      }
    });
  }
}
