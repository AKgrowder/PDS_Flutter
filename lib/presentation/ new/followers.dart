// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/followerBlock/followBlock.dart';
import 'package:pds/API/Bloc/followerBlock/follwerState.dart';
import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/theme/theme_helper.dart';

class Followers extends StatelessWidget {
  String appBarName;

  FollowersClassModel followersClassModel;
  String? userId;
  Followers(
      {required this.appBarName,
      required this.followersClassModel,
      required this.userId});
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
          appBarName,
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
        },
        builder: (context, state) {
          return Column(
              children: List.generate(
                  followersClassModel.object?.length ?? 0,
                  (index) => SizedBox(
                        height: 80,
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                          User_ID: followersClassModel
                                                  .object?[index].userUid
                                                  .toString() ??
                                              '',
                                          isFollowing: followersClassModel
                                              .object?[index].isFollow
                                              .toString())));
                            },
                            child: followersClassModel
                                        .object?[index].userProfilePic !=

                                    null && followersClassModel
                                        .object?[index].userProfilePic != ""

                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${followersClassModel.object?[index].userProfilePic}"),
                                    radius: 25,
                                  )
                                : CircleAvatar(
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
                                  "${followersClassModel.object?[index].userName}",
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
                                  "${followersClassModel.object?[index].name}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "outfit",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          trailing: followersClassModel
                                      .object?[index].isFollow ==
                                  null
                              ? GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<FollowerBlock>(context)
                                        .removeFollwerApi(
                                            context,
                                            followersClassModel.object?[index]
                                                    .followerUid ??
                                                '');
                                    followersClassModel.object?.removeAt(index);
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
                                    child: Text(
                                        "${followersClassModel.object?[index].isFollow}"),
                                  ),
                                )
                              : Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  width: 90,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: ColorConstant.primary_color,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    followersClassModel.object?[index].isFollow
                                            .toString() ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                        ),
                      )));
        },
      ),
    );
  }
}
