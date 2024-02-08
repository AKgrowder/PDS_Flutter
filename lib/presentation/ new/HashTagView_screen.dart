import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_state.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/OpenSavePostImage.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comment_bottom_sheet.dart';
import 'package:pds/presentation/%20new/home_screen_new.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import '../../API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import '../../API/Model/HashTage_Model/HashTagView_model.dart';
import '../../API/Model/UserTagModel/UserTag_model.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../widgets/custom_image_view.dart';
import '../register_create_account_screen/register_create_account_screen.dart';
import 'RePost_Screen.dart';

class HashTagViewScreen extends StatefulWidget {
  String? title;
  HashTagViewScreen({Key? key, this.title}) : super(key: key);

  @override
  State<HashTagViewScreen> createState() => _HashTagViewScreenState();
}

class _HashTagViewScreenState extends State<HashTagViewScreen> {
  final ScrollController scroll = ScrollController();
  HashtagViewDataModel? hashTagViewData;
  DateTime? parsedDateTime;
  String? uuid;
  int indexx = 0;
  GetGuestAllPostModel? AllGuestPostRoomData;
  List<PageController> _pageControllers = [];
  List<int> _currentPages = [];
  int imageCount = 1;
  UserTagModel? userTagModel;
  @override
  void initState() {
    super.initState();
    Get_UserToken();
    BlocProvider.of<HashTagCubit>(context)
        .HashTagViewDataAPI(context, widget.title.toString());
  }

  Get_UserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uuid = prefs.getString(PreferencesKey.loginUserID);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   elevation: 1,
          //   backgroundColor: Colors.white,
          //   leading: GestureDetector(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       child: Icon(
          //         Icons.arrow_back,
          //         color: Colors.grey,
          //       )),
          //   title: Row(
          //     children: [
          //       Image.asset(
          //         ImageConstant.hashTagimg,
          //         height: 45,
          //         width: 45,
          //       ),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       Text(
          //         "${widget.title}",
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 18,
          //             fontWeight: FontWeight.w500),
          //       )
          //     ],
          //   ),
          // ),
          body: BlocConsumer<HashTagCubit, HashTagState>(
        listener: (context, state) async {
          if (state is HashTagErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is HashTagViewDataLoadedState) {
            hashTagViewData = state.HashTagViewData;
            print("HashTagViewDataLoadedState${hashTagViewData}");
          }
          if (state is PostLikeLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.likePost.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            BlocProvider.of<HashTagCubit>(context)
                .HashTagViewDataAPI(context, widget.title.toString());
          }
          if (state is UserTagHashTagLoadedState) {
            userTagModel = await state.userTagModel;
            print("hey i am comming in profilr screen !!");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfileScreen(
                  User_ID: "${userTagModel?.object}", isFollowing: "");
            }));
          }
        },
        builder: (context, state) {
          if (state is HashTagLoadingState) {
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
          }
          return Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                          )),
                    ),
                    Image.asset(
                      ImageConstant.hashTagimg,
                      height: 45,
                      width: 45,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        "${widget.title}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: hashTagViewData?.object?.posts?.length,
                      itemBuilder: (context, index) {
                        hashTagViewData?.object?.posts?[index].postData
                            ?.forEach((element) {
                          _pageControllers.add(PageController());
                          _currentPages.add(0);
                        });
                        parsedDateTime = DateTime.parse(
                            '${hashTagViewData?.object?.posts?[index].createdAt ?? ""}');
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              // margin: EdgeInsets.all(10),
                              // height: (hashTagViewData
                              //             ?.object?.posts?[index].postData?.isEmpty ??
                              //         false)
                              //     ? 180
                              //     : 400,
                              width: _width,
                              decoration: ShapeDecoration(
                                // color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFD3D3D3)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: ListTile(
                                      leading: GestureDetector(
                                        onTap: () {
                                          if (uuid == null) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterCreateAccountScreen()));
                                          } else {
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
                                                          "${hashTagViewData?.object?.posts?[index].userUid}",
                                                      isFollowing:
                                                          hashTagViewData
                                                              ?.object
                                                              ?.posts?[index]
                                                              .isFollowing));
                                            }));
                                          }
                                        },
                                        child: hashTagViewData
                                                        ?.object
                                                        ?.posts?[index]
                                                        .userProfilePic !=
                                                    null &&
                                                hashTagViewData
                                                        ?.object
                                                        ?.posts?[index]
                                                        .userProfilePic !=
                                                    ""
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    "${hashTagViewData?.object?.posts?[index].userProfilePic}"),
                                                backgroundColor: Colors.white,
                                                radius: 25,
                                              )
                                            : CircleAvatar(
                                                backgroundColor: Colors.white,
                                                backgroundImage: AssetImage(
                                                    ImageConstant.tomcruse),
                                              ),
                                      ),
                                      title: GestureDetector(
                                        onTap: () {
                                          if (uuid == null) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterCreateAccountScreen()));
                                          } else {
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
                                                          "${hashTagViewData?.object?.posts?[index].userUid}",
                                                      isFollowing:
                                                          hashTagViewData
                                                              ?.object
                                                              ?.posts?[index]
                                                              .isFollowing));
                                            }));
                                          }
                                        },
                                        child: Container(
                                          child: Text(
                                            "${hashTagViewData?.object?.posts?[index].postUserName}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'outfit',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                        customFormat(parsedDateTime!),
                                        style: TextStyle(
                                          color: Color(0xFF8F8F8F),
                                          fontSize: 12,
                                          fontFamily: 'outfit',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      trailing: uuid ==
                                              hashTagViewData?.object
                                                  ?.posts?[index].userUid
                                          ? GestureDetector(
                                              onTapDown:
                                                  (TapDownDetails details) {
                                                delete_dilog_menu(
                                                  details.globalPosition,
                                                  context,
                                                );
                                              },
                                              child: Icon(
                                                Icons.more_vert_rounded,
                                              ))
                                          : GestureDetector(
                                              onTap: () async {
                                                await soicalFunation(
                                                    apiName: 'Follow',
                                                    index: index);
                                              },
                                              child: Container(
                                                height: 25,
                                                alignment: Alignment.center,
                                                width: 65,
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: ColorConstant
                                                        .primary_color,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: hashTagViewData
                                                            ?.object
                                                            ?.posts?[index]
                                                            .isFollowing ==
                                                        'FOLLOW'
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
                                                    : hashTagViewData
                                                                ?.object
                                                                ?.posts?[index]
                                                                .isFollowing ==
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
                                                            'Following ',
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
                                              ),
                                            ),
                                    ),
                                  ),
                                  hashTagViewData?.object?.posts?[index]
                                              .description !=
                                          null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: LinkifyText(
                                              "${hashTagViewData?.object?.posts?[index].description}",
                                              linkStyle: TextStyle(
                                                color: Colors.blue,
                                                fontFamily: 'outfit',
                                              ),
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'outfit',
                                              ),
                                              linkTypes: [
                                                LinkType.url,
                                                LinkType.userTag,
                                                LinkType.hashTag,
                                                // LinkType
                                                //     .email
                                              ],
                                              onTap: (link) async {
                                                var SelectedTest =
                                                    link.value.toString();
                                                var Link =
                                                    SelectedTest.startsWith(
                                                        'https');
                                                var Link1 =
                                                    SelectedTest.startsWith(
                                                        'http');
                                                var Link2 =
                                                    SelectedTest.startsWith(
                                                        'www');
                                                var Link3 =
                                                    SelectedTest.startsWith(
                                                        'WWW');
                                                var Link4 =
                                                    SelectedTest.startsWith(
                                                        'HTTPS');
                                                var Link5 =
                                                    SelectedTest.startsWith(
                                                        'HTTP');
                                                var Link6 = SelectedTest.startsWith(
                                                    'https://pdslink.page.link/');
                                                print(SelectedTest.toString());

                                                if (Link == true ||
                                                    Link1 == true ||
                                                    Link2 == true ||
                                                    Link3 == true ||
                                                    Link4 == true ||
                                                    Link5 == true ||
                                                    Link6 == true) {
                                                  if (Link2 == true ||
                                                      Link3 == true) {
                                                    launchUrl(Uri.parse(
                                                        "https://${link.value.toString()}"));
                                                  } else {
                                                    if (Link6 == true) {
                                                      print("yes i am in room");
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return NewBottomBar(
                                                            buttomIndex: 1,
                                                          );
                                                        },
                                                      ));
                                                    } else {
                                                      launchUrl(Uri.parse(link
                                                          .value
                                                          .toString()));
                                                      print(
                                                          "link.valuelink.value -- ${link.value}");
                                                    }
                                                  }
                                                } else {
                                                  if (link.value!
                                                      .startsWith('#')) {
                                                    print("${link}");
                                                    if (widget.title ==
                                                        link.value) {
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                HashTagViewScreen(
                                                                    title:
                                                                        "${link.value}"),
                                                          ));
                                                    }
                                                  } else if (link.value!
                                                      .startsWith('@')) {
                                                    var name;
                                                    var tagName;
                                                    name = SelectedTest;
                                                    tagName = name.replaceAll(
                                                        "@", "");
                                                    await BlocProvider.of<
                                                                HashTagCubit>(
                                                            context)
                                                        .UserTagAPI(
                                                            context, tagName);

                                                    print(
                                                        "tagName -- ${tagName}");
                                                    print(
                                                        "user id -- ${userTagModel?.object}");
                                                  } else {
                                                    launchUrl(Uri.parse(
                                                        "https://${link.value.toString()}"));
                                                  }
                                                }
                                              },
                                            ),

                                            // HashTagText(
                                            //   text:
                                            //       "${hashTagViewData?.object?.posts?[index].description}",
                                            //   decoratedStyle: TextStyle(
                                            //       fontFamily: "outfit",
                                            //       fontSize: 14,
                                            //       fontWeight: FontWeight.bold,
                                            //       color: ColorConstant
                                            //           .HasTagColor),
                                            //   basicStyle: TextStyle(
                                            //       fontFamily: "outfit",
                                            //       fontSize: 14,
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.black),
                                            //   onTap: (text) {
                                            //     print(text);
                                            //     if (widget.title == text) {
                                            //     } else {
                                            //       Navigator.push(
                                            //           context,
                                            //           MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 HashTagViewScreen(
                                            //                     title:
                                            //                         "${text}"),
                                            //           ));
                                            //     }
                                            //   },
                                            // ),
                                          ),
                                        )
                                      : SizedBox(),
                                  hashTagViewData?.object?.posts?[index]
                                              .postDataType ==
                                          null
                                      ? SizedBox()
                                      : hashTagViewData?.object?.posts?[index]
                                                  .postDataType ==
                                              "VIDEO"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20, top: 15),
                                              child: VideoListItem(
                                                videoUrl: hashTagViewData
                                                        ?.object
                                                        ?.posts?[index]
                                                        .postData
                                                        ?.first ??
                                                    '',
                                              ),
                                            )
                                          : hashTagViewData
                                                      ?.object
                                                      ?.posts?[index]
                                                      .postData
                                                      ?.length ==
                                                  1
                                              ? (hashTagViewData
                                                          ?.object
                                                          ?.posts?[index]
                                                          .postDataType ==
                                                      "IMAGE"
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => OpenSavePostImage(
                                                                  PostID: hashTagViewData
                                                                          ?.object
                                                                          ?.posts?[
                                                                              index]
                                                                          .postUid ??
                                                                      "")),
                                                        );
                                                      },
                                                      child: Container(
                                                        // height: 230,
                                                        // width: _width,
                                                        margin: EdgeInsets.only(
                                                            left: 16,
                                                            top: 15,
                                                            right: 16),
                                                        child: Center(
                                                            child:
                                                                CustomImageView(
                                                          url:
                                                              "${hashTagViewData?.object?.posts?[index].postData?[0]}",
                                                        )),
                                                      ),
                                                    )
                                                  : hashTagViewData
                                                              ?.object
                                                              ?.posts?[index]
                                                              .postDataType ==
                                                          "ATTACHMENT"
                                                      ? (hashTagViewData
                                                                  ?.object
                                                                  ?.posts?[
                                                                      index]
                                                                  .postData
                                                                  ?.isNotEmpty ==
                                                              true)
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  width: _width,
                                                                  color: Colors
                                                                       .transparent,
                                                                  /* child: DocumentViewScreen1(
                                                                                            path: AllGuestPostRoomData?.object?.content?[index].postData?[0].toString(),
                                                                                          ) */
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    print(
                                                                        "objectobjectobjectobject");
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return DocumentViewScreen1(
                                                                            path:
                                                                                hashTagViewData?.object?.posts?[index].postData?[0].toString());
                                                                      },
                                                                    ));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl: hashTagViewData
                                                                              ?.object
                                                                              ?.posts?[index]
                                                                              .thumbnailImageUrl ??
                                                                          "",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : SizedBox()
                                                      : SizedBox())
                                              : Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        if ((hashTagViewData
                                                                ?.object
                                                                ?.posts?[index]
                                                                .postData
                                                                ?.isNotEmpty ==
                                                            true))
                                                          SizedBox(
                                                            height: 230,
                                                            child: PageView
                                                                .builder(
                                                              onPageChanged:
                                                                  (page) {
                                                                super.setState(() {
                                                                  _currentPages[
                                                                          index] =
                                                                      page;
                                                                  imageCount =
                                                                      page + 1;
                                                                });
                                                              },
                                                              controller:
                                                                  _pageControllers[
                                                                      index],
                                                              itemCount:
                                                                  hashTagViewData
                                                                      ?.object
                                                                      ?.posts?[
                                                                          index]
                                                                      .postData
                                                                      ?.length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index1) {
                                                                if (hashTagViewData
                                                                        ?.object
                                                                        ?.posts?[
                                                                            index]
                                                                        .postDataType ==
                                                                    "IMAGE") {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                OpenSavePostImage(
                                                                                  PostID: hashTagViewData?.object?.posts?[index].postUid,
                                                                                  index: index,
                                                                                )),
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          _width,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              16,
                                                                          top:
                                                                              15,
                                                                          right:
                                                                              16),
                                                                      child: Center(
                                                                          child: Stack(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topCenter,
                                                                            child:
                                                                                CustomImageView(
                                                                              url: "${hashTagViewData?.object?.posts?[index].postData?[index1]}",
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            child:
                                                                                Card(
                                                                              color: Colors.transparent,
                                                                              elevation: 0,
                                                                              child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  height: 30,
                                                                                  width: 50,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color.fromARGB(255, 2, 1, 1),
                                                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                                  ),
                                                                                  child: Text(
                                                                                    imageCount.toString() + '/' + '${hashTagViewData?.object?.posts?[index].postData?.length}',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  )),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )),
                                                                    ),
                                                                  );
                                                                } else if (hashTagViewData
                                                                        ?.object
                                                                        ?.posts?[
                                                                            index]
                                                                        .postDataType ==
                                                                    "ATTACHMENT") {
                                                                  return Container(
                                                                      // height: 100,
                                                                      width:
                                                                          _width,
                                                                      child:
                                                                          DocumentViewScreen1(
                                                                        path: hashTagViewData
                                                                            ?.object
                                                                            ?.posts?[index]
                                                                            .postData?[index1]
                                                                            .toString(),
                                                                      ));
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        (hashTagViewData
                                                                    ?.object
                                                                    ?.posts?[
                                                                        index]
                                                                    .postData
                                                                    ?.isNotEmpty ==
                                                                true)
                                                            ? Positioned(
                                                                bottom: 5,
                                                                left: 0,
                                                                right: 0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 0),
                                                                  child:
                                                                      Container(
                                                                    height: 20,
                                                                    child:
                                                                        DotsIndicator(
                                                                      dotsCount: hashTagViewData
                                                                              ?.object
                                                                              ?.posts?[index]
                                                                              .postData
                                                                              ?.length ??
                                                                          0,
                                                                      position:
                                                                          _currentPages[index]
                                                                              .toDouble(),
                                                                      decorator:
                                                                          DotsDecorator(
                                                                        size: const Size(
                                                                            10.0,
                                                                            7.0),
                                                                        activeSize: const Size(
                                                                            10.0,
                                                                            10.0),
                                                                        spacing:
                                                                            const EdgeInsets.symmetric(horizontal: 2),
                                                                        activeColor:
                                                                            ColorConstant.primary_color,
                                                                        color: Color(
                                                                            0xff6A6A6A),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ))
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await soicalFunation(
                                                apiName: 'like_post',
                                                index: index);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: hashTagViewData
                                                          ?.object
                                                          ?.posts?[index]
                                                          .isLiked !=
                                                      true
                                                  ? Image.asset(
                                                      ImageConstant.likewithout,
                                                      height: 20,
                                                    )
                                                  : Image.asset(
                                                      ImageConstant.like,
                                                      height: 20,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0,
                                        ),
                                        hashTagViewData?.object?.posts?[index]
                                                    .likedCount ==
                                                0
                                            ? SizedBox()
                                            : GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return ShowAllPostLike(
                                                          "${hashTagViewData?.object?.posts?[index].postUid}");
                                                    },
                                                  ));
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "${hashTagViewData?.object?.posts?[index].likedCount}",
                                                      style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        //this bottomsheet will  remaing --ankur
                                        GestureDetector(
                                          onTap: () async {
                                            /*  await Navigator.push(context,
                                                    MaterialPageRoute(builder: (context) {
                                                  return CommentsScreen(
                                                    image: hashTagViewData?.object
                                                        ?.posts?[index].userProfilePic,
                                                    userName: hashTagViewData?.object
                                                        ?.posts?[index].postUserName,
                                                    description: hashTagViewData?.object
                                                        ?.posts?[index].description,
                                                    PostUID:
                                                        '${hashTagViewData?.object?.posts?[index].postUid}',
                                                    date: hashTagViewData?.object
                                                            ?.posts?[index].createdAt ??
                                                        "",
                                                  );
                                                })).then((value) =>
                                                    BlocProvider.of<HashTagCubit>(context)
                                                        .HashTagViewDataAPI(context,
                                                            widget.title.toString())); */

                                            BlocProvider.of<AddcommentCubit>(
                                                    context)
                                                .Addcomment(context,
                                                    '${hashTagViewData?.object?.posts?[index].postUid}');
                                            if (uuid == null) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterCreateAccountScreen()));
                                            } else {
                                              _settingModalBottomSheet1(
                                                  context, index, _width);
                                            }
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.asset(
                                                ImageConstant.meesage,
                                                height: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        hashTagViewData?.object?.posts?[index]
                                                    .commentCount ==
                                                0
                                            ? SizedBox()
                                            : Text(
                                                "${hashTagViewData?.object?.posts?[index].commentCount}",
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 14),
                                              ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            rePostBottommSheet(context, index);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.asset(
                                                ImageConstant.vector2,
                                                height: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 18,
                                        // ),
                                        // Image.asset(
                                        //   ImageConstant.vector2,
                                        //   height: 12,
                                        // ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        // Text(
                                        //   '1335',
                                        //   style: TextStyle(
                                        //       fontFamily: "outfit", fontSize: 14),
                                        // ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            await soicalFunation(
                                                apiName: 'savedata',
                                                index: index);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.asset(
                                                hashTagViewData
                                                            ?.object
                                                            ?.posts?[index]
                                                            .isSaved ==
                                                        false
                                                    ? ImageConstant.savePin
                                                    : ImageConstant.Savefill,
                                                height: 17,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }

  void _settingModalBottomSheet1(context, index, _width) {
    void _goToElement() {
      scroll.animateTo((1000 * 20),
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: true,
        showDragHandle: true,
        enableDrag: true,
        constraints: BoxConstraints.tight(Size.infinite),
        context: context,
        builder: (BuildContext bc) {
          return CommentBottomSheet(
              useruid: hashTagViewData?.object?.posts?[index].userUid ?? "",
              userProfile:
                  hashTagViewData?.object?.posts?[index].userProfilePic ?? "",
              UserName:
                  hashTagViewData?.object?.posts?[index].postUserName ?? "",
              desc: hashTagViewData?.object?.posts?[index].description ?? "",
              postUuID: hashTagViewData?.object?.posts?[index].postUid ?? "");
        });
  }

  String customFormat(DateTime date) {
    String day = date.day.toString();
    // String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$time';
    return formattedDate;
  }

  soicalFunation({String? apiName, int? index}) async {
    print("fghdfghdfgh");
    if (uuid == null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } else if (apiName == 'Follow') {
      print("dfhsdfhsdfhsdgf");
      await BlocProvider.of<HashTagCubit>(context).followWIngMethod(
          hashTagViewData?.object?.posts?[index ?? 0].userUid, context);
      if (hashTagViewData?.object?.posts?[index ?? 0].isFollowing == 'FOLLOW') {
        hashTagViewData?.object?.posts?[index ?? 0].isFollowing = 'REQUESTED';
      } else {
        hashTagViewData?.object?.posts?[index ?? 0].isFollowing = 'FOLLOW';
      }
    } else if (apiName == 'like_post') {
      await BlocProvider.of<HashTagCubit>(context).like_post(
          hashTagViewData?.object?.posts?[index ?? 0].postUid, context);
      print("isLiked-->${hashTagViewData?.object?.posts?[index ?? 0].isLiked}");
      if (hashTagViewData?.object?.posts?[index ?? 0].isLiked == true) {
        hashTagViewData?.object?.posts?[index ?? 0].isLiked = false;
        int a = hashTagViewData?.object?.posts?[index ?? 0].likedCount ?? 0;
        int b = 1;
        hashTagViewData?.object?.posts?[index ?? 0].likedCount = a - b;
      } else {
        hashTagViewData?.object?.posts?[index ?? 0].isLiked = true;
        hashTagViewData?.object?.posts?[index ?? 0].likedCount;
        int a = hashTagViewData?.object?.posts?[index ?? 0].likedCount ?? 0;
        int b = 1;
        hashTagViewData?.object?.posts?[index ?? 0].likedCount = a + b;
      }
    } else if (apiName == 'savedata') {
      await BlocProvider.of<HashTagCubit>(context).savedData(
          hashTagViewData?.object?.posts?[index ?? 0].postUid, context);

      if (hashTagViewData?.object?.posts?[index ?? 0].isSaved == true) {
        hashTagViewData?.object?.posts?[index ?? 0].isSaved = false;
      } else {
        hashTagViewData?.object?.posts?[index ?? 0].isSaved = true;
      }
    } else if (apiName == 'Deletepost') {
      await BlocProvider.of<HashTagCubit>(context).DeletePost(
          '${hashTagViewData?.object?.posts?[index ?? 0].postUid}', context);
      hashTagViewData?.object?.posts?.removeAt(index ?? 0);
    }
  }

  void delete_dilog_menu(
    Offset position,
    BuildContext context,
  ) async {
    List<String> ankur = [
      "Delete Post",
    ];
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
                enabled: true,
                onTap: () {
                  super.setState(() {
                    indexx = index;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    Deletedilog(
                        hashTagViewData?.object?.posts?[index].postUid ?? "",
                        index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: indexx == index
                            ? ColorConstant.primary_color
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    width: 130,
                    height: 40,
                    child: Center(
                      child: Text(
                        ankur[index],
                        style: TextStyle(
                            color:
                                indexx == index ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ))));
  }

  Deletedilog(String PostUID, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // title: const Text("Create Expert"),
        content: Container(
          height: 80,
          child: Column(
            children: [
              Text("Are You Sure You Want To delete This Post."),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await soicalFunation(apiName: 'Deletepost', index: index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      // color: Colors.green,
                      child: Text(
                        "Yas",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      // color: Colors.green,
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void rePostBottommSheet(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 200,
            child: new Wrap(
              children: [
                Container(
                  height: 20,
                  width: 50,
                  color: Colors.transparent,
                ),
                Center(
                    child: Container(
                  height: 5,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),
                )),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: new ListTile(
                      leading: new Image.asset(
                        ImageConstant.vector2,
                        height: 20,
                      ),
                      title: new Text('RePost'),
                      subtitle: Text(
                        "Share this post with your followers",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      onTap: () async {
                        Map<String, dynamic> param = {"postType": "PUBLIC"};
                        BlocProvider.of<GetGuestAllPostCubit>(context)
                            .RePostAPI(
                                context,
                                param,
                                AllGuestPostRoomData
                                    ?.object?.content?[index].postUid,
                                "Repost");
                        Navigator.pop(context);
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: new ListTile(
                    leading: new Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                    ),
                    title: new Text('Quote'),
                    subtitle: Text(
                      "Add a comment, photo or GIF before you share this post",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RePostScreen(
                            userProfile: hashTagViewData
                                ?.object?.posts?[index].userProfilePic,
                            username: hashTagViewData
                                ?.object?.posts?[index].postUserName,
                            date: hashTagViewData
                                ?.object?.posts?[index].createdAt,
                            desc: hashTagViewData
                                ?.object?.posts?[index].description,
                            postData:
                                hashTagViewData?.object?.posts?[index].postData,
                            postDataType: hashTagViewData
                                ?.object?.posts?[index].postDataType,
                            index: index,
                            hashTagViewData: hashTagViewData,
                            postUid:
                                hashTagViewData?.object?.posts?[index].postUid,
                                thumbNailURL:hashTagViewData?.object?.posts?[index].thumbnailImageUrl ,
                          );
                        },
                      ));
                      // Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }
}
