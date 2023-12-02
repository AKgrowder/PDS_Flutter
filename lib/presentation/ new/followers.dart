// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
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
  String User_ID;

  String? userId;
  Followers(
      {required this.appBarName, required this.User_ID, required this.userId});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  String? User_ID;
  bool apiDataGet = false;
  FollowersClassModel? followersClassModel1;
  int? indexxCheckAllTime;
  @override
  void initState() {
    super.initState();
    dataGetFuntion();
    if (widget.appBarName == 'Followers') {
      BlocProvider.of<FollowerBlock>(context)
          .getFollwerApi(context, widget.User_ID);
    } else {
      BlocProvider.of<FollowerBlock>(context)
          .getAllFollwing(context, widget.User_ID);
    }
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
          if (state is FollowersClass) {
            //get all follwers
            followersClassModel1 = state.followersClassModel;

            apiDataGet = true;
          }
          if (state is FollowersClass1) {
            //get all follwing
            followersClassModel1 = state.followersClassModel1;
            apiDataGet = true;
          }
          if (state is RemoveLoddingState) {
            followersClassModel1?.object?.removeAt(indexxCheckAllTime!);

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
          return apiDataGet == true
              ? SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                          followersClassModel1?.object?.length ?? 0,
                          (index) => SizedBox(
                                height: 80,
                                child: ListTile(
                                  leading: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return MultiBlocProvider(
                                            providers: [
                                              BlocProvider<NewProfileSCubit>(
                                                create: (context) =>
                                                    NewProfileSCubit(),
                                              ),
                                            ],
                                            child: ProfileScreen(
                                                User_ID: followersClassModel1
                                                        ?.object?[index].userUid
                                                        .toString() ??
                                                    '',
                                                isFollowing:
                                                    followersClassModel1
                                                        ?.object?[index]
                                                        .isFollow
                                                        .toString()));
                                      }));
                                    },
                                    child: followersClassModel1?.object?[index]
                                                    .userProfilePic !=
                                                null &&
                                            followersClassModel1?.object?[index]
                                                    .userProfilePic !=
                                                ""
                                        ? CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                                "${followersClassModel1?.object?[index].userProfilePic}"),
                                            radius: 25,
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: AssetImage(
                                                ImageConstant.tomcruse),
                                            radius: 25,
                                          ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${followersClassModel1?.object?[index].userName}",
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${followersClassModel1?.object?[index].name}",
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
                                            if (widget.appBarName ==
                                                'Followers') {
                                              UserSelfRemoveFunction(index);
                                            } else {
                                              UserSelfRemoveFunction(index);
                                            }
                                            /*  if (widget.appBarName == 'Following') {
                                            folloFuction(index);
                                            BlocProvider.of<FollowerBlock>(
                                                    context)
                                                .getAllFollwing(
                                                    context, widget.User_ID);
                                          } else {
                                            BlocProvider.of<FollowerBlock>(
                                                    context)
                                                .removeFollwerApi(
                                                    context,
                                                    followersClassModel1
                                                            ?.object?[index]
                                                            .followerUid ??
                                                        '');
                                            BlocProvider.of<FollowerBlock>(
                                                    context)
                                                .getFollwerApi(
                                                    context, widget.User_ID);
                                          } */
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
                                            child: widget.appBarName ==
                                                    'Following'
                                                ? Text(followersClassModel1
                                                        ?.object?[index]
                                                        .isFollow
                                                        .toString()
                                                        .toLowerCase() ??
                                                    '')
                                                : Text(
                                                    "Remove"), //remove user self
                                          ),
                                        ) //
                                      : User_ID ==
                                              followersClassModel1
                                                  ?.object?[index].userUid
                                          ? GestureDetector(
                                              onTap: () {
                                                print(
                                                    "this is the match condison");
                                                /*   BlocProvider.of<FollowerBlock>(
                                                      context)
                                                  .removeFollwerApi(
                                                      context,
                                                      followersClassModel1
                                                              ?.object?[index]
                                                              .followerUid ??
                                                          '');
                                              if (widget.appBarName ==
                                                  'Followers') {
                                                BlocProvider.of<FollowerBlock>(
                                                        context)
                                                    .getFollwerApi(
                                                        context, widget.User_ID);
                                              } else {
                                                BlocProvider.of<FollowerBlock>(
                                                        context)
                                                    .getAllFollwing(
                                                        context, widget.User_ID);
                                              } */
                                              },
                                              child: SizedBox(),
                                              /*  child: Container(
                                              height: 60,
                                              alignment: Alignment.center,
                                              width: 80,
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffEFEFEF),
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: Text(
                                                  "Remove"), //remove user self
                                            ), */
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                folloFuction(index);
                                              },
                                              child: Container(
                                                  height: 60,
                                                  alignment: Alignment.center,
                                                  width: 90,
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .primary_color,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: followersClassModel1
                                                              ?.object?[index]
                                                              .isFollow ==
                                                          'FOLLOWING'
                                                      ? Text(
                                                          'Following',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "outfit",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : followersClassModel1
                                                                  ?.object?[
                                                                      index]
                                                                  .isFollow ==
                                                              'REQUESTED'
                                                          ? Text(
                                                              'Requested',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text(
                                                              'Follow',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                            ),
                                ),
                              ))),
                )
              : Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(ImageConstant.loader,
                          fit: BoxFit.cover, height: 100.0, width: 100),
                    ),
                  ),
                );
        },
      ),
    );
  }

  folloFuction(int index) {
    BlocProvider.of<FollowerBlock>(context).followWIngMethod(
        followersClassModel1?.object?[index].userUid, context);
    if (widget.appBarName == 'Followers') {
      BlocProvider.of<FollowerBlock>(context)
          .getFollwerApi(context, widget.User_ID);
    } else {
      BlocProvider.of<FollowerBlock>(context)
          .getAllFollwing(context, widget.User_ID);
    }
    /* if (followersClassModel1?.object?[index].isFollow == null) {
      if (followersClassModel1?.object?[index].userUid ==
          followersClassModel1?.object?[index].userUid) {
        followersClassModel1?.object?[index].isFollow = 'REQUESTED';
      }
    } else if (followersClassModel1?.object?[index].isFollow == 'REQUESTED') {
      if (followersClassModel1?.object?[index].userUid ==
          followersClassModel1?.object?[index].userUid) {
        followersClassModel1?.object?[index].isFollow = 'FOLLOW';
      } else {
        followersClassModel1?.object?[index].isFollow = 'REQUESTED';
      }
    } */
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

  UserSelfRemoveFunction(index) async {
    BlocProvider.of<FollowerBlock>(context).removeFollwerApi(
        context, followersClassModel1?.object?[index].followerUid ?? '');
    indexxCheckAllTime = index;

    if (widget.appBarName == 'Followers') {
      BlocProvider.of<FollowerBlock>(context)
          .getFollwerApi(context, widget.User_ID);
    } else {
      BlocProvider.of<FollowerBlock>(context)
          .getAllFollwing(context, widget.User_ID);
    }
  }
}
