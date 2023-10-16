import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_state.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_utils.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/%20new/stroycommenwoget.dart';
import 'package:pds/presentation/Create_Post_Screen/Ceratepost_Screen.dart';
import 'package:pds/presentation/create_story/create_story.dart';
import 'package:pds/presentation/create_story/full_story_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  List a = ['1', '2', '3', '4'];
  List<String> data1 = ['Create Forum', 'Become an Expert'];
  String? uuid;
  int indexx = 0;
  String? User_ID;
  String? User_Name;
  String? User_Module;
  List<String> image = [
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
  ];
  GetGuestAllPostModel? AllGuestPostRoomData;

  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    Get_UserToken();
    getDataUserFunction();
    for (int i = 0; i < 10; i++) {
      buttonDatas.add(StoryButtonData(
        timelineBackgroundColor: Colors.grey,
        buttonDecoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/expert3.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        borderDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(60.0),
          ),
          border: Border.fromBorderSide(
            BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
        ),
        storyPages: List.generate(3, (index) {
          return FullStoryPage(
            text:
                'Want to buy a new car? Get our loan for the rest of your life!',
            imageName: 'car',
          );
        }),
        segmentDuration: const Duration(seconds: 3),
      ));
    }
    for (var buttonData in buttonDatas) {
      storyButtons.add(StoryButton(
          onPressed: (data) {
            Navigator.of(context).push(
              StoryRoute(
                storyContainerSettings: StoryContainerSettings(
                  buttonData: buttonData,
                  tapPosition: buttonData.buttonCenterPosition!,
                  curve: buttonData.pageAnimationCurve,
                  allButtonDatas: buttonDatas,
                  pageTransform: StoryPage3DTransform(),
                  storyListScrollController: ScrollController(),
                ),
                duration: buttonData.pageAnimationDuration,
              ),
            );
          },
          buttonData: buttonData,
          allButtonDatas: buttonDatas,
          storyListViewController: ScrollController()));
    }
    super.initState();
  }

  List<StoryButtonData> buttonDatas = [];
  List<StoryButton?> storyButtons = List.filled(1, null, growable: true);

  Get_UserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var Token = prefs.getString(PreferencesKey.loginJwt);
    var FCMToken = prefs.getString(PreferencesKey.fcmToken);
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    User_Name = prefs.getString(PreferencesKey.ProfileName);
    User_Module = prefs.getString(PreferencesKey.module);

    print("---------------------->> : ${FCMToken}");
    print("User Token :--- " + "${Token}");

    User_ID == null ? api() : NewApi();
  }

  api() {
    BlocProvider.of<GetGuestAllPostCubit>(context).GetGuestAllPostAPI(context);
  }

  NewApi() async {
    print("1111111111111${User_ID}");
    // /user/api/get_all_post
    BlocProvider.of<GetGuestAllPostCubit>(context).GetUserAllPostAPI(context);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    var TotleDataCount;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffED1C25),
          onPressed: () {
            if (uuid != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MultiBlocProvider(providers: [
                  BlocProvider<AddPostCubit>(
                    create: (context) => AddPostCubit(),
                  ),
                ], child: CreateNewPost());
              }));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegisterCreateAccountScreen()));
            }
          },
          child: Image.asset(
            ImageConstant.huge,
            height: 30,
          ),
          elevation: 0,
        ),
        // backgroundColor: Colors.red,
        body: BlocConsumer<GetGuestAllPostCubit, GetGuestAllPostState>(
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
            AllGuestPostRoomData = state.GetGuestAllPostRoomData;
            TotleDataCount = state.GetGuestAllPostRoomData.object?.length ?? 0;
            print(
                "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            print(TotleDataCount);
            print(AllGuestPostRoomData?.object?[0].description);
          }
        }, builder: (context, state) {
          if (state is GetGuestAllPostLoadedState) {
            TotleDataCount = state.GetGuestAllPostRoomData.object?.length ?? 0;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: double.tryParse("${300 * TotleDataCount}"),
                        // 300 * TotleDataCount,
                        child: ListView.builder(
                            primary: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) => index % 2 == 0
                                ? Transform.translate(
                                    offset: Offset(index == 0 ? -300 : -350,
                                        index == 0 ? -90 : 150),
                                    child: Container(
                                      height: 240,
                                      width: 150,
                                      margin: EdgeInsets.only(
                                          top: index == 0 ? 0 : 600),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          //  color: Colors.amber,
                                          boxShadow: [
                                            BoxShadow(
                                                // color: Colors.black,
                                                color: Color(0xffFFE9E9),
                                                blurRadius: 70,
                                                spreadRadius: 150),
                                          ]),
                                    ),
                                  )
                                : Transform.translate(
                                    offset: Offset(index == 0 ? 50 : 290, 90),
                                    child: Container(
                                      height: 190,
                                      width: 150,
                                      margin: EdgeInsets.only(top: 400),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // color: Colors.red,
                                          boxShadow: [
                                            BoxShadow(
                                                // color: Colors.red,
                                                color: Color(0xffFFE9E9),
                                                blurRadius: 70.0,
                                                spreadRadius: 110),
                                          ]),
                                    ),
                                  ))),
                      ),
                      Container(
                        height: double.tryParse("${300 * TotleDataCount}"),
                        // color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 55,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 40,
                                      child: Image.asset(
                                          ImageConstant.splashImage)),
                                  Spacer(),
                                  GestureDetector(
                                    onTapDown: (TapDownDetails details) {
                                      _showPopupMenu(
                                        details.globalPosition,
                                        context,
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffED1C25)),
                                      child: Icon(
                                        Icons.person_add_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen()));
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            ImageConstant.placeholder),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 90,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return GestureDetector(
                                      onTap: () async {
                                        if (Platform.isAndroid) {
                                          final info = await DeviceInfoPlugin()
                                              .androidInfo;
                                          if (num.parse(await info
                                                      .version.release)
                                                  .toInt() >=
                                              13) {
                                            if (await permissionHandler(context,
                                                    Permission.photos) ??
                                                false) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CreateStoryPage()));
                                            }
                                          } else if (await permissionHandler(
                                                  context,
                                                  Permission.storage) ??
                                              false) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        CreateStoryPage()));
                                          }
                                        }
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          DottedBorder(
                                            borderType: BorderType.Circle,
                                            dashPattern: [5, 5, 5, 5],
                                            color: ColorConstant.primary_color,
                                            child: Container(
                                              height: 67,
                                              width: 67,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0x4CED1C25)),
                                              child: Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                color:
                                                    ColorConstant.primary_color,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Share Story',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: storyButtons[index]!,
                                            flex: 1,
                                          ),
                                          Text(
                                            'Jones $index',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 8,
                                  );
                                },
                                itemCount: storyButtons.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                primary: true,
                                itemCount:
                                    AllGuestPostRoomData?.object?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  DateTime parsedDateTime = DateTime.parse(
                                      '${AllGuestPostRoomData?.object?[index].createdAt ?? ""}');
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.25)),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      // height: 300,
                                      width: _width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 50,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage: AllGuestPostRoomData
                                                            ?.object?[index]
                                                            .userProfilePic !=
                                                        null
                                                    ? NetworkImage(
                                                        "${AllGuestPostRoomData?.object?[index].userProfilePic}")
                                                    : NetworkImage(
                                                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"),
                                                radius: 25,
                                              ),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    "${AllGuestPostRoomData?.object?[index].postUserName}",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: "outfit",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    customFormat(
                                                        parsedDateTime),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "outfit",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailing: Container(
                                                height: 25,
                                                alignment: Alignment.center,
                                                width: 65,
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffED1C25),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: AllGuestPostRoomData
                                                            ?.object?[index]
                                                            .isFollowing ==
                                                        false
                                                    ? Text(
                                                        'Follow',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        'Following',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: Text(
                                              '${AllGuestPostRoomData?.object?[index].description}',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          // index == 0
                                          AllGuestPostRoomData?.object?[index]
                                                      .postType ==
                                                  "IMAGE"
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16,
                                                      top: 15,
                                                      right: 16),
                                                  child: Center(
                                                      child: CustomImageView(
                                                    url:
                                                        "${AllGuestPostRoomData?.object?[index].postData}",
                                                  ) /*  Image.asset(
                                                        ImageConstant
                                                            .placeholder), */
                                                      ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 13),
                                                  child: Divider(
                                                    thickness: 1,
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3, right: 16),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                Image.asset(
                                                  ImageConstant.thumShup,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${AllGuestPostRoomData?.object?[index].likedCount}",
                                                  style: TextStyle(
                                                      fontFamily: "outfit",
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  width: 18,
                                                ),
                                                Image.asset(
                                                  ImageConstant.meesage,
                                                  height: 14,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${AllGuestPostRoomData?.object?[index].commentCount}",
                                                  style: TextStyle(
                                                      fontFamily: "outfit",
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  width: 18,
                                                ),
                                                Image.asset(
                                                  ImageConstant.vector2,
                                                  height: 12,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '1335',
                                                  style: TextStyle(
                                                      fontFamily: "outfit",
                                                      fontSize: 14),
                                                ),
                                                Spacer(),
                                                Image.asset(
                                                  AllGuestPostRoomData
                                                              ?.object?[index]
                                                              .isSaved ==
                                                          false
                                                      ? ImageConstant.savePin
                                                      : ImageConstant.Savefill,
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  if (index == 1) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Experts',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                                height: 20,
                                                child: Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: Colors.black,
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 230,
                                          width: _width,
                                          child: ListView.builder(
                                            itemCount: image.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 170,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  width: 3,
                                                                  color: Color(
                                                                      0xffED1C25),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14)),
                                                        child: Image.asset(
                                                          image[index],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    top: 15,
                                                    left: 30,
                                                    child: Container(
                                                      height: 24,
                                                      alignment:
                                                          Alignment.center,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8),
                                                        ),
                                                        color: Color.fromRGBO(
                                                            237, 28, 37, 0.5),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .person_add_alt,
                                                            size: 16,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            'Follow',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "outfit",
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 55,
                                                    /*  right: 2,
                                                left: 2, */
                                                    left: 14,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 115,
                                                        color:
                                                            Color(0xffED1C25),
                                                        child: Text(
                                                          'Invite',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "outfit",
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 70,
                                                    left: 15,
                                                    child: Container(
                                                      height: 40,
                                                      width: 115,
                                                      // color: Colors.amber,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Kriston Watshon",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        "outfit",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              Image.asset(
                                                                ImageConstant
                                                                    .Star,
                                                                height: 11,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              SizedBox(
                                                                  height: 14,
                                                                  child: Image.asset(
                                                                      ImageConstant
                                                                          .beg)),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(
                                                                'Expertise in....',
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "outfit",
                                                                    fontSize:
                                                                        11,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  if (index == 4) {
                                    print("index check$index");
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Blogs',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                                height: 20,
                                                child: Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: Colors.black,
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: _height / 3.23,
                                          width: _width,
                                          margin: EdgeInsets.only(bottom: 15),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                height: 220,
                                                width: _width / 1.6,
                                                margin: EdgeInsets.only(
                                                    left: 10, top: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        // color: Colors.black,
                                                        color:
                                                            Color(0xffF1F1F1),
                                                        width: 5)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      ImageConstant.rendom,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 9, top: 7),
                                                      child: Text(
                                                        'Baluran Wild The Savvanah',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontFamily:
                                                                "outfit",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 3),
                                                          child: Text(
                                                            '27th June 2020 10:47 pm',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "outfit",
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xffABABAB)),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 6,
                                                          width: 7,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5,
                                                                  left: 2),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffABABAB)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 4,
                                                                  left: 1),
                                                          child: Text(
                                                            '12.3K Views',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Color(
                                                                    0xffABABAB)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 7,
                                                                  top: 4),
                                                          child: index != 0
                                                              ? Icon(Icons
                                                                  .favorite_border)
                                                              : Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                        ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2),
                                                            child: Image.asset(
                                                                ImageConstant
                                                                    .arrowright),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        SizedBox(
                                                          height: 35,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 6),
                                                            child: Image.asset(
                                                                ImageConstant
                                                                    .blogunsaveimage),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return SizedBox(
                                      height: 30,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        //  color: const Color.fromARGB(88, 76, 175, 79),
                      )
                    ],
                  ),
                ],
              ),
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
        }));
  }

  void _showPopupMenu(
    Offset position,
    BuildContext context,
  ) async {
    List<String> ankur = ["Create Forum", "Become an Expert"];
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final selectedOption = await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        position: RelativeRect.fromRect(
          position & const Size(40, 40),
          Offset.zero & overlay.size,
        ),
        items: List.generate(
            ankur.length,
            (index) => PopupMenuItem(
                onTap: () {
                  setState(() {
                    indexx = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: indexx == index
                          ? Color(0xffED1C25)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      ankur[index],
                      style: TextStyle(
                          color: indexx == index ? Colors.white : Colors.black),
                    ),
                  ),
                ))));
  }

  String customFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$time';
    return formattedDate;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'st January';
      case 2:
        return 'nd February';
      case 3:
        return 'rd March';
      case 4:
        return 'th April';
      case 5:
        return 'th May';
      case 6:
        return 'th June';
      case 7:
        return 'th July';
      case 8:
        return 'th August';
      case 9:
        return 'th September';
      case 10:
        return 'th October';
      case 11:
        return 'th November';
      case 12:
        return 'th December';
      default:
        return '';
    }
  }

  getDataUserFunction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uuid = prefs.getString(
      PreferencesKey.loginUserID,
    );
    setState(() {});
  }
}
