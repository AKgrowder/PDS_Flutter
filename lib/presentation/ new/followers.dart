// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/followerBlock/followBlock.dart';
import 'package:pds/API/Bloc/followerBlock/follwerState.dart';
import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pds/API/Model/GetAdminRolesForCompanyPageModel/GetAdminRolesForCompanyPageModel.dart';

class Followers extends StatefulWidget {
  String appBarName;
  String User_ID;
  String? userId;
  String? userCompanyPageUid;

  Followers(
      {required this.appBarName,
      required this.User_ID,
      required this.userId,
      this.userCompanyPageUid});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  String? User_ID;
  bool apiDataGet = false;
  FollowersClassModel? followersClassModel1;
  int? indexxCheckAllTime;
  String? User_CompnyPageModule;
  FocusNode _focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  GetAllUserListModel? getAllUserRoomData;
  bool isSerchDataGet = false;
  ScrollController scrollController = ScrollController();
  GetAdminRolesForCompanyPage? getAdminRoleForCompnyUser;
  bool isMounted = true;
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
    User_CompnyPageModule = prefs.getString(PreferencesKey.module1);
    if (widget.appBarName == 'Followers' && User_CompnyPageModule != null) {
      BlocProvider.of<FollowerBlock>(context)
          .get_admin_roles_for_company_pageMethod(context);
    }
    super.setState(() {});
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
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
            print("check Klength0${followersClassModel1?.object?.length}");

            apiDataGet = true;
          }
          if (state is FollowersClass1) {
            //get all follwing
            followersClassModel1 = state.followersClassModel1;
            print("check Klength0${followersClassModel1?.object?.length}");
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
          if (state is GetAllUserLoadedState) {
            getAllUserRoomData = state.getAllUserRoomData;
            isSerchDataGet = true;
          }
          if (state is AdminRoleForCompnyUserLoadedState) {
            print("this is the AdminRoleForCompnyUserLoadedState");
            getAdminRoleForCompnyUser = state.getAdminRoleForCompnyUser;
          }
        },
        builder: (context, state) {
          return apiDataGet == true
              ? Column(
                  children: [
                    if (widget.appBarName == 'Followers' &&
                        User_CompnyPageModule != null)
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 16, right: 16),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Color(0xffFBD8D9),
                              border: Border.all(
                                color: ColorConstant.primary_color,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            onChanged: (value) {
                              if (searchController.text.isNotEmpty) {
                                if (searchController.text.contains('#')) {
                                  SnackBar snackBar = SnackBar(
                                    content:
                                        Text('You can Only Serach userName'),
                                    backgroundColor:
                                        ColorConstant.primary_color,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  BlocProvider.of<FollowerBlock>(context)
                                      .getalluser(
                                          1, searchController.text, context);
                                }
                              } else {}
                              if (isMounted == true) {
                                if (mounted) {
                                  setState(() {});
                                }
                              }
                            },
                            focusNode: _focusNode,
                            controller: searchController,
                            cursorColor: ColorConstant.primary_color,
                            decoration: InputDecoration(
                                suffixIcon: searchController.text.isEmpty
                                    ? SizedBox()
                                    : IconButton(
                                        onPressed: () {
                                          searchController.clear();

                                          _focusNode.unfocus();
                                          super.setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        )),
                                hintText: "Search....",
                                hintStyle: TextStyle(
                                    color: ColorConstant.primary_color),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: ColorConstant.primary_color,
                                )),
                          ),
                        ),
                      ),
                    if (getAllUserRoomData?.object != null &&
                        isSerchDataGet == true)
                      serchFunction(_height, _width, getAdminRoleForCompnyUser,
                          widget.userCompanyPageUid),
                    if (getAllUserRoomData?.object == null)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                              children: List.generate(
                                  followersClassModel1?.object?.length ?? 0,
                                  (index) {
                            GlobalKey buttonKey = GlobalKey();
                            return SizedBox(
                                height: 80,
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
                                                  User_ID: followersClassModel1
                                                          ?.object?[index]
                                                          .userUid
                                                          .toString() ??
                                                      '',
                                                  isFollowing:
                                                      followersClassModel1
                                                          ?.object?[index]
                                                          .isFollow
                                                          .toString()));
                                        }));
                                      },
                                      child: followersClassModel1
                                                      ?.object?[index]
                                                      .userProfilePic !=
                                                  null &&
                                              followersClassModel1
                                                      ?.object?[index]
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
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MultiBlocProvider(
                                                    providers: [
                                                      BlocProvider<
                                                          NewProfileSCubit>(
                                                        create: (context) =>
                                                            NewProfileSCubit(),
                                                      ),
                                                    ],
                                                    child: ProfileScreen(
                                                        User_ID:
                                                            followersClassModel1
                                                                    ?.object?[
                                                                        index]
                                                                    .userUid
                                                                    .toString() ??
                                                                '',
                                                        isFollowing:
                                                            followersClassModel1
                                                                ?.object?[index]
                                                                .isFollow
                                                                .toString()));
                                              }));
                                            },
                                            child: Container(
                                              child: Text(
                                                "${followersClassModel1?.object?[index].userName}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "outfit",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
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
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        widget.appBarName == 'Followers'
                                            ? User_ID == widget.userId
                                                ? GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          "User_ID == ${User_ID}");
                                                      print(
                                                          "widget.userId == ${widget.userId}");

                                                      UserSelfRemoveFunction(
                                                          index);
                                                    },
                                                    child: Container(
                                                      height: 60,
                                                      alignment:
                                                          Alignment.center,
                                                      width: 80,
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffEFEFEF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Text(
                                                          "Remove"), //remove user self
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      folloFuction(index);
                                                    },
                                                    child: followersClassModel1
                                                                ?.object?[index]
                                                                .userUid ==
                                                            User_ID
                                                        ? SizedBox()
                                                        : Container(
                                                            height: 60,
                                                            alignment: Alignment
                                                                .center,
                                                            width: 90,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                color: ColorConstant
                                                                    .primary_color,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        10)),
                                                            child:
                                                                followersClassModel1
                                                                            ?.object?[
                                                                                index]
                                                                            .isFollow ==
                                                                        'FOLLOWING'
                                                                    ? Text(
                                                                        'Following',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "outfit",
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : followersClassModel1?.object?[index].isFollow ==
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
                                                                            'Follow',
                                                                            style: TextStyle(
                                                                                fontFamily: "outfit",
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white),
                                                                          )),
                                                  )
                                            : GestureDetector(
                                                onTap: () {
                                                  folloFuction(index);
                                                },
                                                child: followersClassModel1
                                                            ?.object?[index]
                                                            .userUid ==
                                                        User_ID
                                                    ? SizedBox()
                                                    : Container(
                                                        height: 60,
                                                        alignment:
                                                            Alignment.center,
                                                        width: 90,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: ColorConstant
                                                                .primary_color,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                        child:
                                                            followersClassModel1
                                                                        ?.object?[
                                                                            index]
                                                                        .isFollow ==
                                                                    'FOLLOWING'
                                                                ? Text(
                                                                    'Following',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                : followersClassModel1
                                                                            ?.object?[index]
                                                                            .isFollow ==
                                                                        'REQUESTED'
                                                                    ? Text(
                                                                        'Requested',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "outfit",
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : Text(
                                                                        'Follow',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "outfit",
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )),
                                              ),
                                        if (widget.appBarName == 'Followers' &&
                                            User_CompnyPageModule != null)
                                          GestureDetector(
                                              key: buttonKey,
                                              onTap: () {
                                                showPopupMenuAssingAdmin(
                                                    context,
                                                    buttonKey,
                                                    getAdminRoleForCompnyUser!,
                                                    '${followersClassModel1?.object?[index].userUid}',
                                                    widget.userCompanyPageUid
                                                        .toString());
                                              },
                                              child: Icon(Icons.more_vert))
                                      ],
                                    )));
                          })),
                        ),
                      ),
                  ],
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

  folloFuction(int index) async {
    // BlocProvider.of<FollowerBlock>(context).followWIngMethod(
    //     followersClassModel1?.object?[index].userUid, context);
    // if (widget.appBarName == 'Followers') {
    //   BlocProvider.of<FollowerBlock>(context)
    //       .getFollwerApi(context, widget.User_ID);
    // } else {
    //   BlocProvider.of<FollowerBlock>(context)
    //       .getAllFollwing(context, widget.User_ID);
    // }
    await BlocProvider.of<FollowerBlock>(context).followWIngMethod(
        followersClassModel1?.object?[index ?? 0].userUid, context);
    if (followersClassModel1?.object?[index ?? 0].isFollow == 'FOLLOW') {
      for (int i = 0; i < (followersClassModel1?.object?.length ?? 0); i++) {
        print("i-${i}");
        if (followersClassModel1?.object?[index ?? 0].userUid ==
            followersClassModel1?.object?[i].userUid) {
          followersClassModel1?.object?[i].isFollow = 'REQUESTED';
          print("check data-${followersClassModel1?.object?[i].isFollow}");
        }
      }
    } else {
      for (int i = 0; i < (followersClassModel1?.object?.length ?? 0); i++) {
        if (followersClassModel1?.object?[index ?? 0].userUid ==
            followersClassModel1?.object?[i].userUid) {
          followersClassModel1?.object?[i].isFollow = 'FOLLOW';
        }
      }
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
      /* AllGuestPostRoomData?.object?.content?[index ?? 0].isFollow =
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

  UserSelfRemoveFunction(
    index,
  ) async {
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

  serchFunction(_height, _width, getAdminRoleForCompnyUser, companyPageUid) {
    return Expanded(
        child: SingleChildScrollView(
      controller: scrollController,
      /* controller: scrollController,
        child: PaginationWidget(
          scrollController: scrollController,
          totalSize: getAllUserRoomData?.object?.totalElements,
          offSet: getAllUserRoomData?.object?.pageable?.pageNumber,
          onPagination: (p0) async {
            /* if (searchController.text.contains("#")) {
              String hashTageValue =
                  searchController.text.replaceAll("#", "%23");
              BlocProvider.of<HashTagCubit>(context)
                  .getAllPagaationApi((p0 + 1), hashTageValue.trim(), context);
            } else {
              if (searchController.text.isNotEmpty) {
                BlocProvider.of<HashTagCubit>(context).getAllPagaationApi(
                    (p0 + 1), searchController.text.trim(), context);
              }
            } */
          }, */
      child: PaginationWidget1(
        totalSize: getAllUserRoomData?.object?.totalElements,
        offSet: getAllUserRoomData?.object?.pageable?.pageNumber,
        scrollController: scrollController,
        onPagination: (p0) async {
          BlocProvider.of<FollowerBlock>(context).getAllPagaationApi(
              (p0 + 1), searchController.text.trim(), context);
        },
        items: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: getAllUserRoomData?.object?.content?.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (getAllUserRoomData
                        ?.object?.content?[index].hashtagNamesDto ==
                    null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 55,
                        width: _width / 1.1,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          SizedBox(
                            width: 8,
                          ),
                          getAllUserRoomData
                                      ?.object?.content?[index].userProfile ==
                                  null
                              ? CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Image.asset(ImageConstant.tomcruse))
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    "${getAllUserRoomData?.object?.content?[index].userProfile}",
                                  ),
                                  radius: 25,
                                ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            // color: Colors.amber,
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              "${getAllUserRoomData?.object?.content?[index].userName}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          if (getAllUserRoomData
                                  ?.object?.content?[index].isExpert ==
                              true)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Image.asset(
                                ImageConstant.Star,
                                height: 18,
                              ),
                            ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              get_admin_roles_for_company_page(
                                  context,
                                  getAdminRoleForCompnyUser,
                                  '${getAllUserRoomData?.object?.content?[index].userUid}',
                                  companyPageUid);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10),
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: ColorConstant.primary_color,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Assign to Admin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'outfit',
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                if (getAllUserRoomData
                        ?.object?.content?[index].hashtagNamesDto !=
                    null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: _width / 1.1,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: _width / 1.5,
                              child: Text(
                                "${getAllUserRoomData?.object?.content?[index].hashtagNamesDto?.hashtagName}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${getAllUserRoomData?.object?.content?[index].hashtagNamesDto?.postCount} Post",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    ));
  }
}

void get_admin_roles_for_company_page(
    BuildContext context,
    GetAdminRolesForCompanyPage getAdminRoleForCompnyUser,
    String userUid,
    String companyPageUid) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AdminRoleSelectionDialog(
        adminRoles: getAdminRoleForCompnyUser.object ?? [],
        companyPageUid: companyPageUid,
        userUid: userUid,
      );
    },
  );
}

class AdminRoleSelectionDialog extends StatefulWidget {
  final List<Object1> adminRoles;
  final String userUid;
  final String companyPageUid;
  const AdminRoleSelectionDialog(
      {Key? key,
      required this.adminRoles,
      required this.userUid,
      required this.companyPageUid})
      : super(key: key);

  @override
  _AdminRoleSelectionDialogState createState() =>
      _AdminRoleSelectionDialogState();
}

class _AdminRoleSelectionDialogState extends State<AdminRoleSelectionDialog> {
  late String _selectedRoleUid;

  @override
  void initState() {
    super.initState();

    _selectedRoleUid = widget.adminRoles
            .firstWhere((role) => role.adminRole == "Content Admin")
            .adminRoleUid ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Roles'),
      content: Container(
        height: 200,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: widget.adminRoles.length,
          itemBuilder: (context, index) {
            final role = widget.adminRoles[index];
            return RadioListTile<String>(
              activeColor: ColorConstant.primary_color,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                '${role.adminRole}',
                style: TextStyle(
                    fontFamily: 'outfit', fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '${role.roleDescription}',
                  style: TextStyle(
                      fontFamily: 'outfit', fontWeight: FontWeight.w600),
                ),
              ),
              value: '${role.adminRoleUid}',
              groupValue: _selectedRoleUid,
              onChanged: (String? value) {
                setState(() {
                  _selectedRoleUid = value!;
                });
              },
            );
          },
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("check Value -${_selectedRoleUid}");
            Map<String, dynamic> assignedUserToCompanyPage = {
              "adminRoleUid": _selectedRoleUid,
              "companyPageUid": widget.companyPageUid,
              "userUid": widget.userUid
            };
            print("check All Data Value -${assignedUserToCompanyPage}");
            Repository().assigned_user_to_company_page(
                context, assignedUserToCompanyPage);
          },
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstant.primary_color,
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

showPopupMenuAssingAdmin(
    BuildContext context,
    buttonKey,
    GetAdminRolesForCompanyPage getAdminRoleForCompnyUser,
    String useruid,
    String compnypageuid) async {
  final RenderBox button =
      buttonKey.currentContext!.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final double top = button.localToGlobal(Offset.zero, ancestor: overlay).dy;
  final double left = button.localToGlobal(Offset.zero, ancestor: overlay).dx;
  final double padding = 8.0; // Adjust the padding value as needed

  final RelativeRect position = RelativeRect.fromLTRB(
    left, // left
    top + button.size.height, // top
    left + button.size.width + padding, // right
    top + button.size.height, // bottom
  );
  showMenu(
      context: context,
      position: position,
      constraints: BoxConstraints(maxWidth: 150),
      items: <PopupMenuItem>[
        PopupMenuItem(
          value: 'Assign to Admin',
          child: GestureDetector(
            onTap: () async {
              get_admin_roles_for_company_page(
                  context, getAdminRoleForCompnyUser, useruid, compnypageuid);
            },
            child: Center(
              child: Text(
                'Assign to Admin',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ]);
}
