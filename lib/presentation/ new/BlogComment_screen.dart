import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
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

  void _goToElement(int index) {
    scroll.animateTo((1000.0 * 100),
        duration: const Duration(milliseconds: 20), curve: Curves.easeOut);
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
          setState(() {
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

                _goToElement(blogCommentModel?.object?.length ?? 0);
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
                  'photo': element.userProfilePic
                };
                tageData.add(dataSetup);
                if (tageData.isNotEmpty == true) {
                  istageData = true;
                }
                print("check All Tag Datat-$tageData");
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
                                // physics:  NeverScrollableScrollPhysics(),
                                itemCount: blogCommentModel?.object?.length,
                                shrinkWrap: true,
                                controller: scroll,
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
                                                      width: 280,
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
                                                        child: LinkifyText(
                                                          "${blogCommentModel?.object?[index].comment}",
                                                          linkStyle: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          linkTypes: [
                                                            LinkType.url,
                                                            LinkType.userTag,
                                                            LinkType.hashTag,
                                                            // LinkType
                                                            //     .email
                                                          ],
                                                          onTap: (link) async {
                                                            /// do stuff with `link` like
                                                            /// if(link.type == Link.url) launchUrl(link.value);

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
                                                              if (Link2 ==
                                                                      true ||
                                                                  Link3 ==
                                                                      true) {
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
                                                                print(
                                                                    "${link}");
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          HashTagViewScreen(
                                                                              title: "${link.value}"),
                                                                    ));
                                                              } else {
                                                                var name;
                                                                var tagName;
                                                                name =
                                                                    SelectedTest;
                                                                tagName = name
                                                                    .replaceAll(
                                                                        "@",
                                                                        "");
                                                                await BlocProvider.of<
                                                                            BlogcommentCubit>(
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
                                                              }
                                                            }
                                                          },
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
                                                        tageData['photo']
                                                                        .toString()
                                                                        .isNotEmpty ==
                                                                    true &&
                                                                tageData['photo']
                                                                        .toString() !=
                                                                    null
                                                            ? CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        ImageConstant
                                                                            .tomcruse),
                                                              )
                                                            : CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  tageData[
                                                                      'photo'],
                                                                ),
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

                                            setState(() {
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
                                        setState(() {
                                          isEmojiVisible = false;
                                        });
                                      }
                                    },
                                    onEmojiSelected: (category, emoji) {
                                      addcomment.text += emoji.emoji;
                                      setState(() {});
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
    setState(() {
      addcomment.text = value;
    });
    if (value.contains('@')) {
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
    } else if (value.contains('#')) {
      print("check length-${value}");
      String data1 = value.split(' #').last.replaceAll('#', '');
      BlocProvider.of<BlogcommentCubit>(context)
          .GetAllHashtag(context, '10', '#${data1.trim()}');
    } else {
      setState(() {
        istageData = false;
        isHeshTegData = false;
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
}
