import 'dart:convert';
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/ApiService/DMSocket.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Model/inboxScreenModel/inboxScrrenModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/notifaction2.dart';
import 'package:pds/presentation/view_comments/view_comments_screen.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/animatedwiget.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'package:flutter/foundation.dart' as foundation;
import '../../API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import '../register_create_account_screen/register_create_account_screen.dart';

class DmScreen extends StatefulWidget {
  String UserName;
  String ChatInboxUid;
  DmScreen({required this.ChatInboxUid, required this.UserName});

  @override
  State<DmScreen> createState() => _DmScreenState();
}

class _DmScreenState extends State<DmScreen> {
  bool emojiShowing = false;
  String addmsg = "";
  var Token = "";
  var UserCode = "";
  var User_Name = "";
  String? userId;
  DateTime? parsedDateTime;
  String? UserLogin_ID;
  ImagePicker picker = ImagePicker();
  XFile? pickedImageFile;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
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
  GetInboxMessagesModel? getInboxMessagesModel;
  final focusNode = FocusNode();
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  TextEditingController Add_Comment = TextEditingController();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);

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
    //  DMstompClient.deactivate();
    // Delet_DMstompClient.deactivate();
    super.dispose();
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
        // BlocProvider.of<DmInboxCubit>(context).chatImageMethod(
        //    ss, context, userId.toString(), _image!);
        SubmitOneTime = true;
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
        .DMChatListApiMethod(widget.ChatInboxUid, 1, 20, context);
  }

  getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);
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

    DMstompClient.subscribe(
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
    );
  }

  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? a = prefs.getInt(PreferencesKey.mediaSize);
    documentuploadsize = double.parse("${a}");
    setState(() {});
  }

  @override
  void initState() {
    pageNumberMethod();
    // print('Room UID :-----> ${widget.Room_ID}');
    getUserID();
    getToken();
    getDocumentSize();

    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      this.isKeyboardVisible = isKeyboardVisible;

      if (isKeyboardVisible && isEmojiVisible) {
        isEmojiVisible = false;
      }
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
            // resizeToAvoidBottomInset: true,
            backgroundColor: theme.colorScheme.onPrimary,
            appBar: AppBar(
              backgroundColor: theme.colorScheme.onPrimary,
              centerTitle: true,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
              title: Text(
                "DM",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 20),
              ),
            ),
            body: BlocConsumer<DmInboxCubit, getInboxState>(
                listener: (context, state) async {
              if (state is getInboxLoadedState) {
                getInboxMessagesModel = state.getInboxMessagesModel;
              }
            }, builder: (context, state) {
              return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color.fromARGB(101, 158, 158, 158))),
                    child: Stack(
                      children: [
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.5, right: 5),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      maxRadius: 4,
                                    ),
                                  ),
                                  Container(
                                    width: _width / 1.2,
                                    child: Text(
                                      "${widget.UserName}  ",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Divider(
                            color: Color.fromARGB(53, 117, 117, 117),
                          ),
                          Padding(
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
                          ),
                          Divider(
                            height: 5,
                            color: Color.fromARGB(53, 117, 117, 117),
                          ),
                          Expanded(
                            child: Container(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: getInboxMessagesModel == null
                                      ? SizedBox()
                                      : SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            children: [
                                              PaginationWidget(
                                                  onPagination: (p0) async {
                                                    // await BlocProvider.of<
                                                    //             senMSGCubit>(
                                                    //         context)
                                                    //     .coomentPagePagenation(
                                                    //         widget.Room_ID,
                                                    //         context,
                                                    //         p0.toString(),
                                                    //         ShowLoader: true);
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
                                                      controller:
                                                          scrollController1,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
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
                                                        return getInboxMessagesModel
                                                                    ?.object
                                                                    ?.content?[
                                                                        index]
                                                                    .userName !=
                                                                User_Name
                                                            ? Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    /* horizontal: 35, vertical: 5 */),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {},
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
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
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: getInboxMessagesModel?.object?.content?[index].messageType !=
                                                                                'IMAGE'
                                                                            ? Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(left: 8.0, top: 5, bottom: 10),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          // height: 45,
                                                                                          width: _width / 1.3,
                                                                                          // color: Colors.amber,
                                                                                          child: Text(
                                                                                            getInboxMessagesModel?.object?.content?[index].message ?? "",
                                                                                            // maxLines: 3,
                                                                                            textScaleFactor: 1.0,
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: "outfit", fontSize: 12),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : Padding(
                                                                                padding: EdgeInsets.only(right: 16),
                                                                                child: Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Container(
                                                                                    child: AnimatedNetworkImage(imageUrl: "${getInboxMessagesModel?.object?.content?[index].message}"),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                      ),
                                                                      Divider(
                                                                        color: const Color.fromARGB(
                                                                            117,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 16),
                                                                          child:
                                                                              Text(
                                                                            customFormat(parsedDateTime),
                                                                            textScaleFactor:
                                                                                1.0,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.grey,
                                                                                fontFamily: "outfit",
                                                                                fontSize: 12),
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          "${getInboxMessagesModel?.object?.content?[index].userName}",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.black,
                                                                              fontFamily: "outfit",
                                                                              fontSize: 14),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 3,
                                                                              right: 10),
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
                                                                      ],
                                                                    ),
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
                                                                            padding: EdgeInsets.only(
                                                                                left: 8.0,
                                                                                top: 5,
                                                                                bottom: 10,
                                                                                right: 12),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Spacer(),
                                                                                Container(
                                                                                  width: _width / 1.3,
                                                                                  child: Align(
                                                                                    alignment: Alignment.topRight,
                                                                                    child: Text(
                                                                                      "${getInboxMessagesModel?.object?.content?[index].message ?? ""}",
                                                                                      // maxLines: 3,
                                                                                      textScaleFactor: 1.0,
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: "outfit", fontSize: 12),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ))
                                                                        : Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 16),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: Container(
                                                                                child: AnimatedNetworkImage(imageUrl: "${getInboxMessagesModel?.object?.content?[index].message}"),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                    Divider(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          117,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                        // }
                                                      })),
                                            ],
                                          ),
                                        )),
                            ),
                          ),
                          _image != null
                              ? Container(
                                  height: 90,
                                  color:
                                      const Color.fromARGB(255, 255, 241, 240),
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
                              : SizedBox(),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                // width: _width - 90,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(20)),
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
                                          child: IconButton(
                                            icon: Icon(
                                              isEmojiVisible
                                                  ? Icons.keyboard_rounded
                                                  : Icons
                                                      .emoji_emotions_outlined,
                                            ),
                                            onPressed: onClickedEmoji,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: _width / 2.35,
                                          // color: Colors.red,
                                          child: TextField(
                                            controller: Add_Comment,
                                            cursorColor: Colors.grey,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Add Comment",
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            pickProfileImage();
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
                                      if (Add_Comment.text.length >= 255) {
                                        SnackBar snackBar = SnackBar(
                                          content: Text(
                                              'One Time Message Lenght only for 255 Your Meassge -> ${Add_Comment.text.length}'),
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
                                          print("this Data Get-");
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

                                                      print(
                                                          "Alljasonsdssdsdss-$mapDataAdd");
                                                      print(
                                                          "jsonString data-${jsonString['createdAt']}");
                                                      Content content =
                                                          Content.fromJson(
                                                              mapDataAdd!);
                                                      print(
                                                          "Content${content.createdDate}");
                                                      getInboxMessagesModel
                                                          ?.object?.content
                                                          ?.add(content);

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
                                      color: Color(0xFFED1C25),
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
    }
  }
}
