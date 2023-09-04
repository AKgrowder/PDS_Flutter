import 'dart:async';
import 'dart:convert';

import 'package:pds/API/Model/coment/coment_model.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../API/ApiService/socket.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_state.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/pagenation.dart';

class ViewCommentScreen extends StatefulWidget {
  final Room_ID;
  final Title;
  String? Screen_name;
  String? createdDate;
  ViewCommentScreen(
      {required this.Room_ID, required this.Title, this.Screen_name});

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
  ImagePicker picker = ImagePicker();
  XFile? pickedImageFile;
  ScrollController scrollController = ScrollController();

  ComentApiModel? modelData;
  TextEditingController Add_Comment = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    print('bbbbbbbbbbbbb ${widget.Room_ID}');
    BlocProvider.of<senMSGCubit>(context)
        .coomentPage(widget.Room_ID, context, "0", ShowLoader: true);
    // if (widget.Screen_name == "RoomChat") {
    // }
    getToken();
    stompClient.activate();
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
        return 'st January';
      case 2:
        return 'nd February';
      case 3:
        return 'rd March';
      case 4:
        return 'th April';
      case 5:
        return 'th May';
      case 6:
        return 'th June';
      case 7:
        return 'th July';
      case 8:
        return 'th August';
      case 9:
        return 'th September';
      case 10:
        return 'th October';
      case 11:
        return 'th November';
      case 12:
        return 'th December';
      default:
        return '';
    }
  }

  //  @override
  // void dispose() {
  //  stompClient.deactivate();
  //   super.dispose();
  // }

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
    return Scaffold(
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

          if (state is senMSGLoadingState) {
            // Center(
            //   child: Container(
            //     margin: EdgeInsets.only(bottom: 100),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20),
            //       child: Image.asset(ImageConstant.loader,
            //           fit: BoxFit.cover, height: 100.0, width: 100),
            //     ),
            //   ),
            // );
          }
          if (state is senMSGLoadedState) {
            // BlocProvider.of<senMSGCubit>(context)
            //     .coomentPage(widget.Room_ID, context, ShowLoader: true);
          }
          if (state is ComentApiState) {
            modelData = state.comentApiClass;
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
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      child: Column(
                        children: [
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
                                    // color: Colors.amber,
                                    child: Text(
                                      "${widget.Title}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  /*   GestureDetector(
                            onTap: () {
                              setState(() {
                                if (image?.contains(index) ?? false) {
                                  image?.remove(index);
                                } else {
                                  image?.add(index);
                                }
                              });
                            },
                            child: (image?.contains(index) ?? false)
                                ? CustomImageView(
                                    imagePath:
                                        ImageConstant.unselectedimgVector,
                                    height: 20,
                                  )
                                : CustomImageView(
                                    imagePath: ImageConstant.selectedimage,
                                    height: 20,
                                  ),
                          ), */
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
                                  "${modelData?.object?.messageOutputList?.content?.length != null ? modelData?.object?.messageOutputList?.content?.length : '0'} Comments",
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
                            color: Color.fromARGB(53, 117, 117, 117),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 150.0),
                          //   child: Stack(
                          //     // mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       CustomImageView(
                          //         imagePath: ImageConstant.viewcommentimage,
                          //         height: 100,
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(left: 100.0, top: 5),
                          //         child: CustomImageView(
                          //           imagePath: ImageConstant.deleteimage,
                          //           height: 30,
                          //           // alignment: Alignment.topCenter,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          //-----------------------------------------------------------
                          // Container(
                          //   height: 60,
                          //   width: width,
                          //   // color: Colors.red,
                          //   child: Row(
                          //     children: [
                          //       Stack(
                          //         children: [
                          //           Container(
                          //             height: 50,
                          //             width: width - 90,
                          //             decoration: BoxDecoration(
                          //                 color: Color(0xFFF5F5F5),
                          //                 borderRadius:
                          //                     BorderRadius.circular(25)),
                          //             child: Padding(
                          //               padding: const EdgeInsets.only(
                          //                   left: 45, right: 10),
                          //               child: TextField(
                          //                 controller: Add_Comment,
                          //                 cursorColor: Colors.grey,
                          //                 decoration: InputDecoration(
                          //                   border: InputBorder.none,
                          //                   hintText: "Add Comment",
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           Container(
                          //             height: 50,
                          //             width: width - 90,
                          //             child: Row(
                          //               children: [
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Image.asset(
                          //                     "assets/images/ic_outline-emoji-emotions.png",
                          //                     height: 30,
                          //                   ),
                          //                 ),
                          //                 Spacer(),
                          //                 Image.asset(
                          //                   "assets/images/paperclip-2.png",
                          //                   height: 30,
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Image.asset(
                          //                     "assets/images/Vector (12).png",
                          //                     height: 22,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         print(
                          //             "Add comment button-${Add_Comment.text}");
                          //         if (Add_Comment.text.isNotEmpty) {
                          //           checkGuestUser();
                          //         } else {
                          //           SnackBar snackBar = SnackBar(
                          //             content: Text('Please Enter Comment'),
                          //             backgroundColor:
                          //                 ColorConstant.primary_color,
                          //           );
                          //           ScaffoldMessenger.of(context)
                          //               .showSnackBar(snackBar);
                          //         }
                          //       },
                          //       child: Container(
                          //         height: 50,
                          //         // width: 50,
                          //         decoration: BoxDecoration(
                          //             color: Color(0xFFED1C25),
                          //             borderRadius:
                          //                 BorderRadius.circular(25)),
                          //         child: Image.asset(
                          //           "assets/images/Vector (13).png",
                          //           color: Colors.white,
                          //         ),

                          //         // width: width - 95,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // ),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: _width - 90,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        emojiShowing = !emojiShowing;
                                      });
                                      // buildSticker();
                                      // buildSticker();
                                      // KeyboardEmojiPicker().pickEmoji();
                                    },
                                    child: Image.asset(
                                      "assets/images/ic_outline-emoji-emotions.png",
                                      height: 28,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    // height: 40,
                                    width: _width / 1.7,
                                    // color: Colors.amber,
                                    child: TextField(
                                      controller: Add_Comment,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Add Comment",
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     pickProfileImage();
                                  //   },
                                  //   child: Image.asset(
                                  //     "assets/images/paperclip-2.png",
                                  //     height: 28,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     camerapicker();
                                  //   },
                                  //   child: Image.asset(
                                  //     "assets/images/Vector (12).png",
                                  //     height: 20,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                ]),
                                // child: TextField(
                                //   controller: Add_Comment,
                                //   cursorColor: Colors.grey,
                                //   decoration: InputDecoration(
                                //     border: InputBorder.none,
                                //     hintText: "Add Comment",
                                //   ),
                                // ),
                              ),
                              GestureDetector(
                                onTap: () {
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
                                          print(
                                              'Add RealTime MSG --->$jsonString');

                                          Content content1 = Content.fromJson(
                                              jsonString['object']);
                                          print(
                                              "check MSG get Properly ---> ${content1.message}");
                                          var msgUUID = content1.uid;

                                          if (addmsg != msgUUID) {
                                            print(
                                                "please1 ---> ${modelData?.object?.messageOutputList?.content?.length}");

                                            Content content = Content.fromJson(
                                                jsonString['object']);
                                            print(
                                                "please2 ---> ${content.message}");
                                            modelData?.object?.messageOutputList
                                                ?.content
                                                ?.add(content);

                                            setState(() {
                                              addmsg = content.uid ?? "";
                                            });
                                          }

                                          print(
                                              "please3 ---> ${modelData?.object?.messageOutputList?.content?.length}");
                                          // print(
                                          //     'lofifgnfgn-=${jsonString['object']}');
                                          //     var data = jsonString['object'];

                                          // Content content = Content.fromJson(
                                          //     json.decode(jsonString['object']));
                                          // print('content -${content.uid}');

                                          // modelData?.object?.messageOutputList?.content?.add(content);
                                          // var getDataa =
                                          //     socketModel.fromJson(jsonString);
                                          // print(getDataa);

                                          // modelData
                                          //     ?.object?.messageOutputList?.content
                                          //     ?.add(modelData!
                                          //         .object!
                                          //         .messageOutputList!
                                          //         .content!
                                          //         .last);

                                          // print(
                                          //     'getDataa.object${getDataa.object}');

                                          // // var aa = getDataa.object as Content;
                                          // // print(aa);

                                          // // print(
                                          // //     "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&${modelData?.object?.messageOutputList?.content?.length}");
                                          // modelData
                                          //     ?.object?.messageOutputList?.content
                                          //     ?.add(getDataa.object as Content);
                                          // print(
                                          //     "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&${modelData?.object?.messageOutputList?.content?.length}");

                                          // Process the received message
                                        },
                                      );
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
                          Offstage(
                            offstage: !emojiShowing,
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
                        ],
                      ),
                    ),
                    Container(
                      height: _height / 1.4,
                      // color: Colors.red[200],
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: modelData != null
                            ? SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  children: [
                                    PaginationWidget(
                                        onPagination: (p0) async {
                                          print(
                                              "-------------" + p0.toString());

                                          await BlocProvider.of<senMSGCubit>(
                                                  context)
                                              .coomentPagePagenation(
                                                  widget.Room_ID,
                                                  context,
                                                  p0.toString(),
                                                  ShowLoader: true);
                                        },
                                        offSet: (modelData
                                            ?.object
                                            ?.messageOutputList
                                            ?.pageable
                                            ?.pageNumber),
                                        scrollController: scrollController,
                                        totalSize: modelData?.object
                                            ?.messageOutputList?.totalElements,
                                        items: ListView.builder(
                                            itemCount: modelData
                                                ?.object
                                                ?.messageOutputList
                                                ?.content
                                                ?.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              DateTime parsedDateTime =
                                                  DateTime.parse(
                                                      '${modelData?.object?.messageOutputList?.content?[index].createdAt}');
                                              print(
                                                  "check User name --> ${modelData?.object?.messageOutputList?.content?[index].userName} Login User Name --> ${User_Name}");

                                              return modelData
                                                          ?.object
                                                          ?.messageOutputList
                                                          ?.content?[index]
                                                          .userName !=
                                                      User_Name
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          /* horizontal: 35, vertical: 5 */),
                                                      child: GestureDetector(
                                                        onTap: () {},
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
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right: 3),
                                                                  child: modelData
                                                                              ?.object
                                                                              ?.messageOutputList
                                                                              ?.content?[index]
                                                                              .userName !=
                                                                          null
                                                                      ? CustomImageView(
                                                                          url:
                                                                              "${modelData?.object?.messageOutputList?.content?[index].userProfilePic}",
                                                                          height:
                                                                              20,
                                                                          radius:
                                                                              BorderRadius.circular(20),
                                                                          width:
                                                                              20,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )
                                                                      : CustomImageView(
                                                                          imagePath:
                                                                              ImageConstant.tomcruse,
                                                                          height:
                                                                              20,
                                                                        ),
                                                                ),
                                                                Text(
                                                                  "${modelData?.object?.messageOutputList?.content?[index].userName}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Spacer(),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          16),
                                                                  child: Text(
                                                                    customFormat(
                                                                        parsedDateTime),
                                                                    // maxLines: 3,
                                                                    textScaleFactor:
                                                                        1.0,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            /* index == 2
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  CustomImageView(
                                                    imagePath: ImageConstant
                                                        .viewcommentimage,
                                                    height: 60,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomImageView(
                                                    imagePath:
                                                        ImageConstant.mobileman,
                                                    height: 60,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(), */
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              8.0,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                2.0,
                                                                            top:
                                                                                5),
                                                                        // child: CircleAvatar(
                                                                        //     backgroundColor: Colors.black,
                                                                        //     maxRadius: 3),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      Container(
                                                                        // height: 45,
                                                                        width: _width /
                                                                            1.3,
                                                                        // color: Colors.amber,
                                                                        child:
                                                                            Text(
                                                                          modelData?.object?.messageOutputList?.content?[index].message ??
                                                                              "",
                                                                          // maxLines: 3,
                                                                          textScaleFactor:
                                                                              1.0,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.grey,
                                                                              fontFamily: "outfit",
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  117, 0, 0, 0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          /* horizontal: 35, vertical: 5 */),
                                                      child: GestureDetector(
                                                        onTap: () {},
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
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 16),
                                                                  child: Text(
                                                                    customFormat(
                                                                        parsedDateTime),
                                                                    // maxLines: 3,
                                                                    textScaleFactor:
                                                                        1.0,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  "${modelData?.object?.messageOutputList?.content?[index].userName}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 3,
                                                                      right:
                                                                          10),
                                                                  child: modelData
                                                                              ?.object
                                                                              ?.messageOutputList
                                                                              ?.content?[index]
                                                                              .userProfilePic
                                                                              ?.isNotEmpty ??
                                                                          false
                                                                      ? CustomImageView(
                                                                          url:
                                                                              "${modelData?.object?.messageOutputList?.content?[index].userProfilePic}",
                                                                          height:
                                                                              20,
                                                                          radius:
                                                                              BorderRadius.circular(20),
                                                                          width:
                                                                              20,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )
                                                                      : CustomImageView(
                                                                          imagePath:
                                                                              ImageConstant.tomcruse,
                                                                          height:
                                                                              20,
                                                                        ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            /* index == 2
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  CustomImageView(
                                                    imagePath: ImageConstant
                                                        .viewcommentimage,
                                                    height: 60,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomImageView(
                                                    imagePath:
                                                        ImageConstant.mobileman,
                                                    height: 60,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(), */
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Spacer(),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: 8.0,
                                                                      top: 5,
                                                                      bottom:
                                                                          10,
                                                                      right:
                                                                          12),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                2.0,
                                                                            top:
                                                                                5),
                                                                        // child: CircleAvatar(
                                                                        //     backgroundColor: Colors.black,
                                                                        //     maxRadius: 3),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      Container(
                                                                        // height: 45,
                                                                        width: _width /
                                                                            1.3,
                                                                        // color: Colors.amber,
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              Text(
                                                                            modelData?.object?.messageOutputList?.content?[index].message ??
                                                                                "",
                                                                            // maxLines: 3,
                                                                            textScaleFactor:
                                                                                1.0,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.grey,
                                                                                fontFamily: "outfit",
                                                                                fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  117, 0, 0, 0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                            })),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ),
                    ),
                  ]),
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
        }));
  }

  Widget buildSticker() {
    return EmojiPicker(
      key: _formKey,
      textEditingController: Add_Comment,
      config: Config(
        columns: 7,
        // Issue: https://github.com/flutter/flutter/issues/28894
        emojiSizeMax: 32 *
            (foundation.defaultTargetPlatform == TargetPlatform.iOS
                ? 1.30
                : 1.0),
      ),
      // rows: 3,
      // columns: 7,
      // buttonMode: ButtonMode.MATERIAL,
      // recommendKeywords: ["racing", "horse"],
      // numRecommended: 10,
      onEmojiSelected: (emoji, category) {
        print(emoji);
      },
    );
  }

  checkGuestUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID != null) {
      print("user login Mood");
      if (Add_Comment.text.isNotEmpty) {
        // BlocProvider.of<senMSGCubit>(context)
        //     .senMSGAPI(widget.Room_ID, Add_Comment.text, ShowLoader: true);

        // BlocProvider.of<senMSGCubit>(context)
        //         .coomentPage(widget.Room_ID, ShowLoader: true);

        setState(() {
          addmsg = "";
          Add_Comment.text = '';
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
      print("User guest Mood on");
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

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Token = prefs.getString(PreferencesKey.loginJwt) ?? "";
    UserCode = prefs.getString(PreferencesKey.loginUserID) ?? "";
    User_Name = prefs.getString(PreferencesKey.ProfileUserName) ?? "";
  }

  Future<void> camerapicker() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.camera);
  }

  Future<void> pickProfileImage() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
  }
}
