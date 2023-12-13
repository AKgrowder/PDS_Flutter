import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_state.dart';
import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogCommentDelete_model.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogComment_model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/deletecomment/delete_comment_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/BlogComment_BLoc/BlogComment_cubit.dart';
import '../../API/Bloc/BlogComment_BLoc/BlogComment_state.dart';

class BlogCommentBottomSheet extends StatefulWidget {
  String? isFoollinng;

  BlogCommentBottomSheet({this.isFoollinng, key});

  @override
  State<BlogCommentBottomSheet> createState() => _BlogCommentBottomSheetState();
}

class _BlogCommentBottomSheetState extends State<BlogCommentBottomSheet> {
  final TextEditingController addcomment = TextEditingController();
  BlogCommentModel? blogCommentModel;
  final ScrollController scroll = ScrollController();
  DeleteBlogCommentModel? deleteBlogCommentModel;
  GetGuestAllPostModel? AllGuestPostRoomData;
  bool isEmojiVisible = false;
  FocusNode focusNode = FocusNode();
  bool isKeyboardVisible = false;
  String? uuid;
  String? User_ID1;
  String? blogUid;
  bool isDataGet = false;
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
        body: BlocConsumer<BlogcommentCubit, BlogCommentState>(
          listener: (context, state) async {
            if (state is BlogCommentLoadedState) {
              blogCommentModel = state.commentdata;
              isDataGet = true;
            }
            if (state is BlogCommentLoadedState) {
              isDataGet = true;
            }
            if (state is BlogCommentErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is BlognewCommentLoadedState) {
              print("dgdfhgdfhdfghhdfgh-${state.BlognewCommentsModeldata}");
              if (state.BlognewCommentsModeldata['message'] ==
                  'Comment contains a restricted word') {
                SnackBar snackBar = SnackBar(
                  content: Text(state.BlognewCommentsModeldata['message']),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                addcomment.clear();

                ObjectBlog object = ObjectBlog.fromJson(
                    state.BlognewCommentsModeldata['object']);

                blogCommentModel?.object?.add(object);

                _goToElement();
              }
            }
            if (state is DeleteBlogcommentLoadedState) {
              deleteBlogCommentModel = state.Deletecomment;
              SnackBar snackBar = SnackBar(
                content: Text(state.Deletecomment.object ?? ""),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            return isDataGet == false
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
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 70),
                              child: ListView.builder(
                                // physics:  NeverScrollableScrollPhysics(),
                                itemCount: blogCommentModel?.object?.length,
                                shrinkWrap: true,
                                controller: scroll,
                                itemBuilder: (context, index) {
                                  DateTime? parsedDateTime = DateTime.parse(
                                      '${blogCommentModel?.object?[index].createdAt ?? ""}');

                                  blogUid =
                                      blogCommentModel?.object?[index].blogUid;

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0, left: 35.0),
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
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return ProfileScreen(
                                                              User_ID:
                                                                  "${blogCommentModel?.object?[index].userUid}",
                                                              isFollowing: widget
                                                                  .isFoollinng);
                                                        }));
                                                      },
                                                      child: blogCommentModel
                                                                      ?.object?[
                                                                          index]
                                                                      .image
                                                                      ?.isEmpty ==
                                                                  true ||
                                                              blogCommentModel
                                                                      ?.object?[
                                                                          index]
                                                                      .image ==
                                                                  null
                                                          ? CustomImageView(
                                                              radius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              imagePath:
                                                                  ImageConstant
                                                                      .pdslogo,
                                                              fit: BoxFit.fill,
                                                              height: 35,
                                                              width: 35,
                                                            )
                                                          : CustomImageView(
                                                              radius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              url:
                                                                  "${blogCommentModel?.object?[index].image}",
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
                                                          Text(
                                                            "${blogCommentModel?.object?[index].userName}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'outfit',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                              // "1w",
                                                              getTimeDifference(
                                                                  parsedDateTime),
                                                              overflow:
                                                                  TextOverflow
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
                                                            child:
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      Deletecommentdilog(
                                                                          blogCommentModel?.object?[index].commentUid ??
                                                                              "",
                                                                          index);
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete_outline_rounded,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .grey,
                                                                    )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: _width / 1.4,
                                                      // height: 50,
                                                      // color: Colors.amber,
                                                      child: Text(
                                                          "${blogCommentModel?.object?[index].comment}",
                                                          // maxLines: 2,

                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'outfit',
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
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
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: TextFormField(
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
                                                  .invokeMethod(
                                                      'TextInput.hide');
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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.red), //<-- SEE HERE
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
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
                                            "blogUid": blogUid,
                                            "userUid": User_ID1
                                          };

                                          BlocProvider.of<BlogcommentCubit>(
                                                  context)
                                              .AddBloCommentApi(
                                                  context, params);
                                        }
                                      }
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 25,
                                      backgroundColor:
                                          ColorConstant.primary_color,
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
                                      recentTabBehavior:
                                          RecentTabBehavior.RECENT,
                                      recentsLimit: 28,
                                      replaceEmojiOnLimitExceed: false,
                                      noRecents: const Text(
                                        'No Recents',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black26),
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
                          "index print${blogCommentModel?.object?[index1].commentUid}");
                      print(
                          "index print1${blogCommentModel?.object?[index1].comment}");

                      BlocProvider.of<BlogcommentCubit>(context)
                          .DeletecommentAPI(
                              "${blogCommentModel?.object?[index1].commentUid}",
                              context);
                      blogCommentModel?.object?.removeAt(index1);
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

  String getTimeDifference(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return '1 day ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks == 1 ? '' : 's'} ago';
      }
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return '1 hour ago';
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return '1 minute ago';
      } else {
        return '${difference.inMinutes} minutes ago';
      }
    } else {
      return 'Just now';
    }
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
