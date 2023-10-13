// import 'package:pds/core/utils/size_utils.dart';
// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_cubit.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_state.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_cubit.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_state.dart';
import 'package:pds/API/Model/FatchAllMembers/fatchallmembers_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/add_threads/add_threads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../view_details_screen/view_details_screen.dart';

class RoomMembersScreen extends StatefulWidget {
  String room_Id;
  var roomname;
  var roomdescription;
  bool RoomOwner;
  String? CreateUserID;

  RoomMembersScreen({
    Key? key,
    required this.room_Id,
    this.roomname,
    this.roomdescription,
    this.CreateUserID,
    required this.RoomOwner,
  }) : super(key: key);

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

class _RoomMembersScreenState extends State<RoomMembersScreen> {
  @override
  void initState() {
    BlocProvider.of<FatchAllMembersCubit>(context)
        .FatchAllMembersAPI("${widget.room_Id}", context);
    super.initState();
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
            print("@@@@@@@@@@@@@@@@@@${_data?.object?.length}");
            // setState(() {});
          }
        }, builder: (context, state) {
          if (state is FatchAllMembersLoadedState) {
            _data = state.FatchAllMembersData;
            print("@@@@@@@@@@@@@@@@@@${_data?.object?.length}");
            return Column(
              children: [
                Center(
                  child: Container(
                    height: _height / 9,
                    width: _width / 1.2,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE7E7),
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
                  itemCount: _data?.object?.length,
                  // itemCount: 2,

                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print('axfhsdfh-${_data?.object?.length}');

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
                              CustomImageView(
                                url: _data?.object?[index].userProfilePic
                                            ?.isNotEmpty ??
                                        false
                                    ? "${_data?.object?[index].userProfilePic}"
                                    : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                height: 50,
                                radius: BorderRadius.circular(25),
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${_data?.object?[index].fullName ?? ""}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: "outfit",
                                    fontSize: 15),
                              ),
                              // _data?.object?[index].isExpert == true
                              //     ? Container(
                              //         color:ColorConstant.primary_color,
                              //         height: 20,
                              //         width: 20,
                              //       )
                              //     : SizedBox(),
                              Spacer(),
                              widget.CreateUserID !=
                                      _data?.object?[index].userUuid
                                  ? GestureDetector(
                                      onTapDown: (details) {
                                        _showPopupMenu(index,
                                            details.globalPosition, context);
                                      },
                                      child: Container(
                                        height: 50,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
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
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Room Owner")),
                                        )
                                      : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
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

  void _showPopupMenu(
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
          print(
              "object object object object object object object object object ");
          print(_data?.object?[MemberIndex].userUuid);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<ViewDetailsCubit>(
                    create: (context) => ViewDetailsCubit(),
                    child: ViewDetailsScreen(
                      uuID: _data?.object?[MemberIndex].userUuid,
                    )),
              ));
          // }
        }
        if (value == 1) {
          showDialog(
              context: context,
              builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<ViewDetailsCubit>(
                      create: (context) {
                        return ViewDetailsCubit();
                      },
                    ),
                    BlocProvider<FatchAllMembersCubit>(
                      create: (context) {
                        return FatchAllMembersCubit();
                      },
                    ),
                  ],
                  child: Center(
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
                              content: Text(state.removeUserModel.object ?? ""),
                              backgroundColor: ColorConstant.primary_color,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("User removed!!");
                                      BlocProvider.of<ViewDetailsCubit>(context)
                                          .ReamoveMemberAPI(
                                        widget.room_Id,
                                        _data?.object?[MemberIndex].userUuid,
                                        context,
                                      );
                                    },
                                    child: Container(
                                      height: 43,
                                      width: _width / 3.5,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFED1C25),
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
                                          color: Color(0xFFED1C25),
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
                  ),
                );
              }).then((value) async => await BlocProvider.of<
                  FatchAllMembersCubit>(context)
              .FatchAllMembersAPI("${widget.room_Id}", context));
        }
      }
    });
  }
}
