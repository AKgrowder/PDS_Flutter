import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_state.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/OpenSavePostImage.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comment_bottom_sheet.dart';
import 'package:pds/presentation/%20new/commenwigetReposrt.dart';
import 'package:pds/presentation/%20new/home_screen_new.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import '../../API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import '../../API/Model/HashTage_Model/HashTagView_model.dart';
import '../../API/Model/UserTagModel/UserTag_model.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../widgets/custom_image_view.dart';
import '../register_create_account_screen/register_create_account_screen.dart';
import 'RePost_Screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';


class HashTagViewScreen extends StatefulWidget {
  String? title;
  HashTagViewScreen({Key? key, this.title}) : super(key: key);

  @override
  State<HashTagViewScreen> createState() => _HashTagViewScreenState();
}

class _HashTagViewScreenState extends State<HashTagViewScreen> with Observer {
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

  bool _permissionReady = false;

  int? version;

  String _localPath="";
  @override
  void initState() {
    Observable.instance.addObserver(this);
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
  update(Observable observable, String? notifyName, Map? map) async {
    print("dfgsdfgdfgsdg-${map?['index']}");
    hashTagViewData?.object?.posts?[map?['index']].isReports = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
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

          hashTagViewData?.object?.posts?.forEach((element) {
            _pageControllers.add(PageController());
            print(
                "_pageControllers-${_pageControllers.length}-${hashTagViewData?.object?.posts?.length}");

            _currentPages.add(0);
          });
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
              const EdgeInsets.only(top: 45, left: 0, right: 0, bottom: 20),
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
                      GlobalKey buttonKey = GlobalKey(); //
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
                          child: hashTagViewData
                                      ?.object?.posts?[index].isReports ==
                                  true
                              ? Container(
                                  width: _width,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF0F0F0),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                          height: 20,
                                          child: Image.asset(
                                              ImageConstant.greenseen)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Thanks for reporting',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Post Reported and under review',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
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
                                      /* borderRadius: BorderRadius.circular(10), */
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
                                                                  ?.posts?[
                                                                      index]
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
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 25,
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
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
                                                                  ?.posts?[
                                                                      index]
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
                                          trailing:
                                              uuid ==
                                                      hashTagViewData
                                                          ?.object
                                                          ?.posts?[index]
                                                          .userUid
                                                  ? GestureDetector(
                                                      onTapDown: (TapDownDetails
                                                          details) {
                                                        delete_dilog_menu(
                                                          details
                                                              .globalPosition,
                                                          context,
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.more_vert_rounded,
                                                      ))
                                                  : Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await soicalFunation(
                                                                apiName:
                                                                    'Follow',
                                                                index: index);
                                                          },
                                                          child: Container(
                                                            height: 25,
                                                            alignment: Alignment
                                                                .center,
                                                            width: 65,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 5),
                                                            decoration: BoxDecoration(
                                                                color: ColorConstant
                                                                    .primary_color,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                            child: hashTagViewData
                                                                        ?.object
                                                                        ?.posts?[
                                                                            index]
                                                                        .isFollowing ==
                                                                    'FOLLOW'
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
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : Text(
                                                                        'Following ',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "outfit",
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                          ),
                                                        ),
                                                        if (uuid != null)
                                                          GestureDetector(
                                                              key: buttonKey,
                                                              onTap: () async {
                                                                showPopupMenu1(
                                                                    context,
                                                                    index,
                                                                    buttonKey,
                                                                    hashTagViewData
                                                                        ?.object
                                                                        ?.posts?[
                                                                            index]
                                                                        .postUid,
                                                                    '_HashTagViewScreenState');
                                                              },
                                                              child: Container(
                                                                  height: 25,
                                                                  width: 40,
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Icon(Icons
                                                                      .more_vert_rounded))),
                                                      ],
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
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    LinkifyText(
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
                                                        var Link6 =
                                                            SelectedTest.startsWith(
                                                                'https://pdslink.page.link/');
                                                        print(SelectedTest
                                                            .toString());

                                                        if (Link == true ||
                                                            Link1 == true ||
                                                            Link2 == true ||
                                                            Link3 == true ||
                                                            Link4 == true ||
                                                            Link5 == true ||
                                                            Link6 == true) {
                                                          if (Link2 == true ||
                                                              Link3 == true) {
                                                            if (isYouTubeUrl(SelectedTest)) {
                                                              playLink(SelectedTest, context);
                                                            } else launchUrl(Uri.parse(
                                                                "https://${link.value.toString()}"));
                                                          } else {
                                                            if (Link6 == true) {
                                                              print(
                                                                  "yes i am in room");
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                builder: (context) {
                                                                  return NewBottomBar(
                                                                    buttomIndex: 1,
                                                                  );
                                                                },
                                                              ));
                                                            } else {
                                                              if (isYouTubeUrl(SelectedTest)) {
                                                                playLink(SelectedTest, context);
                                                              } else launchUrl(Uri.parse(
                                                                  link.value
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
                                                            tagName =
                                                                name.replaceAll(
                                                                    "@", "");
                                                            await BlocProvider.of<
                                                                        HashTagCubit>(
                                                                    context)
                                                                .UserTagAPI(context,
                                                                    tagName);

                                                            print(
                                                                "tagName -- ${tagName}");
                                                            print(
                                                                "user id -- ${userTagModel?.object}");
                                                          } else {
                                                            if (isYouTubeUrl(SelectedTest)) {
                                                              playLink(SelectedTest, context);
                                                            } else launchUrl(Uri.parse(
                                                                "https://${link.value.toString()}"));
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    if (extractUrls(hashTagViewData?.object?.posts?[index]
                                                        .description ?? "").isNotEmpty)
                                                      isYouTubeUrl(extractUrls(hashTagViewData?.object?.posts?[index]
                                                          .description ?? "").first)
                                                          ? FutureBuilder(
                                                          future: fetchYoutubeThumbnail(extractUrls(hashTagViewData?.object?.posts?[index]
                                                              .description ?? "").first),
                                                          builder: (context, snap) {
                                                            return Container(
                                                              height: 200,
                                                              decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(snap.data.toString())), borderRadius: BorderRadius.circular(10)),
                                                              clipBehavior: Clip.antiAlias,
                                                              child: Center(
                                                                  child: IconButton(
                                                                    icon: Icon(
                                                                      Icons.play_circle_fill_rounded,
                                                                      color: Colors.white,
                                                                      size: 60,
                                                                    ),
                                                                    onPressed: () {
                                                                      playLink(extractUrls(hashTagViewData?.object?.posts?[index]
                                                                          .description ?? "").first, context);
                                                                    },
                                                                  )),
                                                            );
                                                          })
                                                          : Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                                        child: AnyLinkPreview(
                                                          link: extractUrls(hashTagViewData?.object?.posts?[index]
                                                              .description ?? "").first,
                                                          displayDirection: UIDirection.uiDirectionHorizontal,
                                                          showMultimedia: true,
                                                          bodyMaxLines: 5,
                                                          bodyTextOverflow: TextOverflow.ellipsis,
                                                          titleStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                          bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                                          errorBody: 'Show my custom error body',
                                                          errorTitle: 'Show my custom error title',
                                                          errorWidget: null,
                                                          errorImage: "https://flutter.dev/",
                                                          cache: Duration(days: 7),
                                                          backgroundColor: Colors.grey[300],
                                                          borderRadius: 12,
                                                          removeElevation: false,
                                                          boxShadow: [
                                                            BoxShadow(blurRadius: 3, color: Colors.grey)
                                                          ],
                                                          onTap: () {
                                                            launchUrl(Uri.parse(extractUrls(hashTagViewData?.object?.posts?[index]
                                                                .description ?? "").first));
                                                          }, // This disables tap event
                                                        ),
                                                      ),
                                                  ],
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
                                          : hashTagViewData
                                                      ?.object
                                                      ?.posts?[index]
                                                      .postDataType ==
                                                  "VIDEO"
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                              ?.posts?[index]
                                                                              .postUid ??
                                                                          "")),
                                                            );
                                                          },
                                                          child: Container(
                                                            // height: 230,
                                                            // width: _width,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 0,
                                                                    top: 15,
                                                                    right: 0),
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
                                                                  ?.posts?[
                                                                      index]
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
                                                                      width:
                                                                          _width,
                                                                      color: Colors
                                                                          .transparent,
                                                                      /* child: DocumentViewScreen1(
                                                                                          path: AllGuestPostRoomData?.object?.content?[index].postData?[0].toString(),
                                                                                        ) */
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            "objectobjectobjectobject");
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                            return DocumentViewScreen1(path: hashTagViewData?.object?.posts?[index].postData?[0].toString());
                                                                          },
                                                                        ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              hashTagViewData?.object?.posts?[index].thumbnailImageUrl ?? "",
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
                                                                    ?.posts?[
                                                                        index]
                                                                    .postData
                                                                    ?.isNotEmpty ==
                                                                true))
                                                              Container(
                                                                height: _height/1.4,
                                                                child: PageView
                                                                    .builder(
                                                                  onPageChanged:
                                                                      (page) {
                                                                    super
                                                                        .setState(
                                                                            () {
                                                                      _currentPages[
                                                                              index] =
                                                                          page;
                                                                      imageCount =
                                                                          page +
                                                                              1;
                                                                    });
                                                                  },
                                                                  controller:
                                                                      _pageControllers[
                                                                          index],
                                                                  itemCount: hashTagViewData
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
                                                                        onTap:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => OpenSavePostImage(
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
                                                                              left: 0,
                                                                              top: 15,
                                                                              right: 0),
                                                                          child: Center(
                                                                              child: Stack(
                                                                            children: [
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: CustomImageView(
                                                                                  url: "${hashTagViewData?.object?.posts?[index].postData?[index1]}",
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topRight,
                                                                                child: Card(
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
                                                                            ?.posts?[index]
                                                                            .postDataType ==
                                                                        "ATTACHMENT") {
                                                                      return Container(
                                                                          // height: 100,
                                                                          width:
                                                                              _width,
                                                                          child:
                                                                              DocumentViewScreen1(
                                                                            path:
                                                                                hashTagViewData?.object?.posts?[index].postData?[index1].toString(),
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
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            20,
                                                                        child:
                                                                            DotsIndicator(
                                                                          dotsCount:
                                                                              hashTagViewData?.object?.posts?[index].postData?.length ?? 0,
                                                                          position:
                                                                              _currentPages[index].toDouble(),
                                                                          decorator:
                                                                              DotsDecorator(
                                                                            size:
                                                                                const Size(10.0, 7.0),
                                                                            activeSize:
                                                                                const Size(10.0, 10.0),
                                                                            spacing:
                                                                                const EdgeInsets.symmetric(horizontal: 2),
                                                                            activeColor:
                                                                                ColorConstant.primary_color,
                                                                            color:
                                                                                Color(0xff6A6A6A),
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
                                        padding:
                                            const EdgeInsets.only(left: 13),
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
                                                          ImageConstant
                                                              .likewithout,
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
                                            hashTagViewData
                                                        ?.object
                                                        ?.posts?[index]
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
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          "${hashTagViewData?.object?.posts?[index].likedCount}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "outfit",
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

                                                BlocProvider.of<
                                                            AddcommentCubit>(
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
                                            hashTagViewData
                                                        ?.object
                                                        ?.posts?[index]
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
                                                rePostBottommSheet(
                                                    context, index);
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
                                            GestureDetector(
                                              onTap: () async{
                                                if (uuid == null) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RegisterCreateAccountScreen()));
                                                } else {
                                                  if (hashTagViewData!.object!.posts![index].postDataType != "VIDEO") {
                                                    String thumb = "";
                                                    if (hashTagViewData!.object!.posts![index].thumbnailImageUrl != null) {
                                                      thumb = hashTagViewData!.object!.posts![index].thumbnailImageUrl!;
                                                    } else {
                                                      if (hashTagViewData!.object!.posts![index].postData != null && hashTagViewData!.object!.posts![index].postData!.isNotEmpty) {
                                                        thumb = hashTagViewData!.object!.posts![index].postData!.first;
                                                      } else {
                                                        thumb = "";
                                                      }
                                                    }
                                                    _onShareXFileFromAssets(
                                                      context,
                                                      thumb,
                                                      hashTagViewData!.object!.posts![index].postUserName ?? "",
                                                      hashTagViewData!.object!.posts![index].description ?? "",
                                                      androidLink: '${hashTagViewData!.object!.posts![index].postLink}',
                                                    );
                                                  } else {
                                                    final fileName = await VideoThumbnail.thumbnailFile(
                                                        video: hashTagViewData!.object!.posts![index].postData?.first ?? "",
                                                        thumbnailPath: (await getTemporaryDirectory()).path,
                                                imageFormat: ImageFormat.WEBP,
                                                quality: 100,
                                                );
                                                _onShareXFileFromAssets(
                                                context,
                                                fileName!,
                                                hashTagViewData!.object!.posts![index].postUserName ?? "",
                                                hashTagViewData!.object!.posts![index].description ?? "",
                                                androidLink: '${hashTagViewData!.object!.posts![index].postLink}',
                                                );
                                              }
                                                }
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 30,
                                                color: Colors.transparent,
                                                child: Icon(Icons.share_rounded,
                                                    size: 20),
                                              ),
                                            ),
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
                                                        : ImageConstant
                                                            .Savefill,
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
    ));
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

  // String customFormat(DateTime date) {
  //   String day = date.day.toString();
  //   // String month = _getMonthName(date.month);
  //   String year = date.year.toString();
  //   String time = DateFormat('h:mm a').format(date);

  //   String formattedDate = '$time';
  //   return formattedDate;
  // }

  String customFormat(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return '1 day ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks == 1 ? '' : 's'} ago';
      }
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return '1 hour ago';
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return '1 minute ago';
      } else {
        return '${difference.inMinutes} minutes ago';
      }
    } else {
      return 'Just now';
    }
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
          height: 100,
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
                    child:Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            // color: Colors.green,
                            color: ColorConstant.primary_color,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            // color: Colors.green,
                            color: ColorConstant.primary_color,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          ),
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
                            thumbNailURL: hashTagViewData
                                ?.object?.posts?[index].thumbnailImageUrl,
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

  void _onShareXFileFromAssets(BuildContext context, String postLink,
      String userName, String description,
      {String? androidLink}) async {
    // RenderBox? box = context.findAncestorRenderObjectOfType();

    var directory = await getTemporaryDirectory();

    if (postLink.isNotEmpty) {
      _permissionReady = await _checkPermission();
      await _prepareSaveDir();
      if(Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        version = int.parse(androidInfo.version.release);
        if((version ?? 0) >= 13){
          PermissionStatus status = await Permission.photos.request();
          _permissionReady =status == PermissionStatus.granted;
        }
      }




      if (_permissionReady) {
        print("Downloading");
        print("${postLink}");
        try {
          await Dio().download(
            postLink.toString(),
            directory.path + "/" + "IP__image.jpg",
          );

          print("Download Completed.");
        } catch (e) {
          print("Download Failed.\n\n" + e.toString());
        }
      }
      if (Platform.isAndroid) {

        Share.shareXFiles(
          [
            XFile(postLink.startsWith("http")
                ? "${directory.path}/IP__image.jpg"
                : postLink)
          ],
          subject: "Share",
          text:
          "$userName posted ${description.isNotEmpty ? "\n\n${description.length > 50 ? description.substring(0,50):description}.... \n\n" : ""}on InPackaging \n\n https://www.inpackaging.com \n\n ${androidLink}",
          // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      } else {
        Share.shareXFiles(
          [
            XFile(directory.path +
                Platform.pathSeparator +
                'IP/IP__image.jpg')
          ],
          subject: "Share",
          text:
          "$userName posted ${description.isNotEmpty ? "\n\n${description.length > 50 ? description.substring(0,50):description}.... \n\n" : ""}on InPackaging \n\n https://www.inpackaging.com \n\n ${androidLink}",
          // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      }
    } else {
      print('No Invoice Available');
      if(Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        version = int.parse(androidInfo.version.release);
        if((version ?? 0) >= 13){
          PermissionStatus status = await Permission.photos.request();
          _permissionReady =status == PermissionStatus.granted;
        }
      }
      if (Platform.isAndroid) {
        if((version ?? 0) >= 13){
          PermissionStatus status = await Permission.photos.request();
          _permissionReady =status == PermissionStatus.granted;
        }
        if(_permissionReady) {
          Share.shareXFiles(
            [XFile("/data/data/com.ip.app/ip/IP__image.jpg")],
            subject: "Share",
            text: "$userName posted ${description.isNotEmpty ? "\n\n${description.length > 50 ? description.substring(0,50):description}.... \n\n" : ""}on InPackaging \n\n https://www.inpackaging.com \n\n ${androidLink}",
            // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
          );
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
        Share.shareXFiles(
          [XFile(directory.path + Platform.pathSeparator + 'IP/IP__image.jpg')],
          subject: "Share",
          text: "$userName posted ${description.isNotEmpty ? "\n\n${description.length > 50 ? description.substring(0,50):description}.... \n\n" : ""}on InPackaging \n https://www.inpackaging.com \n ${androidLink}",
          // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      }

    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print("objectobjectobjectobjectobjectobjectobjectobject ${androidInfo.version.release}");
      version = int.parse(androidInfo.version.release);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // version =
      //     await int.parse(prefs.getString(UserdefaultsData.version).toString());
      print('dddwssadasdasdasdasdasd ${version}');
    }
    if (Platform.isAndroid) {
      final status = (version ?? 0) < 13 ? await Permission.storage.status : PermissionStatus.granted;
      if (status != PermissionStatus.granted) {
        print('gegegegegegegegegegegegegege');
        print('gegegegegegegegegegegegegege $status');
        final result = (version ?? 0) < 13 ? await Permission.storage.request() : PermissionStatus.granted;
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
      print('first vvvvvvvvvvvvvvvvvvv');
    }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      return "/data/data/com.ip.app/ip/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'IP_Image';
    }
  }

  Future<String> fetchYoutubeThumbnail(String url) async {
    try {
      // Extract video ID from YouTube URL
      // We will use this to build our own custom UI
      List<String> urls = extractUrls(url);
      Metadata? _metadata = await AnyLinkPreview.getMetadata(
        link: urls.first,
        cache: Duration(days: 1),
        // proxyUrl: "https://cors-anywhere.herokuapp.com/", // Need for web
      );
      return _metadata?.image ?? "";
    } catch (e) {
      print('Error: $e');
      return "";
    }
  }

  List<String> extractUrls(String text) {
    RegExp regExp = RegExp(
      r"https?:\/\/[\w\-]+(\.[\w\-]+)+[\w\-.,@?^=%&:/~\+#]*[\w\-@?^=%&/~\+#]?",
      caseSensitive: false,
    );

    List<String> urls = regExp.allMatches(text).map((match) => match.group(0)!).toList();
    List<String> finalUrls = [];
    RegExp urlRegex = RegExp(r"(http(s)?://)", caseSensitive: false);
    urls.forEach((element) {
      if(urlRegex.allMatches(element).toList().length > 1){
        String xyz = element.replaceAll("http", ",http");
        List<String> splitted = xyz.split(RegExp(r",|;"));
        splitted.forEach((element1) {
          if(element1.isNotEmpty)
            finalUrls.add(element1);
        });
      }else{
        finalUrls.add(element);
      }
    });
    return finalUrls;

  }

  bool isYouTubeUrl(String url) {
    // Regular expression pattern to match YouTube URLs
    RegExp youtubeVideoRegex = RegExp(r"^https?://(?:www\.)?youtube\.com/(?:watch\?v=)?([^#&?]+)");
    RegExp youtubeShortsRegex = RegExp(r"^https?://(?:www\.)?youtube\.com/shorts/([^#&?]+)");

    if (youtubeVideoRegex.hasMatch(url) || youtubeShortsRegex.hasMatch(url)) {
      return true;
    }

    // Additional checks based on specific test link patterns (optional)
    if (url.contains("youtu.be/")) {
      // This check might need adjustments if Youtube short URLs change format
      return true;
    }

    return false;
  }

  void playLink(String videoUrl, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Center(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.width * 0.80,
              decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(future: getYoutubePlayer(videoUrl, () {
                        Navigator.pop(ctx);
                        launchUrl(Uri.parse(videoUrl));
                      }), builder: (context,snap){
                        if(snap.data != null)
                          return snap.data as Widget;
                        else return Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        );
                      })
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  String extractPlaylistId(String playlistLink) {
    Uri uri = Uri.parse(playlistLink);

    String playlistId = '';

    // Check if the link is a valid YouTube playlist link
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      if (uri.pathSegments.contains('playlist')) {
        int index = uri.pathSegments.indexOf('playlist');
        if (index != -1 /*&& index + 1 < uri.pathSegments.length*/) {
          playlistId = uri.queryParameters['list']!;
        }
      }
    } else if (uri.host == 'youtu.be') {
      // If the link is a short link
      playlistId = uri.pathSegments.first;
    }

    return playlistId;
  }


  Future<List<String>> getPlaylistVideos(String playlistId) async {
    // final url = "https://www.youtube.com/playlist?list=RDF0SflZWxv8k";
    final url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$playlistId&key=AIzaSyAT_gzTjHn9XuvQsmGdY63br7lKhD2KRdo";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Parse the HTML content to extract video IDs (implementation depends on website structure)
      List<String> videoIds = [];
      final Map<String, dynamic> data = json.decode(response.body);
      for (var item in data['items']) {
        videoIds.add(item['snippet']['resourceId']['videoId']);
      }
      return videoIds; // List of video IDs
    } else {
      print ("Failed to fetch playlist videos");
      return [];
    }
  }

  String extractLiveId(String liveLink) {
    Uri uri = Uri.parse(liveLink);

    String liveId = '';

    // Check if the link is a valid YouTube live link
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      if (uri.pathSegments.contains('watch')) {
        // If the link contains 'watch' segment
        int index = uri.pathSegments.indexOf('watch');
        if (index != -1 && index + 1 < uri.pathSegments.length) {
          // Get the video ID
          liveId = uri.queryParameters['v']!;
        }
      } else if (uri.pathSegments.contains('live')) {
        // If the link contains 'live' segment
        int index = uri.pathSegments.indexOf('live');
        if (index != -1 && index + 1 < uri.pathSegments.length) {
          // Get the live ID
          liveId = uri.pathSegments[index + 1];
        }
      }
    } else if (uri.host == 'youtu.be') {
      // If the link is a short link
      liveId = uri.pathSegments.first;
    }

    return liveId;
  }


  Future<Widget> getYoutubePlayer(String videoUrl, Function() fullScreen) async{
    late YoutubePlayerController _controller;
    String videoId = "";
    if(videoUrl.toLowerCase().contains("playlist")){
      String playlistId = extractPlaylistId(videoUrl);
      var videoIds = await getPlaylistVideos(playlistId);
      videoId = videoIds.first;
    }else if(videoUrl.toLowerCase().contains("live")){
      videoId = extractLiveId(videoUrl);
    }else{
      videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    }
    print("video id ========================> $videoId");
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: videoUrl.toLowerCase().contains("live"),
        forceHD: false,
        enableCaption: true,
      ),
    );
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        _controller.toggleFullScreenMode();
        _controller.dispose();
        fullScreen.call();
      },
      builder: (context, player) {
        return player;
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        bottomActions: [
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
          ),
          RemainingDuration(),
          const PlaybackSpeedButton(),
          IconButton(
            icon: Icon(
              _controller.value.isFullScreen
                  ? Icons.fullscreen_exit
                  : Icons.fullscreen,
              color: Colors.white,
            ),
            onPressed: () => fullScreen.call(),
          ),
        ],
        onReady: () {
          _controller.addListener(() {
            if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
              setState(() {
                _playerState = _controller.value.playerState;
                _videoMetaData = _controller.metadata;
              });
            }
          });
        },
      ),
    );
  }
}
