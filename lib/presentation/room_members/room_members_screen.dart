// import 'package:pds/core/utils/size_utils.dart';
// ignore_for_file: must_be_immutable

import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_cubit.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_state.dart';
import 'package:pds/API/Model/FatchAllMembers/fatchallmembers_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class RoomMembersScreen extends StatefulWidget {
  String room_Id;
  RoomMembersScreen({Key? key, required this.room_Id}) : super(key: key);

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
                                Text(
                                  "Room Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "outfit",
                                      fontSize: 15),
                                ),
                                _data?.object?.length == 1
                                    ? Container(
                                        width: 99,
                                        height: 27.88,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                  width: 26.88,
                                                  height: 26.87,
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .primary_color,
                                                      shape: BoxShape.circle),
                                                  child: CustomImageView(
                                                    url: _data?.object?[0]
                                                                .userProfilePic?.isNotEmpty ?? false 
                                                        ? "${_data?.object?[0].userProfilePic}"
                                                        : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                    height: 20,
                                                    radius:
                                                        BorderRadius.circular(
                                                            20),
                                                    width: 20,
                                                    fit: BoxFit.fill,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )
                                    : _data?.object?.length == 2
                                        ? Container(
                                            width: 99,
                                            height: 27.88,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Container(
                                                      width: 26.88,
                                                      height: 26.87,
                                                      decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .primary_color,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: CustomImageView(
                                                        url: _data?.object?[0]
                                                                    .userProfilePic?.isNotEmpty ?? false 
                                                            ? "${_data?.object?[0].userProfilePic}"
                                                            : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                        height: 20,
                                                        radius: BorderRadius
                                                            .circular(20),
                                                        width: 20,
                                                        fit: BoxFit.fill,
                                                      )),
                                                ),
                                                Positioned(
                                                  left: 22.56,
                                                  top: 0,
                                                  child: Container(
                                                      width: 26.88,
                                                      height: 26.87,
                                                      decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .primary_color,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: CustomImageView(
                                                        url: _data?.object?[1]
                                                                    .userProfilePic?.isNotEmpty ?? false 
                                                            ? "${_data?.object?[1].userProfilePic}"
                                                            : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                        height: 20,
                                                        radius: BorderRadius
                                                            .circular(20),
                                                        width: 20,
                                                        fit: BoxFit.fill,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        : _data?.object?.length == 3
                                            ? Container(
                                                width: 99,
                                                height: 27.88,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: 0,
                                                      child: Container(
                                                          width: 26.88,
                                                          height: 26.87,
                                                          decoration: BoxDecoration(
                                                              color: ColorConstant
                                                                  .primary_color,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child:
                                                              CustomImageView(
                                                            url: _data?.object?[0]
                                                                        .userProfilePic?.isNotEmpty ?? false 
                                                                ? "${_data?.object?[0].userProfilePic}"
                                                                : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                            height: 20,
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            width: 20,
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    Positioned(
                                                      left: 22.56,
                                                      top: 0,
                                                      child: Container(
                                                          width: 26.88,
                                                          height: 26.87,
                                                          decoration: BoxDecoration(
                                                              color: ColorConstant
                                                                  .primary_color,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child:
                                                              CustomImageView(
                                                            url: _data?.object?[1]
                                                                        .userProfilePic?.isNotEmpty ?? false 
                                                                ? "${_data?.object?[1].userProfilePic}"
                                                                : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                            height: 20,
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            width: 20,
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    Positioned(
                                                      left: 45.12,
                                                      top: 0,
                                                      child: Container(
                                                          width: 26.88,
                                                          height: 26.87,
                                                          decoration: BoxDecoration(
                                                              color: ColorConstant
                                                                  .primary_color,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child:
                                                              CustomImageView(
                                                            url: _data?.object?[2]
                                                                        .userProfilePic?.isNotEmpty ?? false 
                                                                ? "${_data?.object?[2].userProfilePic}"
                                                                : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                            height: 20,
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            width: 20,
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                width: 99,
                                                height: 27.88,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: 0,
                                                      child: Container(
                                                          width: 26.88,
                                                          height: 26.87,
                                                          decoration: BoxDecoration(
                                                              color: ColorConstant
                                                                  .primary_color,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child:
                                                              CustomImageView(
                                                            url: _data?.object?[0]
                                                                        .userProfilePic?.isNotEmpty ?? false 
                                                                ? "${_data?.object?[0].userProfilePic}"
                                                                : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                            height: 20,
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            width: 20,
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    Positioned(
                                                      left: 22.56,
                                                      top: 0,
                                                      child: Container(
                                                          width: 26.88,
                                                          height: 26.87,
                                                          decoration: BoxDecoration(
                                                              color: ColorConstant
                                                                  .primary_color,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child:
                                                              CustomImageView(
                                                            url: _data?.object?[1]
                                                                        .userProfilePic?.isNotEmpty ?? false 
                                                                ? "${_data?.object?[1].userProfilePic}"
                                                                : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                            height: 20,
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            width: 20,
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    Positioned(
                                                      left: 45.12,
                                                      top: 0,
                                                      child: Container(
                                                          width: 26.88,
                                                          height: 26.87,
                                                          decoration: BoxDecoration(
                                                              color: ColorConstant
                                                                  .primary_color,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child:
                                                              CustomImageView(
                                                            url: _data?.object?[2]
                                                                        .userProfilePic?.isNotEmpty ?? false 
                                                                ? "${_data?.object?[2].userProfilePic}"
                                                                : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                            height: 20,
                                                            radius: BorderRadius
                                                                .circular(20),
                                                            width: 20,
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    Positioned(
                                                      left: 78,
                                                      top: 7,
                                                      child: SizedBox(
                                                        width: 21,
                                                        height: 16,
                                                        child: Text(
                                                          "+${(_data?.object?.length ?? 0) - 3}",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF2A2A2A),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Outfit',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Description of the problem/Topic to be discussed here......lorem ipsum.....",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 13),
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
                              CachedNetworkImage(
                                  imageUrl:
                                      "${_data?.object?[index].userProfilePic}",
                                  placeholder: (context, url) => Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/Ellipse 6 (1).png")),
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
                              GestureDetector(
                                onTapDown: (details) {
                                  _showPopupMenu(
                                      details.globalPosition, context);
                                },
                                child: Container(
                                  height: 50,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      child: CustomImageView(
                                        imagePath: ImageConstant.popupimage,
                                        height: 20,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              )
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
    Offset offset,
    BuildContext context,
  ) async {
    double right = offset.dx;
    double top = offset.dy;

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
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ViewDetailsScreen(),
              //     ));
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
            // onTap: () {},
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
                      "Leave",
                      style: TextStyle(color: Colors.black),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
