import 'dart:io';
import 'package:pds/API/Bloc/CreateStory_Bloc/CreateStory_Cubit.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/CreateStory_Bloc/CreateStory_state.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_state.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Bloc/postData_Bloc/postData_Bloc.dart';
import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';
import 'package:pds/API/Model/CreateStory_Model/CreateStory_model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_utils.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/Create_Post_Screen/Ceratepost_Screen.dart';
import 'package:pds/presentation/create_story/create_story.dart';
import 'package:pds/presentation/create_story/full_story_page.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GetPostAllLike_Bloc/GetPostAllLike_cubit.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comments_screen.dart';

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
  LikePost? likePost;
  GetGuestAllPostModel? AllGuestPostRoomData;
  ScrollController scrollController = ScrollController();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool showDraggableSheet = false;
  bool storyAdded = false;
  BuildContext? storycontext;
  List<Widget> storyPagedata = [];

  @override
  void initState() {
    Get_UserToken();

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
    storycontext = context;

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
    uuid = prefs.getString(PreferencesKey.loginUserID);

    print("---------------------->> : ${FCMToken}");
    print("User Token :--- " + "${Token}");

    User_ID == null ? api() : NewApi();
  }

  api() async {
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .GetGuestAllPostAPI(context);
  }

  NewApi() async {
    print("1111111111111${User_ID}");
    // /user/api/get_all_post
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .GetUserAllPostAPI(context, '1', showAlert: true);
    await BlocProvider.of<GetGuestAllPostCubit>(context).get_all_story(
      context,
    );
  }

  loginFunction({String? apiName, int? index}) async {
    if (uuid == null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } else if (apiName == 'Follow') {
      await BlocProvider.of<GetGuestAllPostCubit>(context).followWIngMethod(
          AllGuestPostRoomData?.object?.content?[index ?? 0].userUid, context);

      if (AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing ==
          true) {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing = false;
      } else {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing = true;
      }
      AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing = true;
    } else if (apiName == 'like_post') {
      await BlocProvider.of<GetGuestAllPostCubit>(context).like_post(
          AllGuestPostRoomData?.object?.content?[index ?? 0].postUid, context);
      print(
          "isLiked-->${AllGuestPostRoomData?.object?.content?[index ?? 0].isLiked}");
      if (AllGuestPostRoomData?.object?.content?[index ?? 0].isLiked == true) {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isLiked = false;
        int a =
            AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount ?? 0;
        int b = 1;
        AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount = a - b;
      } else {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isLiked = true;
        AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount;
        int a =
            AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount ?? 0;
        int b = 1;
        AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount = a + b;
      }
    } else if (apiName == 'savedata') {
      await BlocProvider.of<GetGuestAllPostCubit>(context).savedData(
          AllGuestPostRoomData?.object?.content?[index ?? 0].postUid, context);

      if (AllGuestPostRoomData?.object?.content?[index ?? 0].isSaved == true) {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isSaved = false;
      } else {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isSaved = true;
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    }
  }

  methodtoReffrser() {
    User_ID == null ? api() : NewApi();
  }

  @override
  Widget build(BuildContext context) {
    methodtoReffrser();
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    var TotleDataCount;
    bool apiCalingdone = false;

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
              })).then((value) => Get_UserToken());
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
          if (state is GetAllStoryLoadedState) {
                   
            SnackBar snackBar = SnackBar(
              content: Text(state.getAllStoryModel.message.toString()),
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
            TotleDataCount =
                state.GetGuestAllPostRoomData.object?.content?.length ?? 0;
            print(
                "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            print(TotleDataCount);
            print(AllGuestPostRoomData?.object?.content?[0].description);
            apiCalingdone = true;
          }
          if (state is PostLikeLoadedState) {
            likePost = state.likePost;
          }
        }, builder: (context, state) {
          print("TotleDataCount-->$TotleDataCount");
          return apiCalingdone == true
              ? SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
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
                                child: Image.asset(ImageConstant.splashImage)),
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
                                        builder: (context) => ProfileScreen()));
                              },
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ImageConstant.placeholder),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 90,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              if (!storyAdded)
                                return GestureDetector(
                                  onTap: () async {
                                    ImageDataPost? imageDataPost;
                                    if (Platform.isAndroid) {
                                      final info =
                                          await DeviceInfoPlugin().androidInfo;
                                      if (num.parse(await info.version.release)
                                              .toInt() >=
                                          13) {
                                        if (await permissionHandler(
                                                context, Permission.photos) ??
                                            false) {
                                          imageDataPost = await Navigator.push(
                                              context, MaterialPageRoute(
                                                  builder: (context) {
                                            return MultiBlocProvider(
                                              providers: [
                                                BlocProvider<CreateStoryCubit>(
                                                  create: (context) =>
                                                      CreateStoryCubit(),
                                                )
                                              ],
                                              child: CreateStoryPage(),
                                            );
                                          }));
                                        }
                                      } else if (await permissionHandler(
                                              context, Permission.storage) ??
                                          false) {
                                        imageDataPost = await Navigator.push(
                                            context, MaterialPageRoute(
                                                builder: (context) {
                                          return MultiBlocProvider(
                                            providers: [
                                              BlocProvider<CreateStoryCubit>(
                                                create: (context) =>
                                                    CreateStoryCubit(),
                                              )
                                            ],
                                            child: CreateStoryPage(),
                                          );
                                        }));
                                      }
                                    }
                                    print(
                                        "imageDataPost?.object-->${imageDataPost?.object}");
                                    if (imageDataPost?.object != null) {
                                      print("else condison working");
                                      StoryButtonData buttonData =
                                          StoryButtonData(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                        storyPages: [
                                          FullStoryPage(
                                            imageName:
                                                '${imageDataPost?.object.toString()}',
                                          )
                                        ],
                                        segmentDuration:
                                            const Duration(seconds: 3),
                                      );
                                      buttonDatas.insert(0, buttonData);
                                      storyButtons[0] = StoryButton(
                                          onPressed: (data) {
                                            Navigator.of(storycontext!).push(
                                              StoryRoute(
                                                storyContainerSettings:
                                                    StoryContainerSettings(
                                                  buttonData: buttonData,
                                                  tapPosition: buttonData
                                                      .buttonCenterPosition!,
                                                  curve: buttonData
                                                      .pageAnimationCurve,
                                                  allButtonDatas: buttonDatas,
                                                  pageTransform:
                                                      StoryPage3DTransform(),
                                                  storyListScrollController:
                                                      ScrollController(),
                                                ),
                                                duration: buttonData
                                                    .pageAnimationDuration,
                                              ),
                                            );
                                          },
                                          buttonData: buttonData,
                                          allButtonDatas: buttonDatas,
                                          storyListViewController:
                                              ScrollController());
                                      if (mounted)
                                        setState(() {
                                          storyAdded = true;
                                        });
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
                                            Icons.add_circle_outline_rounded,
                                            color: ColorConstant.primary_color,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Share Story',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      )
                                    ],
                                  ),
                                );
                              else
                                return SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            storyButtons[index]!,
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  ImageDataPost? imageDataPost;
                                                  if (Platform.isAndroid) {
                                                    final info =
                                                        await DeviceInfoPlugin()
                                                            .androidInfo;
                                                    if (num.parse(await info
                                                                .version
                                                                .release)
                                                            .toInt() >=
                                                        13) {
                                                      if (await permissionHandler(
                                                              context,
                                                              Permission
                                                                  .photos) ??
                                                          false) {
                                                        imageDataPost =
                                                            await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                          return MultiBlocProvider(
                                                            providers: [
                                                              BlocProvider<
                                                                  CreateStoryCubit>(
                                                                create: (context) =>
                                                                    CreateStoryCubit(),
                                                              )
                                                            ],
                                                            child:
                                                                CreateStoryPage(),
                                                          );
                                                        }));
                                                      }
                                                    } else if (await permissionHandler(
                                                            context,
                                                            Permission
                                                                .storage) ??
                                                        false) {
                                                      imageDataPost =
                                                          await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                        return MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider<
                                                                CreateStoryCubit>(
                                                              create: (context) =>
                                                                  CreateStoryCubit(),
                                                            )
                                                          ],
                                                          child:
                                                              CreateStoryPage(),
                                                        );
                                                      }));
                                                    }
                                                  }

                                                  if (imageDataPost?.object !=
                                                      null) {
                                                    buttonDatas[0]
                                                        .storyPages
                                                        .add(FullStoryPage(
                                                          imageName:
                                                              '${imageDataPost?.object}',
                                                        ));
                                                    if (mounted)
                                                      setState(() {
                                                        storyAdded = true;
                                                      });
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    Icons.add_circle_rounded,
                                                    color: ColorConstant
                                                        .primary_color,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        flex: 1,
                                      ),
                                      Text(
                                        'Jones $index',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
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
                                          color: Colors.black, fontSize: 16),
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
                      AllGuestPostRoomData?.object?.content?.length == 0 ||
                              AllGuestPostRoomData
                                      ?.object?.content?.isNotEmpty ==
                                  true
                          ? PaginationWidget(
                              scrollController: scrollController,
                              totalSize:
                                  AllGuestPostRoomData?.object?.totalElements,
                              offSet: AllGuestPostRoomData
                                  ?.object?.pageable?.pageNumber,
                              onPagination: ((p0) async {
                                await BlocProvider.of<GetGuestAllPostCubit>(
                                        context)
                                    .GetUserAllPostAPIPagantion(
                                        context, (p0 + 1).toString(),
                                        showAlert: true);
                              }),
                              items: ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: AllGuestPostRoomData
                                        ?.object?.content?.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  DateTime parsedDateTime = DateTime.parse(
                                      '${AllGuestPostRoomData?.object?.content?[index].createdAt ?? ""}');
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
                                                            ?.object
                                                            ?.content?[index]
                                                            .userProfilePic !=
                                                        null
                                                    ? NetworkImage(
                                                        "${AllGuestPostRoomData?.object?.content?[index].userProfilePic}")
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
                                                    "${AllGuestPostRoomData?.object?.content?[index].postUserName}",
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
                                              trailing: User_ID ==
                                                      AllGuestPostRoomData
                                                          ?.object
                                                          ?.content?[index]
                                                          .userUid
                                                  ? SizedBox()
                                                  : GestureDetector(
                                                      onTap: () async {
                                                        await loginFunction(
                                                            apiName: 'Follow',
                                                            index: index);
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        alignment:
                                                            Alignment.center,
                                                        width: 65,
                                                        margin: EdgeInsets.only(
                                                            bottom: 5),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffED1C25),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: AllGuestPostRoomData
                                                                    ?.object
                                                                    ?.content?[
                                                                        index]
                                                                    .isFollowing ==
                                                                false
                                                            ? Text(
                                                                'Follow',
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
                                                            : Text(
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
                                                              ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          AllGuestPostRoomData
                                                      ?.object
                                                      ?.content?[index]
                                                      .description !=
                                                  null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Text(
                                                    '${AllGuestPostRoomData?.object?.content?[index].description}',
                                                    style: TextStyle(
                                                        fontFamily: "outfit",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                )
                                              : SizedBox(),
                                          // index == 0
                                          AllGuestPostRoomData
                                                      ?.object
                                                      ?.content?[index]
                                                      .postDataType ==
                                                  null
                                              ? SizedBox()
                                              : AllGuestPostRoomData
                                                          ?.object
                                                          ?.content?[index]
                                                          .postDataType ==
                                                      "IMAGE"
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          left: 16,
                                                          top: 15,
                                                          right: 16),
                                                      child: Center(
                                                          child:
                                                              CustomImageView(
                                                        url:
                                                            "${AllGuestPostRoomData?.object?.content?[index].postData}",
                                                      ) /*  Image.asset(
                                            ImageConstant
                                                .placeholder), */
                                                          ),
                                                    )
                                                  : Container(
                                                      margin: EdgeInsets.only(
                                                          left: 16,
                                                          top: 15,
                                                          right: 16),
                                                      child: Center(
                                                        child: Image.asset(
                                                            ImageConstant
                                                                .placeholder),
                                                      ),
                                                    ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 13),
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
                                                GestureDetector(
                                                  onTap: () async {
                                                    await loginFunction(
                                                        apiName: 'like_post',
                                                        index: index);
                                                  },
                                                  child: AllGuestPostRoomData
                                                              ?.object
                                                              ?.content?[index]
                                                              .isLiked !=
                                                          true
                                                      ? Image.asset(
                                                          ImageConstant
                                                              .likewithout,
                                                          height: 20,
                                                        )
                                                      : Image.asset(
                                                          ImageConstant.like,
                                                          height: 20,
                                                        ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                
                                                    ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */

                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  GetPostAllLikeCubit(),
                                                            ),
                                                          ],
                                                          child: ShowAllPostLike(
                                                              "${AllGuestPostRoomData?.object?.content?[index].postUid}"),
                                                        );
                                                      },
                                                    ));
                                                  },
                                                  child: Text(
                                                    "${AllGuestPostRoomData?.object?.content?[index].likedCount}",
                                                    style: TextStyle(
                                                        fontFamily: "outfit",
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 18,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider<
                                                                AddcommentCubit>(
                                                              create: (context) =>
                                                                  AddcommentCubit(),
                                                            ),
                                                          ],
                                                          child: CommentsScreen(
                                                            image: AllGuestPostRoomData
                                                                ?.object
                                                                ?.content?[
                                                                    index]
                                                                .userProfilePic,
                                                            userName:
                                                                AllGuestPostRoomData
                                                                    ?.object
                                                                    ?.content?[
                                                                        index]
                                                                    .postUserName,
                                                            description:
                                                                AllGuestPostRoomData
                                                                    ?.object
                                                                    ?.content?[
                                                                        index]
                                                                    .description,
                                                            PostUID:
                                                                '${AllGuestPostRoomData?.object?.content?[index].postUid}',
                                                            date: AllGuestPostRoomData
                                                                    ?.object
                                                                    ?.content?[
                                                                        index]
                                                                    .createdAt ??
                                                                "",
                                                          ));
                                                    }));
                                                  },
                                                  child: Image.asset(
                                                    ImageConstant.meesage,
                                                    height: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${AllGuestPostRoomData?.object?.content?[index].commentCount}",
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
                                                GestureDetector(
                                                  onTap: () async {
                                                    await loginFunction(
                                                        apiName: 'savedata',
                                                        index: index);
                                                  },
                                                  child: Image.asset(
                                                    AllGuestPostRoomData
                                                                ?.object
                                                                ?.content?[
                                                                    index]
                                                                .isSaved ==
                                                            false
                                                        ? ImageConstant.savePin
                                                        : ImageConstant
                                                            .Savefill,
                                                    height: 16,
                                                  ),
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
                            )
                          : SizedBox(),
                    ],
                  ),
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

          /* Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(ImageConstant.loader,
                    fit: BoxFit.cover, height: 100.0, width: 100),
              ),
            ),
          ); */
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
}
