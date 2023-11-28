// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/followerBlock/followBlock.dart';
import 'package:pds/API/Bloc/followerBlock/follwerState.dart';
import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Followers extends StatefulWidget {
  String appBarName;

  FollowersClassModel followersClassModel;
  String? userId;
  Followers(
      {required this.appBarName,
      required this.followersClassModel,
      required this.userId});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  String? User_ID;
  @override
  void initState() {
    super.initState();
    dataGetFuntion();
  }

  dataGetFuntion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
          widget.appBarName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: BlocConsumer<FollowerBlock, FolllwerBlockState>(
        listener: (context, state) {
          if (state is RemoveLoddingState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.remove_Follower!.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is PostLikeLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.likePost.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Column(
              children: List.generate(
                  widget.followersClassModel.object?.length ?? 0,
                  (index) => SizedBox(
                        height: 80,
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                          User_ID: widget.followersClassModel
                                                  .object?[index].userUid
                                                  .toString() ??
                                              '',
                                          isFollowing: widget
                                              .followersClassModel
                                              .object?[index]
                                              .isFollow
                                              .toString())));
                            },
                            child: widget.followersClassModel.object?[index]
                                            .userProfilePic !=
                                        null &&
                                    widget.followersClassModel.object?[index]
                                            .userProfilePic !=
                                        ""
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "${widget.followersClassModel.object?[index].userProfilePic}"),
                                    radius: 25,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        AssetImage(ImageConstant.tomcruse),
                                    radius: 25,
                                  ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "${widget.followersClassModel.object?[index].userName}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "outfit",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "${widget.followersClassModel.object?[index].name}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "outfit",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          trailing: User_ID == widget.userId
                              ? GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<FollowerBlock>(context)
                                        .removeFollwerApi(
                                            context,
                                            widget
                                                    .followersClassModel
                                                    .object?[index]
                                                    .followerUid ??
                                                '');
                                    widget.followersClassModel.object
                                        ?.removeAt(index);
                                  },
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    width: 80,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffEFEFEF),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text("Remove"), //remove user self
                                  ),
                                )
                              : User_ID ==
                                      widget.followersClassModel.object?[index]
                                          .userUid
                                  ? GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<FollowerBlock>(context)
                                            .removeFollwerApi(
                                                context,
                                                widget
                                                        .followersClassModel
                                                        .object?[index]
                                                        .followerUid ??
                                                    '');
                                        widget.followersClassModel.object
                                            ?.removeAt(index);
                                      },
                                      child: Container(
                                        height: 60,
                                        alignment: Alignment.center,
                                        width: 80,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Color(0xffEFEFEF),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child:
                                            Text("Remove"), //remove user self
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        print(
                                            "check Data--${widget.followersClassModel.object?[index].userUid}");
                                        print("dfsdfdgfg-${widget.userId}");
                                        folloFuction(index);
                                      },
                                      child: Container(
                                          height: 60,
                                          alignment: Alignment.center,
                                          width: 90,
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorConstant.primary_color,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: widget
                                                      .followersClassModel
                                                      .object?[index]
                                                      .isFollow ==
                                                  'FOLLOWING'
                                              ? Text(
                                                  'Following ',
                                                  style: TextStyle(
                                                      fontFamily: "outfit",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              : widget
                                                          .followersClassModel
                                                          .object?[index]
                                                          .isFollow ==
                                                      'REQUESTED'
                                                  ? Text(
                                                      'Requested',
                                                      style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    )
                                                  : Text(
                                                      'Follow',
                                                      style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    )),
                                    ),
                        ),
                      )));
        },
      ),
    );
  }

  folloFuction(int index) {
    BlocProvider.of<FollowerBlock>(context).followWIngMethod(
        widget.followersClassModel.object?[index].userUid, context);
    print(
        "i want check--${widget.followersClassModel.object?[index].isFollow}");
    if (widget.followersClassModel.object?[index].isFollow == null) {
      if (widget.followersClassModel.object?[index].userUid ==
          widget.followersClassModel.object?[index].userUid) {
        widget.followersClassModel.object?[index].isFollow = 'REQUESTED';
      }
    } else if( widget.followersClassModel.object?[index].isFollow == 'REQUESTED'){
      if (widget.followersClassModel.object?[index].userUid ==
          widget.followersClassModel.object?[index].userUid) {
        widget.followersClassModel.object?[index].isFollow = 'FOLLOW';
       
      }
      else{
         widget.followersClassModel.object?[index].isFollow = 'REQUESTED';
      }
    }
    /* if (widget.followersClassModel.object?[index].isFollow == 'FOLLOW') {
      /* AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing =
            'REQUESTED'; */
      for (int i = 0;
          i < (widget.followersClassModel.object?.length ?? 0);
          i++) {
        print("i-${i}");
        if (widget.followersClassModel.object?[index].userUid ==
            widget.followersClassModel.object?[i].userUid) {
          widget.followersClassModel.object?[i].isFollow = 'REQUESTED';
          print("check data-${widget.followersClassModel.object?[i].isFollow}");
        }
      }
    } else {
      /* AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing =
            'FOLLOW'; */
      for (int i = 0;
          i < (widget.followersClassModel.object?.length ?? 0);
          i++) {
        if (widget.followersClassModel.object?[index].userUid ==
            widget.followersClassModel.object?[i].userUid) {
          widget.followersClassModel.object?[i].isFollow = 'FOLLOW';
        }
      }
    } */
  }
}
