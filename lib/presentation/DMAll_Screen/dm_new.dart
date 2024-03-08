import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import 'package:pds/API/Model/inboxScreenModel/inboxScrrenModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

bool isLogPress = false;
bool isMeesageReaction = false;
int selectedCount = 0;
bool isMeesageCoppy = false;
int? swipeToIndex;
ScrollController scrollController = ScrollController();

class DmScreenNew extends StatefulWidget {
  String ChatInboxUid;
  DmScreenNew({required this.ChatInboxUid});

  @override
  State<DmScreenNew> createState() => _DmScreenNewState();
}

class _DmScreenNewState extends State<DmScreenNew> {
  String? UserLogin_ID;
  String? DMbaseURL;
  WebSocketChannel? channel;
  bool _isConnected = false;
  bool isMounted = true;
  GetInboxMessagesModel? getInboxMessagesModel;
  StompClient? stompClient;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController addComment = TextEditingController();
  Map<String, dynamic>? mapDataAdd;

  @override
  void initState() {
    isMounted = true;
    BlocProvider.of<DmInboxCubit>(context).seetinonExpried(context);
    pageNumberMethod();

    super.initState();
  }

  void onConnectCallback(StompFrame connectFrame) {
    stompClient?.subscribe(
        destination: '/topic/getInboxMessage/${widget.ChatInboxUid}',
        headers: {},
        callback: (frame) {
          addComment.clear();
          mapDataAdd?.clear();
          Map<String, dynamic> jsonString = json.decode(frame.body ?? "");
          print("check want to get-${jsonString}");
          print("login user uid -${UserLogin_ID}");
          mapDataAdd = {
            "userUid": jsonString['object']['userCode'],
            "userChatMessageUid": jsonString['object']['userChatInboxUid'],
            "userName": jsonString['object']['userName'],
            "userProfilePic": jsonString['object']['userProfilePic'],
            "message": jsonString['object']['message'],
            "createdDate": jsonString['object']['createdAt'],
            "messageType": jsonString['object']['messageType'],
            "isDeleted": jsonString['object']['isDeleted'],
            "isDelivered": jsonString['object']['isDelivered']
          };
          Content content = Content.fromJson(mapDataAdd!);
          getInboxMessagesModel?.object?.content?.add(content);
          if (isMounted == true) if (mounted) {
            setState(() {});
          }

          // Received a frame for this subscription
        });
  }

  void sendMessageMethod() {
    stompClient?.send(
        destination: '/send_message_in_user_chat/${widget.ChatInboxUid}',
        body: json.encode({
          "message": "${addComment.text}",
          "messageType": "TEXT",
          "userChatInboxUid": "${widget.ChatInboxUid}",
          //  "${widget.Room_ID}",
          "userCode": "${UserLogin_ID}",
          "isDelivered": true,
        }));
    /*  stompClient?.subscribe(
      destination: "/topic/getInboxMessage/${widget.ChatInboxUid}",
      callback: (StompFrame frame) {
        Map<String, dynamic> jsonString = json.decode(frame.body ?? "");
        print("jsonStringcheck-$jsonString");
      },
    ); */
  }

  pageNumberMethod() async {
    await BlocProvider.of<DmInboxCubit>(context)
        .DMChatListApiMethod(widget.ChatInboxUid, 1, context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);
    DMbaseURL = prefs.getString(PreferencesKey.SocketLink) ?? "";
    stompClient = StompClient(
        config: StompConfig(url: DMbaseURL!, onConnect: onConnectCallback));
    stompClient?.activate();
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
                  : Stack(
                      children: [
                        Column(
                          children: [
                            if (isLogPress == false)
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
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
                                    CustomImageView(
                                      imagePath: ImageConstant.tomcruse,
                                      height: 30,
                                      width: 30,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Ankur",
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
                                child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  chatPaginationWidget(
                                    onPagination: (p0) async {
                                      await BlocProvider.of<DmInboxCubit>(
                                              context)
                                          .DMChatListApiPagantion(
                                              widget.ChatInboxUid,
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
                            )),
                            if (isMeesageReaction == false)
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
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
                                            'Replying to Ankur',
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
                                          onTap: () {},
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
                        ),
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
      String reactionMessageData) {
    return GestureDetector(
      onTap: () {
        if (getInboxMessagesModel?.object?.content?[index].isSelected == null) {
          if (selectedCount < 10) {
            getInboxMessagesModel?.object?.content?[index].isSelected = true;
            _incrementSelectedCount();
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
          _incrementSelectedCount();
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
          onLeftSwipe: (details) {
            isMeesageReaction = true;

            swipeToIndex = index;
            print("swipetoindex-$swipeToIndex");
            if (isMounted == true) {
              if (mounted) setState(() {});
            }
            print("left side-$isMeesageReaction");

            print("detles-${details}");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (userMeesage == false)
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 5, bottom: 5),
                  child: GestureDetector(
                    onTap: () {
                      /* Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen(
                            User_ID: getInboxMessagesModel
                                    ?.object?.content?[index].userUid ??
                                "",
                            isFollowing: "");
                      },
                    )); */
                    },
                    child: userProfilePic != null || userProfilePic.isEmpty
                        ? CustomImageView(
                            alignment: Alignment.bottomLeft,
                            url: "${userProfilePic}",
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
                      onTap: () {
                        if (isLogPress == true) {
                          if (getInboxMessagesModel
                                  ?.object?.content?[index].isSelected ==
                              null) {
                            if (selectedCount < 10) {
                              getInboxMessagesModel
                                  ?.object?.content?[index].isSelected = true;
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

                            _incrementSelectedCount();
                          }
                          _hasImageMessageTypeSelected(index);
                          if (isMounted == true) {
                            if (mounted) {
                              setState(() {});
                            }
                          }
                        }
                      },
                      onLongPress: () {
                        isMeesageReaction = false;
                        isLogPress = true;

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
                      ),
                    )),
              ),
              if (userMeesage == true)
                GestureDetector(
                  onTap: () {
                    /* Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen(
                          User_ID: getInboxMessagesModel
                                  ?.object?.content?[index].userUid ??
                              "",
                          isFollowing: "");
                    },
                  )); */
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        print("this is the check -${userProfilePic.isEmpty}");
                      },
                      child: userProfilePic.isEmpty || userProfilePic == null
                          ? CustomImageView(
                              imagePath: ImageConstant.tomcruse,
                              height: 20,
                              radius: BorderRadius.circular(20),
                              width: 20,
                              fit: BoxFit.fill,
                            )
                          : CustomImageView(
                              url: userProfilePic,
                              height: 20,
                              radius: BorderRadius.circular(20),
                              width: 20,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
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
  }) : super(key: key);

  final bool userMeesage;
  final DateTime parsedDateTime;
  final bool isSelected;
  final String meessageTyep;
  final bool emojiReaction;

  final GetInboxMessagesModel getInboxMessagesModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (getInboxMessagesModel.object?.content?[index]
                    .messageType == // only user can sher image
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
              CustomImageView(
                margin: EdgeInsets.only(top: 10),
                url: "${getInboxMessagesModel.object?.content?[index].message}",
                height: 130,
                radius: BorderRadius.circular(20),
                fit: BoxFit.fill,
              ),
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ColorConstant.chatcolor,
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
          Container(
              constraints: BoxConstraints(
                  maxWidth: isSelected
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width / 2),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: LinkifyText(
                      getInboxMessagesModel.object?.content?[index].message ??
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
                          launchUrl(
                              Uri.parse("https://${link.value.toString()}"));
                        }
                      },
                    ),
                  ),

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