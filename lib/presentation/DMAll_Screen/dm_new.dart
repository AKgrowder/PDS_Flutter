import 'dart:async';
import 'dart:convert';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/inboxScreenModel/inboxScrrenModel.dart';
import 'package:pds/API/Model/story_model.dart';
import 'package:pds/StoryFile/src/story_button.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/new_story_view_page.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/create_story/full_story_page.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/videocallCommenClass.dart/commenFile.dart';
import 'package:pds/videocallCommenClass.dart/videocommeninviation.dart';
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
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:http/http.dart' as http;
import 'allStarMessage.dart';

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
bool isLoading = true;
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
  String chatOtherUseruid;
  String? videoId;
  bool? isExpert;
  bool? isBlock;
  bool? online;

  DmScreenNew(
      {required this.chatInboxUid,
      required this.chatUserName,
      required this.chatUserProfile,
      required this.chatOtherUseruid,
      this.online,
      this.videoId,
      this.isExpert,
      this.isBlock});

  @override
  State<DmScreenNew> createState() => _DmScreenNewState();
}

class _DmScreenNewState extends State<DmScreenNew> with Observer {
  String? UserLogin_ID;
  Timer? timer;
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
  Map<String, dynamic>? markStarred;

  @override
  void initState() {
    GetAllStory_Data();
    Observable.instance.addObserver(this);
    isEditMessage = false;
    isEditedindex = 0;
    selectedCount = 0;
    swipeToIndex = 0;
    isLogPress = false;
    isMeesageReaction = false;
    BlocProvider.of<DmInboxCubit>(context).seetinonExpried(context);
    pageNumberMethod();
    imageurlCheck = widget.chatUserProfile;
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  myscrollFunction() {
    scrollController.addListener(() {});
  }

  GetAllStory_Data() async {
    await BlocProvider.of<DmInboxCubit>(context).seetinonExpried(context);
    await BlocProvider.of<DmInboxCubit>(context)
        .DMChatListApiMethod(widget.chatInboxUid, 1, context);
    await BlocProvider.of<DmInboxCubit>(context).get_all_story(context);
  }

  saveNotificationCount(int NotificationCount, int MessageCount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.NotificationCount, NotificationCount);
    prefs.setInt(PreferencesKey.MessageCount, MessageCount);
  }

  @override
  update(Observable observable, String? notifyName, Map? map) async {
    print("this condison is working yet");
    pageNumberMethod();
  }

  void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
  ) {
    if (errorInvitees.isNotEmpty) {
      var userIDs = '';
      for (var index = 0; index < errorInvitees.length; index++) {
        if (index >= 5) {
          userIDs += '... ';
          break;
        }

        final userID = errorInvitees.elementAt(index);
        userIDs += '$userID ';
      }
      if (userIDs.isNotEmpty) {
        userIDs = userIDs.substring(0, userIDs.length - 1);
      }

      var message = "User doesn't exist or is offline: $userIDs";
      if (code.isNotEmpty) {
        message += ', code: $code, message:$message';
      }
      /*  showToast(
        message,
        position: StyledToastPosition.top,
        context: context,
      ); */
    } else if (code.isNotEmpty) {
      showToast(
        'User is offline',
        /*     'code: $code, message:$message', */
        position: StyledToastPosition.top,
        context: context,
      );
      /*
      SnackBar snackBar = SnackBar(
        content: Text('User is offline'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar); */
    }
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
          title = '';
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
    // await BlocProvider.of<DmInboxCubit>(context)
    //     .DMChatListApiMethod(widget.chatInboxUid, 1, context);
    // await BlocProvider.of<DmInboxCubit>(context).get_all_story(context);
    await BlocProvider.of<DmInboxCubit>(context)
        .LiveStatus(context, widget.chatInboxUid);
    await BlocProvider.of<DmInboxCubit>(context)
        .SeenMessage(context, widget.chatInboxUid);
    await BlocProvider.of<DmInboxCubit>(context)
        .getAllNoticationsCountAPI(context);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);
    String? UserName = prefs.getString(PreferencesKey.ProfileName);
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

  String title = "";
  Timer? _timer;

  void dispose() {
    timer?.cancel();
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
                      setState(() {
                        _scrollToBottom();
                      });
                    }
                  }
                });
              }
              if (state is GetAllStoryLoadedState) {
                print('this stater Caling');
                getAllStoryModel = state.getAllStoryModel;
              }

              if (state is GetAllStarClass) {
                isLogPress = false;
                selectedCount = 0;
                if (markStarred?['status'] == true) {
                  getInboxMessagesModel?.object?.content?.forEach((element) {
                    if (element.isSelected == true) {
                      element.isStarred = true;
                      element.isSelected = false;
                    }
                  });
                } else if (markStarred?['status'] == false) {
                  getInboxMessagesModel?.object?.content?.forEach((element) {
                    if (element.isSelected == true) {
                      element.isStarred = false;
                      element.isSelected = false;
                    }
                  });
                }
              }
              if (state is GetNotificationCountLoadedState) {
                saveNotificationCount(
                    state.GetNotificationCountData.object?.notificationCount ??
                        0,
                    state.GetNotificationCountData.object?.messageCount ?? 0);
              }
            },
            builder: (context, state) {
              return isLoading
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
                  : getInboxMessagesModel?.object == null
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
                                            imagePath:
                                                ImageConstant.RightArrowgrey,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return ProfileScreen(
                                                User_ID:
                                                    widget.chatOtherUseruid,
                                                isFollowing: "");
                                          },
                                        ));
                                      },
                                      child: widget.chatUserProfile.isEmpty ||
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
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return ProfileScreen(
                                                User_ID: widget.chatUserProfile,
                                                isFollowing: "");
                                          },
                                        ));
                                      },
                                      child: Container(
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
                                    ),
                                    Spacer(),
                                    /*    sendCallButton(
                                      isVideoCall: false,
                                      invitees: [
                                        ZegoUIKitUser(
                                            id: widget.chatOtherUseruid
                                                .split('-')
                                                .last
                                                .toString(),
                                            name: widget.chatUserName
                                                .toLowerCase())
                                      ],
                                      onCallFinished:
                                          onSendCallInvitationFinished,
                                    ),
                                    sendCallButton(
                                      isVideoCall: true,
                                      invitees: [
                                        ZegoUIKitUser(
                                            id: widget.chatOtherUseruid
                                                .split('-')
                                                .last
                                                .toString(),
                                            name: widget.chatUserName
                                                .toLowerCase())
                                      ],
                                      onCallFinished:
                                          onSendCallInvitationFinished,
                                    ), */
                                    /* GestureDetector(
                                        onTapDown: (TapDownDetails details) {
                                          _showPopupMenu(
                                              context, details.globalPosition);
                                        },
                                        child: Icon(Icons.more_vert)), */

                                    /*   sendCallButton(
                                  isVideoCall: true,
                                  userChatInboxUid:
                                      ValueNotifier(widget.chatInboxUid),
                                ), */
                                    /* GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ZegoSendCallInvitationButton(
                                                  isVideoCall: true,
                                                  invitees: [
                                                    ZegoUIKitUser(
                                                        id: widget.chatInboxUid,
                                                        name: 'ankur'),
                                                  ],
                                p                  resourceID: 'zego_data',
                                                  iconSize: const Size(40, 40),
                                                  buttonSize:
                                                      const Size(50, 50),
                                                  onPressed:
                                                      (code, message, p2) {},
                                                )));
                                  },
                                  child: Image.asset(
                                    ImageConstant.videocall,
                                    height: 25,
                                  ),
                                ), */
                                    SizedBox(
                                      width: 20,
                                    )
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
                                            imagePath:
                                                ImageConstant.RightArrowgrey,
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
                                            usercoppmessage
                                                .add(element.message);
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
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        markStarred?.clear();
                                        List<String> forStarDataSet = [];

                                        List<Content>? newList =
                                            getInboxMessagesModel
                                                ?.object?.content
                                                ?.where((element) =>
                                                    element.isSelected == true)
                                                .toList();
                                        newList?.forEach((element) {
                                          forStarDataSet.add(
                                              '${element.userChatMessageUid}');
                                        });
                                        if (newList?.every((element) =>
                                                element.isStarred ?? false) ==
                                            true) {
                                          markStarred = {
                                            'inboxUid':
                                                '${widget.chatInboxUid}',
                                            "messageUuids": forStarDataSet,
                                            "status": false,
                                          };
                                        } else if (newList?.every((element) =>
                                                element.isStarred ?? false) ==
                                            false) {
                                          markStarred = {
                                            'inboxUid':
                                                '${widget.chatInboxUid}',
                                            "messageUuids": forStarDataSet,
                                            "status": true,
                                          };
                                        } else if (newList?.any((element) =>
                                                element.isStarred ?? false) ==
                                            true) {
                                          markStarred = {
                                            'inboxUid':
                                                '${widget.chatInboxUid}',
                                            "messageUuids": forStarDataSet,
                                            "status": true,
                                          };
                                        }
                                        BlocProvider.of<DmInboxCubit>(context)
                                            .Setmark_starredApi(
                                                context, markStarred!);

                                        /*  if (getInboxMessagesModel?.object?.content
                                            ?.any((element) =>
                                                element.isStarred ?? false) ==
                                        false) {
                                      print("if condison working in Star");
                                      getInboxMessagesModel?.object?.content
                                          ?.forEach((element) {
                                        if (element.isSelected == true) {
                                          forStarDataSet.add(
                                              '${element.userChatMessageUid}');
                                        }
                                      });

                                      markStarred = {
                                        'inboxUid': '${widget.chatInboxUid}',
                                        "messageUuids": forStarDataSet,
                                        "status": true,
                                      };
                                    } else if (getInboxMessagesModel
                                            ?.object?.content
                                            ?.any((element) =>
                                                element.isStarred ?? false) ==
                                        true) {
                                      print("else if condison working in Star");
                                      getInboxMessagesModel?.object?.content
                                          ?.forEach((element) {
                                        if (element.isSelected == true) {
                                          forStarDataSet.add(
                                              '${element.userChatMessageUid}');
                                        }
                                      });
                                      markStarred = {
                                        'inboxUid': '${widget.chatInboxUid}',
                                        "messageUuids": forStarDataSet,
                                        "status": false,
                                      };
                                    } */
                                      },
                                      child: SizedBox(
                                        height: 25,
                                        child:
                                            Image.asset(ImageConstant.newStar),
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
                                    itemCount: getInboxMessagesModel
                                        ?.object?.content?.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final GlobalKey _widgetKey = GlobalKey();
                                      final isFirstMessageForDate = index ==
                                              0 ||
                                          _isDifferentDate(
                                              '${getInboxMessagesModel?.object?.content?[index - 1].createdDate}',
                                              '${getInboxMessagesModel?.object?.content?[index].createdDate}');
                                      DateTime parsedDateTime = DateTime.parse(
                                          '${getInboxMessagesModel?.object?.content?[index].createdDate}');
                                      List<Content>? lists =
                                          getInboxMessagesModel?.object?.content
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
                                                      color: Color(0xff5C5C5C),
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
                                                '${getInboxMessagesModel?.object?.content?[index].reactionMessage}',
                                                _widgetKey,
                                                iSReplay,
                                                UserLogin_ID ?? ""),
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
                                        onChanged: (value) {
                                          setState(() {
                                            title = "";
                                          });
                                          if (AnyLinkPreview.isValidLink(
                                              extractUrls(value).first)) {
                                            if (_timer != null) {
                                              _timer?.cancel();
                                              _timer = Timer(
                                                  Duration(seconds: 2), () {
                                                setState(() {
                                                  title =
                                                      extractUrls(value).first;
                                                });
                                              });
                                            } else {
                                              _timer = Timer(
                                                  Duration(seconds: 2), () {
                                                setState(() {
                                                  title =
                                                      extractUrls(value).first;
                                                });
                                              });
                                            }
                                          }
                                        },
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
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 3,
                                                        color: ColorConstant
                                                            .primary_color), //<-- SEE HERE
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 3,
                                                      color: ColorConstant
                                                          .primary_color, // Set the same color as enabledBorder
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  hintText: 'Type Message',
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  suffixIcon: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                    "userCode":
                                                        "${UserLogin_ID}",
                                                    "isDelivered": true,
                                                    'replyMessageUid':
                                                        "${getInboxMessagesModel?.object?.content?[swipeToIndex ?? 0].userChatMessageUid}",
                                                  }));
                                            } else {
                                              SnackBar snackBar = SnackBar(
                                                content:
                                                    Text('Please Enter Text'),
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
                                                color:
                                                    ColorConstant.primary_color,
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

  getYoutubePlayer(String videoUrl, Function() fullScreen) {
    late YoutubePlayerController _controller;

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
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
    print("i want to check As Now Points -${userMeesage}");
    return GestureDetector(
      onTap: () {
        if (isLogPress == true) {
          if (getInboxMessagesModel?.object?.content?[index].isSelected ==
              null) {
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
          } else if (getInboxMessagesModel
                  ?.object?.content?[index].isSelected ==
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen(
                            User_ID: getInboxMessagesModel
                                    ?.object?.content?[index].userUid ??
                                "",
                            isFollowing: "");
                      },
                    ));

                    print("object");
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 3, right: 5, bottom: 5),
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
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ProfileScreen(
                                User_ID: getInboxMessagesModel
                                        ?.object?.content?[index].userUid ??
                                    "",
                                isFollowing: "");
                          },
                        ));

                        print("object");
                      },
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
      print("check seclted conut- ${selectedCount}");
      if (selectedCount == 0) {
        isLogPress = false;
        if (isMounted == true) {
          if (mounted) {
            setState(() {});
          }
        }
      }
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
      left += renderBox.size.width + 60;
      popupWidth = screenWidth - left - 20;
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

class MessageViewWidget extends StatefulWidget {
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
  State<MessageViewWidget> createState() => _MessageViewWidgetState();
}

class _MessageViewWidgetState extends State<MessageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.getInboxMessagesModel.object?.content?[widget.index]
                    .messageType ==
                'IMAGE' &&
            widget.getInboxMessagesModel.object?.content?[widget.index]
                    .emojiReaction ==
                false &&
            widget.getInboxMessagesModel.object?.content?[widget.index]
                    .reactionMessage ==
                null)
          Container(
            margin: EdgeInsets.all(10),
            height: 100,
            width: 160,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: CustomImageView(
              url:
                  "${widget.getInboxMessagesModel.object?.content?[widget.index].message}",
              height: 20,
              radius: BorderRadius.circular(20),
              width: 20,
              fit: BoxFit.fill,
            ),
          ),
        if (widget.getInboxMessagesModel.object?.content?[widget.index]
                    .messageType == // only user can sher image
                'IMAGE' &&
            widget.getInboxMessagesModel.object?.content?[widget.index]
                    .emojiReaction ==
                false &&
            widget.getInboxMessagesModel.object?.content?[widget.index]
                    .reactionMessage !=
                null)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: widget.userMeesage == true
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
                            widget.getInboxMessagesModel.object
                                ?.content?[widget.index].storyUid) {
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
                          StoryButtonData data = StoryButtonData(
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
                              ]);
                          buttonDatas.insert(0, data);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return NewStoryViewPage(
                                data, buttonDatas, 0, widget.useruid);
                          }));
                          /*Navigator.of(context).push(
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
                          );*/
                        }
                      });
                    });
                  }
                },
                child: CustomImageView(
                  margin: EdgeInsets.only(top: 10),
                  url:
                      "${widget.getInboxMessagesModel.object?.content?[widget.index].message}",
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
                      color: widget.userMeesage == true
                          ? ColorConstant.otheruserchat
                          : ColorConstant.ChatBackColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    widget.getInboxMessagesModel.object?.content?[widget.index]
                            .reactionMessage ??
                        '',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        if (widget.getInboxMessagesModel.object?.content?[widget.index]
                    .messageType == // only user can sher image
                'IMAGE' &&
            widget.getInboxMessagesModel.object?.content?[widget.index]
                    .emojiReaction ==
                true)
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: CustomImageView(
                  height: 130,
                  url: widget.getInboxMessagesModel.object
                      ?.content?[widget.index].message,
                  radius: BorderRadius.circular(20), //Ankur1
                  // height: 20,
                ),
              ),
              Positioned.fill(
                  child: Align(
                alignment: widget.userMeesage == true
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                child: Container(
                  // height: 110,
                  // width: 50,
                  margin: EdgeInsets.only(bottom: 4, right: 2),
                  child: Text(
                    '${widget.getInboxMessagesModel.object?.content?[widget.index].reactionMessage}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ))
            ],
          ),
        if (widget.getInboxMessagesModel.object?.content?[widget.index]
                .messageType ==
            'TEXT')
          Column(
            crossAxisAlignment: widget.userMeesage == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isReplay != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: GestureDetector(
                    onTap: () {
                      print(
                          "check Value-${widget.isReplay.userUid}-${widget.useruid}");
                    },
                    child: Text(
                      "Replied To ${widget.isReplay.userUid == widget.useruid ? 'you' : '${widget.isReplay.userName}'}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              if (widget.isReplay != null)
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2),
                    padding: EdgeInsets.all(11),
                    margin: EdgeInsets.only(
                      top: widget.isSelected == true ? 3 : 5,
                      left: widget.userMeesage == true ? 0 : 20,
                      right: widget.userMeesage == true ? 20 : 0,
                    ),
                    decoration: BoxDecoration(
                        color: widget.userMeesage == true
                            ? Color(0xffFFF3F1).withOpacity(0.4)
                            : Color(0xffECECED).withOpacity(0.4),
                        borderRadius: widget.userMeesage == true
                            ? BorderRadius.only(
                                topLeft: Radius.circular(13),
                                bottomLeft: Radius.circular(13))
                            : BorderRadius.only(
                                topRight: Radius.circular(13),
                                bottomRight: Radius.circular(13))),
                    child: Text(
                      "${widget.isReplay.message}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                ),
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.70),
                  padding: EdgeInsets.all(11),
                  margin:
                      EdgeInsets.only(top: widget.isSelected == true ? 3 : 5),
                  decoration: BoxDecoration(
                      color: widget.userMeesage == true
                          ? ColorConstant.otheruserchat
                          : ColorConstant.ChatBackColor,
                      borderRadius: widget.userMeesage == true
                          ? BorderRadius.circular(13)
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(13),
                              bottomRight: Radius.circular(13),
                              topRight: Radius.circular(13))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Column(
                              children: [
                                if (extractUrls(widget
                                            .getInboxMessagesModel
                                            .object
                                            ?.content?[widget.index]
                                            .message ??
                                        "")
                                    .isNotEmpty)
                                  isYouTubeUrl(extractUrls(widget
                                                  .getInboxMessagesModel
                                                  .object
                                                  ?.content?[widget.index]
                                                  .message ??
                                              "")
                                          .first)
                                      ? FutureBuilder(
                                          future: fetchYoutubeThumbnail(
                                              extractUrls(widget
                                                          .getInboxMessagesModel
                                                          .object
                                                          ?.content?[
                                                              widget.index]
                                                          .message ??
                                                      "")
                                                  .first),
                                          builder: (context, snap) {
                                            return Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              snap.data
                                                                  .toString())),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              clipBehavior: Clip.antiAlias,
                                              child: Center(
                                                  child: IconButton(
                                                icon: Icon(
                                                  Icons
                                                      .play_circle_fill_rounded,
                                                  color: Colors.white,
                                                  size: 60,
                                                ),
                                                onPressed: () {
                                                  playLink(
                                                      extractUrls(widget
                                                                  .getInboxMessagesModel
                                                                  .object
                                                                  ?.content?[
                                                                      widget
                                                                          .index]
                                                                  .message ??
                                                              "")
                                                          .first,
                                                      context);
                                                },
                                              )),
                                            );
                                          })
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8.0),
                                          child: AnyLinkPreview(
                                            link: extractUrls(widget
                                                        .getInboxMessagesModel
                                                        .object
                                                        ?.content?[widget.index]
                                                        .message ??
                                                    "")
                                                .first,
                                            displayDirection: UIDirection
                                                .uiDirectionHorizontal,
                                            showMultimedia: true,
                                            bodyMaxLines: 5,
                                            bodyTextOverflow:
                                                TextOverflow.ellipsis,
                                            titleStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            bodyStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                            errorBody:
                                                'Show my custom error body',
                                            errorTitle:
                                                'Show my custom error title',
                                            errorWidget: null,
                                            errorImage: "https://flutter.dev/",
                                            cache: Duration(days: 7),
                                            backgroundColor: Colors.grey[300],
                                            borderRadius: 12,
                                            removeElevation: false,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 3,
                                                  color: Colors.grey)
                                            ],
                                            onTap: () {
                                              launchUrl(Uri.parse(extractUrls(widget
                                                          .getInboxMessagesModel
                                                          .object
                                                          ?.content?[
                                                              widget.index]
                                                          .message ??
                                                      "")
                                                  .first));
                                            }, // This disables tap event
                                          ),
                                        ),
                                SizedBox(
                                  height: 8,
                                ),
                                LinkifyText(
                                  widget.getInboxMessagesModel.object
                                          ?.content?[widget.index].message ??
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
                                    var Link4 =
                                        SelectedTest.startsWith('HTTPS');
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

                                      if (isYouTubeUrl(SelectedTest)) {
                                        playLink(SelectedTest, context);
                                      } else
                                        launchUrl(Uri.parse(
                                            "${link.value.toString()}"));
                                    } else {
                                      if (isYouTubeUrl(SelectedTest)) {
                                        playLink(SelectedTest, context);
                                      } else
                                        launchUrl(Uri.parse(
                                            "https://${link.value.toString()}"));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (widget.getInboxMessagesModel.object
                                  ?.content?[widget.index].isStarred ==
                              true)
                            Image.asset(
                              ImageConstant.newStar,
                              height: 15,
                            )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 3),
                        child: Text(
                          customFormat(widget.parsedDateTime),
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              fontFamily: "outfit",
                              fontSize: 10),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
      ],
    );
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

void _showPopupMenu(BuildContext context, Offset position) async {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final value = await showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromPoints(position, position),
      Offset.zero & overlay.size,
    ),
    items: <PopupMenuEntry>[
      PopupMenuItem(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text('Images & Attachments'),
        ),
        value: 'images',
      ),
      PopupMenuItem(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text('Star Message'),
        ),
        value: 'star',
      ),
      PopupMenuItem(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text('Save'),
        ),
        value: 'save',
      ),
    ],
  );

  if (value != null) {
    switch (value) {
      case 'images':
        // Handle images & attachments option
        break;
      case 'star':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StatrMessage(),
            ));
        break;
      case 'save':
        // Handle save option
        break;
    }
  }
}
