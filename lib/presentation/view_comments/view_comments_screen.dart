import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Model/coment/coment_model.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/parser.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

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
  String? userId;
  DateTime? parsedDateTime;
  String? UserLogin_ID;
  ImagePicker picker = ImagePicker();
  XFile? pickedImageFile;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  bool isScroll = false;
  bool AddNewData = false;
  File? _image;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  FocusNode _focusNode = FocusNode();
  final focusNode = FocusNode();
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

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
    getUserID();
    getToken();

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
  void dispose() {
    //  stompClient.deactivate();
    // Delet_stompClient.deactivate();
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
            if (state is ComentApiIntragtionWithChatState) {
              print('second loaded state');

              _image = null;
              print('dfdfhsdfhsh-${state.comentApiClass1}');
              Content content1 =
                  Content.fromJson(state.comentApiClass1['object']);
              print('sdfhdsghghfgh--${content1.createdAt}');
              AddNewData = true;
              modelData?.object?.messageOutputList?.content?.add(content1);
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
                                  width: _width / 1.2,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${widget.Title}  ",
                                    // overflow: TextOverflow.ellipsis,
                                    // maxLines: 2,
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
                          height: 5,
                          color: Color.fromARGB(53, 117, 117, 117),
                        ),
                        Expanded(
                          child: Container(
                            // height: _height / 1.4,
                            // color: Colors.red[200],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: modelData != null
                                  ? modelData?.object?.roomUid == null ||
                                          modelData?.object?.roomUid == ""
                                      ? SizedBox()
                                      : SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            children: [
                                              PaginationWidget(
                                                  onPagination: (p0) async {
                                                    print("-------------" +
                                                        p0.toString());

                                                    await BlocProvider.of<
                                                                senMSGCubit>(
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
                                                  scrollController:
                                                      scrollController,
                                                  totalSize: modelData
                                                      ?.object
                                                      ?.messageOutputList
                                                      ?.totalElements,
                                                  items: ListView.builder(
                                                      // reverse: true,
                                                      itemCount: (modelData
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
                                                                '${modelData?.object?.messageOutputList?.content?[index].createdAt}');

                                                        DateTime time =
                                                            DateTime.now();
                                                        var format =
                                                            DateFormat("mm");
                                                        var aa =
                                                            format.format(time);

                                                        var bb = format.format(
                                                            parsedDateTime);

                                                        var one =
                                                            format.parse(bb);
                                                        var two =
                                                            format.parse(aa);
                                                        var final_time =
                                                            two.difference(one);

                                                        var bbb = Duration(
                                                            minutes: 10);

                                                        var finalAPI_Time =
                                                            int.parse(bbb
                                                                .toString()
                                                                .split(":")[1]);

                                                        var FixTime = int.parse(
                                                            final_time
                                                                .toString()
                                                                .split(":")[1]);

                                                        // one.difference(two);

                                                        print(
                                                            "check User name --> ${modelData?.object?.messageOutputList?.content?[index].userName} Login User Name --> ${User_Name}");

                                                        if (isScroll == false) {
                                                          Future.delayed(
                                                              Duration(
                                                                  microseconds:
                                                                      1), () {
                                                            if (scrollController
                                                                .hasClients) {
                                                              for (int i = 0;
                                                                  i <
                                                                      (modelData
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
                                                            // setState(() {
                                                            isScroll = true;
                                                            // });
                                                          });
                                                        } else {}
                                                        return modelData
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
                                                                            child: modelData?.object?.messageOutputList?.content?[index].userName != null
                                                                                ? CustomImageView(
                                                                                    url: "${modelData?.object?.messageOutputList?.content?[index].userProfilePic}",
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
                                                                            "${modelData?.object?.messageOutputList?.content?[index].userName}",
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.black,
                                                                                fontFamily: "outfit",
                                                                                fontSize: 14),
                                                                          ),
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

                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: modelData?.object?.messageOutputList?.content?[index].messageType !=
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
                                                                                            modelData?.object?.messageOutputList?.content?[index].message ?? "",
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
                                                                                    child: AnimatedNetworkImage(imageUrl: "${modelData?.object?.messageOutputList?.content?[index].message}"),
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
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    /* horizontal: 35, vertical: 5 */),
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
                                                                            customFormat(parsedDateTime!),
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
                                                                        Spacer(),
                                                                        Text(
                                                                          "${modelData?.object?.messageOutputList?.content?[index].userName}",
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
                                                                          child: modelData?.object?.messageOutputList?.content?[index].userProfilePic?.isNotEmpty ?? false
                                                                              ? CustomImageView(
                                                                                  url: "${modelData?.object?.messageOutputList?.content?[index].userProfilePic}",
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
                                                                    Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                16),
                                                                        child: finalAPI_Time <
                                                                                FixTime
                                                                            ? SizedBox()
                                                                            : GestureDetector(
                                                                                onTap: () {
                                                                                  print("delete msg");

                                                                                  print(modelData?.object?.messageOutputList?.content?[index].uid);
                                                                                  print(UserLogin_ID);
                                                                                  // roomUid = "${widget.Room_ID}";
                                                                                  // DeleteMSg_baseURL = " assas ";

                                                                                  // var Delete_MEG_uid = "${modelData?.object?.messageOutputList?.content?[index].uid}";
                                                                                  // var Login_userUID = "${UserLogin_ID}";

                                                                                  // checkGuestUser();
                                                                                  // roomUid = "${widget.Room_ID}";
                                                                                  Room_ID_stomp = "${widget.Room_ID}";
                                                                                  stompClient.subscribe(
                                                                                    destination:
                                                                                        // "ws://72c1-2405-201-200b-a0cf-210f-e5fe-f229-e899.ngrok.io",
                                                                                        "/topic/getDeletedMessage/${widget.Room_ID}",
                                                                                    callback: (StompFrame frame) {
                                                                                      Map<String, dynamic> jsonString = json.decode(frame.body ?? "");
                                                                                      print('Add RealTime MSG --->$jsonString');

                                                                                      Content content1 = Content.fromJson(jsonString['object']);
                                                                                      print("check MSG get Properly ---> ${content1.message}");

                                                                                      var msgUUID = content1.uid;
                                                                                      if (content1.isDeleted == true) {
                                                                                        BlocProvider.of<senMSGCubit>(context).coomentPage(widget.Room_ID, context, "0", ShowLoader: true);
                                                                                      }

                                                                                      // if (addmsg != msgUUID) {
                                                                                      //   print("please1 ---> ${modelData?.object?.messageOutputList?.content?.length}");

                                                                                      //   Content content = Content.fromJson(jsonString['object']);
                                                                                      //   print("please2 ---> ${content.message}");
                                                                                      //   modelData?.object?.messageOutputList?.content?.add(content);

                                                                                      //   setState(() {
                                                                                      //     addmsg = content.uid ?? "";
                                                                                      //   });
                                                                                      // }

                                                                                      // print("please3 ---> ${modelData?.object?.messageOutputList?.content?.length}");
                                                                                    },
                                                                                  );

                                                                                  stompClient.send(
                                                                                    destination: "/deleteMessage/${widget.Room_ID}",
                                                                                    body: json.encode({
                                                                                      "uid": "${modelData?.object?.messageOutputList?.content?[index].uid}",
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
                                                                                ))),
                                                                    modelData?.object?.messageOutputList?.content?[index].messageType !=
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
                                                                                  // height: 45,
                                                                                  width: _width / 1.3,
                                                                                  // color: Colors.amber,
                                                                                  child: Align(
                                                                                    alignment: Alignment.topRight,
                                                                                    child: Text(
                                                                                      "${modelData?.object?.messageOutputList?.content?[index].message ?? ""}",
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
                                                                                child: AnimatedNetworkImage(imageUrl: "${modelData?.object?.messageOutputList?.content?[index].message}"),
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
                              width: _width - 90,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Container(
                                  child: IconButton(
                                    icon: Icon(
                                      isEmojiVisible
                                          ? Icons.keyboard_rounded
                                          : Icons.emoji_emotions_outlined,
                                    ),
                                    onPressed: onClickedEmoji,
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     setState(() {
                                //       emojiShowing = !emojiShowing;
                                //     });
                                //     // buildSticker();
                                //     // buildSticker();
                                //     // KeyboardEmojiPicker().pickEmoji();
                                //   },
                                //   child: Image.asset(
                                //     "assets/images/ic_outline-emoji-emotions.png",
                                //     height: 28,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: _width / 2.2,
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
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    pickProfileImage();
                                  },
                                  child: Image.asset(
                                    "assets/images/paperclip-2.png",
                                    height: 22,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
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
                                if (_image != null) {
                                  BlocProvider.of<senMSGCubit>(context)
                                      .chatImageMethod(widget.Room_ID, context,
                                          userId.toString(), _image!);
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
                                          print(
                                              'Add RealTime MSG --->$jsonString');

                                          Content content1 = Content.fromJson(
                                              jsonString['object']);
                                          print(
                                              "check MSG get Properly ---> ${content1.message}");
                                          var msgUUID = content1.uid;

                                          if (AddNewData == false) {
                                            print(
                                                'check value --> $AddNewData');
                                            if (addmsg != msgUUID) {
                                              print(
                                                  "please1 ---> ${modelData?.object?.messageOutputList?.content?.length}");

                                              Content content =
                                                  Content.fromJson(
                                                      jsonString['object']);
                                              print(
                                                  "please2 ---> ${content.message}");
                                              modelData?.object
                                                  ?.messageOutputList?.content
                                                  ?.add(content);

                                              setState(() {
                                                addmsg = content.uid ?? "";
                                              });
                                            }
                                          }
                                          print(
                                              "please3 ---> ${modelData?.object?.messageOutputList?.content?.length}");
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
        print(emoji);
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
      print("user login Mood");
      if (Add_Comment.text.isNotEmpty) {
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
    userId = prefs.getString(PreferencesKey.loginUserID) ?? "";
    Token = prefs.getString(PreferencesKey.loginJwt) ?? "";
    UserCode = prefs.getString(PreferencesKey.loginUserID) ?? "";
    User_Name = prefs.getString(PreferencesKey.ProfileUserName) ?? "";
    baseURL = prefs.getString(PreferencesKey.SocketLink) ?? "";
    stompClient.activate();
    // Delet_stompClient.activate();
  }

  Future<void> camerapicker() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedImageFile != null) {
      if (!_isGifOrSvg(pickedImageFile!.path)) {
        setState(() {
          _image = File(pickedImageFile!.path);
        });
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
        setState(() {
          _image = File(pickedImageFile!.path);
        });
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

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  void onEmojiSelected(String emoji) => setState(() {
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
}
