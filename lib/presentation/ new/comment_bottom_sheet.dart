import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_state.dart';
import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/deletecomment/delete_comment_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isKeyboardVisible = false;
  String? uuid;
  String? User_ID1;

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
        body: BlocConsumer<AddcommentCubit, AddCommentState>(
          listener: (context, state) async {
            if (state is AddCommentLoadedState) {
              addCommentModeldata = state.commentdata;
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
              if(state.addnewCommentsModeldata['message'] =='Comment contains a restricted word'){
                 SnackBar snackBar = SnackBar(
                content: Text(state.addnewCommentsModeldata['message']),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }else{
                addcomment.clear();

              Object1 object =
                  Object1.fromJson(state.addnewCommentsModeldata['object']);

              addCommentModeldata?.object?.add(object);

              _goToElement();
              }
              
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
                                          addCommentModeldata?.object?[index]
                                                      .profilePic ==
                                                  null
                                              ? CustomImageView(
                                                  radius:
                                                      BorderRadius.circular(50),
                                                  imagePath:
                                                      ImageConstant.pdslogo,
                                                  fit: BoxFit.fill,
                                                  height: 35,
                                                  width: 35,
                                                )
                                              : CustomImageView(
                                                  radius:
                                                      BorderRadius.circular(50),
                                                  url:
                                                      "${addCommentModeldata?.object?[index].profilePic}",
                                                  fit: BoxFit.fill,
                                                  height: 35,
                                                  width: 35,
                                                ),
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
                                                    Text(
                                                      "${addCommentModeldata?.object?[index].userName}",
                                                      style: TextStyle(
                                                          fontFamily: 'outfit',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        // "1w",
                                                        customadateFormat(
                                                            parsedDateTime),
                                                      overflow: TextOverflow.ellipsis,

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
                                                child: Text(
                                                    "${addCommentModeldata?.object?[index].comment}",
                                                    // maxLines: 2,

                                                    style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        overflow: TextOverflow
                                                            .visible,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400)),
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
                      Container(
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
                      ),
                      Offstage(
                        offstage: !isEmojiVisible,
                        child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              textEditingController: addcomment,
                              onBackspacePressed: () {
                                if (isEmojiVisible) {
                                  setState(() {
                                    isEmojiVisible = false;
                                  });
                                }
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
