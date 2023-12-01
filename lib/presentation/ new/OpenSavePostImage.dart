import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Model/OpenSaveImagepostModel/OpenSaveImagepost_Model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/RePost_Screen.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comment_bottom_sheet.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_state.dart';

// ignore: must_be_immutable
class OpenSavePostImage extends StatefulWidget {
  String? PostID;
  bool? profileTure;
  int? index;
  OpenSavePostImage({
    Key? key,
    required this.PostID,
    this.profileTure,
    this.index,
  }) : super(key: key);
  @override
  State<OpenSavePostImage> createState() => _OpenSavePostImageState();
}

class _OpenSavePostImageState extends State<OpenSavePostImage> {
  OpenSaveImagepostModel? OpenSaveModelData;
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime? parsedDateTimeBlogs;
  final ScrollController scroll = ScrollController();
  List<int> currentPages = [];
  List<PageController> pageControllers = [];
  bool added = false;
  int imageCount = 1;

  @override
  void initState() {
    BlocProvider.of<OpenSaveCubit>(context)
        .openSaveImagePostAPI(context, "${widget.PostID}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return BlocConsumer<OpenSaveCubit, OpenSaveState>(
        listener: (context, state) async {
      if (state is OpenSaveErrorState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.error),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // if (state is OpenSaveLoadingState) {
      //   Center(
      //     child: Container(
      //       margin: EdgeInsets.only(bottom: 100),
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(20),
      //         child: Image.asset(ImageConstant.loader,
      //             fit: BoxFit.cover, height: 100.0, width: 100),
      //       ),
      //     ),
      //   );
      // }
      if (state is OpenSaveLoadedState) {
        OpenSaveModelData = state.OpenSaveData;
        print(OpenSaveModelData?.object?.postUserName);
        parsedDateTimeBlogs =
            DateTime.parse('${OpenSaveModelData?.object?.createdAt ?? ""}');
        navigationFunction();
        print("home imges -- ${widget.index}");
        if (!added) {
          OpenSaveModelData?.object?.postData?.forEach((element) {
            pageControllers.add(PageController());
            currentPages.add(0);
          });
          WidgetsBinding.instance
              .addPostFrameCallback((timeStamp) => setState(() {
                    added = true;
                  }));
        }
      }
      if (state is RePostLoadedState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.RePost.object.toString()),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return NewBottomBar(
              buttomIndex: 0,
            );
          },
        ), (Route<dynamic> route) => false);
      }
      if (state is PostLikeLoadedState) {
        print("${state.likePost.object}");
        // SnackBar snackBar = SnackBar(
        //   content: Text(state.likePost.object ?? ""),
        //   backgroundColor: ColorConstant.primary_color,
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, builder: (context, state) {
      if (state is OpenSaveLoadingState) {
        return Center(
            child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                )));
      }
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: _width,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                            child: Center(
                              child: Image.asset(
                                ImageConstant.whiteClose,
                                fit: BoxFit.fill,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfileScreen(
                                  User_ID:
                                      "${OpenSaveModelData?.object?.userUid}",
                                  isFollowing:
                                      OpenSaveModelData?.object?.isFollowing);
                            }));
                          },
                          child: OpenSaveModelData?.object?.userProfilePic !=
                                      null &&
                                  OpenSaveModelData?.object?.userProfilePic !=
                                      ""
                              ? CustomImageView(
                                  url:
                                      "${OpenSaveModelData?.object?.userProfilePic}",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                  radius: BorderRadius.circular(25),
                                )
                              : CustomImageView(
                                  imagePath: ImageConstant.tomcruse,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                  radius: BorderRadius.circular(25),
                                ),
                        ),
                        SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${OpenSaveModelData?.object?.postUserName}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'outfit',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(customFormat(parsedDateTimeBlogs!),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w600,
                                  ))
                            ])
                      ])),
                  OpenSaveModelData?.object?.postDataType == null
                      ? SizedBox()
                      : Container(
                          // height: _height / 1.5,
                          // width: _width,
                          child: OpenSaveModelData?.object?.postDataType == null
                              ? SizedBox()
                              : OpenSaveModelData?.object?.postData?.length == 1
                                  ? OpenSaveModelData?.object?.postDataType ==
                                          "IMAGE"
                                      ? Center(
                                          child: CustomImageView(
                                          fit: BoxFit.cover,
                                          url:
                                              "${OpenSaveModelData?.object?.postData?[0]}",
                                        ))
                                      : OpenSaveModelData
                                                  ?.object?.postDataType ==
                                              "ATTACHMENT"
                                          ? Container(
                                              height: 400,
                                              width: _width,
                                              child: DocumentViewScreen1(
                                                path: "",
                                              ))
                                          : SizedBox()
                                  : Column(
                                      children: [
                                        Stack(
                                          children: [
                                            if ((OpenSaveModelData?.object
                                                    ?.postData?.isNotEmpty ??
                                                false)) ...[
                                              Container(
                                                color: Colors.transparent,
                                                height: _height / 2,
                                                child: PageView.builder(
                                                  onPageChanged: (page) {
                                                    setState(() {
                                                      currentPages[
                                                          widget.index ??
                                                              0] = page;
                                                      imageCount = page + 1;
                                                    });
                                                  },
                                                  controller: pageControllers[
                                                      widget.index ?? 0],
                                                  itemCount: OpenSaveModelData
                                                      ?.object
                                                      ?.postData
                                                      ?.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index1) {
                                                    if (OpenSaveModelData
                                                            ?.object
                                                            ?.postDataType ==
                                                        "IMAGE") {
                                                      return Container(
                                                        width: _width,
                                                        margin: EdgeInsets.only(
                                                            left: 16,
                                                            top: 15,
                                                            right: 16),
                                                        child: Center(
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child:
                                                                    CustomImageView(
                                                                  url:
                                                                      "${OpenSaveModelData?.object?.postData?[index1]}",
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Card(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation: 0,
                                                                  child: Container(
                                                                      alignment: Alignment.center,
                                                                      height: 30,
                                                                      width: 50,
                                                                      decoration: BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            2,
                                                                            1,
                                                                            1),
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(50)),
                                                                      ),
                                                                      child: Text(
                                                                        imageCount.toString() +
                                                                            '/' +
                                                                            '${OpenSaveModelData?.object?.postData?.length}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    } else if (OpenSaveModelData
                                                            ?.object
                                                            ?.postDataType ==
                                                        "ATTACHMENT") {
                                                      return Container(
                                                          height: 400,
                                                          width: _width,
                                                          // color: Colors.green,
                                                          child:
                                                              DocumentViewScreen1(
                                                            path:
                                                                OpenSaveModelData
                                                                    ?.object
                                                                    ?.postData?[
                                                                        index1]
                                                                    .toString(),
                                                          ));
                                                    }
                                                  },
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 5,
                                                  left: 0,
                                                  right: 0,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    child: Container(
                                                      height: 20,
                                                      child: DotsIndicator(
                                                        dotsCount:
                                                            OpenSaveModelData
                                                                    ?.object
                                                                    ?.postData
                                                                    ?.length ??
                                                                1,
                                                        position: currentPages[
                                                                widget.index ??
                                                                    0]
                                                            .toDouble(),
                                                        decorator:
                                                            DotsDecorator(
                                                          size: const Size(
                                                              10.0, 7.0),
                                                          activeSize:
                                                              const Size(
                                                                  10.0, 10.0),
                                                          spacing:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      2),
                                                          activeColor:
                                                              Color(0xffED1C25),
                                                          color:
                                                              Color(0xff6A6A6A),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                            ]
                                          ],
                                        ),
                                      ],
                                    ),
                        ),
                  OpenSaveModelData?.object?.description == null
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: LinkifyText(
                              "${OpenSaveModelData?.object?.description}",
                              linkStyle: TextStyle(color: Colors.blue),
                              textStyle: TextStyle(color: Colors.white),
                              linkTypes: [
                                LinkType.url,
                                // LinkType
                                //     .userTag,
                                LinkType.hashTag,
                                // LinkType
                                //     .email
                              ],
                              onTap: (link) {
                                var SelectedTest = link.value.toString();
                                var Link = SelectedTest.startsWith('https');
                                var Link1 = SelectedTest.startsWith('http');
                                var Link2 = SelectedTest.startsWith('www');

                                print(SelectedTest.toString());
                                print(Link);
                                // if (User_ID ==
                                //     null) {
                                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                // } else {
                                if (Link == true &&
                                    Link1 == true &&
                                    Link2 == true) {
                                  launch(link.value.toString(),
                                      forceWebView: true,
                                      enableJavaScript: true);
                                } else {
                                  print("${link}");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HashTagViewScreen(
                                            title: "${link.value}"),
                                      ));
                                }
                                // }
                              },
                            ), /* Text(
                              "${OpenSaveModelData?.object?.description ?? ""}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w600,
                              ),
                            ) */
                          ),
                        ),
                  Container(
                    // color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 0, bottom: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await soicalFunation(
                                apiName: 'like_post',
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child:
                                    OpenSaveModelData?.object?.isLiked != true
                                        ? Image.asset(
                                            ImageConstant.likewithout,
                                            height: 20,
                                            color: Colors.white,
                                          )
                                        : Image.asset(
                                            ImageConstant.like,
                                            height: 20,
                                          ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          OpenSaveModelData?.object?.likedCount == 0
                              ? SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        
                                                            ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */

                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return ShowAllPostLike(
                                            "${OpenSaveModelData?.object?.postUid}");
                                      },
                                    ));
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${OpenSaveModelData?.object?.likedCount}",
                                        style: TextStyle(
                                          fontFamily: "outfit",
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () async {
                              BlocProvider.of<AddcommentCubit>(context)
                                  .Addcomment(context,
                                      '${OpenSaveModelData?.object?.postUid}');

                              _settingModalBottomSheet1(context, 0, _width);

                              /*     await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return CommentsScreen(
                                                                image:
                                                                    AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .userProfilePic,
                                                                userName:
                                                                    AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .postUserName,
                                                                description:
                                                                    AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .description,
                                                                PostUID:
                                                                    '${AllGuestPostRoomData?.object?.content?[index].postUid}',
                                                                date: AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .createdAt ??
                                                                    "",
                                                              );
                                                            })).then((value) =>
                                                                methodtoReffrser()); */
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  ImageConstant.meesage,
                                  height: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          OpenSaveModelData?.object?.commentCount == 0
                              ? SizedBox()
                              : Text(
                                  "${OpenSaveModelData?.object?.commentCount}",
                                  style: TextStyle(
                                    fontFamily: "outfit",
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                          GestureDetector(
                            onTap: () {
                              rePostBottomSheet(
                                context,
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  ImageConstant.vector2,
                                  height: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          OpenSaveModelData?.object?.repostCount == 0
                              ? SizedBox()
                              : Text(
                                  '${OpenSaveModelData?.object?.repostCount}',
                                  style: TextStyle(
                                      fontFamily: "outfit", fontSize: 14),
                                ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await soicalFunation(
                                apiName: 'savedata',
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  OpenSaveModelData?.object?.isSaved == false
                                      ? ImageConstant.savePin
                                      : ImageConstant.Savefill,
                                  height: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Share.share(
                          //         'https://play.google.com/store/apps/details?id=com.pds.app');
                          //   },
                          //   child: Container(
                          //     color: Colors.transparent,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(5.0),
                          //       child: Image.asset(
                          //         ImageConstant.shareWhite,
                          //         height: 17,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  String customFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('dd-MM-yyyy     h:mm a').format(date);

    String formattedDate = '$time';
    return formattedDate;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return ' January';
      case 2:
        return ' February';
      case 3:
        return ' March';
      case 4:
        return ' April';
      case 5:
        return ' May';
      case 6:
        return ' June';
      case 7:
        return ' July';
      case 8:
        return ' August';
      case 9:
        return ' September';
      case 10:
        return ' October';
      case 11:
        return ' November';
      case 12:
        return ' December';
      default:
        return '';
    }
  }

  navigationFunction() {
    if (widget.profileTure == true) {
      Future.delayed(
        Duration(seconds: 2),
      ).then((value) {
        BlocProvider.of<AddcommentCubit>(context)
            .Addcomment(context, '${OpenSaveModelData?.object?.postUid}');
        _settingModalBottomSheet1(context, 0, double.infinity);
      });
    }
  }

  void _settingModalBottomSheet1(context, index, _width) {
    void _goToElement() {
      scroll.animateTo((1000 * 20),
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: true,
        showDragHandle: true,
        enableDrag: true,
        constraints: BoxConstraints.tight(Size.infinite),
        context: context,
        builder: (BuildContext bc) {
          return CommentBottomSheet(
              userProfile: OpenSaveModelData?.object?.userProfilePic ?? "",
              UserName: OpenSaveModelData?.object?.postUserName ?? "",
              desc: OpenSaveModelData?.object?.description ?? "",
              postUuID: OpenSaveModelData?.object?.postUid ?? "");
        });
  }

  soicalFunation({
    String? apiName,
  }) async {
    print("fghdfghdfgh");
    if (apiName == 'like_post') {
      await BlocProvider.of<OpenSaveCubit>(context)
          .like_post(OpenSaveModelData?.object?.postUid, context);

      if (OpenSaveModelData?.object?.isLiked == true) {
        OpenSaveModelData?.object?.isLiked = false;
        int a = OpenSaveModelData?.object?.likedCount ?? 0;
        int b = 1;
        OpenSaveModelData?.object?.likedCount = a - b;
      } else {
        OpenSaveModelData?.object?.isLiked = true;
        OpenSaveModelData?.object?.likedCount;
        int a = OpenSaveModelData?.object?.likedCount ?? 0;
        int b = 1;
        OpenSaveModelData?.object?.likedCount = a + b;
      }
    } else if (apiName == 'savedata') {
      await BlocProvider.of<OpenSaveCubit>(context)
          .savedData(OpenSaveModelData?.object?.postUid, context);

      if (OpenSaveModelData?.object?.isSaved == true) {
        OpenSaveModelData?.object?.isSaved = false;
      } else {
        OpenSaveModelData?.object?.isSaved = true;
      }
    }
  }

  void rePostBottomSheet(
    context,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 200,
            child: new Wrap(
              children: [
                Container(
                  height: 20,
                  width: 50,
                  color: Colors.transparent,
                ),
                Center(
                    child: Container(
                  height: 5,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),
                )),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: new ListTile(
                      leading: new Image.asset(
                        ImageConstant.vector2,
                        height: 20,
                      ),
                      title: new Text('RePost'),
                      subtitle: Text(
                        "Share this post with your followers",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      onTap: () async {
                        Map<String, dynamic> param = {"postType": "PUBLIC"};
                        BlocProvider.of<OpenSaveCubit>(context).RePostAPI(
                            context, param, OpenSaveModelData?.object?.postUid);
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: new ListTile(
                    leading: new Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                    ),
                    title: new Text('Quote'),
                    subtitle: Text(
                      "Add a comment, photo or GIF before you share this post",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RePostScreen(
                            userProfile:
                                OpenSaveModelData?.object?.userProfilePic,
                            username: OpenSaveModelData?.object?.postUserName,
                            date: OpenSaveModelData?.object?.createdAt,
                            desc: OpenSaveModelData?.object?.description,
                            postData: OpenSaveModelData?.object?.postData,
                            postDataType:
                                OpenSaveModelData?.object?.postDataType,
                            OpenSaveModelData: OpenSaveModelData,
                            postUid: OpenSaveModelData?.object?.postUid,
                          );
                        },
                      ));
                      // Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }
}
