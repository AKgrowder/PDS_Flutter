import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/ApiService/DMSocket.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
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
import 'package:pds/presentation/gallery_All_Image.dart/gallery_All_image.dart';
// import 'package:pds/presentation/%20new/notifaction2.dart';
import 'package:pds/presentation/view_comments/view_comments_screen.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/Unblocked_userChat_dailog.dart';
import 'package:pds/widgets/animatedwiget.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import '../register_create_account_screen/register_create_account_screen.dart';
  ScrollController scrollController = ScrollController();

class DmScreen extends StatefulWidget {
  String UserName;
  String UserUID;
  String ChatInboxUid;
  String UserImage;
  String? videoId;
  bool? isExpert;
  bool? isBlock;
  DmScreen(
      {required this.ChatInboxUid,
      required this.UserName,
      required this.UserUID,
      required this.UserImage,
      this.videoId,
      this.isExpert,
      this.isBlock});

  @override
  State<DmScreen> createState() => _DmScreenState();
}

class _DmScreenState extends State<DmScreen> {
  bool emojiShowing = false;
  String addmsg = "";
  var Token = "";
  bool isontap = true;
  var UserCode = "";
  var User_Name = "";
  String? userId;
  DateTime? parsedDateTime;
  String? UserLogin_ID;
  ImagePicker picker = ImagePicker();
  XFile? pickedImageFile;
  ScrollController scrollController1 = ScrollController();
  TextEditingController videoId = TextEditingController();
  bool isScroll = false;
  bool AddNewData = false;
  bool addDataSccesfully = false;
  bool SubmitOneTime = false;
  File? _image;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  bool ReverseBool = false;
  bool OneTimeDelete = false;
  double documentuploadsize = 0;
  FocusNode _focusNode = FocusNode();
  Map<String, dynamic>? mapDataAdd;
  PlatformFile? file12;
  double value2 = 0.0;
  double finalFileSize = 0;
  ChooseDocument1? imageDataPost;
  String? stroyUid;
  GetInboxMessagesModel? getInboxMessagesModel;
  final focusNode = FocusNode();
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  TextEditingController Add_Comment = TextEditingController();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  List<StoryButtonData> buttonDatas = [];

  void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.vidoCallUid, widget.videoId ?? '') ?? "";
    showToast(
      message,
      position: StyledToastPosition.top,
      context: context,
    );
  }

  void _goToElement() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 100);
    print("msgUUIDmsgUUIDmsgUUID :- 1 ${widget.ChatInboxUid}");
  }

  Offset? get centerPosition {
    if (!mounted) {
      return null;
    }
    final renderBox = context.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(
      Offset(
        renderBox.paintBounds.width * .5,
        renderBox.paintBounds.height * .5,
      ),
    );
  }

  getDocumentSize() async {
    await BlocProvider.of<DmInboxCubit>(context).seetinonExpried(context);
    await BlocProvider.of<DmInboxCubit>(context)
        .SeenMessage(context, widget.ChatInboxUid);
    await BlocProvider.of<DmInboxCubit>(context)
        .getAllNoticationsCountAPI(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    documentuploadsize = await double.parse(
        prefs.getString(PreferencesKey.MaxInboxUploadSizeInMB) ?? "0");

    finalFileSize = documentuploadsize;
    setState(() {});
  }

  TapDownDetails? dataGet;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  void dispose() {
    DMstompClient.deactivate();

    // Delet_DMstompClient.deactivate();
    super.dispose();
  }

  String preprocessText(String text) {
    return text.replaceAll(RegExp(r'\b(?:https?://)?\S+\.com\b'), '');
  }

  checkGuestUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID != null) {
      // print("user login Mood");
      if (Add_Comment.text.isNotEmpty) {
        // setState(() {
        addmsg = "";
        Add_Comment.text = '';
        // });
      } else if (_image != null) {
        print("Usr_Id-$UserLogin_ID");
        print("Usr_Id-${widget.ChatInboxUid}");
        print("check this condiosn");
        BlocProvider.of<DmInboxCubit>(context).send_image_in_user_chat(context,
            widget.ChatInboxUid, UserLogin_ID.toString(), File(_image!.path));
        setState(() {
          SubmitOneTime = true;
        });
      } else {
        if (UserLogin_ID != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegisterCreateAccountScreen()));
        } else {
          SnackBar snackBar = SnackBar(
            content: Text('Please Enter Comment'),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      // print("User guest Mood on");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    }
  }

  pageNumberMethod() async {
    await BlocProvider.of<DmInboxCubit>(context)
        .DMChatListApiMethod(widget.ChatInboxUid, 1, context);
  }

  getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);
    print("UserLogin_ID-${UserLogin_ID}");
  }

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(PreferencesKey.loginUserID) ?? "";
    Token = prefs.getString(PreferencesKey.loginJwt) ?? "";
    UserCode = prefs.getString(PreferencesKey.loginUserID) ?? "";
    User_Name = prefs.getString(PreferencesKey.ProfileUserName) ?? "";
    DMbaseURL = prefs.getString(PreferencesKey.SocketLink) ?? "";
    DMstompClient.activate();
    // Delet_DMstompClient.activate();

    /*   DMstompClient.subscribe(
      destination:
          // "ws://72c1-2405-201-200b-a0cf-210f-e5fe-f229-e899.ngrok.io",
          // "/topic/getDeletedMessage/${widget.Room_ID}",
          "/send_message_in_user_chat/${widget.ChatInboxUid}",
      callback: (StompFrame frame) {
        Map<String, dynamic> jsonString = json.decode(frame.body ?? "");

        Content content1 = Content.fromJson(jsonString['object']);
        print("CCCCCCCC ->>>>>> ${content1}");
        var msgUUID = content1.userUid;
        /* if (content1.isDeleted == true) {
          setState(() {
            /*  AllChatmodelData?.object?.messageOutputList?.content =
                AllChatmodelData?.object?.messageOutputList?.content?.reversed
                    .toList(); */
            ReverseBool = false;
            // BlocProvider.of<senMSGCubit>(context)
            //     .coomentPage(widget.Room_ID, context, "${0}", ShowLoader: true);
          });
        } */

        getInboxMessagesModel?.object?.content =
            getInboxMessagesModel?.object?.content?.reversed.toList();
        ReverseBool = false;
        BlocProvider.of<DmInboxCubit>(context)
            .DMChatListApiMethod(widget.ChatInboxUid, 1, 20, context);
      },
    ); */
  }

  @override
  void initState() {
    print("dfgdfsdgf-${widget.videoId}");
    BlocProvider.of<DmInboxCubit>(context).seetinonExpried(context);
    getDocumentSize();
    pageNumberMethod();
    if (widget.videoId?.isNotEmpty == true) {
      print("dsfgdfgdfgsdgfsdg");
      // onUserLogin(widget.videoId ?? '', 'sxfdgfgd');
    }
    getUserID();
    getToken();
    getDocumentSize();

    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      this.isKeyboardVisible = isKeyboardVisible;

      if (isKeyboardVisible && isEmojiVisible) {
        isEmojiVisible = false;
      }
    });

    if (widget.isBlock == true) {
      Future.delayed(
        Duration(
          milliseconds: 2,
        ),
        () {
          showDialog(
            context: context,
            builder: (_) => UnBlockUserChatdailog(
              userName: widget.UserName,
            ),
          );
        },
      );
    }

    super.initState();
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

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isDifferentDate(String dateString1, String dateString2) {
    final date1 = DateTime.parse(dateString1).toLocal();
    final date2 = DateTime.parse(dateString2).toLocal();
    return !_isSameDate(date1, date2);
  }

  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
            // resizeToAvoidBottomInset: true,
            backgroundColor: theme.colorScheme.onPrimary,
            body: BlocConsumer<DmInboxCubit, getInboxState>(
                listener: (context, state) async {
              if (state is getInboxLoadedState) {
                List<String> date = [];
                DateTime today = DateTime.now();
                getInboxMessagesModel = state.getInboxMessagesModel;
                /*  getInboxMessagesModel?.object?.content?.forEach((element) {
                  date.add(customFormat1(element.createdDate ?? ''));
                });
                print("date -$date");
                List<String> uniqueDates = removeDuplicates(date);
                print('uniqueDates${uniqueDates}'); */
              }
              if (state is SeenAllMessageLoadedState) {
                print(state.SeenAllMessageModelData.object);
              }
              if (state is AddPostImaegState) {
                imageDataPost = state.imageDataPost;
              }
              if (state is GetNotificationCountLoadedState) {
                print(state.GetNotificationCountData.object);
                saveNotificationCount(
                    state.GetNotificationCountData.object?.notificationCount ??
                        0,
                    state.GetNotificationCountData.object?.messageCount ?? 0);
              }
              if (state is SendImageInUserChatState) {
                dynamic data = state.chatImageData;
                print("data -$data");

                _image = null;
                mapDataAdd?.clear();
                mapDataAdd = {
                  "userUid": data['object']['uid'],
                  "userChatMessageUid": data['object']['userChatInboxUid'],
                  "userName": data['object']['userName'],
                  "userProfilePic": data['object']['userProfilePic'],
                  "message": data['object']['message'],
                  "createdDate": data['object']['createdAt'],
                  "messageType": data['object']['messageType'],
                  "isDeleted": data['object']['isDeleted']
                };

                Content content = Content.fromJson(mapDataAdd!);

                getInboxMessagesModel?.object?.content?.add(content);
                SubmitOneTime = false;
              }
              if (state is GetAllStoryLoadedState) {
                print('this stater Caling');
                buttonDatas.clear();
                print("this is the Data Get");
                state.getAllStoryModel.object?.forEach((element) {
                  element.storyData?.forEach((index) {
                    print(
                        "check all functinty-${index.storyUid}---${stroyUid}");
                    if (index.storyUid == stroyUid) {
                      List<StoryModel> images = [
                        StoryModel(
                            index.storyData!,
                            index.createdAt!,
                            index.profilePic,
                            index.userName,
                            index.storyUid,
                            index.userUid,
                            index.storyViewCount,
                            index.videoDuration ?? 15)
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
                                  imageName: '${index.storyData}',
                                )
                              ]));
                      Navigator.of(context)
                          .push(
                            StoryRoute(
                              // hii working Date
                              onTap: () async {
                                await BlocProvider.of<DmInboxCubit>(context)
                                    .seetinonExpried(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProfileScreen(
                                      User_ID: "${index.userUid}",
                                      isFollowing: "");
                                }));
                              },
                              storyContainerSettings: StoryContainerSettings(
                                buttonData: buttonDatas.first,
                                tapPosition:
                                    buttonDatas.first.buttonCenterPosition ??
                                        dataGet!.localPosition,
                                curve: buttonDatas.first.pageAnimationCurve,
                                allButtonDatas: buttonDatas,
                                pageTransform: StoryPage3DTransform(),
                                storyListScrollController: ScrollController(),
                              ),
                              duration: buttonDatas.first.pageAnimationDuration,
                            ),
                          )
                          .then((value) => pageNumberMethod());
                    }
                  });
                });
              }
            }, builder: (context, state) {
              return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 45),
                  child: Container(
                    /*  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color.fromARGB(101, 158, 158, 158))), */
                    child: Stack(
                      children: [
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
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
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return ProfileScreen(
                                              User_ID: widget.UserUID,
                                              isFollowing: "");
                                        },
                                      ));
                                    },
                                    child: Container(
                                      child: widget.UserImage != null &&
                                              widget.UserImage != ""
                                          ? Container(
                                              child: CustomImageView(
                                                url: "${widget.UserImage}",
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.cover,
                                                radius:
                                                    BorderRadius.circular(30),
                                              ),
                                            )
                                          : CustomImageView(
                                              imagePath: ImageConstant.tomcruse,
                                              height: 30,
                                              width: 30,
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 2),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return ProfileScreen(
                                                User_ID: widget.UserUID,
                                                isFollowing: "");
                                          },
                                        ));
                                      },
                                      child: Container(
                                        child: Text(
                                          "${widget.UserName}",
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
                                  ),
                                  if (widget.isExpert == true)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 3),
                                      child: Image.asset(
                                        ImageConstant.Star,
                                        height: 15,
                                      ),
                                    ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MultiBlocProvider(
                                              providers: [
                                                BlocProvider<DmInboxCubit>(
                                                  create: (context) =>
                                                      DmInboxCubit(),
                                                ),
                                              ],
                                              child: GalleryImage(
                                                userChatInboxUid:
                                                    widget.ChatInboxUid,
                                              ));
                                        }));
                                        /* Navigator.push(context, MaterialPageRoute(builder: (context)=> GalleryImage())); */
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        // color: Colors.red,
                                        child: Center(
                                          child: CustomImageView(
                                            imagePath:
                                                ImageConstant.inbox_picture,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*    Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: sendCallButton(
                                      isVideoCall: true,
                                      inviteeUsersIDTextCtrl: widget.UserUID,
                                      onCallFinished:
                                          onSendCallInvitationFinished,
                                      inviterusername: widget.UserName,
                                    ),
                                  ) */
                                  /*   Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            PreferencesKey.vidoCallUid,
                                            widget.videoId ?? '');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Callpage(
                                                callId: widget.videoId ?? '',
                                                userid: widget.videoId ?? '',
                                                username: User_Name,
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        // color: Colors.red,
                                        child:
                                            Center(child: Icon(Icons.videocam)),
                                      ),
                                    ),
                                  ), */
                                  /*     Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        // color: Colors.red,
                                        child: Center(
                                          child: CustomImageView(
                                            imagePath:
                                                ImageConstant.inbox_search,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ), */
                                ]),
                          ),

                          /* Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${formattedDate}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${getInboxMessagesModel?.object?.content?.length != null ? getInboxMessagesModel?.object?.content?.length : '0'} Comments",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ), */
                          Divider(
                            height: 5,
                            color: Color.fromARGB(53, 117, 117, 117),
                          ),
                          Expanded(
                            child: Container(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: getInboxMessagesModel == null
                                      ? SizedBox()
                                      : SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            children: [
                                              chatPaginationWidget(
                                                  onPagination: (p0) async {
                                                    await BlocProvider.of<
                                                                DmInboxCubit>(
                                                            context)
                                                        .DMChatListApiPagantion(
                                                            widget.ChatInboxUid,
                                                            p0 + 1,
                                                            context);
                                                  },
                                                  offSet: (getInboxMessagesModel
                                                      ?.object
                                                      ?.pageable
                                                      ?.pageNumber),
                                                  scrollController:
                                                      scrollController,
                                                  totalSize:
                                                      getInboxMessagesModel
                                                          ?.object
                                                          ?.totalElements,
                                                  items: ListView.builder(
                                                      // reverse: true,
                                                      itemCount:
                                                          (getInboxMessagesModel
                                                                  ?.object
                                                                  ?.content
                                                                  ?.length ??
                                                              0),
                                                      shrinkWrap: true,
                                                      // controller:
                                                      //     scrollController1,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        final isFirstMessageForDate =
                                                            index == 0 ||
                                                                _isDifferentDate(
                                                                    '${getInboxMessagesModel?.object?.content?[index - 1].createdDate}',
                                                                    '${getInboxMessagesModel?.object?.content?[index].createdDate}');
                                                        DateTime
                                                            parsedDateTime =
                                                            DateTime.parse(
                                                                '${getInboxMessagesModel?.object?.content?[index].createdDate}');

                                                        // var ara = getTime(
                                                        //     parsedDateTime);

                                                        if (isScroll == false) {
                                                          Future.delayed(
                                                              Duration(
                                                                  microseconds:
                                                                      1), () {
                                                            if (scrollController
                                                                .hasClients) {
                                                              for (int i = 0;
                                                                  i <
                                                                      (getInboxMessagesModel
                                                                              ?.object
                                                                              ?.content!
                                                                              .length ??
                                                                          0);
                                                                  i++)
                                                                scrollController
                                                                    .jumpTo(
                                                                  scrollController
                                                                      .position
                                                                      .maxScrollExtent,
                                                                );
                                                            }
                                                            // setState(() {
                                                            isScroll = true;
                                                            // });
                                                          });
                                                        } else {}

                                                        ///
                                                        return Column(
                                                          children: [
                                                            if (isFirstMessageForDate)
                                                              Container(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    _formatDate(
                                                                        '${getInboxMessagesModel?.object?.content?[index].createdDate}'),
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff5C5C5C),
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            getInboxMessagesModel
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .userName !=
                                                                    User_Name
                                                                ? Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          /* horizontal: 35, vertical: 5 */),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            /*   Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding:
                                                                                  const EdgeInsets.only(left: 10, right: 3),
                                                                              child: getInboxMessagesModel?.object?.content?[index].userName != null
                                                                                  ? CustomImageView(
                                                                                      url: "${getInboxMessagesModel?.object?.content?[index].userProfilePic}",
                                                                                      height: 20,
                                                                                      radius: BorderRadius.circular(20),
                                                                                      width: 20,
                                                                                      fit: BoxFit.fill,
                                                                                    )
                                                                                  : CustomImageView(
                                                                                      imagePath: ImageConstant.tomcruse,
                                                                                      height: 20,
                                                                                    ),
                                                                            ),
                                                                            Text(
                                                                              "${getInboxMessagesModel?.object?.content?[index].userName}",
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: Colors.black,
                                                                                  fontFamily: "outfit",
                                                                                  fontSize: 14),
                                                                            ),
                                                                            Spacer(),
                                                                            Align(
                                                                              alignment:
                                                                                  Alignment.centerRight,
                                                                              child:
                                                                                  Padding(
                                                                                padding: const EdgeInsets.only(right: 16),
                                                                                child: Text(
                                                                                  customFormat(parsedDateTime),
                                                                                  // maxLines: 3,
                                                                                  textScaleFactor: 1.0,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: "outfit", fontSize: 12),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ), */
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            getInboxMessagesModel?.object?.content?[index].messageType != 'IMAGE'
                                                                                ? Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      // Spacer(),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 3, right: 0),
                                                                                        child: GestureDetector(
                                                                                          onTap: () {
                                                                                            Navigator.push(context, MaterialPageRoute(
                                                                                              builder: (context) {
                                                                                                return ProfileScreen(User_ID: getInboxMessagesModel?.object?.content?[index].userUid ?? "", isFollowing: "");
                                                                                              },
                                                                                            ));
                                                                                          },
                                                                                          child: getInboxMessagesModel?.object?.content?[index].userProfilePic != null && getInboxMessagesModel?.object?.content?[index].userProfilePic != ""
                                                                                              ? CustomImageView(
                                                                                                  url: "${getInboxMessagesModel?.object?.content?[index].userProfilePic}",
                                                                                                  height: 20,
                                                                                                  radius: BorderRadius.circular(20),
                                                                                                  width: 20,
                                                                                                  fit: BoxFit.fill,
                                                                                                )
                                                                                              : CustomImageView(
                                                                                                  imagePath: ImageConstant.tomcruse,
                                                                                                  height: 20,
                                                                                                ),
                                                                                        ),
                                                                                      ),
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(top: 0, left: 3),
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: ColorConstant.ChatBackColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(13), bottomRight: Radius.circular(13), topRight: Radius.circular(13))),
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                                  child: Text(
                                                                                                    "${getInboxMessagesModel?.object?.content?[index].message ?? ""}",
                                                                                                    // maxLines: 3,
                                                                                                    textScaleFactor: 1.0,
                                                                                                    style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontFamily: "outfit", fontSize: 15),
                                                                                                  ),
                                                                                                ),
                                                                                                // Padding(

                                                                                                //   padding: const EdgeInsets.only(left: 4, right: 4),
                                                                                                //   child: Text(
                                                                                                //     getTimeDifference(parsedDateTime),
                                                                                                //     textScaleFactor: 1.0,
                                                                                                //     style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontFamily: "outfit", fontSize: 10),
                                                                                                //   ),
                                                                                                // ),
                                                                                                 
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 4, right: 8, bottom: 2),
                                                                                                  child: Text(
                                                                                                    customFormat(parsedDateTime),
                                                                                                    textScaleFactor: 1.0,
                                                                                                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontFamily: "outfit", fontSize: 10,),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                      SizedBox(
                                                                                        width: 70,
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          Navigator.push(context, MaterialPageRoute(
                                                                                            builder: (context) {
                                                                                              return ProfileScreen(User_ID: getInboxMessagesModel?.object?.content?[index].userUid ?? "", isFollowing: "");
                                                                                            },
                                                                                          ));
                                                                                        },
                                                                                        child: getInboxMessagesModel?.object?.content?[index].userProfilePic != null && getInboxMessagesModel?.object?.content?[index].userProfilePic != ""
                                                                                            ? Padding(
                                                                                                padding: EdgeInsets.only(top: 10, left: 3),
                                                                                                child: CustomImageView(
                                                                                                  url: "${getInboxMessagesModel?.object?.content?[index].userProfilePic}",
                                                                                                  height: 20,
                                                                                                  radius: BorderRadius.circular(20),
                                                                                                  width: 20,
                                                                                                  fit: BoxFit.fill,
                                                                                                ),
                                                                                              )
                                                                                            : Padding(
                                                                                                padding: EdgeInsets.only(top: 10, left: 3),
                                                                                                child: CustomImageView(
                                                                                                  imagePath: ImageConstant.tomcruse,
                                                                                                  height: 20,
                                                                                                ),
                                                                                              ),
                                                                                      ),
                                                                                      Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(top: 10, left: 3),
                                                                                            child: Container(
                                                                                              height: getInboxMessagesModel?.object?.content?[index].reactionMessage != null ? 130 : 100,
                                                                                              width: getInboxMessagesModel?.object?.content?[index].reactionMessage != null ? 70 : 150,
                                                                                              child: getInboxMessagesModel?.object?.content?[index].reactionMessage != null
                                                                                                  ? GestureDetector(
                                                                                                      onTapDown: (detalis) {
                                                                                                        print('sdgfgdfgdfgsdfdgfg');
                                                                                                        print('emojiReaction-${getInboxMessagesModel?.object?.content?[index].reactionMessage}');
                                                                                                        print('emojiReaction-${getInboxMessagesModel?.object?.content?[index].emojiReaction}');
                                                                                                        print("dsdfdffffff-${getInboxMessagesModel?.object?.content?[index].storyUid}");
                                                                                                        stroyUid = getInboxMessagesModel?.object?.content?[index].storyUid;
                                                                                                        BlocProvider.of<DmInboxCubit>(context).get_all_story(context).then((value) {});
                                                                                                        dataGet = detalis;
                                                                                                      },
                                                                                                      child: getInboxMessagesModel?.object?.content?[index].emojiReaction == true
                                                                                                          ? Stack(
                                                                                                              children: [
                                                                                                                CustomImageView(
                                                                                                                  url: getInboxMessagesModel?.object?.content?[index].message,
                                                                                                                  radius: BorderRadius.circular(20),
                                                                                                                  // height: 20,
                                                                                                                ),
                                                                                                                Positioned.fill(
                                                                                                                    child: Align(
                                                                                                                  alignment: Alignment.bottomRight,
                                                                                                                  child: Container(
                                                                                                                    // height: 110,
                                                                                                                    // width: 50,
                                                                                                                    margin: EdgeInsets.only(bottom: 2, right: 2),
                                                                                                                    child: Text(
                                                                                                                      '${getInboxMessagesModel?.object?.content?[index].reactionMessage}',
                                                                                                                      style: TextStyle(fontSize: 20),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ))
                                                                                                              ],
                                                                                                            )
                                                                                                          : getInboxMessagesModel?.object?.content?[index].message?.endsWith('.mp4') == true
                                                                                                              ? VideoThumbnailPage(
                                                                                                                  videoUrl: getInboxMessagesModel?.object?.content?[index].message ?? '',
                                                                                                                )
                                                                                                              : CustomImageView(
                                                                                                                  url: getInboxMessagesModel?.object?.content?[index].message,
                                                                                                                  radius: BorderRadius.circular(20),
                                                                                                                  // height: 20,
                                                                                                                ),
                                                                                                    )
                                                                                                  : AnimatedNetworkImage(imageUrl: "${getInboxMessagesModel?.object?.content?[index].message}"),
                                                                                            ),
                                                                                          ),

                                                                                          /* Container(
                                                                                        height: 50,
                                                                                        width: 50,
                                                                                        color: Colors.amber,
                                                                                      ) */

                                                                                          /*  Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: Align(
                                                                                alignment: Alignment.topRight,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(right: 20),
                                                                                  child: Container(
                                                                                      padding: EdgeInsets.all(10),
                                                                                      decoration: BoxDecoration(color: ColorConstant.primary_color, borderRadius: BorderRadius.circular(10)),
                                                                                      child: Text(
                                                                                        getInboxMessagesModel?.object?.content?[index].reactionMessage ?? '',
                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                      )),
                                                                                )),
                                                                          ),
                                                                        ],
                                                                      ) */
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                            /* Divider(
                                                                          color: const Color.fromARGB(
                                                                              117,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ), */
                                                                            if (getInboxMessagesModel?.object?.content?[index].reactionMessage != null &&
                                                                                getInboxMessagesModel?.object?.content?[index].emojiReaction != true)
                                                                              Row(
                                                                                children: [
                                                                                  Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.only(top: getInboxMessagesModel?.object?.content?[index].messageType == 'TEXT' ? 10 : 0, left: 20),
                                                                                        child: Container(
                                                                                            margin: EdgeInsets.only(top: 3),
                                                                                            padding: EdgeInsets.all(10),
                                                                                            decoration: BoxDecoration(color: ColorConstant.chatcolor, borderRadius: BorderRadius.circular(10)),
                                                                                            child: Text(
                                                                                              getInboxMessagesModel?.object?.content?[index].reactionMessage ?? '',
                                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                            )),
                                                                                      )),
                                                                                ],
                                                                              )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        /*  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              16),
                                                                      child: ara ==
                                                                              null
                                                                          ? GestureDetector(
                                                                              onTap: () {
                                                                                OneTimeDelete = false;
                                                                                print(AllChatmodelData?.object?.messageOutputList?.content?[index].uid);
                                                                                print(UserLogin_ID);
                                                                                DMChatInboxUid = "${widget.ChatInboxUid}";
                                                                                DMstompClient.subscribe(
                                                                                  destination:
                                                                                      // "ws://72c1-2405-201-200b-a0cf-210f-e5fe-f229-e899.ngrok.io",
                                                                                      // "/topic/getDeletedMessage/${widget.Room_ID}",
                                                                                      "/user/api/send_message_in_user_chat/${widget.ChatInboxUid}",
                                                                                  callback: (StompFrame frame) {
                                                                                    Map<String, dynamic> jsonString = json.decode(frame.body ?? "");

                                                                                    Content content1 = Content.fromJson(jsonString['object']);
                                                                                    print("AAAAAAAAA ->>>>>> ${content1}");
                                                                                    print("delete 11");
                                                                                    var msgUUID = content1.uid;
                                                                                    if (content1.isDeleted == true) {
                                                                                      // AllChatmodelData?.object?.messageOutputList?.content?.removeAt(index);

                                                                                      if (OneTimeDelete == false) {
                                                                                        OneTimeDelete = true;
                                                                                        setState(() {
                                                                                          AllChatmodelData?.object?.messageOutputList?.content = AllChatmodelData?.object?.messageOutputList?.content?.reversed.toList();
                                                                                          ReverseBool = false;
                                                                                          // BlocProvider.of<senMSGCubit>(context).coomentPage(widget.Room_ID, context, "${0}", ShowLoader: true);
                                                                                        });
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                );

                                                                                DMstompClient.send(
                                                                                  destination:  "/user/api/send_message_in_user_chat/${widget.ChatInboxUid}",
                                                                                  // "/deleteMessage/${widget.Room_ID}",
                                                                                  body: json.encode({
                                                                                    "uid": "${AllChatmodelData?.object?.messageOutputList?.content?[index].uid}",
                                                                                    "userCode": "${UserLogin_ID}",
                                                                                    "roomUid": ""
                                                                                    // "${widget.Room_ID}"
                                                                                  }),
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                height: 20,
                                                                                width: 20,
                                                                                child: Image.asset(
                                                                                  ImageConstant.delete,
                                                                                  color: Colors.red,
                                                                                ),
                                                                              ))
                                                                          : ara.split(" ")[1] == "hours" || ara.split(" ")[1] == "days"
                                                                              ? SizedBox()
                                                                              : ara == "a few seconds ago" || ara == null
                                                                                  ? GestureDetector(
                                                                                      onTap: () {
                                                                                        OneTimeDelete = false;
                                                                                        print(AllChatmodelData?.object?.messageOutputList?.content?[index].uid);
                                                                                        print(UserLogin_ID);
                                                                                        DMChatInboxUid = "${widget.ChatInboxUid}";

                                                                                        // "${widget.Room_ID}";
                                                                                        DMstompClient.subscribe(
                                                                                          destination:  "/user/api/send_message_in_user_chat/${widget.ChatInboxUid}",
                                                                                          // "/topic/getDeletedMessage/${widget.Room_ID}",
                                                                                          callback: (StompFrame frame) {
                                                                                            Map<String, dynamic> jsonString = json.decode(frame.body ?? "");

                                                                                            Content content1 = Content.fromJson(jsonString['object']);
                                                                                            print("delete 22");
                                                                                            print("BBBBBBBBB ->>>>>> ${content1}");
                                                                                            var msgUUID = content1.uid;
                                                                                            if (content1.userCode == "") {
                                                                                            } else {
                                                                                              if (content1.isDeleted == true) {
                                                                                                if (OneTimeDelete == false) {
                                                                                                  OneTimeDelete = true;
                                                                                                  setState(() {
                                                                                                    AllChatmodelData?.object?.messageOutputList?.content = AllChatmodelData?.object?.messageOutputList?.content?.reversed.toList();
                                                                                                    ReverseBool = false;
                                                                                                    // BlocProvider.of<senMSGCubit>(context).coomentPage(widget.Room_ID, context, "${0}", ShowLoader: true);
                                                                                                  });
                                                                                                }
                                                                                              }
                                                                                            }
                                                                                          },
                                                                                        );

                                                                                        DMstompClient.send(
                                                                                          destination:  "/user/api/send_message_in_user_chat/${widget.ChatInboxUid}",
                                                                                          //  "/deleteMessage/${widget.Room_ID}",
                                                                                          body: json.encode({
                                                                                            "uid": "${AllChatmodelData?.object?.messageOutputList?.content?[index].uid}",
                                                                                            "userCode": "${UserLogin_ID}",
                                                                                            "roomUid": ""
                                                                                            //  "${widget.Room_ID}"
                                                                                          }),
                                                                                        );
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 20,
                                                                                        width: 20,
                                                                                        child: Image.asset(
                                                                                          ImageConstant.delete,
                                                                                          color: Colors.red,
                                                                                        ),
                                                                                      ))
                                                                                  : int.parse(ara.split(" ")[0]) <= 10
                                                                                      ? GestureDetector(
                                                                                          onTap: () {
                                                                                            OneTimeDelete = false;
                                                                                            print(AllChatmodelData?.object?.messageOutputList?.content?[index].uid);
                                                                                            print(UserLogin_ID);

                                                                                            DMChatInboxUid = "${widget.ChatInboxUid}";

                                                                                            // "${widget.Room_ID}";
                                                                                            DMstompClient.subscribe(
                                                                                              destination:
                                                                                                  // "ws://72c1-2405-201-200b-a0cf-210f-e5fe-f229-e899.ngrok.io",
                                                                                                  // "/topic/getDeletedMessage/${widget.Room_ID}",
                                                                                                   "/user/api/send_message_in_user_chat/${widget.ChatInboxUid}",
                                                                                              callback: (StompFrame frame) {
                                                                                                Map<String, dynamic> jsonString = json.decode(frame.body ?? "");

                                                                                                Content content1 = Content.fromJson(jsonString['object']);
                                                                                                print("CCCCCCCC ->>>>>> ${content1}");
                                                                                                var msgUUID = content1.uid;
                                                                                                if (content1.isDeleted == true) {
                                                                                                  if (OneTimeDelete == false) {
                                                                                                    OneTimeDelete = true;
                                                                                                    setState(() {
                                                                                                      AllChatmodelData?.object?.messageOutputList?.content = AllChatmodelData?.object?.messageOutputList?.content?.reversed.toList();
                                                                                                      ReverseBool = false;
                                                                                                      // BlocProvider.of<senMSGCubit>(context).coomentPage(widget.Room_ID, context, "${0}", ShowLoader: true);
                                                                                                    });
                                                                                                  }
                                                                                                }
                                                                                              },
                                                                                            );

                                                                                            DMstompClient.send(
                                                                                              destination:  "/user/api/send_message_in_user_chat/${widget.ChatInboxUid}",
                                                                                              // "/deleteMessage/${widget.Room_ID}",
                                                                                              body: json.encode({
                                                                                                "uid": "${AllChatmodelData?.object?.messageOutputList?.content?[index].uid}",
                                                                                                "userCode": "${UserLogin_ID}",
                                                                                                "roomUid": ""
                                                                                                // "${widget.Room_ID}"
                                                                                              }),
                                                                                            );
                                                                                          },
                                                                                          child: Container(
                                                                                            height: 20,
                                                                                            width: 20,
                                                                                            child: Image.asset(
                                                                                              ImageConstant.delete,
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                          ))
                                                                                      : SizedBox(),
                                                                    ), */
                                                                        getInboxMessagesModel?.object?.content?[index].messageType !=
                                                                                'IMAGE'
                                                                            ? Padding(
                                                                                padding: EdgeInsets.only(left: 8.0, top: 5, bottom: 0, right: 3),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    // Spacer(),
                                                                                    SizedBox(
                                                                                      width: 70,
                                                                                    ),
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.only(top: 3),
                                                                                        child: Container(
                                                                                          margin: EdgeInsets.only(left: 10, right: 10),
                                                                                          decoration: BoxDecoration(color: ColorConstant.otheruserchat, borderRadius: BorderRadius.circular(13)),
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(left: 4, right: 4,top: 3),
                                                                                                /*  child: Text(
                                                                                              "${getInboxMessagesModel?.object?.content?[index].message ?? ""}", //ankurChek
                                                                                              // maxLines: 3,
                                                                                              textScaleFactor: 1.0,
                                                                                              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontFamily: "outfit", fontSize: 13),
                                                                                            ), */
                                                                                                child: LinkifyText(
                                                                                                  "${getInboxMessagesModel?.object?.content?[index].message ?? ""}",
                                                                                                  linkStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue, fontFamily: "outfit", fontSize: 13, decoration: TextDecoration.underline, decorationColor: Colors.blue),
                                                                                                  textStyle: TextStyle(
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.black,
                                                                                                    fontFamily: "outfit",
                                                                                                    fontSize: 13,
                                                                                                  ),
                                                                                                  linkTypes: [
                                                                                                    LinkType.url,

                                                                                                    // LinkType
                                                                                                    //     .email
                                                                                                  ],
                                                                                                  onTap: (link) {
                                                                                                    var SelectedTest = link.value.toString();
                                                                                                    var Link = SelectedTest.startsWith('https');
                                                                                                    var Link1 = SelectedTest.startsWith('http');
                                                                                                    var Link2 = SelectedTest.startsWith('www');
                                                                                                    var Link3 = SelectedTest.startsWith('WWW');
                                                                                                    var Link4 = SelectedTest.startsWith('HTTPS');
                                                                                                    var Link5 = SelectedTest.startsWith('HTTP');
                                                                                                    var Link6 = SelectedTest.startsWith('https://pdslink.page.link/');
                                                                                                    print(SelectedTest.toString());
                                                                                                    if (Link == true || Link1 == true || Link2 == true || Link3 == true || Link4 == true || Link5 == true || Link6 == true) {
                                                                                                      print("qqqqqqqqhttps://${link.value}");

                                                                                                      launchUrl(Uri.parse("${link.value.toString()}"));
                                                                                                    } else {
                                                                                                      launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                                    }
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                              // Padding(
                                                                                              //   padding: const EdgeInsets.only(left: 4, right: 4),
                                                                                              //   child: Text(
                                                                                              //     getTimeDifference(parsedDateTime),
                                                                                              //     textScaleFactor: 1.0,
                                                                                              //     style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontFamily: "outfit", fontSize: 10),
                                                                                              //   ),
                                                                                              // ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(left: 3, right: 5, bottom: 2),
                                                                                                child: Text(
                                                                                                  customFormat(parsedDateTime),
                                                                                                  textScaleFactor: 1.0,
                                                                                                  style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontFamily: "outfit", fontSize: 10),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 3, right: 0),
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          print("check And data Get-${getInboxMessagesModel?.object?.content?[index].userUid}");

                                                                                          Navigator.push(context, MaterialPageRoute(
                                                                                            builder: (context) {
                                                                                              return ProfileScreen(User_ID: UserLogin_ID.toString(), isFollowing: "");
                                                                                            },
                                                                                          ));
                                                                                        },
                                                                                        child: getInboxMessagesModel?.object?.content?[index].userProfilePic != null && getInboxMessagesModel?.object?.content?[index].userProfilePic != ""
                                                                                            ? CustomImageView(
                                                                                                url: "${getInboxMessagesModel?.object?.content?[index].userProfilePic}",
                                                                                                height: 20,
                                                                                                radius: BorderRadius.circular(20),
                                                                                                width: 20,
                                                                                                fit: BoxFit.fill,
                                                                                              )
                                                                                            : CustomImageView(
                                                                                                imagePath: ImageConstant.tomcruse,
                                                                                                height: 20,
                                                                                              ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ))
                                                                            : Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(top: 10),
                                                                                    child: Container(
                                                                                      // color: Colors.green,
                                                                                      height: getInboxMessagesModel?.object?.content?[index].reactionMessage != null ? 130 : 100,
                                                                                      width: getInboxMessagesModel?.object?.content?[index].reactionMessage != null ? 70 : 150,
                                                                                      child: getInboxMessagesModel?.object?.content?[index].reactionMessage != null
                                                                                          ? GestureDetector(
                                                                                              onTapDown: (detalis) {
                                                                                                print('emojiReaction-${getInboxMessagesModel?.object?.content?[index].reactionMessage}');
                                                                                                print('emojiReaction-${getInboxMessagesModel?.object?.content?[index].emojiReaction}');

                                                                                                stroyUid = getInboxMessagesModel?.object?.content?[index].storyUid;
                                                                                                BlocProvider.of<DmInboxCubit>(context).get_all_story(context);
                                                                                                dataGet = detalis;
                                                                                              },
                                                                                              child: getInboxMessagesModel?.object?.content?[index].emojiReaction == true
                                                                                                  ? Stack(
                                                                                                      children: [
                                                                                                        CustomImageView(
                                                                                                          url: getInboxMessagesModel?.object?.content?[index].message,
                                                                                                          radius: BorderRadius.circular(20),
                                                                                                          // height: 20,
                                                                                                        ),
                                                                                                        Positioned.fill(
                                                                                                            child: Align(
                                                                                                          alignment: Alignment.bottomLeft,
                                                                                                          child: Container(
                                                                                                            // height: 110,
                                                                                                            // width: 50,
                                                                                                            margin: EdgeInsets.only(bottom: 2, right: 2),
                                                                                                            child: Text(
                                                                                                              '${getInboxMessagesModel?.object?.content?[index].reactionMessage}',
                                                                                                              style: TextStyle(fontSize: 20),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ))
                                                                                                      ],
                                                                                                    )
                                                                                                  : CustomImageView(
                                                                                                      url: getInboxMessagesModel?.object?.content?[index].message,
                                                                                                      radius: BorderRadius.circular(20),
                                                                                                      // height: 20,
                                                                                                    ),
                                                                                            )
                                                                                          : AnimatedNetworkImage(imageUrl: "${getInboxMessagesModel?.object?.content?[index].message}"),
                                                                                    ),
                                                                                  ),
                                                                                  getInboxMessagesModel?.object?.content?[index].userProfilePic != null && getInboxMessagesModel?.object?.content?[index].userProfilePic != ""
                                                                                      ? Padding(
                                                                                          padding: EdgeInsets.only(top: 10, left: 3),
                                                                                          child: CustomImageView(
                                                                                            url: "${getInboxMessagesModel?.object?.content?[index].userProfilePic}",
                                                                                            height: 20,
                                                                                            radius: BorderRadius.circular(20),
                                                                                            width: 20,
                                                                                            fit: BoxFit.fill,
                                                                                          ),
                                                                                        )
                                                                                      : Padding(
                                                                                          padding: EdgeInsets.only(top: 10, left: 3),
                                                                                          child: CustomImageView(
                                                                                            imagePath: ImageConstant.tomcruse,
                                                                                            height: 20,
                                                                                          ),
                                                                                        ),
                                                                                ],
                                                                              ),
                                                                        if (getInboxMessagesModel?.object?.content?[index].reactionMessage !=
                                                                                null &&
                                                                            getInboxMessagesModel?.object?.content?[index].emojiReaction !=
                                                                                true)
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Align(
                                                                                    alignment: Alignment.topRight,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(top: getInboxMessagesModel?.object?.content?[index].messageType == 'TEXT' ? 10 : 0, right: 20),
                                                                                      child: Container(
                                                                                          padding: EdgeInsets.all(10),
                                                                                          decoration: BoxDecoration(color: ColorConstant.primary_color, borderRadius: BorderRadius.circular(10)),
                                                                                          child: Text(
                                                                                            getInboxMessagesModel?.object?.content?[index].reactionMessage ?? '',
                                                                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                          )),
                                                                                    )),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        /*  Divider(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          117,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                    ), */
                                                                      ],
                                                                    ),
                                                                  )
                                                          ],
                                                        );

                                                        // }
                                                      })),
                                            ],
                                          ),
                                        )),
                            ),
                          ),
                          /*   _image != null
                              ? Container(
                                  height: 90,
                                  /* color:
                                      const Color.fromARGB(255, 255, 241, 240), */
                                  width: _width,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 150,
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              _image!,
                                              height: 100,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _image = null;
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5, top: 5),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                      height: 22,
                                                      width: 20,
                                                      child: Image.asset(
                                                        ImageConstant.delete,
                                                        color: Colors.red,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(), */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _image != null
                                  ? Container(
                                      height: 90,
                                      /* color:
                                      const Color.fromARGB(255, 255, 241, 240), */
                                      // width: _width,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 90,
                                            width: 150,
                                            child: Stack(
                                              children: [
                                                Image.file(
                                                  _image!,
                                                  height: 100,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _image = null;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5, top: 5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                          height: 22,
                                                          width: 20,
                                                          child: Image.asset(
                                                            ImageConstant
                                                                .delete,
                                                            color: Colors.red,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 50,
                                      // width: _width - 90,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: _width / 1.32,
                                          // color: Colors.amber,
                                          child: Row(
                                            children: [
                                              Container(
                                                  // color: Colors.amber,
                                                  /* child: IconButton(
                                            icon: Icon(
                                              isEmojiVisible
                                                  ? Icons.keyboard_rounded
                                                  : Icons
                                                      .emoji_emotions_outlined,
                                            ),
                                            onPressed: onClickedEmoji,
                                          ), */
                                                  ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: _width / 1.8,
                                                // color: Colors.red,
                                                child: TextField(
                                                  controller: Add_Comment,
                                                  cursorColor: Colors.grey,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Type Message",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              // Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  // pickProfileImage();
                                                  prepareTestPdf(0);
                                                },
                                                child: Image.asset(
                                                  "assets/images/paperclip-2.png",
                                                  height: 23,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 13,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  camerapicker();
                                                },
                                                child: Image.asset(
                                                  "assets/images/Vector (12).png",
                                                  height: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    
                              GestureDetector(
                                onTap: () async {
                                  if (_image != null) {
                                    if (SubmitOneTime == false) {
                                      await checkGuestUser();
                                    }
                                  } else {
                                    if (Add_Comment.text.isNotEmpty) {
                                      if (Add_Comment.text.length >= 1000) {
                                        SnackBar snackBar = SnackBar(
                                          content: Text(
                                              'One Time Message Length only for 1000'),
                                          backgroundColor:
                                              ColorConstant.primary_color,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        if (widget.ChatInboxUid == "") {
                                          print("New chat ");
                                        } else {
                                          checkGuestUser();
                                          print(
                                              "this Data Get-${widget.ChatInboxUid}");
                                          DMChatInboxUid =
                                              "${widget.ChatInboxUid}";

                                          // "${widget.Room_ID}";
                                          DMstompClient.subscribe(
                                              destination:
                                                  "/topic/getInboxMessage/${widget.ChatInboxUid}",
                                              // "/topic/getMessage/${widget.Room_ID}",
                                              callback: (StompFrame frame) {
                                                Map<String, dynamic>
                                                    jsonString = json.decode(
                                                        frame.body ?? "");

                                                var msgUUID =
                                                    jsonString['object']['uid'];
                                                if (AddNewData == false) {
                                                  print(getInboxMessagesModel
                                                      ?.object
                                                      ?.content
                                                      ?.length);
                                                  if (getInboxMessagesModel
                                                          ?.object?.content ==
                                                      null) {
                                                    // BlocProvider.of<senMSGCubit>(
                                                    //         context)
                                                    //     .coomentPage(widget.Room_ID,
                                                    //         context, "${0}",
                                                    //         ShowLoader: true);
                                                  } else {
                                                    if (addmsg != msgUUID) {
                                                      mapDataAdd?.clear();
                                                      print(
                                                          "jsonStringDaatGet-${jsonString}");

                                                      mapDataAdd = {
                                                        "userUid":
                                                            jsonString['object']
                                                                ['uid'],
                                                        "userChatMessageUid":
                                                            jsonString['object']
                                                                [
                                                                'userChatInboxUid'],
                                                        "userName":
                                                            jsonString['object']
                                                                ['userName'],
                                                        "userProfilePic":
                                                            jsonString['object']
                                                                [
                                                                'userProfilePic'],
                                                        "message":
                                                            jsonString['object']
                                                                ['message'],
                                                        "createdDate":
                                                            jsonString['object']
                                                                ['createdAt'],
                                                        "messageType":
                                                            jsonString['object']
                                                                ['messageType'],
                                                        "isDeleted":
                                                            jsonString['object']
                                                                ['isDeleted']
                                                      };

                                                      Content content =
                                                          Content.fromJson(
                                                              mapDataAdd!);
                                                      print(
                                                          "Content${content.createdDate}");
                                                      getInboxMessagesModel
                                                          ?.object?.content
                                                          ?.add(content);
                                                      _goToElement();
                                                      /*  _goToElement(AllChatmodelData
                                                            ?.object
                                                            ?.messageOutputList
                                                            ?.content
                                                            ?.length ??
                                                        0); */

                                                      setState(() {
                                                        addDataSccesfully =
                                                            true;
                                                        addmsg =
                                                            content.userUid ??
                                                                "";
                                                      });
                                                    }
                                                  }
                                                }
                                              });

                                          DMstompClient.send(
                                            destination:
                                                "/send_message_in_user_chat/${widget.ChatInboxUid}",
                                            // "/sendMessage/${widget.Room_ID}",
                                            body: json.encode({
                                              "message": "${Add_Comment.text}",
                                              "messageType": "TEXT",
                                              "userChatInboxUid":
                                                  "${widget.ChatInboxUid}",
                                              //  "${widget.Room_ID}",
                                              "userCode": "${UserCode}"
                                            }),
                                          );
                                        }
                                      }
                                    } else {
                                      SnackBar snackBar = SnackBar(
                                        content: Text('Please Enter Comment'),
                                        backgroundColor:
                                            ColorConstant.primary_color,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  // width: 50,
                                  decoration: BoxDecoration(
                                      color: ColorConstant.primary_color,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Image.asset(
                                    "assets/images/Vector (13).png",
                                    color: Colors.white,
                                  ),

                                  // width: width - 95,
                                ),
                              ),
                            ],
                          ),
                          // Offstage(
                          //   child:
                          //       EmojiPicker(/* onEmojiSelected: onEmojiSelected */),
                          //   offstage: !isEmojiVisible,
                          // ),
                          Offstage(
                            offstage: !isEmojiVisible,
                            child: SizedBox(
                                height: 250,
                                child: EmojiPicker(
                                  textEditingController: Add_Comment,
                                  onBackspacePressed: _onBackspacePressed,
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
                                    tabIndicatorAnimDuration:
                                        kTabScrollDuration,
                                    categoryIcons: const CategoryIcons(),
                                    buttonMode: ButtonMode.MATERIAL,
                                    checkPlatformCompatibility: true,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ]),
                      ],
                    ),
                  ));
              // }
              // return Center(
              //   child: Container(
              //     margin: EdgeInsets.only(bottom: 100),
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(20),
              //       child: Image.asset(ImageConstant.loader,
              //           fit: BoxFit.cover, height: 100.0, width: 100),
              //     ),
              //   ),
              // );
            })));
  }

  saveNotificationCount(int NotificationCount, int MessageCount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.NotificationCount, NotificationCount);
    prefs.setInt(PreferencesKey.MessageCount, MessageCount);
  }

  bool _isGifOrSvg(String imagePath) {
    // Check if the image file has a .gif or .svg extension
    final lowerCaseImagePath = imagePath.toLowerCase();
    return lowerCaseImagePath.endsWith('.gif') ||
        lowerCaseImagePath.endsWith('.svg') ||
        lowerCaseImagePath.endsWith('.pdf') ||
        lowerCaseImagePath.endsWith('.doc') ||
        lowerCaseImagePath.endsWith('.mp4') ||
        lowerCaseImagePath.endsWith('.mov') ||
        lowerCaseImagePath.endsWith('.mp3') ||
        lowerCaseImagePath.endsWith('.m4a');
  }

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    toggleEmojiKeyboard();
  }

  Future<void> pickProfileImage() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      if (!_isGifOrSvg(pickedImageFile!.path)) {
        setState(() {
          _image = File(pickedImageFile!.path);
        });
        final sizeInBytes = await _image!.length();
        final sizeInMB = sizeInBytes / (1024 * 1024);
        // print('documentuploadsize-$documentuploadsize');

        if (sizeInMB > documentuploadsize) {
          setState(() {
            _image = null;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Image Size Exceeded"),
                  content: Text(
                      "Selected image size exceeds $documentuploadsize MB."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              });
        }
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Selected File Error",
              textScaleFactor: 1.0,
            ),
            content: Text(
              "Only PNG, JPG Supported.",
              textScaleFactor: 1.0,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(10),
                  child: const Text("Okay"),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  _onBackspacePressed() {
    Add_Comment
      ..text = Add_Comment.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: Add_Comment.text.length));
  }

  Future<void> camerapicker() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedImageFile != null) {
      _image = File(pickedImageFile!.path);
      setState(() {});
      final int fileSizeInBytes = await _image!.length();
      if (fileSizeInBytes <= finalFileSize * 1024 * 1024) {
        BlocProvider.of<DmInboxCubit>(context)
            .UplodeImageAPI(context, File(_image!.path));
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Max Size ${finalFileSize}MB"),
            content: Text(
                "This file size ${value2} ${fileSizeInBytes} Selected Max size ${finalFileSize}MB"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(10),
                  child: const Text("Okay"),
                ),
              ),
            ],
          ),
        );
      }
    }

    /*    if (pickedImageFile != null) {
      if (!_isGifOrSvg(pickedImageFile!.path)) {
        setState(() {
          _image = File(pickedImageFile!.path);
        });
          
        final sizeInBytes = await _image!.length();
        final sizeInMB = sizeInBytes / (1024 * 1024);

        if (sizeInMB > documentuploadsize) {
          // print('documentuploadsize-$documentuploadsize');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Image Size Exceeded"),
                  content: Text(
                      "Selected image size exceeds $documentuploadsize MB."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              });
        }
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Selected File Error",
              textScaleFactor: 1.0,
            ),
            content: Text(
              "Only PNG, JPG Supported.",
              textScaleFactor: 1.0,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(10),
                  child: const Text("Okay"),
                ),
              ),
            ],
          ),
        );
      }
    } */
  }

  prepareTestPdf(
    int Index,
  ) async {
    PlatformFile file;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'doc', 'jpg'],
    );
    {
      if (result != null) {
        file = result.files.first;

        if ((file.path?.contains(".mp4") ?? false) ||
            (file.path?.contains(".mov") ?? false) ||
            (file.path?.contains(".mp3") ?? false) ||
            (file.path?.contains(".m4a") ?? false)) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Selected File Error",
                textScaleFactor: 1.0,
              ),
              content: Text(
                "Only PDF, PNG, JPG Supported.",
                textScaleFactor: 1.0,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          getFileSize(file.path!, 1, result.files.first, Index);
        }
      } else {}
    }
    return "";
    // "${fileparth}";
  }

  getFileSize(
      String filepath, int decimals, PlatformFile file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);

    print("value2-->$value2");
    switch (i) {
      case 0:
        print("Done file size B");
        switch (Index) {
          case 1:
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              setState(() {
                file12 = file1;
                _image = File(file1.path.toString());
              });
            }

            break;
          default:
        }
        print('xfjsdjfjfilenamecheckKB-${file1.path}');

        break;
      case 1:
        print("Done file size KB");
        switch (Index) {
          case 0:
            print("file1.name-->${file1.name}");
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              setState(() {
                file12 = file1;
                _image = File(file1.path.toString());
              });
            }

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        print("file111.name-->${file1.name}");
        BlocProvider.of<DmInboxCubit>(context)
            .UplodeImageAPI(context, File(_image!.path));

        setState(() {});

        break;
      case 2:
        print("value2check-->$value2");
        print("finalFileSize-->${finalFileSize}");

        if (value2 > finalFileSize) {
          print(
              "this file size ${value2} Selected Max size ${finalFileSize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${finalFileSize}MB"),
              content: Text(
                  "This file size ${value2} Selected Max size ${finalFileSize}MB"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          print("Done file Size 12MB");
          print("file1.namedata-->${file1.name}");
          switch (Index) {
            case 1:
              break;
            default:
          }
          print('filecheckPath1111-${file1.name}');
          print("file222.name-->${file1.name}");
          setState(() {
            file12 = file1;
            _image = File(file1.path.toString());
          });
          BlocProvider.of<DmInboxCubit>(context)
              .UplodeImageAPI(context, File(_image!.path));
          /*   BlocProvider.of<PersonalChatListCubit>(context)
              .UplodeImageAPI(context, File(_image!.path)); */
        }

        break;
      default:
    }

    return STR;
  }
}

String customFormat(DateTime date) {
  /* String day = date.day.toString();
  String month = _getMonthName(date.month);
  String year = date.year.toString(); */
  String time = (DateFormat('HH:mm').format(date));
  /* String DayCount = ""; */

  // final difference = DateTime.now().difference(date);
  // if (difference.inDays > 0) {
  //   if (difference.inDays == 1) {
  //     DayCount = '1 day ago';
  //   } else if (difference.inDays < 7) {
  //     DayCount = '${difference.inDays} days ago';
  //   } else {
  //     final weeks = (difference.inDays / 7).floor();
  //     DayCount = '$weeks week${weeks == 1 ? '' : 's'} ago';
  //   }
  // } else if (difference.inHours > 0) {
  //   if (difference.inHours == 1) {
  //     DayCount = '1 hour ago';
  //   } else {
  //     DayCount = '${difference.inHours} hours ago';
  //   }
  // } else if (difference.inMinutes > 0) {
  //   if (difference.inMinutes == 1) {
  //     DayCount = '1 minute ago';
  //   } else {
  //     DayCount = '${difference.inMinutes} minutes ago';
  //   }
  // } else {
  //   DayCount = 'Just now';
  // }

  String formattedDate = '$time';
  return formattedDate;
}

/* String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'Aug';
    case 9:
      return 'Sept';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
} */

class VideoThumbnailPage extends StatefulWidget {
  String videoUrl;
  VideoThumbnailPage({required this.videoUrl});
  @override
  _VideoThumbnailPageState createState() => _VideoThumbnailPageState();
}

class _VideoThumbnailPageState extends State<VideoThumbnailPage> {
  Uint8List? thumbnailData;

  @override
  void initState() {
    print("dfgdgfdg-${widget.videoUrl}");
    super.initState();
    fetchThumbnail();
  }

  Future<void> fetchThumbnail() async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 100,
      quality: 25,
    );
    setState(() {
      thumbnailData = uint8list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: thumbnailData == null
            ? CircularProgressIndicator()
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 110,
                child: Image.memory(
                  thumbnailData!,
                  fit: BoxFit.cover,
                )));
  }
}
