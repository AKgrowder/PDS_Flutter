import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import 'package:pds/API/Model/coment/coment_model.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../API/ApiService/socket.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_state.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/animatedwiget.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/pagenation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ViewCommentScreen extends StatefulWidget {
  final Room_ID;
  final Title;
  String? Screen_name;
  String? createdDate;
  ViewCommentScreen({
    required this.Room_ID,
    required this.Title,
    this.Screen_name,
  });

  @override
  State<ViewCommentScreen> createState() => _ViewCommentScreenState();
}

List<String> commentslist = [
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
];
DateTime now = DateTime.now();

String formattedDate = DateFormat('dd-MM-yyyy').format(now);

class _ViewCommentScreenState extends State<ViewCommentScreen> {
  // Object? get index => null;
  bool emojiShowing = false;
  String addmsg = "";
  var Token = "";
  var UserCode = "";
  var User_Name = "";
  String? userId;
  bool isdataGet = true;
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
  bool isMounted = true;
  File? _image;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  bool ReverseBool = false;
  bool OneTimeDelete = false;
  FocusNode _focusNode = FocusNode();
  final focusNode = FocusNode();
  Timer? _timer;
  String title = "";
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  ComentApiModel? AllChatmodelData;
  TextEditingController Add_Comment = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? Pagenumber;
  pageNumberMethod() async {
    await BlocProvider.of<senMSGCubit>(context)
        .coomentPage(widget.Room_ID, context, "${0}", ShowLoader: true);
  }

  @override
  void initState() {
    pageNumberMethod();
    print('Room UID :-----> ${widget.Room_ID}');
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

  String customFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$day$month $year $time';
    return formattedDate;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  double documentuploadsize = 0;

  void _goToElement(int index) {
    scrollController.animateTo((1000.0 * index),
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? a = prefs.getInt(PreferencesKey.mediaSize);
    documentuploadsize = double.parse("${a}");
    if (isMounted == true) {
      if (mounted) {
        super.setState(() {});
      }
    }
  }

  //  @override
  void dispose() {
    //  stompClient.deactivate();
    // Delet_stompClient.deactivate();
    isMounted = false;
    super.dispose();
  }

  _onBackspacePressed() {
    Add_Comment
      ..text = Add_Comment.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: Add_Comment.text.length));
  }

  @override
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
              "View Comments",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "outfit",
                  fontSize: 20),
            ),
          ),
          body: BlocConsumer<senMSGCubit, senMSGState>(
              listener: (context, state) async {
            if (state is senMSGErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is senMSGLoadingState) {}
            if (state is senMSGLoadedState) {}

            if (state is ComentApiState) {
              AllChatmodelData = state.comentApiClass;
              if (ReverseBool == false) {
                AllChatmodelData?.object?.messageOutputList?.content =
                    AllChatmodelData
                        ?.object?.messageOutputList?.content?.reversed
                        .toList();
                ReverseBool = true;
              }
            }
            if (state is ComentApiIntragtionWithChatState) {
              SubmitOneTime = false;

              _image = null;
              if (addDataSccesfully == false) {
                Content content1 =
                    Content.fromJson(state.comentApiClass1['object']);
                AddNewData = true;
                AllChatmodelData?.object?.messageOutputList?.content
                    ?.add(content1);
                _goToElement(AllChatmodelData
                        ?.object?.messageOutputList?.content?.length ??
                    0);
              }
            }
          }, builder: (context, state) {
            // if (state is ComentApiState) {

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
                                  padding:
                                      const EdgeInsets.only(top: 5.5, right: 5),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    maxRadius: 4,
                                  ),
                                ),
                                Container(
                                  width: _width / 1.3,
                                  child: Text(
                                    "${widget.Title}  ",
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
                                "${AllChatmodelData?.object?.messageOutputList?.content?.length != null ? AllChatmodelData?.object?.messageOutputList?.content?.length : '0'} Comments",
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
                              child: AllChatmodelData != null
                                  ? AllChatmodelData?.object?.roomUid == null ||
                                          AllChatmodelData?.object?.roomUid ==
                                              ""
                                      ? SizedBox()
                                      : SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            children: [
                                              PaginationWidget(
                                                  onPagination: (p0) async {
                                                    await BlocProvider.of<
                                                                senMSGCubit>(
                                                            context)
                                                        .coomentPagePagenation(
                                                            widget.Room_ID,
                                                            context,
                                                            p0.toString(),
                                                            ShowLoader: true);
                                                  },
                                                  offSet: (AllChatmodelData
                                                      ?.object
                                                      ?.messageOutputList
                                                      ?.pageable
                                                      ?.pageNumber),
                                                  scrollController:
                                                      scrollController,
                                                  totalSize: AllChatmodelData
                                                      ?.object
                                                      ?.messageOutputList
                                                      ?.totalElements,
                                                  items: ListView.builder(
                                                      // reverse: true,
                                                      itemCount: (AllChatmodelData
                                                              ?.object
                                                              ?.messageOutputList
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
                                                                '${AllChatmodelData?.object?.messageOutputList?.content?[index].createdAt}');

                                                        var ara = getTime(
                                                            parsedDateTime);

                                                        if (isScroll == false) {
                                                          Future.delayed(
                                                              Duration(
                                                                  microseconds:
                                                                      1), () {
                                                            if (scrollController
                                                                .hasClients) {
                                                              for (int i = 0;
                                                                  i <
                                                                      (AllChatmodelData
                                                                              ?.object
                                                                              ?.messageOutputList
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
                                                            // super.setState(() {
                                                            isScroll = true;
                                                            // });
                                                          });
                                                        } else {}
                                                        return AllChatmodelData
                                                                    ?.object
                                                                    ?.messageOutputList
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
                                                                  onTap:
                                                                      () async {
                                                                    bool? isBlock = AllChatmodelData
                                                                            ?.object
                                                                            ?.blockedUsers
                                                                        ?.contains(AllChatmodelData?.object?.messageOutputList?.content?[index].userCode);

                                                                    print(
                                                                        "this i want to check-${isBlock}");
                                                                    if (isBlock ==
                                                                        true) {
                                                                      SnackBar
                                                                          snackBar =
                                                                          SnackBar(
                                                                        content:
                                                                            Text('User Blocked.'),
                                                                        backgroundColor:
                                                                            ColorConstant.primary_color,
                                                                      );
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              snackBar);
                                                                    } else {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (context) {
                                                                        return ProfileScreen(
                                                                            User_ID:
                                                                                "${AllChatmodelData?.object?.messageOutputList?.content?[index].userCode}",
                                                                            isFollowing:
                                                                                "");
                                                                      }));
                                                                    }

                                                                    /*  if (AllChatmodelData
                                                                            ?.object
                                                                            ?.blockedUsers
                                                                            ?.isNotEmpty ==
                                                                        true) {
                                                                      AllChatmodelData
                                                                          ?.object
                                                                          ?.blockedUsers
                                                                          ?.forEach(
                                                                              (element) {
                                                                        if (element ==
                                                                            AllChatmodelData?.object?.messageOutputList?.content?[index].userCode) {
                                                                          SnackBar
                                                                              snackBar =
                                                                              SnackBar(
                                                                            content:
                                                                                Text('User Blocked.'),
                                                                            backgroundColor:
                                                                                ColorConstant.primary_color,
                                                                          );
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(snackBar);
                                                                        } else {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder:
                                                                                  (context) {
                                                                            return ProfileScreen(
                                                                                User_ID: "${AllChatmodelData?.object?.messageOutputList?.content?[index].userCode}",
                                                                                isFollowing: "");
                                                                          })).then((value) => BlocProvider.of<senMSGCubit>(context).coomentPage(
                                                                              widget.Room_ID,
                                                                              context,
                                                                              "${0}",
                                                                              ShowLoader: false));
                                                                        }
                                                                      });
                                                                    } else {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (context) {
                                                                        return ProfileScreen(
                                                                            User_ID:
                                                                                "${AllChatmodelData?.object?.messageOutputList?.content?[index].userCode}",
                                                                            isFollowing:
                                                                                "");
                                                                      })).then(
                                                                          (value) {
                                                                        BlocProvider.of<senMSGCubit>(context).coomentPage(
                                                                            widget
                                                                                .Room_ID,
                                                                            context,
                                                                            "${0}",
                                                                            ShowLoader:
                                                                                true);
                                                                      });
                                                                    }

                                                                    /* Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(builder:
                                                                            (context) {
                                                                      return ProfileScreen(
                                                                          User_ID:
                                                                              "${AllChatmodelData?.object?.messageOutputList?.content?[index].userCode}",
                                                                          isFollowing:
                                                                              "");
                                                                    })); */ */
                                                                  },
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
                                                                            child: AllChatmodelData?.object?.messageOutputList?.content?[index].userName != null
                                                                                ? CustomImageView(
                                                                                    url: "${AllChatmodelData?.object?.messageOutputList?.content?[index].userProfilePic}",
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
                                                                            "${AllChatmodelData?.object?.messageOutputList?.content?[index].userName}",
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
                                                                        child: AllChatmodelData?.object?.messageOutputList?.content?[index].messageType !=
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
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,

                                                                                            children: [
                                                                                              /*Text(
                                                                                                AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "",
                                                                                                // maxLines: 3,
                                                                                                textScaleFactor: 1.0,
                                                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: "outfit", fontSize: 12),
                                                                                              ),*/
                                                                                              LinkifyText(
                                                                                                "${AllChatmodelData?.object?.messageOutputList?.content?[index].message}",
                                                                                                linkStyle: TextStyle(
                                                                                                  color: Colors.blue,
                                                                                                  fontFamily: 'outfit',
                                                                                                ),
                                                                                                textStyle: TextStyle(
                                                                                                  color: Colors.black,
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

                                                                                                  if (Link == true ||
                                                                                                      Link1 == true ||
                                                                                                      Link2 == true ||
                                                                                                      Link3 == true ||
                                                                                                      Link4 == true ||
                                                                                                      Link5 == true ||
                                                                                                      Link6 == true) {
                                                                                                    if (Link2 == true ||
                                                                                                        Link3 == true) {
                                                                                                      if (isYouTubeUrl(SelectedTest)) {
                                                                                                        playLink(SelectedTest, context);
                                                                                                      } else launchUrl(Uri.parse(
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
                                                                                                        if (isYouTubeUrl(SelectedTest)) {
                                                                                                          playLink(SelectedTest, context);
                                                                                                        } else launchUrl(Uri.parse(
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
                                                                                                          HashTagCubit>(
                                                                                                          context)
                                                                                                          .UserTagAPI(context,
                                                                                                          tagName);
                                                                                                    } else {
                                                                                                      if (isYouTubeUrl(SelectedTest)) {
                                                                                                        playLink(SelectedTest, context);
                                                                                                      } else launchUrl(Uri.parse(
                                                                                                          "https://${link.value.toString()}"));
                                                                                                    }
                                                                                                  }
                                                                                                },
                                                                                              ),
                                                                                              if (extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").isNotEmpty)
                                                                                                isYouTubeUrl(extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first)
                                                                                                    ? FutureBuilder(
                                                                                                    future: fetchYoutubeThumbnail(extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first),
                                                                                                    builder: (context, snap) {
                                                                                                      return Container(
                                                                                                        height: 100,
                                                                                                        decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(snap.data.toString())), borderRadius: BorderRadius.circular(10)),
                                                                                                        clipBehavior: Clip.antiAlias,
                                                                                                        child: Center(
                                                                                                            child: IconButton(
                                                                                                              icon: Icon(
                                                                                                                Icons.play_circle_fill_rounded,
                                                                                                                color: Colors.white,
                                                                                                                size: 60,
                                                                                                              ),
                                                                                                              onPressed: () {
                                                                                                                playLink(extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first, context);
                                                                                                              },
                                                                                                            )),
                                                                                                      );
                                                                                                    })
                                                                                                    : Padding(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                                                                  child: AnyLinkPreview(
                                                                                                    link: extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first,
                                                                                                    displayDirection: UIDirection.uiDirectionHorizontal,
                                                                                                    showMultimedia: true,
                                                                                                    bodyMaxLines: 5,
                                                                                                    bodyTextOverflow: TextOverflow.ellipsis,
                                                                                                    titleStyle: TextStyle(
                                                                                                      color: Colors.black,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontSize: 15,
                                                                                                    ),
                                                                                                    bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                                    errorBody: 'Show my custom error body',
                                                                                                    errorTitle: 'Show my custom error title',
                                                                                                    errorWidget: null,
                                                                                                    errorImage: "https://flutter.dev/",
                                                                                                    cache: Duration(days: 7),
                                                                                                    backgroundColor: Colors.grey[300],
                                                                                                    borderRadius: 12,
                                                                                                    removeElevation: false,
                                                                                                    boxShadow: [
                                                                                                      BoxShadow(blurRadius: 3, color: Colors.grey)
                                                                                                    ],
                                                                                                    onTap: () {
                                                                                                      launchUrl(Uri.parse(extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first));
                                                                                                    }, // This disables tap event
                                                                                                  ),
                                                                                                ),
                                                                                            ],
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
                                                                                    child: AnimatedNetworkImage(imageUrl: "${AllChatmodelData?.object?.messageOutputList?.content?[index].message}"),
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
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            print("send user id -- ${AllChatmodelData?.object?.messageOutputList?.content?[index].uid}");
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) {
                                                                              return ProfileScreen(User_ID: "${AllChatmodelData?.object?.messageOutputList?.content?[index].userCode}", isFollowing: "");
                                                                            }));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Text(
                                                                              "${AllChatmodelData?.object?.messageOutputList?.content?[index].userName}",
                                                                              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontFamily: "outfit", fontSize: 14),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 3, right: 10),
                                                                            child: GestureDetector(
                                                                              onTap: () {
                                                                                print("send user id -- ${AllChatmodelData?.object?.messageOutputList?.content?[index].uid}");
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                  return ProfileScreen(User_ID: "${AllChatmodelData?.object?.messageOutputList?.content?[index].userCode}", isFollowing: "");
                                                                                }));
                                                                              },
                                                                              child: AllChatmodelData?.object?.messageOutputList?.content?[index].userProfilePic != null && AllChatmodelData?.object?.messageOutputList?.content?[index].userProfilePic != ""
                                                                                  ? CustomImageView(
                                                                                      url: "${AllChatmodelData?.object?.messageOutputList?.content?[index].userProfilePic}",
                                                                                      height: 20,
                                                                                      radius: BorderRadius.circular(20),
                                                                                      width: 20,
                                                                                      fit: BoxFit.fill,
                                                                                    )
                                                                                  : CustomImageView(
                                                                                      imagePath: ImageConstant.tomcruse,
                                                                                      height: 20,
                                                                                    ),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Padding(
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
                                                                                Room_ID_stomp = "${widget.Room_ID}";
                                                                                stompClient.subscribe(
                                                                                  destination:
                                                                                      // "ws://72c1-2405-201-200b-a0cf-210f-e5fe-f229-e899.ngrok.io",
                                                                                      "/topic/getDeletedMessage/${widget.Room_ID}",
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
                                                                                        if (isMounted == true) {
                                                                                          if (mounted) {
                                                                                            super.setState(() {
                                                                                              AllChatmodelData?.object?.messageOutputList?.content = AllChatmodelData?.object?.messageOutputList?.content?.reversed.toList();
                                                                                              ReverseBool = false;
                                                                                              BlocProvider.of<senMSGCubit>(context).coomentPage(widget.Room_ID, context, "${0}", ShowLoader: true);
                                                                                            });
                                                                                          }
                                                                                        }
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                );

                                                                                stompClient.send(
                                                                                  destination: "/deleteMessage/${widget.Room_ID}",
                                                                                  body: json.encode({
                                                                                    "uid": "${AllChatmodelData?.object?.messageOutputList?.content?[index].uid}",
                                                                                    "userCode": "${UserLogin_ID}",
                                                                                    "roomUid": "${widget.Room_ID}"
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
                                                                                        Room_ID_stomp = "${widget.Room_ID}";
                                                                                        print("ara == a few seconds ago || ara == null");
                                                                                        stompClient.subscribe(
                                                                                          destination: "/topic/getDeletedMessage/${widget.Room_ID}",
                                                                                          callback: (StompFrame frame) {
                                                                                            print("check This DataGet-${frame.body}");
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
                                                                                                  if (isMounted == true) {
                                                                                                    if (mounted) {
                                                                                                      super.setState(() {
                                                                                                        AllChatmodelData?.object?.messageOutputList?.content = AllChatmodelData?.object?.messageOutputList?.content?.reversed.toList();
                                                                                                        ReverseBool = false;
                                                                                                        BlocProvider.of<senMSGCubit>(context).coomentPage(widget.Room_ID, context, "${0}", ShowLoader: true);
                                                                                                      });
                                                                                                    }
                                                                                                  }
                                                                                                }
                                                                                              }
                                                                                            }
                                                                                          },
                                                                                        );

                                                                                        stompClient.send(
                                                                                          destination: "/deleteMessage/${widget.Room_ID}",
                                                                                          body: json.encode({
                                                                                            "uid": "${AllChatmodelData?.object?.messageOutputList?.content?[index].uid}",
                                                                                            "userCode": "${UserLogin_ID}",
                                                                                            "roomUid": "${widget.Room_ID}"
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
                                                                                            print("wiget roomId Prinf-${widget.Room_ID}");
                                                                                            Room_ID_stomp = "${widget.Room_ID}";
                                                                                            print("int.parse(ara.split(" ")[0]) <= 10");
                                                                                            stompClient.subscribe(
                                                                                              destination:
                                                                                                  // "ws://72c1-2405-201-200b-a0cf-210f-e5fe-f229-e899.ngrok.io",
                                                                                                  "/topic/getDeletedMessage/${widget.Room_ID}",
                                                                                              callback: (StompFrame frame) {
                                                                                                print("fram check-${frame.body}");
                                                                                                Map<String, dynamic> jsonString = json.decode(frame.body ?? "");

                                                                                                Content content1 = Content.fromJson(jsonString['object']);
                                                                                                print("comtatne check--${content1.isDeleted}");

                                                                                                var msgUUID = content1.uid;
                                                                                                if (content1.isDeleted == true) {
                                                                                                  if (OneTimeDelete == false) {
                                                                                                    OneTimeDelete = true;
                                                                                                    if (isMounted == true) {
                                                                                                      if (mounted) {
                                                                                                        super.setState(() {
                                                                                                          AllChatmodelData?.object?.messageOutputList?.content = AllChatmodelData?.object?.messageOutputList?.content?.reversed.toList();
                                                                                                          ReverseBool = false;
                                                                                                          BlocProvider.of<senMSGCubit>(context).coomentPage(widget.Room_ID, context, "${0}", ShowLoader: true);
                                                                                                        });
                                                                                                      }
                                                                                                    }
                                                                                                  }
                                                                                                }
                                                                                              },
                                                                                            );

                                                                                            stompClient.send(
                                                                                              destination: "/deleteMessage/${widget.Room_ID}",
                                                                                              body: json.encode({
                                                                                                "uid": "${AllChatmodelData?.object?.messageOutputList?.content?[index].uid}",
                                                                                                "userCode": "${UserLogin_ID}",
                                                                                                "roomUid": "${widget.Room_ID}"
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
                                                                    ),
                                                                    AllChatmodelData?.object?.messageOutputList?.content?[index].messageType !=
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
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        /*Text(
                                                                                          "${AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? ""}",
                                                                                          // maxLines: 3,
                                                                                          textScaleFactor: 1.0,
                                                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: "outfit", fontSize: 12),
                                                                                        )*/
                                                                                        LinkifyText(
                                                                                          "${AllChatmodelData?.object?.messageOutputList?.content?[index].message}",
                                                                                          linkStyle: TextStyle(
                                                                                            color: Colors.blue,
                                                                                            fontFamily: 'outfit',
                                                                                          ),
                                                                                          textStyle: TextStyle(
                                                                                            color: Colors.black,
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

                                                                                            if (Link == true ||
                                                                                                Link1 == true ||
                                                                                                Link2 == true ||
                                                                                                Link3 == true ||
                                                                                                Link4 == true ||
                                                                                                Link5 == true ||
                                                                                                Link6 == true) {
                                                                                              if (Link2 == true ||
                                                                                                  Link3 == true) {
                                                                                                if (isYouTubeUrl(SelectedTest)) {
                                                                                                  playLink(SelectedTest, context);
                                                                                                } else launchUrl(Uri.parse(
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
                                                                                                  if (isYouTubeUrl(SelectedTest)) {
                                                                                                    playLink(SelectedTest, context);
                                                                                                  } else launchUrl(Uri.parse(
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
                                                                                                    HashTagCubit>(
                                                                                                    context)
                                                                                                    .UserTagAPI(context,
                                                                                                    tagName);

                                                                                              } else {
                                                                                                if (isYouTubeUrl(SelectedTest)) {
                                                                                                  playLink(SelectedTest, context);
                                                                                                } else launchUrl(Uri.parse(
                                                                                                    "https://${link.value.toString()}"));
                                                                                              }
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                        if (extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").isNotEmpty)
                                                                                          isYouTubeUrl(extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first)
                                                                                              ? FutureBuilder(
                                                                                              future: fetchYoutubeThumbnail(extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first),
                                                                                              builder: (context, snap) {
                                                                                                return Container(
                                                                                                  height: 200,
                                                                                                  decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(snap.data.toString())), borderRadius: BorderRadius.circular(10)),
                                                                                                  clipBehavior: Clip.antiAlias,
                                                                                                  child: Center(
                                                                                                      child: IconButton(
                                                                                                        icon: Icon(
                                                                                                          Icons.play_circle_fill_rounded,
                                                                                                          color: Colors.white,
                                                                                                          size: 60,
                                                                                                        ),
                                                                                                        onPressed: () {
                                                                                                          playLink(extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first, context);
                                                                                                        },
                                                                                                      )),
                                                                                                );
                                                                                              })
                                                                                              : Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                                                            child: AnyLinkPreview(
                                                                                              link: extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first,
                                                                                              displayDirection: UIDirection.uiDirectionHorizontal,
                                                                                              showMultimedia: true,
                                                                                              bodyMaxLines: 5,
                                                                                              bodyTextOverflow: TextOverflow.ellipsis,
                                                                                              titleStyle: TextStyle(
                                                                                                color: Colors.black,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontSize: 15,
                                                                                              ),
                                                                                              bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                              errorBody: 'Show my custom error body',
                                                                                              errorTitle: 'Show my custom error title',
                                                                                              errorWidget: null,
                                                                                              errorImage: "https://flutter.dev/",
                                                                                              cache: Duration(days: 7),
                                                                                              backgroundColor: Colors.grey[300],
                                                                                              borderRadius: 12,
                                                                                              removeElevation: false,
                                                                                              boxShadow: [
                                                                                                BoxShadow(blurRadius: 3, color: Colors.grey)
                                                                                              ],
                                                                                              onTap: () {
                                                                                                launchUrl(Uri.parse(extractUrls(AllChatmodelData?.object?.messageOutputList?.content?[index].message ?? "").first));
                                                                                              }, // This disables tap event
                                                                                            ),
                                                                                          ),
                                                                                      ],
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
                                                                                child: AnimatedNetworkImage(imageUrl: "${AllChatmodelData?.object?.messageOutputList?.content?[index].message}"),
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
                                        )
                                  : SizedBox(),
                            ),
                          ),
                        ),
                        _image != null
                            ? Container(
                                height: 90,
                                color: const Color.fromARGB(255, 255, 241, 240),
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
                                              if (mounted == true) {
                                                if (mounted) {
                                                  super.setState(() {
                                                    _image = null;
                                                  });
                                                }
                                              }
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
                        if(title.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
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
                              bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
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
                              boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                              onTap: (){                                    launchUrl(Uri.parse(title));
                              }, // This disables tap event
                            ),
                          ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  maxLines: null,
                                  controller: Add_Comment,
                                  cursorColor: Colors.grey,
                                  onChanged: (value){
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
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0x82EFEFEF),
                                      /* prefixIcon: IconButton(
                                        icon: Icon(
                                          isEmojiVisible
                                              ? Icons.keyboard_rounded
                                              : Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: onClickedEmoji,
                                      ), */
                                      hintText: "Add Comment",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color(
                                                0xffE6E6E6)), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color(
                                                0xffE6E6E6)), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
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
                                            width: 15,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    title = "";
                                  });
                                  if (_image != null) {
                                    if (SubmitOneTime == false) {
                                      await checkGuestUser();
                                    }
                                  } else {
                                    if (Add_Comment.text.isNotEmpty) {
                                      if (Add_Comment.text.length >= 255) {
                                        SnackBar snackBar = SnackBar(
                                          content: Text(
                                              'One time message length allowed is 300.'),
                                          backgroundColor:
                                              ColorConstant.primary_color,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        checkGuestUser();
                                        Room_ID_stomp = "${widget.Room_ID}";
                                        stompClient.subscribe(
                                            destination:
                                                "/topic/getMessage/${widget.Room_ID}",
                                            callback: (StompFrame frame) {
                                              Map<String, dynamic> jsonString =
                                                  json.decode(frame.body ?? "");

                                              Content content1 =
                                                  Content.fromJson(
                                                      jsonString['object']);

                                              var msgUUID = content1.uid;
                                              if (AddNewData == false) {
                                                print(
                                                    "Array length count 0000000000000000000");
                                                print(AllChatmodelData
                                                    ?.object
                                                    ?.messageOutputList
                                                    ?.content
                                                    ?.length);
                                                if (AllChatmodelData
                                                        ?.object
                                                        ?.messageOutputList
                                                        ?.content ==
                                                    null) {
                                                  BlocProvider.of<senMSGCubit>(
                                                          context)
                                                      .coomentPage(
                                                          widget.Room_ID,
                                                          context,
                                                          "${0}",
                                                          ShowLoader: true);
                                                } else {
                                                  if (addmsg != msgUUID) {
                                                    Content content =
                                                        Content.fromJson(
                                                            jsonString[
                                                                'object']);

                                                    AllChatmodelData
                                                        ?.object
                                                        ?.messageOutputList
                                                        ?.content
                                                        ?.add(content);
                                                    _goToElement(AllChatmodelData
                                                            ?.object
                                                            ?.messageOutputList
                                                            ?.content
                                                            ?.length ??
                                                        0);
                                                    if (isMounted == true) {
                                                      if (mounted) {
                                                        super.setState(() {
                                                          addDataSccesfully =
                                                              true;
                                                          addmsg =
                                                              content.uid ?? "";
                                                        });
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            });

                                        stompClient.send(
                                          destination:
                                              "/sendMessage/${widget.Room_ID}",
                                          body: json.encode({
                                            "message": "${Add_Comment.text}",
                                            "messageType": "TEXT",
                                            "roomUid": "${widget.Room_ID}",
                                            "userCode": "${UserCode}"
                                          }),
                                        );
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
                                  margin: EdgeInsets.only(right: 5),
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
                        ),
                        /* Row(
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
                                                : Icons.emoji_emotions_outlined,
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
                                      checkGuestUser();
                                      Room_ID_stomp = "${widget.Room_ID}";
                                      stompClient.subscribe(
                                          destination:
                                              "/topic/getMessage/${widget.Room_ID}",
                                          callback: (StompFrame frame) {
                                            Map<String, dynamic> jsonString =
                                                json.decode(frame.body ?? "");

                                            Content content1 = Content.fromJson(
                                                jsonString['object']);

                                            var msgUUID = content1.uid;
                                            if (AddNewData == false) {
                                              print(
                                                  "Array length count 0000000000000000000");
                                              print(AllChatmodelData
                                                  ?.object
                                                  ?.messageOutputList
                                                  ?.content
                                                  ?.length);
                                              if (AllChatmodelData
                                                      ?.object
                                                      ?.messageOutputList
                                                      ?.content ==
                                                  null) {
                                                BlocProvider.of<senMSGCubit>(
                                                        context)
                                                    .coomentPage(widget.Room_ID,
                                                        context, "${0}",
                                                        ShowLoader: true);
                                              } else {
                                                if (addmsg != msgUUID) {
                                                  Content content =
                                                      Content.fromJson(
                                                          jsonString['object']);

                                                  AllChatmodelData
                                                      ?.object
                                                      ?.messageOutputList
                                                      ?.content
                                                      ?.add(content);
                                                  _goToElement(AllChatmodelData
                                                          ?.object
                                                          ?.messageOutputList
                                                          ?.content
                                                          ?.length ??
                                                      0);

                                                  super.setState(() {
                                                    addDataSccesfully = true;
                                                    addmsg = content.uid ?? "";
                                                  });
                                                }
                                              }
                                            }
                                          });
                                      stompClient.send(
                                        destination:
                                            "/sendMessage/${widget.Room_ID}",
                                        body: json.encode({
                                          "message": "${Add_Comment.text}",
                                          "messageType": "TEXT",
                                          "roomUid": "${widget.Room_ID}",
                                          "userCode": "${UserCode}"
                                        }),
                                      );
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
                        ), */
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
                                  tabIndicatorAnimDuration: kTabScrollDuration,
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
          })),
    );
  }

  Widget buildSticker() {
    return EmojiPicker(
      key: _formKey,
      textEditingController: Add_Comment,
      config: Config(
        columns: 7,
        emojiSizeMax: 32 *
            (foundation.defaultTargetPlatform == TargetPlatform.iOS
                ? 1.30
                : 1.0),
      ),
      onEmojiSelected: (emoji, category) {
        // print(emoji);
      },
    );
  }

  getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);
  }

  checkGuestUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID != null) {
      // print("user login Mood");
      if (Add_Comment.text.isNotEmpty) {
        // super.setState(() {
        addmsg = "";
        Add_Comment.text = '';
        // });
      } else if (_image != null) {
        BlocProvider.of<senMSGCubit>(context).chatImageMethod(
            widget.Room_ID, context, userId.toString(), _image!);
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

  // Widget buildSticker() {
  //   return EmojiPicker(
  //     // rows: 3,
  //     // columns: 7,
  //     // buttonMode: ButtonMode.MATERIAL,
  //     // recommendKeywords: ["racing", "horse"],
  //     // numRecommended: 10,
  //     onEmojiSelected: (emoji, category) {
  //       print(emoji);
  //     },
  //   );
  // }

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

    List<String> urls = regExp.allMatches(text).map((match) => match.group(0)!).toList();
    List<String> finalUrls = [];
    RegExp urlRegex = RegExp(r"(http(s)?://)", caseSensitive: false);
    urls.forEach((element) {
      if(urlRegex.allMatches(element).toList().length > 1){
        String xyz = element.replaceAll("http", ",http");
        List<String> splitted = xyz.split(RegExp(r",|;"));
        splitted.forEach((element1) {
          if(element1.isNotEmpty)
            finalUrls.add(element1);
        });
      }else{
        finalUrls.add(element);
      }
    });
    return finalUrls;

  }

  bool isYouTubeUrl(String url) {
    // Regular expression pattern to match YouTube URLs
    RegExp youtubeVideoRegex = RegExp(r"^https?://(?:www\.)?youtube\.com/(?:watch\?v=)?([^#&?]+)");
    RegExp youtubeShortsRegex = RegExp(r"^https?://(?:www\.)?youtube\.com/shorts/([^#&?]+)");

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
                      FutureBuilder(future: getYoutubePlayer(videoUrl, () {
                        Navigator.pop(ctx);
                        launchUrl(Uri.parse(videoUrl));
                      }), builder: (context,snap){
                        if(snap.data != null)
                          return snap.data as Widget;
                        else return Center(
                          child: CircularProgressIndicator(color: Colors.white,),
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
    final url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$playlistId&key=AIzaSyAT_gzTjHn9XuvQsmGdY63br7lKhD2KRdo";
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
      print ("Failed to fetch playlist videos");
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


  Future<Widget> getYoutubePlayer(String videoUrl, Function() fullScreen) async{
    late YoutubePlayerController _controller;
    String videoId = "";
    if(videoUrl.toLowerCase().contains("playlist")){
      String playlistId = extractPlaylistId(videoUrl);
      var videoIds = await getPlaylistVideos(playlistId);
      videoId = videoIds.first;
    }else if(videoUrl.toLowerCase().contains("live")){
      videoId = extractLiveId(videoUrl);
    }else{
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

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(PreferencesKey.loginUserID) ?? "";
    Token = prefs.getString(PreferencesKey.loginJwt) ?? "";
    UserCode = prefs.getString(PreferencesKey.loginUserID) ?? "";
    User_Name = prefs.getString(PreferencesKey.ProfileUserName) ?? "";
    baseURL = prefs.getString(PreferencesKey.SocketLink) ?? "";
    stompClient.activate();
    // Delet_stompClient.activate();

    stompClient.subscribe(
      destination:
          // "ws://72c1-2405-201-200b-a0cf-210f-e5fe-f229-e899.ngrok.io",
          "/topic/getDeletedMessage/${widget.Room_ID}",
      callback: (StompFrame frame) {
        Map<String, dynamic> jsonString = json.decode(frame.body ?? "");

        Content content1 = Content.fromJson(jsonString['object']);
        print("CCCCCCCC ->>>>>> ${content1}");
        var msgUUID = content1.uid;
        if (content1.isDeleted == true) {
          if (isMounted == true) {
            if (mounted) {
              super.setState(() {
                AllChatmodelData?.object?.messageOutputList?.content =
                    AllChatmodelData
                        ?.object?.messageOutputList?.content?.reversed
                        .toList();
                ReverseBool = false;
                BlocProvider.of<senMSGCubit>(context).coomentPage(
                    widget.Room_ID, context, "${0}",
                    ShowLoader: true);
              });
            }
          }
        }
      },
    );
  }

  Future<void> camerapicker() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedImageFile != null) {
      if (!_isGifOrSvg(pickedImageFile!.path)) {
        if (isMounted == true) {
          if (mounted) {
            super.setState(() {
              _image = File(pickedImageFile!.path);
            });
          }
        }

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

  Future<void> pickProfileImage() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      if (!_isGifOrSvg(pickedImageFile!.path)) {
        if (isMounted == true) {
          if (mounted) {
            super.setState(() {
              _image = File(pickedImageFile!.path);
            });
          }
        }

        final sizeInBytes = await _image!.length();
        final sizeInMB = sizeInBytes / (1024 * 1024);
        // print('documentuploadsize-$documentuploadsize');

        if (sizeInMB > documentuploadsize) {
          super.setState(() {
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

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    toggleEmojiKeyboard();
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    super.setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  void onEmojiSelected(String emoji) => super.setState(() {
        Add_Comment.text = Add_Comment.text + emoji;
      });

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  getTime(time) {
    if (!DateTime.now().difference(time).isNegative) {
      if (DateTime.now().difference(time).inMinutes < 1) {
        return "a few seconds ago";
      } else if (DateTime.now().difference(time).inMinutes < 60) {
        return "${DateTime.now().difference(time).inMinutes} minutes ago";
      } else if (DateTime.now().difference(time).inMinutes < 1440) {
        return "${DateTime.now().difference(time).inHours} hours ago";
      } else if (DateTime.now().difference(time).inMinutes > 1440) {
        return "${DateTime.now().difference(time).inDays} days ago";
      }
    }
  }
}

bool compareLists(List<String> list1, List<String> list2) {
  // Sort the lists before comparison to ensure order doesn't affect the comparison
  list1.sort();
  list2.sort();
  return list1.toString() == list2.toString();
}
