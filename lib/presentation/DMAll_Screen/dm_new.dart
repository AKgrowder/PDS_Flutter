import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/inboxScreenModel/inboxScrrenModel.dart';
import 'package:pds/API/Model/story_model.dart';
import 'package:pds/StoryFile/src/story_button.dart';
import 'package:pds/StoryFile/src/story_page_transform.dart';
import 'package:pds/StoryFile/src/story_route.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/create_story/full_story_page.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum Reaction { like, laugh, love, none }

bool isLogPress = false;
bool isMeesageReaction = false;
int selectedCount = 0;
bool isMeesageCoppy = false;
int? swipeToIndex;
ScrollController scrollController = ScrollController();
OverlayEntry? overlayEntry;
OverlayEntry? overlayEntry1;
TextEditingController addComment = TextEditingController();
TextEditingController reactionController = TextEditingController();
bool overlayVisible = false;
bool isEditMessage = false;
int isEditedindex = 0;
GetAllStoryModel? getAllStoryModel;
List<StoryButtonData> buttonDatas = [];

final List<ReactionElement> reactions = [
  ReactionElement(
    Reaction.like,
    const Icon(
      Icons.thumb_up_off_alt_rounded,
      color: Colors.blue,
    ),
  ),
  ReactionElement(
    Reaction.love,
    const Icon(
      Icons.favorite,
      color: Colors.red,
    ),
  ),
  ReactionElement(
    Reaction.laugh,
    const Icon(
      Icons.emoji_emotions_rounded,
      color: Colors.deepPurple,
    ),
  ),
];

class DmScreenNew extends StatefulWidget {
  String chatInboxUid;
  String chatUserName;
  String chatUserProfile;

  DmScreenNew(
      {required this.chatInboxUid,
      required this.chatUserName,
      required this.chatUserProfile});

  @override
  State<DmScreenNew> createState() => _DmScreenNewState();
}

class _DmScreenNewState extends State<DmScreenNew> with Observer {
  String? UserLogin_ID;
  String? DMbaseURL;
  WebSocketChannel? channel;
  bool _isConnected = false;
  bool isMounted = true;
  GetInboxMessagesModel? getInboxMessagesModel;
  StompClient? stompClient;
  final GlobalKey _scaffoldKey = GlobalKey();
  TextEditingController addComment = TextEditingController();
  Map<String, dynamic>? mapDataAdd;
  bool isScrollingDown = false;
  final focus = FocusNode();

  @override
  void initState() {
    Observable.instance.addObserver(this);
    isEditMessage = false;
    isEditedindex = 0;
    selectedCount = 0;
    swipeToIndex = 0;
    isLogPress = false;
    isMeesageReaction = false;
    BlocProvider.of<DmInboxCubit>(context).seetinonExpried(context);
    pageNumberMethod();

    super.initState();
  }

  myscrollFunction() {
    scrollController.addListener(() {});
  }

  @override
  update(Observable observable, String? notifyName, Map? map) async {
    print("this condison is working yet");
    pageNumberMethod();
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onConnectCallback(StompFrame connectFrame) {
    stompClient?.subscribe(
        destination: '/topic/getInboxMessage/${widget.chatInboxUid}',
        headers: {},
        callback: (frame) {
          addComment.clear();
          reactionController.clear();
          swipeToIndex = 0;
          isMeesageReaction = false;
          mapDataAdd?.clear();
          Map<String, dynamic> jsonString = json.decode(frame.body ?? "");
          print("check want to get-${jsonString}");
          print("login user uid -${UserLogin_ID}");
          mapDataAdd = {
            "userUid": jsonString['object']['userCode'],
            "userChatMessageUid": jsonString['object']['uid'],
            "userName": jsonString['object']['userName'],
            "userProfilePic": jsonString['object']['userProfilePic'],
            "message": jsonString['object']['message'],
            "createdDate": jsonString['object']['createdAt'],
            "messageType": jsonString['object']['messageType'],
            "isDeleted": jsonString['object']['isDeleted'],
            "isDelivered": jsonString['object']['isDelivered'],
            "replyOnUid": jsonString['object']['replyMessageUid'],
          };
          Content content = Content.fromJson(mapDataAdd!);
          getInboxMessagesModel?.object?.content?.add(content);
          print(
              "check what is Get-${getInboxMessagesModel?.object?.content?[isEditedindex].message}-${jsonString['object']['uid']}");
          /*  if (getInboxMessagesModel?.object?.content?[isEditedindex].message !=
              content.uid) {
            getInboxMessagesModel?.object?.content?.add(content);
          } */

          scrollController
              .jumpTo(scrollController.position.maxScrollExtent + 100);
          if (isMounted == true) if (mounted) {
            setState(() {});
          }
        });
  }

  void sendMessageMethod() {
    if (addComment.text.isNotEmpty) {
      if (isEditMessage == false) {
        stompClient?.send(
            destination: '/send_message_in_user_chat/${widget.chatInboxUid}',
            body: json.encode({
              "message": "${addComment.text}",
              "messageType": "TEXT",
              "userChatInboxUid": "${widget.chatInboxUid}",
              //  "${widget.Room_ID}",
              "userCode": "${UserLogin_ID}",
              "isDelivered": true,
            }));
      } else {
        print(
            "check else condison working -${isEditedindex} -${getInboxMessagesModel?.object?.content?[isEditedindex].userChatMessageUid}");
        stompClient?.send(
            destination: '/send_message_in_user_chat/${widget.chatInboxUid}',
            body: json.encode({
              "message": "${addComment.text}",
              "messageType": "TEXT",
              "userChatInboxUid": "${widget.chatInboxUid}",
              //  "${widget.Room_ID}",
              "userCode": "${UserLogin_ID}",
              "isDelivered": true,
              'uid':
                  "${getInboxMessagesModel?.object?.content?[isEditedindex].userChatMessageUid}",
            }));
      }
    } else {
      SnackBar snackBar = SnackBar(
        content: Text('Please Enter Text'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  pageNumberMethod() async {
    await BlocProvider.of<DmInboxCubit>(context)
        .DMChatListApiMethod(widget.chatInboxUid, 1, context);
    await BlocProvider.of<DmInboxCubit>(context).get_all_story(context);
     await BlocProvider.of<DmInboxCubit>(context)
        .LiveStatus(context, widget.chatInboxUid);
    await BlocProvider.of<DmInboxCubit>(context)
        .SeenMessage(context, widget.chatInboxUid);
    await BlocProvider.of<DmInboxCubit>(context)
        .getAllNoticationsCountAPI(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);
    DMbaseURL = prefs.getString(PreferencesKey.SocketLink) ?? "";
    stompClient = StompClient(
        config: StompConfig(url: DMbaseURL!, onConnect: onConnectCallback));
    stompClient?.activate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isMounted == true) {
        if (mounted) {
          setState(() {
            _scrollToBottom();
          });
        }
      }
    });
  }

  void dispose() {
    isMounted = false;
    stompClient?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
    ));
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BlocConsumer<DmInboxCubit, getInboxState>(
            listener: (context, state) {
              if (state is getInboxLoadedState) {
                print("this State is Calling");
                getInboxMessagesModel = state.getInboxMessagesModel;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (isMounted == true) {
                    if (mounted) {
                      _scrollToBottom();
                    }
                  }
                });
              }
              if (state is GetAllStoryLoadedState) {
                print('this stater Caling');
                getAllStoryModel = state.getAllStoryModel;
              }
            },
            builder: (context, state) {
              return getInboxMessagesModel?.object == null
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
                  : Column(
                      children: [
                        if (isLogPress == false)
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    overlayEntryRemoveMethod();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 30,
                                    width: 30,
                                    // color: Colors.red,
                                    child: Center(
                                      child: CustomImageView(
                                        imagePath: ImageConstant.RightArrowgrey,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                widget.chatUserProfile.isEmpty ||
                                        widget.chatUserProfile == null
                                    ? CustomImageView(
                                        imagePath: ImageConstant.tomcruse,
                                        height: 30,
                                        width: 30,
                                      )
                                    : CustomImageView(
                                        alignment: Alignment.bottomLeft,
                                        url: "${widget.chatUserProfile}",
                                        height: 30,
                                        radius: BorderRadius.circular(20),
                                        width: 30,
                                        fit: BoxFit.fill,
                                      ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${widget.chatUserName}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (isLogPress == true)
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (isMounted == true) {
                                      if (mounted) {
                                        setState(() {
                                          isLogPress = false;
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 30,
                                    width: 30,
                                    // color: Colors.red,
                                    child: Center(
                                      child: CustomImageView(
                                        imagePath: ImageConstant.RightArrowgrey,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${selectedCount}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                /*    Visibility(
                                  child: GestureDetector(
                                    onTap: () {

                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                ), */
                                GestureDetector(
                                  onTap: () async {
                                    /*  await Clipboard.setData(ClipboardData(
                                      text: reactionMessage ?? '')); */
                                    List usercoppmessage = [];
                                    getInboxMessagesModel?.object?.content
                                        ?.forEach((element) {
                                      if (element.isSelected == true) {
                                        print(
                                            "checl element -${element.message}");
                                        usercoppmessage.add(element.message);
                                      }
                                    });
                                    String textToCopy =
                                        usercoppmessage.join('\n');
                                    await Clipboard.setData(
                                        ClipboardData(text: textToCopy));
                                  },
                                  child: Visibility(
                                    visible: isMeesageCoppy,
                                    child: SizedBox(
                                        height: 20,
                                        child: Image.asset(
                                          ImageConstant.coppy,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(
                                        "i want to  check  selcted count-${selectedCount}");
                                    if (isMounted == true) {
                                      if (isMounted) {
                                        setState(() {
                                          isLogPress = false;
                                          isMeesageReaction = true;
                                        });
                                      }
                                    }
                                  },
                                  child: Visibility(
                                    visible: selectedCount == 1,
                                    child: SizedBox(
                                        height: 20,
                                        child: Image.asset(
                                          ImageConstant.replay,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: 20,
                                    child: Icon(Icons.star),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Map<String, dynamic> forwadList = {};
                                    List<Map<String, dynamic>>
                                        forwardMessageDtos = [];
                                    getInboxMessagesModel?.object?.content
                                        ?.forEach((element) {
                                      if (element.isSelected == true) {
                                        Map<String, dynamic> message = {
                                          'chatMessageUuid':
                                              element.userChatMessageUid,
                                          "isDelivered": true,
                                          "messageType": element.messageType
                                        };
                                        forwardMessageDtos.add(message);
                                      }
                                    });

                                    forwadList['forwardMessageDtos'] =
                                        forwardMessageDtos;
                                    print("forwardListcheck-$forwadList");
                                    /*  getInboxMessagesModel?.object?.content
                                      ?.forEach((element) {
                                    if (element.isSelected == true) {
                                      Map<String, dynamic> message = {
                                        'chatMessageUuid':
                                            element.userChatMessageUid,
                                        "isDelivered": true,
                                        "messageType": element.messageType
                                      };
                                      forwadList.add(message);
                                    }
                                  }); */
                                    /*   print("checl valye -${forwadList}"); */

                                    Navigator.pop(context, forwadList);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: SizedBox(
                                        height: 20,
                                        child: Image.asset(
                                          ImageConstant.forward,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        Divider(
                          height: 5,
                          color: Color.fromARGB(53, 117, 117, 117),
                        ),
                        Expanded(
                            child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            overlayEntryRemoveMethod();
                            return true;
                          },
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: chatPaginationWidget(
                              onPagination: (p0) async {
                                await BlocProvider.of<DmInboxCubit>(context)
                                    .DMChatListApiPagantion(
                                        widget.chatInboxUid, p0 + 1, context);
                              },
                              offSet: (getInboxMessagesModel
                                  ?.object?.pageable?.pageNumber),
                              scrollController: scrollController,
                              totalSize:
                                  getInboxMessagesModel?.object?.totalElements,
                              items: ListView.builder(
                                itemCount: getInboxMessagesModel
                                    ?.object?.content?.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final GlobalKey _widgetKey = GlobalKey();
                                  bool isReply = false;
                                  final isFirstMessageForDate = index == 0 ||
                                      _isDifferentDate(
                                          '${getInboxMessagesModel?.object?.content?[index - 1].createdDate}',
                                          '${getInboxMessagesModel?.object?.content?[index].createdDate}');
                                  DateTime parsedDateTime = DateTime.parse(
                                      '${getInboxMessagesModel?.object?.content?[index].createdDate}');
                                  List<Content>? lists = getInboxMessagesModel
                                      ?.object?.content
                                      ?.where((element) {
                                    if (element.userChatMessageUid ==
                                        getInboxMessagesModel?.object
                                            ?.content?[index].replyOnUid) {
                                      return true;
                                    }
                                    return false;
                                  }).toList();
                                  var iSReplay =
                                      lists != null && lists.isNotEmpty
                                          ? lists.first
                                          : null;
                                  print("isReplay check -$iSReplay");
                                  return Column(
                                    children: [
                                      if (isFirstMessageForDate)
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _formatDate(
                                                  '${getInboxMessagesModel?.object?.content?[index].createdDate}'),
                                              style: TextStyle(
                                                  color: Color(0xff5C5C5C),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if (getInboxMessagesModel?.object
                                              ?.content?[index].userUid ==
                                          UserLogin_ID)
                                        // user chat
                                        TextUser(
                                            getInboxMessagesModel?.object
                                                    ?.content?[index].message ??
                                                "",
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .userProfilePic ??
                                                "",
                                            true,
                                            parsedDateTime,
                                            index,
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .messageType ??
                                                "",
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .emojiReaction ??
                                                false,
                                            '${getInboxMessagesModel?.object?.content?[index].reactionMessage}',
                                            _widgetKey,
                                            iSReplay,
                                            UserLogin_ID ?? ""),
                                      if (getInboxMessagesModel?.object
                                              ?.content?[index].userUid !=
                                          UserLogin_ID)
                                        TextUser(
                                            getInboxMessagesModel?.object
                                                    ?.content?[index].message ??
                                                "",
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .userProfilePic ??
                                                "",
                                            false,
                                            parsedDateTime,
                                            index,
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .messageType ??
                                                "",
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .emojiReaction ??
                                                false,
                                            '${getInboxMessagesModel?.object?.content?[index].reactionMessage}',
                                            _widgetKey,
                                            iSReplay,
                                            UserLogin_ID ??
                                                ""), // other user chat
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        )),
                        /*  Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            chatPaginationWidget(
                              onPagination: (p0) async {
                                await BlocProvider.of<DmInboxCubit>(
                                        context)
                                    .DMChatListApiPagantion(
                                        widget.chatInboxUid,
                                        p0 + 1,
                                        context);
                              },
                              offSet: (getInboxMessagesModel
                                  ?.object?.pageable?.pageNumber),
                              scrollController: scrollController,
                              totalSize: getInboxMessagesModel
                                  ?.object?.totalElements,
                              items: ListView.builder(
                                controller: scrollController,
                                itemCount: getInboxMessagesModel
                                    ?.object?.content?.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final isFirstMessageForDate = index ==
                                          0 ||
                                      _isDifferentDate(
                                          '${getInboxMessagesModel?.object?.content?[index - 1].createdDate}',
                                          '${getInboxMessagesModel?.object?.content?[index].createdDate}');
                                  DateTime parsedDateTime = DateTime.parse(
                                      '${getInboxMessagesModel?.object?.content?[index].createdDate}');
                                  return Column(
                                    children: [
                                      if (isFirstMessageForDate)
                                        Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Text(
                                              _formatDate(
                                                  '${getInboxMessagesModel?.object?.content?[index].createdDate}'),
                                              style: TextStyle(
                                                  color:
                                                      Color(0xff5C5C5C),
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if (getInboxMessagesModel?.object
                                              ?.content?[index].userUid ==
                                          UserLogin_ID)
                                        // user chat
                                        TextUser(
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .message ??
                                                "",
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .userProfilePic ??
                                                "",
                                            true,
                                            parsedDateTime,
                                            index,
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .messageType ??
                                                "",
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .emojiReaction ??
                                                false,
                                            '${getInboxMessagesModel?.object?.content?[index].reactionMessage}'),
                                      if (getInboxMessagesModel?.object
                                              ?.content?[index].userUid !=
                                          UserLogin_ID)
                                        TextUser(
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .message ??
                                                "",
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .userProfilePic ??
                                                "",
                                            false,
                                            parsedDateTime,
                                            index,
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .messageType ??
                                                "",
                                            getInboxMessagesModel
                                                    ?.object
                                                    ?.content?[index]
                                                    .emojiReaction ??
                                                false,
                                            '${getInboxMessagesModel?.object?.content?[index].reactionMessage}'), // other user chat
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )), */
                        if (isMeesageReaction == false)
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    focusNode: focus,
                                    controller: addComment,
                                    minLines: 1,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: ColorConstant
                                                  .primary_color), //<-- SEE HERE
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 3,
                                            color: ColorConstant
                                                .primary_color, // Set the same color as enabledBorder
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        hintText: 'Type Message',
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // pickProfileImage();
                                                // prepareTestPdf(0);
                                              },
                                              child: Image.asset(
                                                "assets/images/paperclip-2.png",
                                                height: 23,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.50,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Image.asset(
                                                "assets/images/Vector (12).png",
                                                height: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: sendMessageMethod,
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 50,
                                  // width: 50,
                                  decoration: BoxDecoration(
                                      color: ColorConstant.primary_color,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Image.asset(
                                    "assets/images/Vector (13).png",
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        if (isMeesageReaction == true)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Replying to ${widget.chatUserName}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: IconButton(
                                          onPressed: () {
                                            if (isMounted == true) {
                                              if (mounted) {
                                                setState(() {
                                                  isMeesageReaction = false;
                                                });
                                              }
                                            }
                                          },
                                          icon: (Icon(Icons.close)),
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if (getInboxMessagesModel
                                            ?.object
                                            ?.content?[swipeToIndex ?? 0]
                                            .messageType ==
                                        'IMAGE' &&
                                    getInboxMessagesModel
                                            ?.object
                                            ?.content?[swipeToIndex ?? 0]
                                            .emojiReaction ==
                                        true)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 2),
                                    child: Text(
                                      '${getInboxMessagesModel?.object?.content?[swipeToIndex ?? 0].reactionMessage}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 15),
                                    ),
                                  ),
                                if (getInboxMessagesModel
                                        ?.object
                                        ?.content?[swipeToIndex ?? 0]
                                        .messageType ==
                                    'TEXT')
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 2),
                                    child: Text(
                                      '${getInboxMessagesModel?.object?.content?[swipeToIndex ?? 0].message}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 15),
                                    ),
                                  ),
                                if (getInboxMessagesModel
                                            ?.object
                                            ?.content?[swipeToIndex ?? 0]
                                            .messageType ==
                                        'IMAGE' &&
                                    getInboxMessagesModel
                                            ?.object
                                            ?.content?[swipeToIndex ?? 0]
                                            .emojiReaction ==
                                        false &&
                                    getInboxMessagesModel
                                            ?.object
                                            ?.content?[swipeToIndex ?? 0]
                                            .reactionMessage !=
                                        null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 2),
                                    child: Text(
                                      '${getInboxMessagesModel?.object?.content?[swipeToIndex ?? 0].reactionMessage}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 15),
                                    ),
                                  ),
                                if (getInboxMessagesModel
                                            ?.object
                                            ?.content?[swipeToIndex ?? 0]
                                            .messageType ==
                                        'IMAGE' &&
                                    getInboxMessagesModel
                                            ?.object
                                            ?.content?[swipeToIndex ?? 0]
                                            .emojiReaction ==
                                        false &&
                                    getInboxMessagesModel
                                            ?.object
                                            ?.content?[swipeToIndex ?? 0]
                                            .reactionMessage ==
                                        null)
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 70,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: CustomImageView(
                                      url:
                                          "${getInboxMessagesModel?.object?.content?[swipeToIndex ?? 0].reactionMessage}",
                                      height: 20,
                                      radius: BorderRadius.circular(20),
                                      width: 20,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: reactionController,
                                          minLines: 1,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: ColorConstant
                                                        .primary_color), //<-- SEE HERE
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 3,
                                                  color: ColorConstant
                                                      .primary_color, // Set the same color as enabledBorder
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              hintText: 'Type Message',
                                              filled: true,
                                              fillColor: Colors.white,
                                              suffixIcon: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // pickProfileImage();
                                                      // prepareTestPdf(0);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/paperclip-2.png",
                                                      height: 23,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.50,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Image.asset(
                                                      "assets/images/Vector (12).png",
                                                      height: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (reactionController
                                            .text.isNotEmpty) {
                                          stompClient?.send(
                                              destination:
                                                  '/send_message_in_user_chat/${widget.chatInboxUid}',
                                              body: json.encode({
                                                "message":
                                                    "${reactionController.text}",
                                                "messageType": "TEXT",
                                                "userChatInboxUid":
                                                    "${widget.chatInboxUid}",
                                                //  "${widget.Room_ID}",
                                                "userCode": "${UserLogin_ID}",
                                                "isDelivered": true,
                                                'replyMessageUid':
                                                    "${getInboxMessagesModel?.object?.content?[swipeToIndex ?? 0].userChatMessageUid}",
                                              }));
                                        } else {
                                          SnackBar snackBar = SnackBar(
                                            content: Text('Please Enter Text'),
                                            backgroundColor:
                                                ColorConstant.primary_color,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 50,
                                        // width: 50,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.primary_color,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Image.asset(
                                          "assets/images/Vector (13).png",
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  _hasImageMessageTypeSelected(index) {
    int counter = 0;
    getInboxMessagesModel?.object?.content?.forEach((element) {
      if (element.isSelected == true && element.messageType == 'TEXT') {
        counter++;
      }
    });
    isMeesageCoppy = getInboxMessagesModel?.object?.content
            ?.where((element) => element.isSelected == true)
            .toList()
            .length ==
        counter;
    /* if (getInboxMessagesModel?.object?.content?[index].messageType == 'IMAGE' &&
        getInboxMessagesModel?.object?.content?[index].isSelected == true) {
      isMeesageCoppy = false;
    } else {
      isMeesageCoppy = true;
    } */
  }

  TextUser(
      String message,
      String userProfilePic,
      bool userMeesage,
      DateTime parsedDateTime,
      index,
      String meessageTyep,
      bool emojiReaction,
      String reactionMessageData,
      _widgetKey,
      iSReplay,
      String userUid) {
    return GestureDetector(
      onTap: () {
        if (getInboxMessagesModel?.object?.content?[index].isSelected == null) {
          if (selectedCount < 10) {
            print("check selcecount-${selectedCount}");

            getInboxMessagesModel?.object?.content?[index].isSelected = true;
            if (selectedCount == 2) {
              overlayEntryRemoveMethod();
            }
            _incrementSelectedCount();
            print("this method calling");
          } else {
            final snackBar = SnackBar(
              content: Text('You can only select up to 10 messages.'),
              backgroundColor: ColorConstant.primary_color,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else if (getInboxMessagesModel?.object?.content?[index].isSelected ==
            true) {
          getInboxMessagesModel?.object?.content?[index].isSelected = false;
          _decrementSelectedCount();
        } else {
          getInboxMessagesModel?.object?.content?[index].isSelected = true;
          print("check selcecount-${selectedCount}");
          if (selectedCount == 2) {
            print("this condiso working");
            overlayEntryRemoveMethod();
          }
          _incrementSelectedCount();
          print("esle check");
        }
        _hasImageMessageTypeSelected(index);
        if (isMounted == true) {
          if (mounted) {
            setState(() {});
          }
        }
      },
      child: Container(
        color: getInboxMessagesModel?.object?.content?[index].isSelected == true
            ? Color(0xffE0C6C7).withOpacity(0.2)
            : Colors.transparent,
        margin: EdgeInsets.only(
            bottom: getInboxMessagesModel?.object?.content?[index].isSelected ==
                    true
                ? 4
                : 0),
        child: SwipeTo(
          swipeSensitivity: 10,
          onRightSwipe: (details) {
            isMeesageReaction = true;
            swipeToIndex = index;
            print("sweip to index -$swipeToIndex");
            if (isMounted == true) {
              if (mounted) setState(() {});
            }
          },
          onLeftSwipe: (details) {
            isMeesageReaction = true;
            swipeToIndex = index;
            if (isMounted == true) {
              if (mounted) setState(() {});
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (userMeesage == false)
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 5, bottom: 5),
                  child: getInboxMessagesModel
                                  ?.object?.content?[index].userProfilePic !=
                              null ||
                          getInboxMessagesModel?.object?.content?[index]
                                  .userProfilePic?.isNotEmpty ==
                              true
                      ? CustomImageView(
                          alignment: Alignment.bottomLeft,
                          url:
                              "${getInboxMessagesModel?.object?.content?[index].userProfilePic}",
                          height: 20,
                          radius: BorderRadius.circular(20),
                          width: 20,
                          fit: BoxFit.fill,
                        )
                      : CustomImageView(
                          alignment: Alignment.bottomLeft,
                          imagePath: ImageConstant.tomcruse,
                          height: 20,
                          radius: BorderRadius.circular(20),
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                ),
              Expanded(
                child: Align(
                    alignment: userMeesage == true
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    child: GestureDetector(
                      key: _widgetKey,
                      onTap: () {
                        if (isLogPress == true) {
                          if (getInboxMessagesModel
                                  ?.object?.content?[index].isSelected ==
                              null) {
                            if (selectedCount < 10) {
                              getInboxMessagesModel
                                  ?.object?.content?[index].isSelected = true;
                              _incrementSelectedCount();
                              print("this is the Data Get-${selectedCount}");
                              if (selectedCount == 2) {
                                overlayEntryRemoveMethod();
                              }
                            } else {
                              final snackBar = SnackBar(
                                content: Text(
                                    'You can only select up to 10 messages.'),
                                backgroundColor: ColorConstant.primary_color,
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else if (getInboxMessagesModel
                                  ?.object?.content?[index].isSelected ==
                              true) {
                            getInboxMessagesModel
                                ?.object?.content?[index].isSelected = false;
                            _decrementSelectedCount();
                          } else {
                            getInboxMessagesModel
                                ?.object?.content?[index].isSelected = true;

                            _incrementSelectedCount();
                            if (selectedCount == 2) {
                              overlayEntryRemoveMethod();
                            }
                          }
                          _hasImageMessageTypeSelected(index);
                          if (isMounted == true) {
                            if (mounted) {
                              setState(() {});
                            }
                          }
                        }
                      },
                      onLongPressStart: (details) {
                        isMeesageReaction = false;
                        isLogPress = true;
                        print("checl selectedCount -${selectedCount}");
                        if (selectedCount == 0) {
                          /* _showReactionPopUp(context, details.globalPosition,
                              _widgetKey, userMeesage, index); */
                        }

                        if (isMounted == true) {
                          if (mounted) {
                            setState(() {});
                          }
                        }
                        if (getInboxMessagesModel
                                ?.object?.content?[index].isSelected ==
                            null) {
                          if (selectedCount < 10) {
                            getInboxMessagesModel
                                ?.object?.content?[index].isSelected = true;
                            if (selectedCount == 2) {
                              overlayEntryRemoveMethod();
                            }
                            _incrementSelectedCount();
                          } else {
                            final snackBar = SnackBar(
                              content: Text(
                                  'You can only select up to 10 messages.'),
                              backgroundColor: ColorConstant.primary_color,
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else if (getInboxMessagesModel
                                ?.object?.content?[index].isSelected ==
                            true) {
                          getInboxMessagesModel
                              ?.object?.content?[index].isSelected = false;
                          _decrementSelectedCount();
                        } else {
                          getInboxMessagesModel
                              ?.object?.content?[index].isSelected = true;
                          if (selectedCount == 2) {
                            overlayEntryRemoveMethod();
                          }
                          _incrementSelectedCount();
                        }
                        _hasImageMessageTypeSelected(index);
                        if (isMounted == true) {
                          if (mounted) {
                            setState(() {});
                          }
                        }
                      },
                      child: MessageViewWidget(
                        userMeesage: userMeesage,
                        parsedDateTime: parsedDateTime,
                        isSelected: getInboxMessagesModel
                                ?.object?.content?[index].isSelected ??
                            false,
                        meessageTyep: meessageTyep,
                        emojiReaction: emojiReaction,
                        getInboxMessagesModel: getInboxMessagesModel!,
                        index: index,
                        isReplay: iSReplay,
                        useruid: UserLogin_ID ?? '',
                        chatInboxUid: widget.chatInboxUid,
                      ),
                    )),
              ),
              if (userMeesage == true)
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: GestureDetector(
                      onTap: () {},
                      child: getInboxMessagesModel?.object?.content?[index]
                                      .userProfilePic?.isEmpty ==
                                  true ||
                              getInboxMessagesModel?.object?.content?[index]
                                      .userProfilePic ==
                                  null
                          ? CustomImageView(
                              alignment: Alignment.bottomLeft,
                              imagePath: ImageConstant.tomcruse,
                              height: 20,
                              radius: BorderRadius.circular(20),
                              width: 20,
                              fit: BoxFit.fill,
                            )
                          : CustomImageView(
                              alignment: Alignment.bottomLeft,
                              url:
                                  "${getInboxMessagesModel?.object?.content?[index].userProfilePic}",
                              height: 20,
                              radius: BorderRadius.circular(20),
                              width: 20,
                              fit: BoxFit.fill,
                            )),
                )
            ],
          ),
        ),
      ),
    );
  }

  void _incrementSelectedCount() {
    if (selectedCount < 10) {
      setState(() {
        selectedCount++;
      });
    } else {
      final snackBar = SnackBar(
        content: Text('You can only select up to 10 messages.'),
        backgroundColor: ColorConstant.primary_color,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _decrementSelectedCount() {
    if (selectedCount > 0) {
      setState(() {
        selectedCount--;
      });
    }
  }

  void overlayEntryRemoveMethod() {
    if (overlayEntry1?.mounted == true && overlayEntry?.mounted == true) {
      overlayEntry1?.remove();
      overlayEntry?.remove();
    } else if (overlayEntry?.mounted == true) {
      overlayEntry?.remove();

      overlayEntry = null;
    } else if (overlayEntry1?.mounted == true) {
      overlayEntry1?.remove();
    }
  }

  void _showReactionPopUp(BuildContext context, Offset tapPosition,
      GlobalKey widgetKey, bool usermessage, int index) {
    final RenderBox renderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
    final screenWidth = MediaQuery.of(context).size.width;
    double left = widgetPosition.dx;
    double distanceToLeft = widgetPosition.dx;
    double distanceToRight = screenWidth - widgetPosition.dx;
    double popupWidth = 140; // Default width for the popup menu
    if (distanceToRight > distanceToLeft) {
      left -= 120;
    } else {
      // If the widget is closer to the right edge, adjust the left position
      // and change the popup width to fit it within the screen.
      left += renderBox.size.width + 60; // Adjusted left position
      popupWidth = screenWidth - left - 20; // Adjusted popup width
    }

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        left: usermessage == true ? left - 60 : 10,
        top: tapPosition.dy - 60,
        child: Material(
          child: Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: reactions.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 15 + index * 15,
                    child: FadeInAnimation(
                      child: IconButton(
                        onPressed: () {
                          overlayEntry?.remove();
                          // Your onPressed logic
                        },
                        icon: reactions[index].icon,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry!);

    if (usermessage == true &&
        getInboxMessagesModel?.object?.content?[index].messageType == 'TEXT') {
      print("check what is get");
      overlayEntry1 = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          left: usermessage == true ? left - 60 : 10,
          top: widgetPosition.dy + 110, // Adjust top position as needed
          child: Material(
            child: Container(
              height: 100, // Increased height to accommodate buttons
              width: 150,
              // color: Colors.grey.shade300,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(focus);
                        addComment.text =
                            '${getInboxMessagesModel?.object?.content?[index].message}';
                        isEditMessage = true;
                        isEditedindex = index;
                        overlayEntryRemoveMethod();
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: 80,
                        child: Row(
                          children: [
                            Text('Edit'),
                            Spacer(),
                            SizedBox(height: 20, child: Icon(Icons.edit))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        overlayEntryRemoveMethod();
                        // Copy button action
                      },
                      child: Container(
                        width: 80,
                        child: Row(
                          children: [
                            Text('Replay'),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                print("text -${addComment.text}");
                                /* stompClient?.send(
                                    destination:
                                        '/send_message_in_user_chat/${widget.chatInboxUid}',
                                    body: json.encode({
                                      "message": "${addComment.text}",
                                      "messageType": "TEXT",
                                      "userChatInboxUid":
                                          "${widget.chatInboxUid}",
                                      //  "${widget.Room_ID}",
                                      "userCode": "${UserLogin_ID}",
                                      "isDelivered": true,
                                     "replyMessageUid":
                                    })); */
                              },
                              child: SizedBox(
                                  height: 20,
                                  child: Image.asset(
                                    ImageConstant.replay,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(overlayEntry1!);
    }
  }
}

class MessageViewWidget extends StatelessWidget {
  MessageViewWidget({
    Key? key,
    required this.userMeesage,
    required this.parsedDateTime,
    required this.isSelected,
    required this.meessageTyep,
    required this.emojiReaction,
    required this.getInboxMessagesModel,
    required this.index,
    required this.isReplay,
    required this.useruid,
    required this.chatInboxUid,
  }) : super(key: key);

  final bool userMeesage;
  final DateTime parsedDateTime;
  final bool isSelected;
  final String meessageTyep;
  final bool emojiReaction;
  final GetInboxMessagesModel getInboxMessagesModel;
  final int index;
  final dynamic isReplay;
  final String useruid;
  final String chatInboxUid;
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(
        '${getInboxMessagesModel.object?.content?[index].createdDate}');
    return Column(
      children: [
        if (getInboxMessagesModel
                    .object?.content?[index].messageType ==
                'IMAGE' &&
            getInboxMessagesModel.object?.content?[index].emojiReaction ==
                false &&
            getInboxMessagesModel.object?.content?[index].reactionMessage ==
                null)
          Container(
            margin: EdgeInsets.all(10),
            height: 100,
            width: 160,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: CustomImageView(
              url: "${getInboxMessagesModel.object?.content?[index].message}",
              height: 20,
              radius: BorderRadius.circular(20),
              width: 20,
              fit: BoxFit.fill,
            ),
          ),
        if (getInboxMessagesModel.object?.content?[index]
                    .messageType == // only user can sher image
                'IMAGE' &&
            getInboxMessagesModel.object?.content?[index].emojiReaction ==
                false &&
            getInboxMessagesModel.object?.content?[index].reactionMessage !=
                null)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: userMeesage == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTapDown: (detalis) async {
                  if (getAllStoryModel?.object != null) {
                    buttonDatas.clear();
                    getAllStoryModel?.object?.forEach((element) {
                      element.storyData?.forEach((stroyDataIndex) {
                        if (stroyDataIndex.storyUid ==
                            getInboxMessagesModel
                                .object?.content?[index].storyUid) {
                          List<StoryModel> images = [
                            StoryModel(
                                stroyDataIndex.storyData,
                                stroyDataIndex.createdAt,
                                stroyDataIndex.profilePic,
                                stroyDataIndex.userName,
                                stroyDataIndex.storyUid,
                                stroyDataIndex.userUid,
                                stroyDataIndex.storyViewCount,
                                stroyDataIndex.videoDuration ?? 15)
                          ];
                          buttonDatas.insert(
                              0,
                              StoryButtonData(
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
                                  images: images,
                                  segmentDuration: const Duration(seconds: 3),
                                  storyPages: [
                                    FullStoryPage(
                                      imageName: '${stroyDataIndex.storyData}',
                                    )
                                  ]));
                          Navigator.of(context).push(
                            StoryRoute(
                              // hii working Date
                              onTap: () async {
                                await BlocProvider.of<DmInboxCubit>(context)
                                    .seetinonExpried(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProfileScreen(
                                      User_ID: "${stroyDataIndex.userUid}",
                                      isFollowing: "");
                                }));
                              },
                              storyContainerSettings: StoryContainerSettings(
                                buttonData: buttonDatas.first,
                                tapPosition:
                                    buttonDatas.first.buttonCenterPosition ??
                                        detalis.localPosition,
                                curve: buttonDatas.first.pageAnimationCurve,
                                allButtonDatas: buttonDatas,
                                pageTransform: StoryPage3DTransform(),
                                storyListScrollController: ScrollController(),
                              ),
                              duration: buttonDatas.first.pageAnimationDuration,
                            ),
                          );
                        }
                      });
                    });
                  }
                },
                child: CustomImageView(
                  margin: EdgeInsets.only(top: 10),
                  url:
                      "${getInboxMessagesModel.object?.content?[index].message}",
                  height: 130,
                  radius: BorderRadius.circular(20),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: userMeesage == true
                          ? ColorConstant.otheruserchat
                          : ColorConstant.ChatBackColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    getInboxMessagesModel
                            .object?.content?[index].reactionMessage ??
                        '',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        if (getInboxMessagesModel.object?.content?[index]
                    .messageType == // only user can sher image
                'IMAGE' &&
            getInboxMessagesModel.object?.content?[index].emojiReaction == true)
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: CustomImageView(
                  height: 130,
                  url: getInboxMessagesModel.object?.content?[index].message,
                  radius: BorderRadius.circular(20), //Ankur1
                  // height: 20,
                ),
              ),
              Positioned.fill(
                  child: Align(
                alignment: userMeesage == true
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                child: Container(
                  // height: 110,
                  // width: 50,
                  margin: EdgeInsets.only(bottom: 4, right: 2),
                  child: Text(
                    '${getInboxMessagesModel.object?.content?[index].reactionMessage}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ))
            ],
          ),
        if (getInboxMessagesModel.object?.content?[index].messageType == 'TEXT')
          Column(
            crossAxisAlignment: userMeesage == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isReplay != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: GestureDetector(
                    onTap: () {
                      print("check Value-${isReplay.userUid}-${useruid}");
                    },
                    child: Text(
                      "Replied To ${isReplay.userUid == useruid ? 'you' : '${isReplay.userName}'}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              if (isReplay != null)
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2),
                    padding: EdgeInsets.all(11),
                    margin: EdgeInsets.only(
                      top: isSelected == true ? 3 : 5,
                      left: userMeesage == true ? 0 : 20,
                      right: userMeesage == true ? 20 : 0,
                    ),
                    decoration: BoxDecoration(
                        color: userMeesage == true
                            ? Color(0xffFFF3F1).withOpacity(0.4)
                            : Color(0xffECECED).withOpacity(0.4),
                        borderRadius: userMeesage == true
                            ? BorderRadius.only(
                                topLeft: Radius.circular(13),
                                bottomLeft: Radius.circular(13))
                            : BorderRadius.only(
                                topRight: Radius.circular(13),
                                bottomRight: Radius.circular(13))),
                    child: Text(
                      "${isReplay.message}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                ),
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  padding: EdgeInsets.all(11),
                  margin: EdgeInsets.only(top: isSelected == true ? 3 : 5),
                  decoration: BoxDecoration(
                      color: userMeesage == true
                          ? ColorConstant.otheruserchat
                          : ColorConstant.ChatBackColor,
                      borderRadius: userMeesage == true
                          ? BorderRadius.circular(13)
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(13),
                              bottomRight: Radius.circular(13),
                              topRight: Radius.circular(13))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildRichText(
                          '${getInboxMessagesModel.object?.content?[index].message}',
                          date),
                      /* Flexible(
                        child: LinkifyText(
                          getInboxMessagesModel
                                  .object?.content?[index].message ??
                              '',
                          linkStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              fontFamily: "outfit",
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue),
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: "outfit",
                              fontSize: 15),
                          linkTypes: [
                            LinkType.url,
                          ],
                          onTap: (link) {
                            var SelectedTest = link.value.toString();
                            var Link = SelectedTest.startsWith('https');
                            var Link1 = SelectedTest.startsWith('http');
                            var Link2 = SelectedTest.startsWith('www');
                            var Link3 = SelectedTest.startsWith('WWW');
                            var Link4 = SelectedTest.startsWith('HTTPS');
                            var Link5 = SelectedTest.startsWith('HTTP');
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
                              print("qqqqqqqqhttps://${link.value}");

                              launchUrl(Uri.parse("${link.value.toString()}"));
                            } else {
                              launchUrl(Uri.parse(
                                  "https://${link.value.toString()}"));
                            }
                          },
                        ),
                      ), */
                      /*  Flexible(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            customFormat(parsedDateTime),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontFamily: "outfit",
                                fontSize: 10),
                          ),
                        ),
                      ), */
                      /* Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        customFormat(parsedDateTime),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 10),
                      ),
                    ), */
                    ],
                  )),
            ],
          ),
      ],
    );
  }
}

bool _isDifferentDate(String dateString1, String dateString2) {
  final date1 = DateTime.parse(dateString1).toLocal();
  final date2 = DateTime.parse(dateString2).toLocal();
  return !_isSameDate(date1, date2);
}

bool _isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

String _formatDate(String dateString) {
  final now = DateTime.now();
  final date = DateTime.parse(dateString).toLocal();
  if (_isSameDate(date, now)) {
    return 'Today';
  } else if (_isSameDate(date.add(Duration(days: 1)), now)) {
    return 'Yesterday';
  } else {
    return '${date.day}/${date.month}/${date.year}';
  }
}

String customFormat(DateTime date) {
  String time = (DateFormat('HH:mm').format(date));
  String formattedDate = '$time';
  return formattedDate;
}

navigatorpop() async {
  isLogPress = false;
  isMeesageReaction = false;
  selectedCount = 0;
  isMeesageCoppy = false;
  swipeToIndex = 0;
}

Reaction? getFakeInitialReaction(int index) {
  if (index % 5 == 0) {
    return Reaction.like;
  } else if (index % 7 == 0) {
    return Reaction.love;
  } else if (index % 9 == 0) {
    return Reaction.laugh;
  }
  return null;
}

class ReactionElement {
  final Reaction reaction;
  final Icon icon;
//
  ReactionElement(this.reaction, this.icon);
}

Widget buildRichText(String input, DateTime date) {
  List<TextSpan> textSpans = [];

  RegExp linkRegex = RegExp(r'(https?://\S+)|(@\w+)|(#\w+)');
  List<RegExpMatch> matches = linkRegex.allMatches(input).toList();

  int currentIndex = 0;

  for (RegExpMatch match in matches) {
    String textBeforeMatch = input.substring(currentIndex, match.start);
    if (textBeforeMatch.isNotEmpty) {
      textSpans.add(TextSpan(text: textBeforeMatch));
    }

    String matchedText = match.group(0)!;
    if (matchedText.startsWith('@') || matchedText.startsWith('#')) {
      // Handling @mentions and #hashtags
      textSpans.add(
        TextSpan(
          text: matchedText,
          style: TextStyle(color: Colors.blue),
        ),
      );
    } else if (matchedText.startsWith('http')) {
      // Handling links
      textSpans.add(
        TextSpan(
          text: matchedText,
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Handle tapping on the link here
              print('Tapped on link: $matchedText');
            },
        ),
      );
    }

    currentIndex = match.end;
  }

  String remainingText = input.substring(currentIndex);
  if (remainingText.isNotEmpty) {
    textSpans.add(TextSpan(text: remainingText));
  }

  // Add formatted date in small font size at the end
  String formattedDate = customFormat(date);

  // Wrap the date with padding
  /* textSpans.add(
    TextSpan(
      text: '\n', // Add a newline for top padding
    ),
  ); */
  textSpans.add(
    TextSpan(
      text: ' ${formattedDate}',
      style: TextStyle(
          fontSize: 10,
          color: Colors.grey,
          fontWeight: FontWeight.w700), // Small gray date text
    ),
  );

  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: textSpans,
    ),
  );
}
