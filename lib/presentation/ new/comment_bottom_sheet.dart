import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
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

import '../../API/Model/UserTagModel/UserTag_model.dart';

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

  SearchUserForInbox? searchUserForInbox1;
  bool isKeyboardVisible = false;
  String? uuid;
  String? User_ID1;
  String? TeampData;
  UserTagModel? userTagModel;

  bool istageData = false;
  bool isHeshTegData = false;

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
          setState(() {
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
                        child: ListView.builder(
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
                                  padding:
                                      EdgeInsets.only(top: 15.0, left: 35.0),
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
                                                  const EdgeInsets.all(0.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return ProfileScreen(
                                                        User_ID:
                                                            "${addCommentModeldata?.object?[index].userUid}",
                                                        isFollowing:
                                                            widget.isFoollinng);
                                                  }));
                                                },
                                                child: addCommentModeldata
                                                                ?.object?[index]
                                                                .profilePic
                                                                ?.isEmpty ==
                                                            true ||
                                                        addCommentModeldata
                                                                ?.object?[index]
                                                                .profilePic ==
                                                            null
                                                    ? CustomImageView(
                                                        radius: BorderRadius
                                                            .circular(50),
                                                        imagePath: ImageConstant
                                                            .pdslogo,
                                                        fit: BoxFit.fill,
                                                        height: 35,
                                                        width: 35,
                                                      )
                                                    : CustomImageView(
                                                        radius: BorderRadius
                                                            .circular(50),
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
                                                width: 280,
                                                // color: Colors.amber,
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return ProfileScreen(
                                                        User_ID:
                                                            "${addCommentModeldata?.object?[index].userUid}",
                                                        isFollowing:
                                                            widget.isFoollinng);
                                                  }));
                                                },
                                                      child: Container(
                                                        child: Text(
                                                          "${addCommentModeldata?.object?[index].userName}",
                                                          style: TextStyle(
                                                              fontFamily: 'outfit',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight.bold),
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
                                                        overflow: TextOverflow
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
                                                              addCommentModeldata
                                                                      ?.object?[
                                                                          index]
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
                                                                color:
                                                                    Colors.grey,
                                                              )
                                                            : SizedBox(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: _width / 1.4,
                                                // height: 50,
                                                // color: Colors.amber,
                                                child: LinkifyText(
                                                  "${addCommentModeldata?.object?[index].comment}",
                                                    linkStyle:
                                                                              TextStyle(color: Colors.blue,fontFamily: 'outfit',),
                                                                          textStyle:
                                                                              TextStyle(color: Colors.black,fontFamily: 'outfit',),
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
                                                        } else if (link.value!.startsWith('@')) {
                                                        var name;
                                                        var tagName;
                                                        name = SelectedTest;
                                                        tagName =
                                                            name.replaceAll(
                                                                "@", "");
                                                        await BlocProvider.of<
                                                                    AddcommentCubit>(
                                                                context)
                                                            .UserTagAPI(context,
                                                                tagName);

                                                        print(
                                                            "tagName -- ${tagName}");
                                                        print(
                                                            "user id -- ${userTagModel?.object}");
                                                      }else{
                                                                                    launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                }
                                                    }
                                                  },
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
        
                                          setState(() {
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
                                    Map<String, dynamic> params = {
                                      "comment": addcomment.text,
                                      "postUid": '${widget.postUuID}',
                                    };

                                    BlocProvider.of<AddcommentCubit>(context)
                                        .AddPostApiCalling(context, params);
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
                                          setState(() {
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
        
                                              setState(() {
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
    setState(() {
      addcomment.text = value;
    });
    if (value.contains('@')) {
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
    } else if (value.contains('#')) {
      print("check length-${value}");
      String data1 = value.split(' #').last.replaceAll('#', '');
      BlocProvider.of<AddcommentCubit>(context)
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
}
