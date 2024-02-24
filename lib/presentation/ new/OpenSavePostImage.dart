import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Model/OpenSaveImagepostModel/OpenSaveImagepost_Model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/RePost_Screen.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comment_bottom_sheet.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_state.dart';
import '../../API/Model/UserTagModel/UserTag_model.dart';
import '../../core/utils/sharedPreferences.dart';
import '../Create_Post_Screen/Ceratepost_Screen.dart';
import 'home_screen_new.dart';

// ignore: must_be_immutable
class OpenSavePostImage extends StatefulWidget {
  String? PostID;
  String? PostopenLink;
  bool? profileTure;
  int? index;
  bool? isnavgation;
  String? Userid;

  OpenSavePostImage(
      {Key? key,
      required this.PostID,
      this.profileTure,
      this.PostopenLink,
      this.index,
      this.isnavgation,
      this.Userid})
      : super(key: key);
  @override
  State<OpenSavePostImage> createState() => _OpenSavePostImageState();
}

class _OpenSavePostImageState extends State<OpenSavePostImage> {
  OpenSaveImagepostModel? OpenSaveModelData;
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime? parsedDateTimeBlogs;
  DateTime? repostTime;
  final ScrollController scroll = ScrollController();
  List<int> currentPages = [];
  List<PageController> pageControllers = [];
  List<int> currentPagesRepost = [];
  List<PageController> pageControllersRepost = [];
  String? uuid;
  bool added = false;
  int imageCount = 1;
  UserTagModel? userTagModel;
  bool? readmoree;
  int maxLength = 60;
  GlobalKey buttonKey = GlobalKey();

  @override
  void initState() {
    print("dfgdfgdgf-  ${widget.profileTure}");
    BlocProvider.of<OpenSaveCubit>(context)
        .openSaveImagePostAPI(context, "${widget.PostID}", showAlert: true);
    userIdFun();

    super.initState();
  }

  userIdFun() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    uuid = prefs.getString(PreferencesKey.loginUserID);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, // Light icons for status bar
        statusBarBrightness:
            Brightness.dark // Dark == white status bar -- for IOS.
        ));
    return BlocConsumer<OpenSaveCubit, OpenSaveState>(
        listener: (context, state) async {
      if (state is OpenSaveErrorState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.error),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // if (state is OpenSaveLoadingState) {

      //   Center(
      //     child: Container(
      //       margin: EdgeInsets.only(bottom: 100),
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(20),
      //         child: Image.asset(ImageConstant.loader,
      //             fit: BoxFit.cover, height: 100.0, width: 100),
      //       ),
      //     ),
      //   );
      // }
      if (state is DeletePostLoadedState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.DeletePost.object.toString()),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (state is OpenSaveLoadedState) {
        OpenSaveModelData = state.OpenSaveData;

        if ((OpenSaveModelData?.object?.description?.length ?? 0) <= 60) {
          readmoree = true;
        } else if ((OpenSaveModelData?.object?.repostOn?.description?.length ??
                0) <=
            60) {
          readmoree = true;
        } else {
          readmoree = false;
        }
        print(OpenSaveModelData?.object?.postUserName);
        navigationFunction();
        parsedDateTimeBlogs =
            DateTime.parse('${OpenSaveModelData?.object?.createdAt ?? ""}');
        // parsedDateTimeRepost =
        //     DateTime.parse('${OpenSaveModelData?.object?.repostOn?.createdAt}');

        // if (OpenSaveModelData?.object?.description!= null) {
        //   readmoree.add((OpenSaveModelData?.object?.description?.length ?? 0) <= maxLength);
        // } else {
        //   readmoree.add(false);
        // }
        if (OpenSaveModelData?.object?.repostOn != null) {
          repostTime = DateTime.parse(
              '${OpenSaveModelData?.object?.repostOn!.createdAt ?? ""}');
        }
        print("home imges -- ${widget.index}");
        if (!added) {
          OpenSaveModelData?.object?.postData?.forEach((element) {
            pageControllers.add(PageController());
            currentPages.add(0);
          });

          OpenSaveModelData?.object?.repostOn?.postData?.forEach((element) {
            pageControllersRepost.add(PageController());
            currentPagesRepost.add(0);
          });
          WidgetsBinding.instance
              .addPostFrameCallback((timeStamp) => super.setState(() {
                    added = true;
                  }));
        }
      }

      if (state is PostLikeLoadedState) {
        BlocProvider.of<OpenSaveCubit>(context).openSaveImagePostAPI(
          context,
          "${widget.PostID}",
        );
      }
      if (state is RePostLoadedState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.RePost.object.toString()),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return NewBottomBar(
              buttomIndex: 0,
            );
          },
        ), (Route<dynamic> route) => false);
      }
      if (state is PostLikeLoadedState) {
        print("${state.likePost.object}");
        if (state.likePost.object != 'Post Liked Successfully' &&
            state.likePost.object != 'Post Unliked Successfully') {
          SnackBar snackBar = SnackBar(
            content: Text(state.likePost.object ?? ""),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      if (state is UserTagSaveLoadedState) {
        userTagModel = await state.userTagModel;
      }
    }, builder: (context, state) {
      if (state is OpenSaveLoadingState) {
        return Center(
            child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                )));
      }
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      Container(
                        height: 55,
                        width: _width,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("sdfgsdgfdgf-${widget.isnavgation}");
                                /*   if (widget.isnavgation == true) {
                                  print("sdsdfgdgdfdgd-${widget.isnavgation}");
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OpenSavePostImage(
                                            PostID:
                                                '${OpenSaveModelData?.object?.postUid}',isnavgation: false),
                                      ),
                                      (route) => false);
                                } else {
                                  
                                } */
                                //

                                if (widget.isnavgation == true) {
                                  Navigator.pop(context);
                                }
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                child: Center(
                                  child: Image.asset(
                                    ImageConstant.whiteClose,
                                    fit: BoxFit.fill,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      OpenSaveModelData?.object?.repostOn != null
                          ? Container(
                              /*   decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromRGBO(0, 0, 0, 0.25)),
                                borderRadius: BorderRadius.circular(15)),
                            // height: 300, */
                              width: _width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Container(
                                    height: 60,
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
                                                            "${OpenSaveModelData?.object?.userUid}",
                                                        isFollowing:
                                                            OpenSaveModelData
                                                                ?.object
                                                                ?.isFollowing));
                                              }));
                                            }

                                            ///
                                          },
                                          child: OpenSaveModelData?.object
                                                          ?.userProfilePic !=
                                                      null &&
                                                  OpenSaveModelData?.object
                                                          ?.userProfilePic !=
                                                      ""
                                              ? CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      "${OpenSaveModelData?.object?.userProfilePic}"),
                                                  backgroundColor: Colors.white,
                                                  radius: 25,
                                                )
                                              : CustomImageView(
                                                  imagePath:
                                                      ImageConstant.tomcruse,
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.fill,
                                                  radius:
                                                      BorderRadius.circular(25),
                                                ),
                                        ),
                                        title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return ProfileScreen(
                                                            User_ID:
                                                                "${OpenSaveModelData?.object?.userUid}",
                                                            isFollowing:
                                                                OpenSaveModelData
                                                                    ?.object
                                                                    ?.isFollowing);
                                                      }));
                                                    },
                                                    child: Container(
                                                      child: Text(
                                                        '${OpenSaveModelData?.object?.postUserName}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontFamily: 'outfit',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  uuid !=
                                                          OpenSaveModelData
                                                              ?.object?.userUid
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            if (uuid == null) {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              RegisterCreateAccountScreen()));
                                                            } else {
                                                              await BlocProvider
                                                                      .of<OpenSaveCubit>(
                                                                          context)
                                                                  .followWIngMethodd(
                                                                      OpenSaveModelData
                                                                          ?.object
                                                                          ?.userUid,
                                                                      context);
                                                            }
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
                                                            child: uuid == null
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
                                                                : OpenSaveModelData
                                                                            ?.object
                                                                            ?.userAccountType ==
                                                                        "PUBLIC"
                                                                    ? (OpenSaveModelData?.object?.isFollowing ==
                                                                            'FOLLOW'
                                                                        ? Text(
                                                                            'Follow',
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
                                                                          ))
                                                                    : OpenSaveModelData?.object?.isFollowing ==
                                                                            'FOLLOW'
                                                                        ? Text(
                                                                            'Follow',
                                                                            style: TextStyle(
                                                                                fontFamily: "outfit",
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white),
                                                                          )
                                                                        : OpenSaveModelData?.object?.isFollowing ==
                                                                                'REQUESTED'
                                                                            ? Text(
                                                                                'Requested',
                                                                                style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                              )
                                                                            : Text(
                                                                                'Following ',
                                                                                style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                              ),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          key: buttonKey,
                                                          onTap: () {
                                                            showPopupMenu(
                                                                context,
                                                                buttonKey);
                                                          },
                                                          child: Icon(
                                                            Icons.more_vert,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              Text(
                                                  customFormat(
                                                      parsedDateTimeBlogs!),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontFamily: 'outfit',
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Spacer(),
                                            ])),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  OpenSaveModelData?.object?.description == null
                                      ? SizedBox()
                                      : /* OpenSaveModelData?.object
                                                  ?.translatedDescription !=
                                              null
                                          ? SizedBox()
                                          : SizedBox(), */
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                LinkifyText(
                                                  // "${OpenSaveModelData?.object?.description}",
                                                  /* OpenSaveModelData?.object
                                                            ?.isTrsnalteoption ==
                                                        false ||
                                                    OpenSaveModelData?.object
                                                            ?.isTrsnalteoption ==
                                                        null
                                                ? "${OpenSaveModelData?.object?.description}"
                                                : "${OpenSaveModelData?.object?.translatedDescription}", */

                                                  readmoree == true
                                                      ? (OpenSaveModelData
                                                                      ?.object
                                                                      ?.isTrsnalteoption ==
                                                                  false ||
                                                              OpenSaveModelData
                                                                      ?.object
                                                                      ?.isTrsnalteoption ==
                                                                  null)
                                                          ? "${OpenSaveModelData?.object?.description ?? ""}${(OpenSaveModelData?.object?.description?.length ?? 0) > maxLength ? ' ...ReadLess' : ''}"
                                                          : "${OpenSaveModelData?.object?.translatedDescription}"
                                                      : (OpenSaveModelData
                                                                      ?.object
                                                                      ?.isTrsnalteoption ==
                                                                  false ||
                                                              OpenSaveModelData
                                                                      ?.object
                                                                      ?.isTrsnalteoption ==
                                                                  null)
                                                          ? "${OpenSaveModelData?.object?.description?.substring(0, maxLength)} ...ReadMore"
                                                          : "${OpenSaveModelData?.object?.translatedDescription?.substring(0, maxLength)} ...ReadMore",
                                                  linkStyle: TextStyle(
                                                    color: Colors.blue,
                                                    fontFamily: 'outfit',
                                                  ),
                                                  textStyle: TextStyle(
                                                    color: Colors.white,
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
                                                    if ((OpenSaveModelData
                                                                ?.object
                                                                ?.description
                                                                ?.length ??
                                                            0) >
                                                        maxLength) {
                                                      setState(() {
                                                        if (readmoree == true) {
                                                          readmoree = false;
                                                          print(
                                                              "--------------false ");
                                                        } else {
                                                          readmoree = true;
                                                          print(
                                                              "-------------- true");
                                                        }
                                                      });
                                                    }
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
                                                          launchUrl(Uri.parse(
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
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HashTagViewScreen(
                                                                      title:
                                                                          "${link.value}"),
                                                            ));
                                                      } else if (link.value!
                                                          .startsWith('@')) {
                                                        var name;
                                                        var tagName;
                                                        name = SelectedTest;
                                                        tagName =
                                                            name.replaceAll(
                                                                "@", "");
                                                        await BlocProvider.of<
                                                                    OpenSaveCubit>(
                                                                context)
                                                            .UserTagAPI(context,
                                                                tagName);

                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return ProfileScreen(
                                                              User_ID:
                                                                  "${userTagModel?.object}",
                                                              isFollowing: "");
                                                        }));

                                                        print(
                                                            "tagName -- ${tagName}");
                                                        print(
                                                            "user id -- ${userTagModel?.object}");
                                                      } else {
                                                        // launchUrl(Uri.parse(
                                                        //     "https://${link.value.toString()}"));
                                                      }
                                                    }
                                                  },
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    readmoree == true &&
                                                            OpenSaveModelData
                                                                    ?.object
                                                                    ?.translatedDescription !=
                                                                null
                                                        ? GestureDetector(
                                                            onTap: () async {
                                                              super
                                                                  .setState(() {
                                                                if (OpenSaveModelData
                                                                            ?.object
                                                                            ?.isTrsnalteoption ==
                                                                        false ||
                                                                    OpenSaveModelData
                                                                            ?.object
                                                                            ?.isTrsnalteoption ==
                                                                        null) {
                                                                  OpenSaveModelData
                                                                      ?.object
                                                                      ?.isTrsnalteoption = true;
                                                                } else {
                                                                  OpenSaveModelData
                                                                          ?.object
                                                                          ?.isTrsnalteoption =
                                                                      false;
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                                width: 80,
                                                                decoration: BoxDecoration(
                                                                    color: ColorConstant
                                                                        .primaryLight_color,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Translate",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'outfit',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ))),
                                                          )
                                                        : SizedBox(),
                                                    /*    Align(
                                                      // this seaction is repost
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: (OpenSaveModelData
                                                                      ?.object
                                                                      ?.description
                                                                      ?.length ??
                                                                  0) >
                                                              maxLength
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (readmoree ==
                                                                      true) {
                                                                    readmoree =
                                                                        false;
                                                                    print(
                                                                        "--------------false ");
                                                                  } else {
                                                                    readmoree =
                                                                        true;
                                                                    print(
                                                                        "-------------- true");
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                // color: Colors.red,
                                                                width: 75,
                                                                height: 15,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    readmoree ==
                                                                            true
                                                                        ? 'Read Less'
                                                                        : 'Read More',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                    ), */
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                  (OpenSaveModelData
                                              ?.object?.postData?.isEmpty ??
                                          false)
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            print("fgsdgfsdgsdgfgsdfg");
                                          },
                                          child: Container(
                                            // height: 200,
                                            width: _width,
                                            child: OpenSaveModelData?.object
                                                        ?.postDataType ==
                                                    null
                                                ? SizedBox()
                                                : OpenSaveModelData
                                                            ?.object
                                                            ?.postData
                                                            ?.length ==
                                                        1
                                                    ? (OpenSaveModelData?.object
                                                                ?.postDataType ==
                                                            "IMAGE"
                                                        ? Container(
                                                            // height: 200,
                                                            width: _width,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 16,
                                                                    top: 15,
                                                                    right: 16),
                                                            child: Center(
                                                                child:
                                                                    GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ZoomableImage(
                                                                              imageUrl: '${OpenSaveModelData?.object?.postData?[0]}'),
                                                                    ));
                                                              },
                                                              child:
                                                                  CustomImageView(
                                                                url:
                                                                    "${OpenSaveModelData?.object?.postData?[0]}",
                                                              ),
                                                            )),
                                                          )
                                                        : OpenSaveModelData
                                                                    ?.object
                                                                    ?.postDataType ==
                                                                "VIDEO"
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20,
                                                                        top:
                                                                            15),
                                                                child:
                                                                    VideoListItem(
                                                                  videoUrl: OpenSaveModelData
                                                                          ?.object
                                                                          ?.postData
                                                                          ?.first ??
                                                                      '',
                                                                ),
                                                              )
                                                            : OpenSaveModelData
                                                                        ?.object
                                                                        ?.postDataType ==
                                                                    "ATTACHMENT"
                                                                ? (OpenSaveModelData
                                                                            ?.object
                                                                            ?.postData
                                                                            ?.isNotEmpty ==
                                                                        true)
                                                                    ? /*  Container(
                                                                        height: 200,
                                                                        width: _width,
                                                                        child:
                                                                            DocumentViewScreen1(
                                                                          path: OpenSaveModelData
                                                                              ?.object
                                                                              ?.postData?[
                                                                                  0]
                                                                              .toString(),
                                                                        )) */
                                                                    Stack(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                400,
                                                                            width:
                                                                                _width,
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              print("objectobjectobjectobject");
                                                                              Navigator.push(context, MaterialPageRoute(
                                                                                builder: (context) {
                                                                                  return DocumentViewScreen1(
                                                                                    path: OpenSaveModelData?.object?.postData?[0].toString(),
                                                                                  );
                                                                                },
                                                                              ));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: OpenSaveModelData?.object?.thumbnailImageUrl ?? "",
                                                                                fit: BoxFit.cover,
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
                                                              if ((OpenSaveModelData
                                                                      ?.object
                                                                      ?.postData
                                                                      ?.isNotEmpty ??
                                                                  false)) ...[
                                                                Container(
                                                                  color: Colors
                                                                      .transparent,
                                                                  height:
                                                                      _height /
                                                                          5,
                                                                  child: PageView
                                                                      .builder(
                                                                    onPageChanged:
                                                                        (page) {
                                                                      super.setState(
                                                                          () {
                                                                        currentPages[widget.index ??
                                                                                0] =
                                                                            page;
                                                                        imageCount =
                                                                            page +
                                                                                1;
                                                                      });
                                                                    },
                                                                    controller:
                                                                        pageControllers[
                                                                            widget.index ??
                                                                                0],
                                                                    itemCount: OpenSaveModelData
                                                                        ?.object
                                                                        ?.postData
                                                                        ?.length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index1) {
                                                                      if (OpenSaveModelData
                                                                              ?.object
                                                                              ?.postDataType ==
                                                                          "IMAGE") {
                                                                        return Container(
                                                                          width:
                                                                              _width,
                                                                          margin: EdgeInsets.only(
                                                                              left: 16,
                                                                              top: 15,
                                                                              right: 16),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Align(
                                                                                  alignment: Alignment.topCenter,
                                                                                  child: CustomImageView(
                                                                                    url: "${OpenSaveModelData?.object?.postData?[index1]}",
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
                                                                                          imageCount.toString() + '/' + '${OpenSaveModelData?.object?.postData?.length}',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        )),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else if (OpenSaveModelData
                                                                              ?.object
                                                                              ?.postDataType ==
                                                                          "ATTACHMENT") {
                                                                        return Container(
                                                                            height:
                                                                                400,
                                                                            width:
                                                                                _width,
                                                                            // color: Colors.green,
                                                                            child:
                                                                                DocumentViewScreen1(
                                                                              path: OpenSaveModelData?.object?.postData?[index1].toString(),
                                                                            ));
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                Positioned(
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
                                                                              OpenSaveModelData?.object?.postData?.length ?? 1,
                                                                          position:
                                                                              currentPages[widget.index ?? 0].toDouble(),
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
                                                              ]
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                          ),
                                        ),
                                  // inner post portion

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 10,
                                        top: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.white,
                                          border:
                                              Border.all(color: Colors.white),
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
                                            height: 60,
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
                                                              builder:
                                                                  (context) {
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
                                                                    "${OpenSaveModelData?.object?.repostOn?.userUid}",
                                                                isFollowing:
                                                                    OpenSaveModelData
                                                                        ?.object
                                                                        ?.repostOn
                                                                        ?.isFollowing));
                                                      }));
                                                    }

                                                    //
                                                  },
                                                  child: OpenSaveModelData
                                                                  ?.object
                                                                  ?.repostOn
                                                                  ?.userProfilePic !=
                                                              null &&
                                                          OpenSaveModelData
                                                                  ?.object
                                                                  ?.repostOn
                                                                  ?.userProfilePic !=
                                                              ""
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${OpenSaveModelData?.object?.repostOn?.userProfilePic}"),
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 25,
                                                        )
                                                      : CustomImageView(
                                                          imagePath:
                                                              ImageConstant
                                                                  .tomcruse,
                                                          height: 50,
                                                          width: 50,
                                                          fit: BoxFit.fill,
                                                          radius: BorderRadius
                                                              .circular(25),
                                                        ),
                                                ),
                                                title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return ProfileScreen(
                                                                User_ID:
                                                                    "${OpenSaveModelData?.object?.repostOn?.userUid}",
                                                                isFollowing:
                                                                    OpenSaveModelData
                                                                        ?.object
                                                                        ?.repostOn
                                                                        ?.isFollowing);
                                                          }));
                                                        },
                                                        child: Container(
                                                          child: Text(
                                                            '${OpenSaveModelData?.object?.repostOn?.postUserName}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'outfit',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                          customFormat(
                                                              repostTime!),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                            fontFamily:
                                                                'outfit',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ))
                                                    ])),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          OpenSaveModelData?.object?.repostOn
                                                      ?.description ==
                                                  null
                                              ? SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OpenSavePostImage(
                                                                  PostID: OpenSaveModelData
                                                                      ?.object
                                                                      ?.repostOn
                                                                      ?.postUid)),
                                                    ).then((value) => BlocProvider
                                                            .of<OpenSaveCubit>(
                                                                context)
                                                        .openSaveImagePostAPI(
                                                            context,
                                                            "${widget.PostID}"));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: LinkifyText(
                                                        readmoree == true
                                                            ? (OpenSaveModelData
                                                                            ?.object
                                                                            ?.repostOn
                                                                            ?.isTrsnalteoption ==
                                                                        false ||
                                                                    OpenSaveModelData
                                                                            ?.object
                                                                            ?.repostOn
                                                                            ?.isTrsnalteoption ==
                                                                        null)
                                                                ? "${OpenSaveModelData?.object?.repostOn?.description ?? ""}${(OpenSaveModelData?.object?.repostOn?.description?.length ?? 0) > maxLength ? ' ...ReadLess' : ''}"
                                                                : "${OpenSaveModelData?.object?.repostOn?.translatedDescription}"
                                                            : (OpenSaveModelData
                                                                            ?.object
                                                                            ?.repostOn
                                                                            ?.isTrsnalteoption ==
                                                                        false ||
                                                                    OpenSaveModelData
                                                                            ?.object
                                                                            ?.repostOn
                                                                            ?.isTrsnalteoption ==
                                                                        null)
                                                                ? "${OpenSaveModelData?.object?.repostOn?.description?.substring(0, maxLength)} ...ReadMore "
                                                                : "${OpenSaveModelData?.object?.repostOn?.translatedDescription?.substring(0, maxLength)} ...ReadMore",
                                                        // opem save post image
                                                        linkStyle: TextStyle(
                                                          color: Colors.blue,
                                                          fontFamily: 'outfit',
                                                        ),
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
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
                                                          if ((OpenSaveModelData
                                                                      ?.object
                                                                      ?.repostOn
                                                                      ?.description
                                                                      ?.length ??
                                                                  0) >
                                                              maxLength) {
                                                            setState(() {
                                                              if (readmoree ==
                                                                  true) {
                                                                readmoree =
                                                                    false;
                                                                print(
                                                                    "--------------false ");
                                                              } else {
                                                                readmoree =
                                                                    true;
                                                                print(
                                                                    "-------------- true");
                                                              }
                                                            });
                                                          }
                                                          var SelectedTest =
                                                              link.value
                                                                  .toString();
                                                          var Link =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'https');
                                                          var Link1 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'http');
                                                          var Link2 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'www');
                                                          var Link3 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'WWW');
                                                          var Link4 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'HTTPS');
                                                          var Link5 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'HTTP');
                                                          var Link6 = SelectedTest
                                                              .startsWith(
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
                                                              launchUrl(Uri.parse(
                                                                  "https://${link.value.toString()}"));
                                                            } else {
                                                              if (Link6 ==
                                                                  true) {
                                                                print(
                                                                    "yes i am in room");
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return NewBottomBar(
                                                                      buttomIndex:
                                                                          1,
                                                                    );
                                                                  },
                                                                ));
                                                              } else {
                                                                launchUrl(Uri
                                                                    .parse(link
                                                                        .value
                                                                        .toString()));
                                                                print(
                                                                    "link.valuelink.value -- ${link.value}");
                                                              }
                                                            }
                                                          } else {
                                                            if (link.value!
                                                                .startsWith(
                                                                    '#')) {
                                                              print("${link}");
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        HashTagViewScreen(
                                                                            title:
                                                                                "${link.value}"),
                                                                  ));
                                                            } else if (link
                                                                .value!
                                                                .startsWith(
                                                                    '@')) {
                                                              var name;
                                                              var tagName;
                                                              name =
                                                                  SelectedTest;
                                                              tagName = name
                                                                  .replaceAll(
                                                                      "@", "");
                                                              await BlocProvider
                                                                      .of<OpenSaveCubit>(
                                                                          context)
                                                                  .UserTagAPI(
                                                                      context,
                                                                      tagName);

                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return ProfileScreen(
                                                                    User_ID:
                                                                        "${userTagModel?.object}",
                                                                    isFollowing:
                                                                        "");
                                                              }));

                                                              print(
                                                                  "tagName -- ${tagName}");
                                                              print(
                                                                  "user id -- ${userTagModel?.object}");
                                                            } else {
                                                              // launchUrl(Uri.parse(
                                                              //     "https://${link.value.toString()}"));
                                                            }
                                                          }
                                                        },
                                                      ), /* Text(
                                                                        "${OpenSaveModelData?.object?.description ?? ""}",
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 16,
                                                                          fontFamily: 'outfit',
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ) */
                                                    ),
                                                  ),
                                                ),
                                          if (readmoree == true &&
                                              OpenSaveModelData
                                                      ?.object
                                                      ?.repostOn
                                                      ?.translatedDescription !=
                                                  null)
                                            GestureDetector(
                                              onTap: () async {
                                                super.setState(() {
                                                  if (OpenSaveModelData
                                                              ?.object
                                                              ?.repostOn
                                                              ?.isTrsnalteoption ==
                                                          false ||
                                                      OpenSaveModelData
                                                              ?.object
                                                              ?.repostOn
                                                              ?.isTrsnalteoption ==
                                                          null) {
                                                    OpenSaveModelData
                                                            ?.object
                                                            ?.repostOn
                                                            ?.isTrsnalteoption =
                                                        true;
                                                  } else {
                                                    OpenSaveModelData
                                                            ?.object
                                                            ?.repostOn
                                                            ?.isTrsnalteoption =
                                                        false;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10, top: 10),
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .primaryLight_color,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text(
                                                    "Translate",
                                                    style: TextStyle(
                                                      fontFamily: 'outfit',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ))),
                                            ),
                                          Container(
                                            width: _width,
                                            child: OpenSaveModelData
                                                        ?.object
                                                        ?.repostOn
                                                        ?.postDataType ==
                                                    null
                                                ? SizedBox()
                                                : OpenSaveModelData
                                                            ?.object
                                                            ?.repostOn
                                                            ?.postData
                                                            ?.length ==
                                                        1
                                                    ? (OpenSaveModelData
                                                                ?.object
                                                                ?.repostOn
                                                                ?.postDataType ==
                                                            "IMAGE"
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            OpenSavePostImage(
                                                                      PostID: OpenSaveModelData
                                                                              ?.object
                                                                              ?.repostOn
                                                                              ?.postUid ??
                                                                          '',
                                                                      isnavgation:
                                                                          true,
                                                                    ),
                                                                  ));
                                                            },
                                                            child: Container(
                                                              width: _width,
                                                              height: 150,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 16,
                                                                      top: 15,
                                                                      right:
                                                                          16),
                                                              child: Center(
                                                                  child:
                                                                      CustomImageView(
                                                                url:
                                                                    "${OpenSaveModelData?.object?.repostOn?.postData?[0]}",
                                                              )),
                                                            ),
                                                          )
                                                        : OpenSaveModelData
                                                                    ?.object
                                                                    ?.repostOn
                                                                    ?.postDataType ==
                                                                "VIDEO"
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20,
                                                                        top:
                                                                            15),
                                                                child:
                                                                    VideoListItem(
                                                                  videoUrl: OpenSaveModelData
                                                                          ?.object
                                                                          ?.repostOn
                                                                          ?.postData
                                                                          ?.first ??
                                                                      '',
                                                                ),
                                                              )
                                                            // : SizedBox()
                                                            : OpenSaveModelData
                                                                        ?.object
                                                                        ?.repostOn
                                                                        ?.postDataType ==
                                                                    "ATTACHMENT"
                                                                ? /* Container(
                                                                    height: 400,
                                                                    width: _width,
                                                                    child:
                                                                        DocumentViewScreen1(
                                                                      path: "",
                                                                    )) */
                                                                Stack(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            400,
                                                                        width:
                                                                            _width,
                                                                        color: Colors
                                                                            .transparent,
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
                                                                              return DocumentViewScreen1(
                                                                                path: OpenSaveModelData?.object?.repostOn?.postData?[0].toString(),
                                                                              );
                                                                            },
                                                                          ));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                OpenSaveModelData?.object?.repostOn?.thumbnailImageUrl ?? "",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                : SizedBox())
                                                    : Column(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              if ((OpenSaveModelData
                                                                      ?.object
                                                                      ?.repostOn
                                                                      ?.postData
                                                                      ?.isNotEmpty ??
                                                                  false)) ...[
                                                                Container(
                                                                  color: Colors
                                                                      .transparent,
                                                                  height:
                                                                      _height /
                                                                          2,
                                                                  child: PageView
                                                                      .builder(
                                                                    onPageChanged:
                                                                        (page) {
                                                                      super.setState(
                                                                          () {
                                                                        currentPagesRepost[widget.index ??
                                                                                0] =
                                                                            page;
                                                                        imageCount =
                                                                            page +
                                                                                1;
                                                                      });
                                                                    },
                                                                    controller:
                                                                        pageControllersRepost[
                                                                            widget.index ??
                                                                                0],
                                                                    itemCount: OpenSaveModelData
                                                                        ?.object
                                                                        ?.repostOn
                                                                        ?.postData
                                                                        ?.length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index1) {
                                                                      if (OpenSaveModelData
                                                                              ?.object
                                                                              ?.repostOn
                                                                              ?.postDataType ==
                                                                          "IMAGE") {
                                                                        return Container(
                                                                          width:
                                                                              _width,
                                                                          margin: EdgeInsets.only(
                                                                              left: 16,
                                                                              top: 15,
                                                                              right: 16),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Align(
                                                                                  alignment: Alignment.topCenter,
                                                                                  child: CustomImageView(
                                                                                    url: "${OpenSaveModelData?.object?.repostOn?.postData?[index1]}",
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
                                                                                          imageCount.toString() + '/' + '${OpenSaveModelData?.object?.repostOn?.postData?.length}',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        )),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else if (OpenSaveModelData
                                                                              ?.object
                                                                              ?.repostOn
                                                                              ?.postDataType ==
                                                                          "ATTACHMENT") {
                                                                        return Container(
                                                                            height:
                                                                                400,
                                                                            width:
                                                                                _width,
                                                                            // color: Colors.green,
                                                                            child:
                                                                                DocumentViewScreen1(
                                                                              path: OpenSaveModelData?.object?.repostOn?.postData?[index1].toString(),
                                                                            ));
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                Positioned(
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
                                                                              OpenSaveModelData?.object?.repostOn?.postData?.length ?? 1,
                                                                          position:
                                                                              currentPagesRepost[widget.index ?? 0].toDouble(),
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
                                                              ]
                                                            ],
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
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    // color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, right: 0, bottom: 20),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 0,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (uuid == null) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterCreateAccountScreen()));
                                              } else {
                                                await soicalFunation(
                                                  apiName: 'like_post',
                                                );
                                              }
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: OpenSaveModelData
                                                            ?.object?.isLiked !=
                                                        true
                                                    ? Image.asset(
                                                        ImageConstant
                                                            .likewithout,
                                                        height: 20,
                                                        color: Colors.white,
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
                                          OpenSaveModelData
                                                      ?.object?.likedCount ==
                                                  0
                                              ? SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        
                                                            ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */

                                                    if (uuid == null) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RegisterCreateAccountScreen()));
                                                    } else {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return ShowAllPostLike(
                                                              "${OpenSaveModelData?.object?.postUid}");
                                                        },
                                                      ));
                                                    }
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "${OpenSaveModelData?.object?.likedCount}",
                                                        style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (uuid == null) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterCreateAccountScreen()));
                                              } else {
                                                BlocProvider.of<
                                                            AddcommentCubit>(
                                                        context)
                                                    .Addcomment(context,
                                                        '${OpenSaveModelData?.object?.postUid}');

                                                _settingModalBottomSheet1(
                                                    context, 0, _width);
                                              }

                                              /*     await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return CommentsScreen(
                                                                image:
                                                                    AllGuestPostRoomData
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
                                                              );
                                                            })).then((value) =>
                                                                methodtoReffrser()); */
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Image.asset(
                                                  ImageConstant.meesage,
                                                  height: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          OpenSaveModelData
                                                      ?.object?.commentCount ==
                                                  0
                                              ? SizedBox()
                                              : Text(
                                                  "${OpenSaveModelData?.object?.commentCount}",
                                                  style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          GestureDetector(
                                            onTap: () {
                                              if (uuid == null) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterCreateAccountScreen()));
                                              } else {
                                                rePostBottomSheet(
                                                  context,
                                                );
                                              }
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Image.asset(
                                                  ImageConstant.vector2,
                                                  height: 13,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          OpenSaveModelData
                                                      ?.object?.repostCount ==
                                                  0
                                              ? SizedBox()
                                              : Text(
                                                  '${OpenSaveModelData?.object?.repostCount}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "outfit",
                                                      fontSize: 14),
                                                ),
                                          GestureDetector(
                                            onTap: () {
                                              if (uuid == null) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterCreateAccountScreen()));
                                              } else {
                                                _onShareXFileFromAssets(context,
                                                    androidLink:
                                                        '${OpenSaveModelData?.object?.postLink}'
                                                    /* iosLink:
                                                      "https://apps.apple.com/inList =  /app/growder-b2b-platform/id6451333863" */
                                                    );
                                              }
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 30,
                                              color: Colors.transparent,
                                              child: Icon(Icons.share_rounded,
                                                  color: Colors.white,
                                                  size: 20),
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () async {
                                              if (uuid == null) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterCreateAccountScreen()));
                                              } else {
                                                await soicalFunation(
                                                  apiName: 'savedata',
                                                );
                                              }
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: OpenSaveModelData
                                                              ?.object
                                                              ?.isSaved ==
                                                          false
                                                      ? Image.asset(
                                                          ImageConstant.savePin,
                                                          height: 18,
                                                          color: Colors.white,
                                                        )
                                                      : Image.asset(
                                                          ImageConstant
                                                              .Savefill,
                                                          height: 18,
                                                        )

                                                  // color: Colors.white,
                                                  ),
                                            ),
                                          ),

                                          // GestureDetector(
                                          //   onTap: () {
                                          //     Share.share(
                                          //         'https://play.google.com/store/apps/details?id=com.inpackaging.app');
                                          //   },
                                          //   child: Container(
                                          //     color: Colors.transparent,
                                          //     child: Padding(
                                          //       padding: const EdgeInsets.all(5.0),
                                          //       child: Image.asset(
                                          //         ImageConstant.shareWhite,
                                          //         height: 17,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  child: Row(children: [
                                    GestureDetector(
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
                                            return ProfileScreen(
                                                User_ID:
                                                    "${OpenSaveModelData?.object?.userUid}",
                                                isFollowing: OpenSaveModelData
                                                    ?.object?.isFollowing);
                                          }));
                                        }
                                      },
                                      child: OpenSaveModelData?.object
                                                      ?.userProfilePic !=
                                                  null &&
                                              OpenSaveModelData?.object
                                                      ?.userProfilePic !=
                                                  ""
                                          ? CustomImageView(
                                              url:
                                                  "${OpenSaveModelData?.object?.userProfilePic}",
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fill,
                                              radius: BorderRadius.circular(25),
                                            )
                                          : CustomImageView(
                                              imagePath: ImageConstant.tomcruse,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fill,
                                              radius: BorderRadius.circular(25),
                                            ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return ProfileScreen(
                                                    User_ID:
                                                        "${OpenSaveModelData?.object?.userUid}",
                                                    isFollowing:
                                                        OpenSaveModelData
                                                            ?.object
                                                            ?.isFollowing);
                                              }));
                                            },
                                            child: Container(
                                              child: Text(
                                                '${OpenSaveModelData?.object?.postUserName}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'outfit',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                              customFormat(
                                                  parsedDateTimeBlogs ??
                                                      DateTime(
                                                          2017, 9, 7, 17, 30)),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontFamily: 'outfit',
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ]),
                                    Spacer(),
                                    uuid != OpenSaveModelData?.object?.userUid
                                        ? GestureDetector(
                                            onTap: () async {
                                              if (uuid == null) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterCreateAccountScreen()));
                                              } else {
                                                await BlocProvider.of<
                                                        OpenSaveCubit>(context)
                                                    .followWIngMethodd(
                                                        OpenSaveModelData
                                                            ?.object?.userUid,
                                                        context);
                                              }
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
                                                      BorderRadius.circular(4)),
                                              child: uuid == null
                                                  ? Text(
                                                      'Follow',
                                                      style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    )
                                                  : OpenSaveModelData?.object
                                                              ?.userAccountType ==
                                                          "PUBLIC"
                                                      ? (OpenSaveModelData
                                                                  ?.object
                                                                  ?.isFollowing ==
                                                              'FOLLOW'
                                                          ? Text(
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
                                                            ))
                                                      : OpenSaveModelData
                                                                  ?.object
                                                                  ?.isFollowing ==
                                                              'FOLLOW'
                                                          ? Text(
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
                                                            )
                                                          : OpenSaveModelData
                                                                      ?.object
                                                                      ?.isFollowing ==
                                                                  'REQUESTED'
                                                              ? Text(
                                                                  'Requested',
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
                                                                  'Following ',
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
                                          )
                                        : GestureDetector(
                                            key: buttonKey,
                                            onTap: () {
                                              showPopupMenu(context, buttonKey);
                                            },
                                            child: Icon(
                                              Icons.more_vert,
                                              color: Colors.white,
                                            ),
                                          )
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LinkifyText(
                                          // "${OpenSaveModelData?.object?.description}",
                                          readmoree == true
                                              ? (OpenSaveModelData?.object
                                                              ?.isTrsnalteoption ==
                                                          false ||
                                                      OpenSaveModelData?.object
                                                              ?.isTrsnalteoption ==
                                                          null)
                                                  ? "${OpenSaveModelData?.object?.description ?? ""}${(OpenSaveModelData?.object?.description?.length ?? 0) > maxLength ? ' ...ReadLess' : ''}"
                                                  : "${OpenSaveModelData?.object?.translatedDescription}"
                                              : (OpenSaveModelData?.object
                                                              ?.isTrsnalteoption ==
                                                          false ||
                                                      OpenSaveModelData?.object
                                                              ?.isTrsnalteoption ==
                                                          null)
                                                  ? "${OpenSaveModelData?.object?.description?.substring(0, maxLength)} ...ReadMore "
                                                  : "${OpenSaveModelData?.object?.translatedDescription?.substring(0, maxLength)} ...ReadMore",
                                          linkStyle: TextStyle(
                                            color: Colors.blue,
                                            fontFamily: 'outfit',
                                          ),
                                          textStyle: TextStyle(
                                            color: Colors.white,
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
                                            var Link = SelectedTest.startsWith(
                                                'https');
                                            var Link1 =
                                                SelectedTest.startsWith('http');
                                            var Link2 =
                                                SelectedTest.startsWith('www');
                                            var Link3 =
                                                SelectedTest.startsWith('WWW');
                                            var Link4 = SelectedTest.startsWith(
                                                'HTTPS');
                                            var Link5 =
                                                SelectedTest.startsWith('HTTP');
                                            var Link6 = SelectedTest.startsWith(
                                                'https://pdslink.page.link/');
                                            print(SelectedTest.toString());
                                            if ((OpenSaveModelData?.object
                                                        ?.description?.length ??
                                                    0) >
                                                maxLength) {
                                              setState(() {
                                                if (readmoree == true) {
                                                  readmoree = false;
                                                  print("--------------false ");
                                                } else {
                                                  readmoree = true;
                                                  print("-------------- true");
                                                }
                                              });
                                            }

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
                                                  launchUrl(Uri.parse(
                                                      link.value.toString()));
                                                  print(
                                                      "link.valuelink.value -- ${link.value}");
                                                }
                                              }
                                            } else {
                                              if (link.value!.startsWith('#')) {
                                                print("${link}");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HashTagViewScreen(
                                                              title:
                                                                  "${link.value}"),
                                                    ));
                                              } else if (link.value!
                                                  .startsWith('@')) {
                                                var name;
                                                var tagName;
                                                name = SelectedTest;
                                                tagName =
                                                    name.replaceAll("@", "");
                                                await BlocProvider.of<
                                                        OpenSaveCubit>(context)
                                                    .UserTagAPI(
                                                        context, tagName);

                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return ProfileScreen(
                                                      User_ID:
                                                          "${userTagModel?.object}",
                                                      isFollowing: "");
                                                }));

                                                print("tagName -- ${tagName}");
                                                print(
                                                    "user id -- ${userTagModel?.object}");
                                              } else {
                                                // launchUrl(Uri.parse(
                                                //     "https://${link.value.toString()}"));
                                              }
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            readmoree == true &&
                                                    OpenSaveModelData?.object
                                                            ?.translatedDescription !=
                                                        null
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      super.setState(() {
                                                        if (OpenSaveModelData
                                                                    ?.object
                                                                    ?.isTrsnalteoption ==
                                                                false ||
                                                            OpenSaveModelData
                                                                    ?.object
                                                                    ?.isTrsnalteoption ==
                                                                null) {
                                                          OpenSaveModelData
                                                                  ?.object
                                                                  ?.isTrsnalteoption =
                                                              true;
                                                        } else {
                                                          OpenSaveModelData
                                                                  ?.object
                                                                  ?.isTrsnalteoption =
                                                              false;
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                            color: ColorConstant
                                                                .primaryLight_color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                            child: Text(
                                                          "Translate",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'outfit',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ))),
                                                  )
                                                : SizedBox(),
                                            /*  Align(
                                              alignment: Alignment.centerRight,
                                              child: (OpenSaveModelData
                                                              ?.object
                                                              ?.description
                                                              ?.length ??
                                                          0) >
                                                      maxLength
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (readmoree ==
                                                              true) {
                                                            readmoree = false;
                                                            print(
                                                                "--------------false ");
                                                          } else {
                                                            readmoree = true;
                                                            print(
                                                                "-------------- true");
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        // color: Colors.red,
                                                        width: 75,
                                                        height: 15,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            readmoree == true
                                                                ? 'Read Less'
                                                                : 'Read More',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ), */
                                          ],
                                        )
                                      ],
                                    ), /* Text(
                                  "${OpenSaveModelData?.object?.description ?? ""}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ) */
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                OpenSaveModelData?.object?.postDataType == null
                                    ? SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          print(
                                              "dfsdfgdgfsdgsdgfdfgdgd-${OpenSaveModelData?.object?.postData?[0] ?? ''}");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ZoomableImage(
                                                    imageUrl:
                                                        '${OpenSaveModelData?.object?.postData?[0] ?? ''}'),
                                              ));
                                        },
                                        child: Container(
                                          // height: _height / 1.5,
                                          // width: _width,
                                          child: OpenSaveModelData
                                                      ?.object?.postDataType ==
                                                  null
                                              ? SizedBox()
                                              : OpenSaveModelData?.object
                                                          ?.postDataType ==
                                                      "VIDEO"
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20,
                                                              top: 15),
                                                      child: VideoListItem(
                                                        videoUrl:
                                                            OpenSaveModelData
                                                                    ?.object
                                                                    ?.postData
                                                                    ?.first ??
                                                                '',
                                                      ),
                                                    )
                                                  : OpenSaveModelData
                                                              ?.object
                                                              ?.postData
                                                              ?.length ==
                                                          1
                                                      ? OpenSaveModelData
                                                                  ?.object
                                                                  ?.postDataType ==
                                                              "IMAGE"
                                                          ? Container(
                                                              // height:
                                                              //     _height / 2,
                                                              width: _width,
                                                              child:
                                                                  CustomImageView(
                                                                url: OpenSaveModelData
                                                                        ?.object
                                                                        ?.postData?[0] ??
                                                                    '',
                                                              )

                                                              /* PhotoView(
                                                                imageProvider: NetworkImage(
                                                                    OpenSaveModelData
                                                                            ?.object
                                                                            ?.postData?[0] ??
                                                                        ''),
                                                                minScale:
                                                                    PhotoViewComputedScale
                                                                        .contained,
                                                                maxScale:
                                                                    PhotoViewComputedScale
                                                                            .covered *
                                                                        2,
                                                                backgroundDecoration:
                                                                    BoxDecoration(
                                                                  color: Colors.black,
                                                                ),
                                                              ), */
                                                              )
                                                          /*  SizedBox(
                                                              height: _height,
                                                              width: _width,
                                                              child: WidgetZoom(
                                                                heroAnimationTag:
                                                                    'tag',
                                                                zoomWidget: Container(
                                                                  width:
                                                                      double.infinity,
                                                                  height:
                                                                      double.infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: NetworkImage(
                                                                          "${OpenSaveModelData?.object?.postData?[0]}"),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ) */
                                                          /*  Center(ss
                                                              child: CustomImageView(
                                                              fit: BoxFit.cover,
                                                              url:
                                                                  "${OpenSaveModelData?.object?.postData?[0]}",
                                                            )) */
                                                          : OpenSaveModelData
                                                                      ?.object
                                                                      ?.postDataType ==
                                                                  "ATTACHMENT"
                                                              ? Container(
                                                                  height: 400,
                                                                  width: _width,
                                                                  child:
                                                                      DocumentViewScreen1(
                                                                    path: "",
                                                                  ))
                                                              : SizedBox()
                                                      : Column(
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                if ((OpenSaveModelData
                                                                        ?.object
                                                                        ?.postData
                                                                        ?.isNotEmpty ??
                                                                    false)) ...[
                                                                  Container(
                                                                    color: Colors
                                                                        .transparent,
                                                                    height:
                                                                        _height /
                                                                            2,
                                                                    child: PageView
                                                                        .builder(
                                                                      onPageChanged:
                                                                          (page) {
                                                                        super.setState(
                                                                            () {
                                                                          currentPages[widget.index ?? 0] =
                                                                              page;
                                                                          imageCount =
                                                                              page + 1;
                                                                        });
                                                                      },
                                                                      controller:
                                                                          pageControllers[widget.index ??
                                                                              0],
                                                                      itemCount: OpenSaveModelData
                                                                          ?.object
                                                                          ?.postData
                                                                          ?.length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index1) {
                                                                        if (OpenSaveModelData?.object?.postDataType ==
                                                                            "IMAGE") {
                                                                          return Container(
                                                                            width:
                                                                                _width,
                                                                            margin: EdgeInsets.only(
                                                                                left: 16,
                                                                                top: 15,
                                                                                right: 16),
                                                                            child:
                                                                                Center(
                                                                              child: Stack(
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                            builder: (context) => ZoomableImage(imageUrl: '${OpenSaveModelData?.object?.postData?[index1]}'),
                                                                                          ));
                                                                                    },
                                                                                    child: Align(
                                                                                        alignment: Alignment.topCenter,
                                                                                        child: Container(height: _height / 2, width: _width, child: CustomImageView(url: OpenSaveModelData?.object?.postData?[index1] ?? '')

                                                                                            /*  PhotoView(
                                                                                            imageProvider: NetworkImage(OpenSaveModelData?.object?.postData?[0] ?? ''),
                                                                                            minScale: PhotoViewComputedScale.contained,
                                                                                            maxScale: PhotoViewComputedScale.covered * 2,
                                                                                            backgroundDecoration: BoxDecoration(
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                          ), */
                                                                                            )),
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
                                                                                            imageCount.toString() + '/' + '${OpenSaveModelData?.object?.postData?.length}',
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          )),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        } else if (OpenSaveModelData?.object?.postDataType ==
                                                                            "ATTACHMENT") {
                                                                          return Container(
                                                                              height: 400,
                                                                              width: _width,
                                                                              // color: Colors.green,
                                                                              child: DocumentViewScreen1(
                                                                                path: OpenSaveModelData?.object?.postData?[index1].toString(),
                                                                              ));
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                      bottom: 5,
                                                                      left: 0,
                                                                      right: 0,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          child:
                                                                              DotsIndicator(
                                                                            dotsCount:
                                                                                OpenSaveModelData?.object?.postData?.length ?? 1,
                                                                            position:
                                                                                currentPages[widget.index ?? 0].toDouble(),
                                                                            decorator:
                                                                                DotsDecorator(
                                                                              size: const Size(10.0, 7.0),
                                                                              activeSize: const Size(10.0, 10.0),
                                                                              spacing: const EdgeInsets.symmetric(horizontal: 2),
                                                                              activeColor: ColorConstant.primary_color,
                                                                              color: Color(0xff6A6A6A),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                ]
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                        ),
                                      ),
                                /* OpenSaveModelData?.object?.description == null
                                    ? SizedBox()
                                    : OpenSaveModelData?.object
                                                ?.translatedDescription !=
                                            null
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                             
                                          )
                                        : SizedBox(), */

                                Container(
                                  // color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, right: 0, bottom: 20),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 0,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (uuid == null) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterCreateAccountScreen()));
                                            } else {
                                              await soicalFunation(
                                                apiName: 'like_post',
                                              );
                                            }
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: OpenSaveModelData
                                                          ?.object?.isLiked !=
                                                      true
                                                  ? Image.asset(
                                                      ImageConstant.likewithout,
                                                      height: 20,
                                                      color: Colors.white,
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
                                        OpenSaveModelData?.object?.likedCount ==
                                                0
                                            ? SizedBox()
                                            : GestureDetector(
                                                onTap: () {
                                                  /* Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                            
                                                                ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */
                                                  if (uuid == null) {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RegisterCreateAccountScreen()));
                                                  } else {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return ShowAllPostLike(
                                                            "${OpenSaveModelData?.object?.postUid}");
                                                      },
                                                    ));
                                                  }
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "${OpenSaveModelData?.object?.likedCount}",
                                                      style: TextStyle(
                                                        fontFamily: "outfit",
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (uuid == null) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterCreateAccountScreen()));
                                            } else {
                                              BlocProvider.of<AddcommentCubit>(
                                                      context)
                                                  .Addcomment(context,
                                                      '${OpenSaveModelData?.object?.postUid}');

                                              _settingModalBottomSheet1(
                                                  context, 0, _width);
                                            }

                                            /*     await Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return CommentsScreen(
                                                                    image:
                                                                        AllGuestPostRoomData
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
                                                                  );
                                                                })).then((value) =>
                                                                    methodtoReffrser()); */
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.asset(
                                                ImageConstant.meesage,
                                                height: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        OpenSaveModelData
                                                    ?.object?.commentCount ==
                                                0
                                            ? SizedBox()
                                            : Text(
                                                "${OpenSaveModelData?.object?.commentCount}",
                                                style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                        GestureDetector(
                                          onTap: () {
                                            if (uuid == null) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterCreateAccountScreen()));
                                            } else {
                                              rePostBottomSheet(
                                                context,
                                              );
                                            }
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.asset(
                                                ImageConstant.vector2,
                                                height: 13,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        OpenSaveModelData
                                                    ?.object?.repostCount ==
                                                0
                                            ? SizedBox()
                                            : Text(
                                                '${OpenSaveModelData?.object?.repostCount}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "outfit",
                                                    fontSize: 14),
                                              ),
                                        GestureDetector(
                                          onTap: () {
                                            if (uuid == null) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterCreateAccountScreen()));
                                            } else {
                                              _onShareXFileFromAssets(context,
                                                  androidLink:
                                                      '${OpenSaveModelData?.object?.postLink}'
                                                  /* iosLink:
                                                      "https://apps.apple.com/inList =  /app/growder-b2b-platform/id6451333863" */
                                                  );
                                            }
                                          },
                                          child: Container(
                                            height: 20,
                                            width: 30,
                                            color: Colors.transparent,
                                            child: Icon(Icons.share_rounded,
                                                color: Colors.white, size: 20),
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            if (uuid == null) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterCreateAccountScreen()));
                                            } else {
                                              await soicalFunation(
                                                apiName: 'savedata',
                                              );
                                            }
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: OpenSaveModelData
                                                            ?.object?.isSaved ==
                                                        false
                                                    ? Image.asset(
                                                        ImageConstant.savePin,
                                                        height: 18,
                                                        color: Colors.white,
                                                      )
                                                    : Image.asset(
                                                        ImageConstant.Savefill,
                                                        height: 18,
                                                      )

                                                // color: Colors.white,
                                                ),
                                          ),
                                        ),

                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Share.share(
                                        //         'https://play.google.com/store/apps/details?id=com.inpackaging.app');
                                        //   },
                                        //   child: Container(
                                        //     color: Colors.transparent,
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.all(5.0),
                                        //       child: Image.asset(
                                        //         ImageConstant.shareWhite,
                                        //         height: 17,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 50,
            //   color: Colors.white,
            // ),
          ],
        ),
      );
    });
  }

  // OpenSaveImagepostModel? opensavepostModeldata;
  // final TextEditingController addcomment = TextEditingController();
  // final ScrollController scroll = ScrollController();
  // List<StoryButtonData> buttonDatas = [];
  // List<StoryButton?> storyButtons = List.filled(1, null, growable: true);
  // List<String> userName = [];
  // bool added = false;

  void showPopupMenu(BuildContext context, buttonKey) {
    final RenderBox button =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomLeft(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: OpenSaveModelData?.object?.description != null
          ? <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: GestureDetector(
                  onTap: () {
                    print(OpenSaveModelData?.object?.description);
                    if (OpenSaveModelData?.object?.postDataType == "IMAGE" &&
                        OpenSaveModelData?.object?.postData?.length == 1) {
                      print("sdfgsdvfsdfgsdfg");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPost(
                              PostID: OpenSaveModelData?.object?.postUid,
                              edittextdata:
                                  OpenSaveModelData?.object?.description,
                              editImage:
                                  OpenSaveModelData?.object?.postData?.first,
                            ),
                          )).then((value) {
                        // Get_UserToken();
                        userIdFun();
                        Navigator.pop(context);
                      });
                    } else if (OpenSaveModelData?.object?.postDataType ==
                        "IMAGE") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPost(
                              PostID: OpenSaveModelData?.object?.postUid,
                              edittextdata:
                                  OpenSaveModelData?.object?.description,
                              mutliplePost: OpenSaveModelData?.object?.postData,
                            ),
                          )).then((value) {
                        // Get_UserToken();
                        userIdFun();
                        Navigator.pop(context);
                      });
                    } else {
                      print(
                          "dfhsdfhsdfhsdfh-${OpenSaveModelData?.object?.postData?.length}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPost(
                              PostID: OpenSaveModelData?.object?.postUid,
                              edittextdata:
                                  OpenSaveModelData?.object?.description,
                            ),
                          )).then((value) {
                        // Get_UserToken();
                        userIdFun();
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Container(
                    width: 130,
                    height: 40,
                    child: Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ColorConstant.primary_color,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Container(
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstant.primary_color,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ]
          : <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'delete',
                child: Container(
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstant.primary_color,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ],
    ).then((value) {
      if (value == 'delete') {
        showDeleteConfirmationDialog(
            context, OpenSaveModelData?.object?.postUid ?? "");
      }
    });
  }

  void showDeleteConfirmationDialog(
    BuildContext context,
    String PostUID,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          title: Text('Confirm Delete'),
          titlePadding: EdgeInsets.all(10),
          content: Container(
            height: 100,
            child: Column(
              children: [
                Text('Are you sure you want to delete this Post?'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await BlocProvider.of<OpenSaveCubit>(context)
                            .DeletePost('${OpenSaveModelData?.object?.postUid}',
                                context)
                            .then((value) {
                          Navigator.pop(context);
                        });

                        print('Deleted.');
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
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        print('Not deleted.');
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstant.primary_color),
                            borderRadius: BorderRadius.circular(5)),
                        // color: Colors.green,
                        child: Center(
                          child: Text(
                            "No",
                            style:
                                TextStyle(color: ColorConstant.primary_color),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actionsPadding: EdgeInsets.all(5),
          /* actions: <Widget>[
           
            SizedBox(
              width: 40,
              height: 50,
            ),
          ], */
        );
      },
    );
  }

  String customFormat(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
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

  // String customFormat(DateTime date) {
  //   String day = date.day.toString();
  //   String month = _getMonthName(date.month);
  //   String year = date.year.toString();
  //   String time = DateFormat('dd-MM-yyyy     h:mm a').format(date);

  //   String formattedDate = '$time';
  //   return formattedDate;
  // }

  // String _getMonthName(int month) {
  //   switch (month) {
  //     case 1:
  //       return ' January';
  //     case 2:
  //       return ' February';
  //     case 3:
  //       return ' March';
  //     case 4:
  //       return ' April';
  //     case 5:
  //       return ' May';
  //     case 6:
  //       return ' June';
  //     case 7:
  //       return ' July';
  //     case 8:
  //       return ' August';
  //     case 9:
  //       return ' September';
  //     case 10:
  //       return ' October';
  //     case 11:
  //       return ' November';
  //     case 12:
  //       return ' December';
  //     default:
  //       return '';
  //   }
  // }

  navigationFunction() {
    if (widget.profileTure == true) {
      Future.delayed(
        Duration(seconds: 2),
      ).then((value) {
        BlocProvider.of<AddcommentCubit>(context)
            .Addcomment(context, '${OpenSaveModelData?.object?.postUid}');
        _settingModalBottomSheet1(context, 0, double.infinity);
      });
    }
  }

  void _settingModalBottomSheet1(context, index, _width) {
    void _goToElement() {
      scroll.animateTo((1000 * 20),
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (BuildContext bc) {
          return CommentBottomSheet(
              useruid: OpenSaveModelData?.object?.userUid,
              userProfile: OpenSaveModelData?.object?.userProfilePic ?? "",
              UserName: OpenSaveModelData?.object?.postUserName ?? "",
              desc: OpenSaveModelData?.object?.description ?? "",
              postUuID: OpenSaveModelData?.object?.postUid ?? "");
        });
  }

  soicalFunation({
    String? apiName,
  }) async {
    print("fghdfghdfgh");
    if (apiName == 'like_post') {
      await BlocProvider.of<OpenSaveCubit>(context)
          .like_post(OpenSaveModelData?.object?.postUid, context);

      if (OpenSaveModelData?.object?.isLiked == true) {
        OpenSaveModelData?.object?.isLiked = false;
        int a = OpenSaveModelData?.object?.likedCount ?? 0;
        int b = 1;
        OpenSaveModelData?.object?.likedCount = a - b;
      } else {
        OpenSaveModelData?.object?.isLiked = true;
        OpenSaveModelData?.object?.likedCount;
        int a = OpenSaveModelData?.object?.likedCount ?? 0;
        int b = 1;
        OpenSaveModelData?.object?.likedCount = a + b;
      }
    } else if (apiName == 'savedata') {
      await BlocProvider.of<OpenSaveCubit>(context)
          .savedData(OpenSaveModelData?.object?.postUid, context);

      if (OpenSaveModelData?.object?.isSaved == true) {
        OpenSaveModelData?.object?.isSaved = false;
      } else {
        OpenSaveModelData?.object?.isSaved = true;
      }
    } /* else if (apiName == 'Follow') {
      print("dfhsdfhsdfhsdgf");
      await BlocProvider.of<OpenSaveCubit>(context)
          .followWIngMethodd(OpenSaveModelData?.object?.userUid, context);

      if (OpenSaveModelData?.object?.isFollowing == 'FOLLOW') {
        if (OpenSaveModelData?.object?.userUid ==
            OpenSaveModelData?.object?.userUid) {
          OpenSaveModelData?.object?.isFollowing = 'REQUESTED';
          print("check data-${OpenSaveModelData?.object?.isFollowing}");
        }
      } else {
        if (OpenSaveModelData?.object?.userUid ==
            OpenSaveModelData?.object?.userUid) {
          OpenSaveModelData?.object?.isFollowing = 'FOLLOW';
        }
      }
    } */
  }

  void rePostBottomSheet(
    context,
  ) {
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
                        BlocProvider.of<OpenSaveCubit>(context).RePostAPI(
                            context,
                            param,
                            OpenSaveModelData?.object?.postUid,
                            "Repost");
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
                            userProfile:
                                OpenSaveModelData?.object?.userProfilePic,
                            username: OpenSaveModelData?.object?.postUserName,
                            date: OpenSaveModelData?.object?.createdAt,
                            desc: OpenSaveModelData?.object?.description,
                            postData: OpenSaveModelData?.object?.postData,
                            postDataType:
                                OpenSaveModelData?.object?.postDataType,
                            OpenSaveModelData: OpenSaveModelData,
                            postUid: OpenSaveModelData?.object?.postUid,
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

  void _onShareXFileFromAssets(BuildContext context,
      {String? androidLink}) async {
    // RenderBox? box = context.findAncestorRenderObjectOfType();

    var directory = await getApplicationDocumentsDirectory();

    if (Platform.isAndroid) {
      Share.shareXFiles(
        [XFile("/sdcard/download/IPImage.jpg")],
        subject: "Share",
        text: "Try This Awesome App \n\n Android :- ${androidLink}",
        // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      Share.shareXFiles(
        [
          XFile(directory.path +
              Platform.pathSeparator +
              'Growder_Image/IPImage.jpg')
        ],
        subject: "Share",
        text: "Try This Awesome App \n\n Android :- ${androidLink}",
        // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }
}

class ZoomableImage extends StatefulWidget {
  final String imageUrl;
  ZoomableImage({required this.imageUrl});

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  MemoryImage? _memoryImage;
  Uint8List? bytes;
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Future<void> loadImage() async {
    final http.Response response = await http.get(Uri.parse(widget.imageUrl));
    bytes = response.bodyBytes;

    final memoryImage = MemoryImage(Uint8List.fromList(bytes!));

    super.setState(() {
      _memoryImage = memoryImage;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 15,
            width: 15,
            margin: EdgeInsets.all(10),
            color: Color.fromRGBO(255, 255, 255, 0.3),
            child: Center(
              child: Image.asset(
                ImageConstant.whiteClose,
                fit: BoxFit.fill,
                height: 15,
                width: 15,
              ),
            ),
          ),
        ),
      ),
      body: _memoryImage != null
          ? PhotoView(
              imageProvider: MemoryImage(bytes!),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
            )
          : GestureDetector(
              onTap: () {
                print("sdfsdhsdgfsdgfsdgsdgfgdgfd-${widget.imageUrl}");
              },
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
