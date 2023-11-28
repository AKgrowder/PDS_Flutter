// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GetPostAllLike_Bloc/GetPostAllLike_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GetPostAllLike_Bloc/GetPostAllLike_state.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetPostLike_Model.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowAllPostLike extends StatefulWidget {
  String? PostID;
  ShowAllPostLike(this.PostID);

  @override
  State<ShowAllPostLike> createState() => _ShowAllPostLikeState();
}

class _ShowAllPostLikeState extends State<ShowAllPostLike> {
  GetPostLikeModel? GetPostAllLikeRoomData;
  String? User_ID;
  getLoginUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    setState(() {});
  }

  @override
  void initState() {
    getLoginUserData();
    BlocProvider.of<GetPostAllLikeCubit>(context)
        .GetPostAllLikeAPI(context, "${widget.PostID}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Post Likes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: BlocConsumer<GetPostAllLikeCubit, GetPostAllLikeState>(
            listener: (context, state) async {
          if (state is GetGuestAllPostErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is GetGuestAllPostLoadingState) {
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
          if (state is GetGuestAllPostLoadedState) {
            print(
                "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

            print(state.GetPostAllLikeRoomData.message);
            GetPostAllLikeRoomData = state.GetPostAllLikeRoomData;
          }
        }, builder: (context, state) {
          return GetPostAllLikeRoomData?.object?.length == 0 ||
                  GetPostAllLikeRoomData?.object?.isEmpty == true
              ? Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(ImageConstant.loader,
                          fit: BoxFit.cover, height: 100.0, width: 100),
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: GetPostAllLikeRoomData?.object?.length ?? 0,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 40,
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MultiBlocProvider(
                                              providers: [
                                                BlocProvider<NewProfileSCubit>(
                                                  create: (context) =>
                                                      NewProfileSCubit(),
                                                ),
                                              ],
                                              child: ProfileScreen(
                                          User_ID:
                                              "${GetPostAllLikeRoomData?.object?[index].userUid}",
                                          isFollowing:
                                              "${GetPostAllLikeRoomData?.object?[index].isFollowing}",
                                        ));
                                        }));
                           
                          },
                          child: GetPostAllLikeRoomData
                                      ?.object?[index].profilePic !=
                                  null && GetPostAllLikeRoomData
                                      ?.object?[index].profilePic != ""
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${GetPostAllLikeRoomData?.object?[index].profilePic}"),
                                 backgroundColor: Colors.white,
                                  radius: 25,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.tomcruse,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.fill,
                                  ),
                                ),

                          /* CircleAvatar(
                            backgroundImage: GetPostAllLikeRoomData
                                        ?.object?[index].profilePic !=
                                    null
                                    
                                ? NetworkImage(
                                    "${GetPostAllLikeRoomData?.object?[index].profilePic}")
                                : NetworkImage(
                                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"),
                            radius: 25,
                          ), */
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "${GetPostAllLikeRoomData?.object?[index].userName}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "outfit",
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   customFormat(
                            //       parsedDateTime),
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //     fontFamily: "outfit",
                            //   ),
                            // ),
                          ],
                        ),
                        trailing: User_ID ==
                                GetPostAllLikeRoomData?.object?[index].userUid
                            ? SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  followFunction(
                                    apiName: 'Follow',
                                    index: index,
                                  );
                                },
                                child: Container(
                                  height: 25,
                                  alignment: Alignment.center,
                                  width: 65,
                                  margin: EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                      color: Color(0xffED1C25),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: GetPostAllLikeRoomData
                                              ?.object?[index].isFollowing ==
                                          'FOLLOW'
                                      ? Text(
                                          'Follow',
                                          style: TextStyle(
                                              fontFamily: "outfit",
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      : GetPostAllLikeRoomData?.object?[index]
                                                  .isFollowing ==
                                              'REQUESTED'
                                          ? Text(
                                              'Requested',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              'Following ',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                ),
                              ),
                      ),
                    );
                  });
        }));
  }

  followFunction({String? apiName, int? index}) async {
    print("fghdfghdfgh");
    if (apiName == 'Follow') {
      print("dfhsdfhsdfhsdgf");
      await BlocProvider.of<GetPostAllLikeCubit>(context).followWIngMethod(
          GetPostAllLikeRoomData?.object?[index ?? 0].userUid, context);
      if (GetPostAllLikeRoomData?.object?[index ?? 0].isFollowing == 'FOLLOW') {
        GetPostAllLikeRoomData?.object?[index ?? 0].isFollowing = 'REQUESTED';
      } else {
        GetPostAllLikeRoomData?.object?[index ?? 0].isFollowing = 'FOLLOW';
      }
    }
  }
}
