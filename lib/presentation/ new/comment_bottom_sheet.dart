import 'dart:async';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_state.dart';
import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/API/Model/deletecomment/delete_comment_model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../API/Model/UserTagModel/UserTag_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentBottomSheet extends StatefulWidget {
  String userProfile;
  String UserName;
  String desc;
  String postUuID;
  String? isFoollinng;
  String? useruid;

  // GetGuestAllPostModel? AllGuestPostRoomData;
  // int index;
  CommentBottomSheet(
      {required this.userProfile,
      required this.UserName,
      required this.desc,
      required this.postUuID,
      this.isFoollinng,
      this.useruid,
      key});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController addcomment = TextEditingController();
  AddCommentModel? addCommentModeldata;
  final ScrollController scroll = ScrollController();
  DeleteCommentModel? DeletecommentDataa;
  GetGuestAllPostModel? AllGuestPostRoomData;
  bool isEmojiVisible = false;
  FocusNode focusNode = FocusNode();
  List<String> postTexContrlloer = [];
  HasDataModel? getAllHashtag;
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  bool OneTimeSend = false;
  SearchUserForInbox? searchUserForInbox1;
  bool isKeyboardVisible = false;
  String? uuid;
  String? User_ID1;
  String? TeampData;
  UserTagModel? userTagModel;

  bool istageData = false;
  bool isHeshTegData = false;
  Timer? _timer;
  String title = "";

  List<Map<String, dynamic>> tageData = [];
  List<Map<String, dynamic>> heshTageData = [];
  void _goToElement() {
    scroll.animateTo((1000 * 20),
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  void initState() {
    setUserId();
    super.initState();
  }

  setUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    User_ID1 = prefs.getString(PreferencesKey.loginUserID);
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () {
        if (isEmojiVisible) {
          super.setState(() {
            isEmojiVisible = false;
          });
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Comments",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
                print("sdfgsdfgsdfgsdgfsdfgsdgf");
                Map<String, dynamic> data = {'bool': true};
                Observable.instance
                    .notifyObservers(['_HomeScreenNewState'], map: data);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: BlocConsumer<AddcommentCubit, AddCommentState>(
          listener: (context, state) async {
            if (state is AddCommentLoadedState) {
              addCommentModeldata = state.commentdata;
            }
            if (state is GetAllHashtagState) {
              getAllHashtag = state.getAllHashtag;
              for (int i = 0;
                  i < (getAllHashtag?.object?.content?.length ?? 0);
                  i++) {
                // getAllHashtag?.object?.content?[i].split('#').last;
                Map<String, dynamic> dataSetup = {
                  'id': '${i}',
                  'display':
                      '${getAllHashtag?.object?.content?[i].split('#').last}',
                };
                heshTageData.add(dataSetup);
                if (heshTageData.isNotEmpty == true) {
                  isHeshTegData = true;
                }
              }
            }
            if (state is SearchHistoryDataAddxtends) {
              searchUserForInbox1 = state.searchUserForInbox;

              /*  isTagData = true;
          isHeshTegData = false; */
              searchUserForInbox1?.object?.content?.forEach((element) {
                Map<String, dynamic> dataSetup = {
                  'id': element.userUid,
                  'display': element.userName,
                  'photo': element.userProfilePic,
                };

                tageData.add(dataSetup);
                List<Map<String, dynamic>> uniqueTageData = [];
                Set<String> encounteredIds = Set<String>();
                for (Map<String, dynamic> data in tageData) {
                  if (!encounteredIds.contains(data['id'])) {
                    // If the ID hasn't been encountered, add to the result list
                    uniqueTageData.add(data);

                    // Mark the ID as encountered
                    encounteredIds.add(data['id']);
                  }
                  tageData = uniqueTageData;
                }
                if (tageData.isNotEmpty == true) {
                  istageData = true;
                }
              });
            }
            if (state is AddCommentErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is AddnewCommentLoadedState) {
              print("dgdfhgdfhdfghhdfgh-${state.addnewCommentsModeldata}");
              OneTimeSend = false;
              if (state.addnewCommentsModeldata['message'] ==
                  'Comment contains a restricted word') {
                SnackBar snackBar = SnackBar(
                  content: Text(state.addnewCommentsModeldata['message']),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                Object1 object =
                    Object1.fromJson(state.addnewCommentsModeldata['object']);
                key.currentState!.controller!.clear();
                addCommentModeldata?.object?.add(object);

                _goToElement();
              }
            }
            if (state is UserTagCommentLoadedState) {
              userTagModel = await state.userTagModel;
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfileScreen(
                    User_ID: "${userTagModel?.object}", isFollowing: "");
              }));
            }
            if (state is DeletecommentLoadedState) {
              DeletecommentDataa = state.Deletecomment;
              SnackBar snackBar = SnackBar(
                content: Text(state.Deletecomment.object ?? ""),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              if (DeletecommentDataa?.object ==
                  "Comment deleted successfully") {
                // addCommentModeldata = addCommentModeldata?.object?.removeAt(index);

                // BlocProvider.of<AddcommentCubit>(context).Addcomment(
                //     context,
                //     '${AllGuestPostRoomData?.object?.content?[index].postUid}');
              }
            }
          },
          builder: (context, state) {
            if (state is AddCommentLoadingState) {
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
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      /*    Container(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (User_ID1 == null) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterCreateAccountScreen()));
                                      } else {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (
                                          context,
                                        ) {
                                          return ProfileScreen(
                                              User_ID: widget.useruid ?? "",
                                              isFollowing: widget.isFoollinng);
                                        }));
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: widget.userProfile != null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "${widget.userProfile}"),
                                              radius: 25,
                                            )
                                          : CustomImageView(
                                              imagePath: ImageConstant.tomcruse,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fill,
                                              radius: BorderRadius.circular(25),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${widget.UserName}',
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("1w",
                                                // customFormat(parsedDateTime),
                                                style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(' ${widget.desc ?? ""}',
                                                // maxLines: 2,
                                                style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ), */
                      Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: addCommentModeldata?.object?.isNotEmpty ?? true
                            ? ListView.builder(
                                // physics:  NeverScrollableScrollPhysics(),
                                itemCount: addCommentModeldata?.object?.length,
                                shrinkWrap: true,
                                controller: scroll,
                                itemBuilder: (context, index) {
                                  DateTime parsedDateTime = DateTime.parse(
                                      '${addCommentModeldata?.object?[index].createdAt ?? ""}');

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0, left: 35.0),
                                        child: Container(
                                          // height: 80,
                                          // width: _width / 1.2,
                                          decoration: BoxDecoration(
                                              // color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return ProfileScreen(
                                                              User_ID:
                                                                  "${addCommentModeldata?.object?[index].userUid}",
                                                              isFollowing: widget
                                                                  .isFoollinng);
                                                        }));
                                                      },
                                                      child: addCommentModeldata
                                                                      ?.object?[
                                                                          index]
                                                                      .profilePic
                                                                      ?.isEmpty ==
                                                                  true ||
                                                              addCommentModeldata
                                                                      ?.object?[
                                                                          index]
                                                                      .profilePic ==
                                                                  null
                                                          ? CustomImageView(
                                                              radius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              imagePath:
                                                                  ImageConstant
                                                                      .pdslogo,
                                                              fit: BoxFit.fill,
                                                              height: 35,
                                                              width: 35,
                                                            )
                                                          : CustomImageView(
                                                              radius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              url:
                                                                  "${addCommentModeldata?.object?[index].profilePic}",
                                                              fit: BoxFit.fill,
                                                              height: 35,
                                                              width: 35,
                                                            ),
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: _width / 1.4,
                                                      // color: Colors.red,
                                                      child: Row(
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
                                                                        "${addCommentModeldata?.object?[index].userUid}",
                                                                    isFollowing:
                                                                        widget
                                                                            .isFoollinng);
                                                              }));
                                                            },
                                                            child: Container(
                                                              child: Text(
                                                                "${addCommentModeldata?.object?[index].userName}",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'outfit',
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                              // "1w",
                                                              customadateFormat(
                                                                  parsedDateTime),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'outfit',
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          Container(
                                                            width: 30,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Deletecommentdilog(
                                                                    addCommentModeldata
                                                                            ?.object?[index]
                                                                            .commentUid ??
                                                                        "",
                                                                    index);
                                                              },
                                                              child: addCommentModeldata
                                                                          ?.object?[
                                                                              index]
                                                                          .commentByLoggedInUser ==
                                                                      true
                                                                  ? Icon(
                                                                      Icons
                                                                          .delete_outline_rounded,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .grey,
                                                                    )
                                                                  : SizedBox(),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          addCommentModeldata
                                                                      ?.object?[
                                                                          index]
                                                                      .translatedComment !=
                                                                  null
                                                              ? GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    super
                                                                        .setState(
                                                                            () {
                                                                      if (addCommentModeldata?.object?[index].isTrsnalteoption ==
                                                                              false ||
                                                                          addCommentModeldata?.object?[index].isTrsnalteoption ==
                                                                              null) {
                                                                        addCommentModeldata
                                                                            ?.object?[index]
                                                                            .isTrsnalteoption = true;
                                                                      } else {
                                                                        addCommentModeldata
                                                                            ?.object?[index]
                                                                            .isTrsnalteoption = false;
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                      width: 80,
                                                                      decoration: BoxDecoration(color: ColorConstant.primaryLight_color, borderRadius: BorderRadius.circular(10)),
                                                                      child: Center(
                                                                          child: Text(
                                                                        "Translate",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'outfit',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ))),
                                                                )
                                                              : SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: _width / 1.4,
                                                      // height: 50,
                                                      // color: Colors.amber,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          LinkifyText(
                                                            addCommentModeldata
                                                                            ?.object?[
                                                                                index]
                                                                            .isTrsnalteoption ==
                                                                        false ||
                                                                    addCommentModeldata
                                                                            ?.object?[index]
                                                                            .isTrsnalteoption ==
                                                                        null
                                                                ? "${addCommentModeldata?.object?[index].comment}"
                                                                : "${addCommentModeldata?.object?[index].translatedComment}",
                                                            linkStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontFamily:
                                                                  'outfit',
                                                            ),
                                                            textStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'outfit',
                                                            ),
                                                            linkTypes: [
                                                              LinkType.url,
                                                              LinkType.userTag,
                                                              LinkType.hashTag,
                                                              // LinkType
                                                              //     .email
                                                            ],
                                                            onTap:
                                                                (link) async {
                                                              /// do stuff with `link` like
                                                              /// if(link.type == Link.url) launchUrl(link.value);

                                                              var SelectedTest =
                                                                  link.value
                                                                      .toString();
                                                              var Link = SelectedTest
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

                                                              if (Link ==
                                                                      true ||
                                                                  Link1 ==
                                                                      true ||
                                                                  Link2 ==
                                                                      true ||
                                                                  Link3 ==
                                                                      true ||
                                                                  Link4 ==
                                                                      true ||
                                                                  Link5 ==
                                                                      true ||
                                                                  Link6 ==
                                                                      true) {
                                                                if (Link2 ==
                                                                        true ||
                                                                    Link3 ==
                                                                        true) {
                                                                  if (isYouTubeUrl(
                                                                      SelectedTest)) {
                                                                    playLink(
                                                                        SelectedTest,
                                                                        context);
                                                                  } else
                                                                    launchUrl(Uri
                                                                        .parse(
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
                                                                    if (isYouTubeUrl(
                                                                        SelectedTest)) {
                                                                      playLink(
                                                                          SelectedTest,
                                                                          context);
                                                                    } else
                                                                      launchUrl(Uri.parse(link
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
                                                                  print(
                                                                      "${link}");
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                HashTagViewScreen(title: "${link.value}"),
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
                                                                          "@",
                                                                          "");
                                                                  await BlocProvider.of<
                                                                              AddcommentCubit>(
                                                                          context)
                                                                      .UserTagAPI(
                                                                          context,
                                                                          tagName);

                                                                  print(
                                                                      "tagName -- ${tagName}");
                                                                  print(
                                                                      "user id -- ${userTagModel?.object}");
                                                                } else {
                                                                  if (isYouTubeUrl(
                                                                      SelectedTest)) {
                                                                    playLink(
                                                                        SelectedTest,
                                                                        context);
                                                                  } else
                                                                    launchUrl(Uri
                                                                        .parse(
                                                                            "https://${link.value.toString()}"));
                                                                }
                                                              }
                                                            },
                                                          ),
                                                          if (extractUrls(addCommentModeldata
                                                                      ?.object?[
                                                                          index]
                                                                      .comment ??
                                                                  "")
                                                              .isNotEmpty)
                                                            isYouTubeUrl(extractUrls(
                                                                        addCommentModeldata?.object?[index].comment ??
                                                                            "")
                                                                    .first)
                                                                ? FutureBuilder(
                                                                    future: fetchYoutubeThumbnail(extractUrls(
                                                                            addCommentModeldata?.object?[index].comment ??
                                                                                "")
                                                                        .first),
                                                                    builder:
                                                                        (context,
                                                                            snap) {
                                                                      return Container(
                                                                        height:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: CachedNetworkImageProvider(snap.data.toString())),
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        child: Center(
                                                                            child: IconButton(
                                                                          icon:
                                                                              Icon(
                                                                            Icons.play_circle_fill_rounded,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                60,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            playLink(extractUrls(addCommentModeldata?.object?[index].comment ?? "").first,
                                                                                context);
                                                                          },
                                                                        )),
                                                                      );
                                                                    })
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            16.0,
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        AnyLinkPreview(
                                                                      link: extractUrls(addCommentModeldata?.object?[index].comment ??
                                                                              "")
                                                                          .first,
                                                                      displayDirection:
                                                                          UIDirection
                                                                              .uiDirectionHorizontal,
                                                                      showMultimedia:
                                                                          true,
                                                                      bodyMaxLines:
                                                                          5,
                                                                      bodyTextOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      titleStyle:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            15,
                                                                      ),
                                                                      bodyStyle: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              12),
                                                                      errorBody:
                                                                          'Show my custom error body',
                                                                      errorTitle:
                                                                          'Show my custom error title',
                                                                      errorWidget:
                                                                          null,
                                                                      errorImage:
                                                                          "https://flutter.dev/",
                                                                      cache: Duration(
                                                                          days:
                                                                              7),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[300],
                                                                      borderRadius:
                                                                          12,
                                                                      removeElevation:
                                                                          false,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            blurRadius:
                                                                                3,
                                                                            color:
                                                                                Colors.grey)
                                                                      ],
                                                                      onTap:
                                                                          () {
                                                                        launchUrl(Uri.parse(extractUrls(addCommentModeldata?.object?[index].comment ??
                                                                                "")
                                                                            .first));
                                                                      }, // This disables tap event
                                                                    ),
                                                                  ),
                                                        ],
                                                      )

                                                      /*  Text(
                                                        "${addCommentModeldata?.object?[index].comment}",
                                                        // maxLines: 2,

                                                        style: TextStyle(
                                                            fontFamily: 'outfit',
                                                            overflow: TextOverflow
                                                                .visible,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400)) */
                                                      ,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                "No Comments available",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: AnyLinkPreview(
                            link: title,
                            displayDirection: UIDirection.uiDirectionHorizontal,
                            showMultimedia: true,
                            bodyMaxLines: 5,
                            bodyTextOverflow: TextOverflow.ellipsis,
                            titleStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            bodyStyle:
                                TextStyle(color: Colors.grey, fontSize: 12),
                            errorBody: 'Show my custom error body',
                            errorTitle: 'Show my custom error title',
                            errorWidget: Container(
                              color: Colors.grey[300],
                              child: Text('Oops!'),
                            ),
                            errorImage: "https://flutter.dev/",
                            cache: Duration(days: 7),
                            backgroundColor: Colors.grey[300],
                            borderRadius: 12,
                            removeElevation: false,
                            boxShadow: [
                              BoxShadow(blurRadius: 3, color: Colors.grey)
                            ],
                            onTap: () {
                              launchUrl(Uri.parse(title));
                            }, // This disables tap event
                          ),
                        ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: FlutterMentions(
                                  key: key,
                                  minLines: 1,
                                  maxLines: 5,
                                  onChanged: (value) {
                                    onChangeMethod(value);
                                  },
                                  suggestionPosition: SuggestionPosition.Top,
                                  decoration: InputDecoration(
                                    hintText: 'Add Comment',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.red), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.red), //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  mentions: [
                                    Mention(
                                        trigger: "@",
                                        style: TextStyle(color: Colors.blue),
                                        data: tageData,
                                        matchAll: false,
                                        disableMarkup: true,
                                        suggestionBuilder: (tageData) {
                                          if (istageData) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: 50, bottom: 10),
                                              child: Row(
                                                children: <Widget>[
                                                  tageData['photo'] != null
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            tageData['photo'],
                                                          ),
                                                        )
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  ImageConstant
                                                                      .tomcruse),
                                                        ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Text(
                                                          '@${tageData['display']}'),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          }

                                          return Container(
                                            color: Colors.amber,
                                          );
                                        }),
                                    Mention(
                                        trigger: "#",
                                        style: TextStyle(color: Colors.blue),
                                        data: heshTageData,
                                        suggestionBuilder: (heshTageData) {
                                          print("sdfgfgdgh-$heshTageData");
                                          if (isHeshTegData) {
                                            return Container(
                                              height: 50,
                                              width: 110,
                                              margin: EdgeInsets.only(
                                                  left: 40, bottom: 10),
                                              child: ListTile(
                                                  leading: CircleAvatar(
                                                    child: Text('#'),
                                                  ),
                                                  title: Text(
                                                    '${heshTageData['display']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                            );
                                          }
                                          return Container(
                                            height: 30,
                                            width: 110,
                                            color: Colors.green,
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          /* Flexible(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      // onChangeMethod(value);
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(300),
                                    ],
                                    minLines: 1,
                                    maxLines: 5,
                                    controller: addcomment,
                                    decoration: InputDecoration(
                                      hintText: "Add Comment",
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          isEmojiVisible
                                              ? Icons.keyboard_alt_outlined
                                              : Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: () async {
                                          print("this is ontap");

                                          if (isEmojiVisible) {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          } else if (isKeyboardVisible) {
                                            await SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                            await Future.delayed(
                                                Duration(milliseconds: 100));
                                          }
                                          if (isKeyboardVisible) {
                                            FocusScope.of(context).unfocus();
                                          }

                                          super.setState(() {
                                            isEmojiVisible = !isEmojiVisible;
                                          });
                                        },
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.red), //<-- SEE HERE
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.red), //<-- SEE HERE
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              )), */
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                if (addcomment.text.isEmpty) {
                                  SnackBar snackBar = SnackBar(
                                    content: Text('Please Add Comment'),
                                    backgroundColor:
                                        ColorConstant.primary_color,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  print(
                                      "i want to check-${addcomment.text.length}");
                                  if (addcomment.text.length >= 300) {
                                    SnackBar snackBar = SnackBar(
                                      content: Text(
                                          'One time message length allowed is 300'),
                                      backgroundColor:
                                          ColorConstant.primary_color,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    if (OneTimeSend == false) {
                                      OneTimeSend = true;
                                      print(
                                          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                                      addcomment.text.isEmpty;
                                      Map<String, dynamic> params = {
                                        "comment": addcomment.text,
                                        "postUid": '${widget.postUuID}',
                                      };

                                      BlocProvider.of<AddcommentCubit>(context)
                                          .AddPostApiCalling(context, params);
                                    }
                                  }
                                }
                              },
                              child: CircleAvatar(
                                maxRadius: 25,
                                backgroundColor: ColorConstant.primary_color,
                                child: Center(
                                  child: Image.asset(
                                    ImageConstant.commentarrow,
                                    height: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      /*   Container(
                            height: 70,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  width: _width / 1.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: TextField(
                                      expands: true,
                                        maxLines: null,
                                      onTap: () {
                                        if (isEmojiVisible) {
                                          super.setState(() {
                                            isEmojiVisible = !isEmojiVisible;
                                          });
                                        }
                                      },

                                      controller: addcomment,
                                      maxLength: 300,
                                      //
                                      cursorColor: ColorConstant.primary_color,
                                      decoration: InputDecoration(
                                        counterText: "",

                                        border: InputBorder.none,
                                        hintText: "Add Comment",
                                        icon: Container(
                                          child: IconButton(
                                            icon: Icon(
                                              isEmojiVisible
                                                  ? Icons.keyboard_alt_outlined
                                                  : Icons.emoji_emotions_outlined,
                                            ),
                                            onPressed: () async {
                                              if (isEmojiVisible) {
                                                focusNode.requestFocus();
                                              } else if (isKeyboardVisible) {
                                                await SystemChannels.textInput
                                                    .invokeMethod('TextInput.hide');
                                                await Future.delayed(
                                                    Duration(milliseconds: 100));
                                              }
                                              if (isKeyboardVisible) {
                                                FocusScope.of(context).unfocus();
                                              }

                                              super.setState(() {
                                                isEmojiVisible = !isEmojiVisible;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (addcomment.text.isEmpty) {
                                      SnackBar snackBar = SnackBar(
                                        content: Text('Please Add Comment'),
                                        backgroundColor:
                                            ColorConstant.primary_color,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      Map<String, dynamic> params = {
                                        "comment": addcomment.text,
                                        "postUid": '${widget.postUuID}',
                                      };

                                      BlocProvider.of<AddcommentCubit>(context)
                                          .AddPostApiCalling(context, params);
                                    }
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 25,
                                    backgroundColor: ColorConstant.primary_color,
                                    child: Center(
                                      child: Image.asset(
                                        ImageConstant.commentarrow,
                                        height: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ), */
                      Offstage(
                        offstage: !isEmojiVisible,
                        child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              onBackspacePressed: () {
                                if (isEmojiVisible) {
                                  super.setState(() {
                                    isEmojiVisible = false;
                                  });
                                }
                              },
                              onEmojiSelected: (category, emoji) {
                                addcomment.text += emoji.emoji;
                                super.setState(() {});
                              },
                              config: Config(
                                columns: 7,
                                // Issue: https://github.com/flutter/flutter/issues/28894
                                emojiSizeMax: 32 *
                                    (foundation.defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? 1.30
                                        : 1.0),
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                initCategory: Category.RECENT,
                                bgColor: const Color(0xFFF2F2F2),
                                indicatorColor: Colors.blue,
                                iconColor: Colors.grey,
                                iconColorSelected: Colors.blue,
                                backspaceColor: Colors.blue,
                                skinToneDialogBgColor: Colors.white,
                                skinToneIndicatorColor: Colors.grey,
                                enableSkinTones: true,
                                recentTabBehavior: RecentTabBehavior.RECENT,
                                recentsLimit: 28,
                                replaceEmojiOnLimitExceed: false,
                                noRecents: const Text(
                                  'No Recents',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ),
                                loadingIndicator: const SizedBox.shrink(),
                                tabIndicatorAnimDuration: kTabScrollDuration,
                                categoryIcons: const CategoryIcons(),
                                buttonMode: ButtonMode.MATERIAL,
                                checkPlatformCompatibility: true,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
              alignment: Alignment.topRight,
            );
          },
        ),
      ),
    );
  }

  onChangeMethod(String value) {
    super.setState(() {
      addcomment.text = value;
      title = "";
    });
    if (value.contains('@')) {
      title = "";
      print("if this condison is working-${value}");
      if (value.length >= 3 && value.contains('@')) {
        print("value check --${value.endsWith(' #')}");
        if (value.endsWith(' #')) {
          String data1 = value.split(' #').last.replaceAll('#', '');
          BlocProvider.of<AddcommentCubit>(context)
              .GetAllHashtag(context, '10', '#${data1.trim()}');
        } else {
          String data = value.split(' @').last.replaceAll('@', '');
          BlocProvider.of<AddcommentCubit>(context)
              .search_user_for_inbox(context, '${data.trim()}', '1');
        }
      } else if (value.endsWith(' #')) {
        print("ends with value-${value}");
      } else {
        print("check lenth else-${value.length}");
      }
      if (AnyLinkPreview.isValidLink(extractUrls(value).first)) {
        if (_timer != null) {
          _timer?.cancel();
          _timer = Timer(Duration(seconds: 2), () {
            setState(() {
              title = extractUrls(value).first;
            });
          });
        } else {
          _timer = Timer(Duration(seconds: 2), () {
            setState(() {
              title = extractUrls(value).first;
            });
          });
        }
      }
    } else if (value.contains('#')) {
      title = "";
      print("check length-${value}");
      String data1 = value.split(' #').last.replaceAll('#', '');
      BlocProvider.of<AddcommentCubit>(context)
          .GetAllHashtag(context, '10', '#${data1.trim()}');
      if (AnyLinkPreview.isValidLink(extractUrls(value).first)) {
        if (_timer != null) {
          _timer?.cancel();
          _timer = Timer(Duration(seconds: 2), () {
            setState(() {
              title = extractUrls(value).first;
            });
          });
        } else {
          _timer = Timer(Duration(seconds: 2), () {
            setState(() {
              title = extractUrls(value).first;
            });
          });
        }
      }
    } else if (AnyLinkPreview.isValidLink(extractUrls(value).first)) {
      if (_timer != null) {
        _timer?.cancel();
        _timer = Timer(Duration(seconds: 2), () {
          setState(() {
            title = extractUrls(value).first;
          });
        });
      } else {
        _timer = Timer(Duration(seconds: 2), () {
          setState(() {
            title = extractUrls(value).first;
          });
        });
      }
    } else {
      super.setState(() {
        istageData = false;
        isHeshTegData = false;
        title = "";
      });
    }
  }

  Deletecommentdilog(String commentuuid, int index1) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // title: const Text("Create Expert"),
        content: Container(
          height: 90,
          child: Column(
            children: [
              Text("Are You Sure You Want To delete This Comment."),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      print(
                          "index print${addCommentModeldata?.object?[index1].commentUid}");
                      print(
                          "index print1${addCommentModeldata?.object?[index1].comment}");

                      BlocProvider.of<AddcommentCubit>(context).Deletecomment(
                          "${addCommentModeldata?.object?[index1].commentUid}",
                          context);
                      addCommentModeldata?.object?.removeAt(index1);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          color: ColorConstant.primary_color,
                          borderRadius: BorderRadius.circular(5)),
                      // color: Colors.green,
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
                          border:
                              Border.all(color: ColorConstant.primary_color),
                          borderRadius: BorderRadius.circular(5)),
                      // color: Colors.green,
                      child: Center(
                        child: Text(
                          "No",
                          style: TextStyle(color: ColorConstant.primary_color),
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

  String customadateFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$day $month $year $time';
    return formattedDate;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return '/01/';
      case 2:
        return '/02/';
      case 3:
        return '/03/';
      case 4:
        return '/04/';
      case 5:
        return '/05/';
      case 6:
        return '/06/';
      case 7:
        return '/07/';
      case 8:
        return '/08/';
      case 9:
        return '/09/';
      case 10:
        return '/10/';
      case 11:
        return '/11/';
      case 12:
        return '/12/';
      default:
        return '';
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

    List<String> urls =
        regExp.allMatches(text).map((match) => match.group(0)!).toList();
    List<String> finalUrls = [];
    RegExp urlRegex = RegExp(r"(http(s)?://)", caseSensitive: false);
    urls.forEach((element) {
      if (urlRegex.allMatches(element).toList().length > 1) {
        String xyz = element.replaceAll("http", ",http");
        List<String> splitted = xyz.split(RegExp(r",|;"));
        splitted.forEach((element1) {
          if (element1.isNotEmpty) finalUrls.add(element1);
        });
      } else {
        finalUrls.add(element);
      }
    });
    return finalUrls;
  }

  bool isYouTubeUrl(String url) {
    // Regular expression pattern to match YouTube URLs
    RegExp youtubeVideoRegex =
        RegExp(r"^https?://(?:www\.)?youtube\.com/(?:watch\?v=)?([^#&?]+)");
    RegExp youtubeShortsRegex =
        RegExp(r"^https?://(?:www\.)?youtube\.com/shorts/([^#&?]+)");

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
                      FutureBuilder(
                          future: getYoutubePlayer(videoUrl, () {
                            Navigator.pop(ctx);
                            launchUrl(Uri.parse(videoUrl));
                          }),
                          builder: (context, snap) {
                            if (snap.data != null)
                              return snap.data as Widget;
                            else
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
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
    final url =
        "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$playlistId&key=AIzaSyAT_gzTjHn9XuvQsmGdY63br7lKhD2KRdo";
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
      print("Failed to fetch playlist videos");
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

  Future<Widget> getYoutubePlayer(
      String videoUrl, Function() fullScreen) async {
    late YoutubePlayerController _controller;
    String videoId = "";
    if (videoUrl.toLowerCase().contains("playlist")) {
      String playlistId = extractPlaylistId(videoUrl);
      var videoIds = await getPlaylistVideos(playlistId);
      videoId = videoIds.first;
    } else if (videoUrl.toLowerCase().contains("live")) {
      videoId = extractLiveId(videoUrl);
    } else {
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
