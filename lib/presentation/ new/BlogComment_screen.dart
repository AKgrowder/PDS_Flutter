import 'dart:async';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_state.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogCommentDelete_model.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogComment_model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/API/Model/UserTagModel/UserTag_model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../API/Bloc/BlogComment_BLoc/BlogComment_cubit.dart';
import '../../API/Bloc/BlogComment_BLoc/BlogComment_state.dart';

class BlogCommentBottomSheet extends StatefulWidget {
  String? isFoollinng;
  String? blogUid;

  BlogCommentBottomSheet({this.isFoollinng, this.blogUid, key});

  @override
  State<BlogCommentBottomSheet> createState() => _BlogCommentBottomSheetState();
}

class _BlogCommentBottomSheetState extends State<BlogCommentBottomSheet> {
  final TextEditingController addcomment = TextEditingController();
  BlogCommentModel? blogCommentModel;
  ScrollController scroll = ScrollController();
  DeleteBlogCommentModel? deleteBlogCommentModel;
  GetGuestAllPostModel? AllGuestPostRoomData;
  bool isEmojiVisible = false;
  FocusNode focusNode = FocusNode();
  bool isKeyboardVisible = false;
  String? uuid;
  String? User_ID1;
  bool isDataGet = false;
  UserTagModel? userTagModel;
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  List<Map<String, dynamic>> tageData = [];
  List<Map<String, dynamic>> heshTageData = [];
  SearchUserForInbox? searchUserForInbox1;
  HasDataModel? getAllHashtag;
  Timer? _timer;
  String title = "";

  void _goToElement() {
    /* scroll.animateTo((1000.0 * 100),
        duration: const Duration(milliseconds: 20), curve: Curves.easeOut); */
    scroll.jumpTo(scroll.position.maxScrollExtent + 100);
  }

  bool istageData = false;
  bool isHeshTegData = false;
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
        backgroundColor: theme.colorScheme.onPrimary,
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
                Map<String, dynamic> data = {'bool': true};
                Observable.instance
                    .notifyObservers(['_HomeScreenNewState'], map: data);
                Navigator.pop(
                  context,
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<BlogcommentCubit, BlogCommentState>(
          listener: (context, state) async {
            if (state is BlogCommentLoadedState) {
              blogCommentModel = state.commentdata;
              isDataGet = true;
            }
            if (state is BlogCommentLoadedState) {
              isDataGet = true;
            }
            if (state is BlogCommentErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is BlognewCommentLoadedState) {
              print("dgdfhgdfhdfghhdfgh-${state.BlognewCommentsModeldata}");
              if (state.BlognewCommentsModeldata['message'] ==
                  'Comment contains a restricted word') {
                SnackBar snackBar = SnackBar(
                  content: Text(state.BlognewCommentsModeldata['message']),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                addcomment.clear();
                key.currentState!.controller!.clear();
                ObjectBlog object = ObjectBlog.fromJson(
                    state.BlognewCommentsModeldata['object']);

                blogCommentModel?.object?.add(object);

                _goToElement();
              }
            }
            if (state is DeleteBlogcommentLoadedState) {
              deleteBlogCommentModel = state.Deletecomment;
              SnackBar snackBar = SnackBar(
                content: Text(state.Deletecomment.object ?? ""),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is UserTagBlogLoadedState) {
              userTagModel = await state.userTagModel;
            }
            if (state is SearchHistoryDataAddxtends1) {
              searchUserForInbox1 = state.searchUserForInbox;
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
                    //    If the ID hasn't been encountered, add to the result list
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
            if (state is GetAllHashtagState1) {
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
          },
          builder: (
            context,
            state,
          ) {
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
            return isDataGet == false
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
                : Stack(
                    children: [
                      SingleChildScrollView(
                        controller: scroll,
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 70),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: blogCommentModel?.object?.length,
                                shrinkWrap: true,
                                // controller: scroll,
                                itemBuilder: (context, index) {
                                  DateTime? parsedDateTime = DateTime.parse(
                                      '${blogCommentModel?.object?[index].createdAt ?? ""}');

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
                                                                  "${blogCommentModel?.object?[index].userUid}",
                                                              isFollowing: widget
                                                                  .isFoollinng);
                                                        }));
                                                      },
                                                      child: blogCommentModel
                                                                      ?.object?[
                                                                          index]
                                                                      .userProfilePic
                                                                      ?.isEmpty ==
                                                                  true ||
                                                              blogCommentModel
                                                                      ?.object?[
                                                                          index]
                                                                      .userProfilePic ==
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
                                                                  "${blogCommentModel?.object?[index].userProfilePic}",
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
                                                      width: _width / 1.5,
                                                      // color: Colors.amber,
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
                                                                        "${blogCommentModel?.object?[index].userUid}",
                                                                    isFollowing:
                                                                        widget
                                                                            .isFoollinng);
                                                              }));
                                                            },
                                                            child: Container(
                                                              /* color: Colors.amber, */
                                                              child: Text(
                                                                "${blogCommentModel?.object?[index].userName}",
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
                                                              getTimeDifference(
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
                                                            child: GestureDetector(
                                                                onTap: () {
                                                                  Deletecommentdilog(
                                                                      blogCommentModel
                                                                              ?.object?[index]
                                                                              .commentUid ??
                                                                          "",
                                                                      index);
                                                                },
                                                                child: blogCommentModel?.object?[index].userUid == User_ID1
                                                                    ? Icon(
                                                                        Icons
                                                                            .delete_outline_rounded,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .grey,
                                                                      )
                                                                    : SizedBox()),
                                                          ),
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
                                                              "${blogCommentModel?.object?[index].comment}",
                                                              linkStyle:
                                                                  TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontFamily:
                                                                    'outfit',
                                                              ),
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'outfit',
                                                              ),
                                                              linkTypes: [
                                                                LinkType.url,
                                                                LinkType
                                                                    .userTag,
                                                                LinkType
                                                                    .hashTag,
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
                                                                var Link1 = SelectedTest
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
                                                                var Link4 = SelectedTest
                                                                    .startsWith(
                                                                        'HTTPS');
                                                                var Link5 = SelectedTest
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
                                                                      launchUrl(
                                                                          Uri.parse(
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
                                                                  if (link
                                                                      .value!
                                                                      .startsWith(
                                                                          '#')) {
                                                                    print(
                                                                        "${link}");
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
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
                                                                    await BlocProvider.of<BlogcommentCubit>(
                                                                            context)
                                                                        .UserTagAPI(
                                                                            context,
                                                                            tagName);

                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(builder:
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
                                                                    if (isYouTubeUrl(
                                                                        SelectedTest)) {
                                                                      playLink(
                                                                          SelectedTest,
                                                                          context);
                                                                    } else
                                                                      launchUrl(
                                                                          Uri.parse(
                                                                              "https://${link.value.toString()}"));
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                            if (extractUrls(blogCommentModel
                                                                        ?.object?[
                                                                            index]
                                                                        .comment ??
                                                                    "")
                                                                .isNotEmpty)
                                                              isYouTubeUrl(extractUrls(
                                                                          blogCommentModel?.object?[index].comment ??
                                                                              "")
                                                                      .first)
                                                                  ? FutureBuilder(
                                                                      future: fetchYoutubeThumbnail(extractUrls(blogCommentModel?.object?[index].comment ??
                                                                              "")
                                                                          .first),
                                                                      builder:
                                                                          (context,
                                                                              snap) {
                                                                        return Container(
                                                                          height:
                                                                              200,
                                                                          decoration: BoxDecoration(
                                                                              image: DecorationImage(image: CachedNetworkImageProvider(snap.data.toString())),
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          clipBehavior:
                                                                              Clip.antiAlias,
                                                                          child: Center(
                                                                              child: IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.play_circle_fill_rounded,
                                                                              color: Colors.white,
                                                                              size: 60,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              playLink(extractUrls(blogCommentModel?.object?[index].comment ?? "").first, context);
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
                                                                        link: extractUrls(blogCommentModel?.object?[index].comment ??
                                                                                "")
                                                                            .first,
                                                                        displayDirection:
                                                                            UIDirection.uiDirectionHorizontal,
                                                                        showMultimedia:
                                                                            true,
                                                                        bodyMaxLines:
                                                                            5,
                                                                        bodyTextOverflow:
                                                                            TextOverflow.ellipsis,
                                                                        titleStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                        bodyStyle: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
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
                                                                            Colors.grey[300],
                                                                        borderRadius:
                                                                            12,
                                                                        removeElevation:
                                                                            false,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              blurRadius: 3,
                                                                              color: Colors.grey)
                                                                        ],
                                                                        onTap:
                                                                            () {
                                                                          launchUrl(
                                                                              Uri.parse(extractUrls(blogCommentModel?.object?[index].comment ?? "").first));
                                                                        }, // This disables tap event
                                                                      ),
                                                                    ),
                                                          ],
                                                        )
                                                        /* Text(
                                                          "${blogCommentModel?.object?[index].comment}",
                                                          // maxLines: 2,

                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'outfit',
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)), */
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
                              ),
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
                                  displayDirection:
                                      UIDirection.uiDirectionHorizontal,
                                  showMultimedia: true,
                                  bodyMaxLines: 5,
                                  bodyTextOverflow: TextOverflow.ellipsis,
                                  titleStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  bodyStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12),
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
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: FlutterMentions(
                                        key: key,
                                        minLines: 1,
                                        maxLines: 5,
                                        onChanged: (value) {
                                          onChangeMethod(value);
                                        },
                                        suggestionPosition:
                                            SuggestionPosition.Top,
                                        decoration: InputDecoration(
                                          hintText: 'Add Comment',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color:
                                                    Colors.red), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color:
                                                    Colors.red), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        mentions: [
                                          Mention(
                                              trigger: "@",
                                              style:
                                                  TextStyle(color: Colors.blue),
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
                                                        tageData['photo'] !=
                                                                null
                                                            ? CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  tageData[
                                                                      'photo'],
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
                                              style:
                                                  TextStyle(color: Colors.blue),
                                              data: heshTageData,
                                              suggestionBuilder:
                                                  (heshTageData) {
                                                print(
                                                    "sdfgfgdgh-$heshTageData");
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                /*  Flexible(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: TextFormField(
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
                                                  .invokeMethod(
                                                      'TextInput.hide');
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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.red), //<-- SEE HERE
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                          Map<String, dynamic> params = {
                                            "comment": addcomment.text,
                                            "blogUid": widget.blogUid,
                                            "userUid": User_ID1
                                          };

                                          BlocProvider.of<BlogcommentCubit>(
                                                  context)
                                              .AddBloCommentApi(
                                                  context, params);
                                        }
                                      }
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 25,
                                      backgroundColor:
                                          ColorConstant.primary_color,
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
                                      recentTabBehavior:
                                          RecentTabBehavior.RECENT,
                                      recentsLimit: 28,
                                      replaceEmojiOnLimitExceed: false,
                                      noRecents: const Text(
                                        'No Recents',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black26),
                                        textAlign: TextAlign.center,
                                      ),
                                      loadingIndicator: const SizedBox.shrink(),
                                      tabIndicatorAnimDuration:
                                          kTabScrollDuration,
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
          BlocProvider.of<BlogcommentCubit>(context)
              .GetAllHashtag(context, '10', '#${data1.trim()}');
        } else {
          String data = value.split(' @').last.replaceAll('@', '');
          BlocProvider.of<BlogcommentCubit>(context)
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
      BlocProvider.of<BlogcommentCubit>(context)
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
                          "index print${blogCommentModel?.object?[index1].commentUid}");
                      print(
                          "index print1${blogCommentModel?.object?[index1].comment}");

                      BlocProvider.of<BlogcommentCubit>(context)
                          .DeletecommentAPI(
                              "${blogCommentModel?.object?[index1].commentUid}",
                              "${blogCommentModel?.object?[index1].userUid}",
                              context);
                      blogCommentModel?.object?.removeAt(index1);
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

  String getTimeDifference(DateTime dateTime) {
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
