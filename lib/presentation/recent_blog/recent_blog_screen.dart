import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/BlogComment_BLoc/BlogComment_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Model/Get_all_blog_Model/get_all_blog_model.dart';
import 'package:pds/API/Model/saveAllBlogModel/saveAllBlog_Model.dart';
import 'package:pds/presentation/%20new/BlogComment_screen.dart';
import 'package:pds/presentation/%20new/BlogLikeList_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../widgets/custom_image_view.dart';
import '../home/home.dart';

class RecentBlogScren extends StatefulWidget {
  String? title;
  String? description1;
  String? imageURL;
  int? index;
  bool? ProfileScreenMove;
  saveAllBlogModel? saveAllBlogModelData;
  GetallBlogModel? getallBlogModel1;
  RecentBlogScren(
      {required this.description1,
      required this.title,
      required this.imageURL,
      this.index,
      this.ProfileScreenMove,
      this.saveAllBlogModelData,
      this.getallBlogModel1});

  @override
  State<RecentBlogScren> createState() => _RecentBlogScrenState();
}

var sliderCurrentPosition = 0;
String? User_ID;

Get_UserToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User_ID = prefs.getString(PreferencesKey.loginUserID);
}

class _RecentBlogScrenState extends State<RecentBlogScren> {
  @override
  void initState() {
    Get_UserToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    CustomImageView(
                      url: "${widget.imageURL}",
                      height: _height / 2.8,
                      width: _width,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 55),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CustomImageView(
                            imagePath: ImageConstant.RightArrowWithBorder,
                            height: 35,
                            width: 35,
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    "${widget.description1}", // maxLines: ,
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              /*  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                    boxShadow: [
                                      BoxShadow(
                                          // color: ColorConstant.primary_color,
                                          color: Colors.grey.shade600,
                                          spreadRadius: 1,
                                          blurRadius: 10)
                                    ]), */
              height: 60,
              width: _width / 1.4,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                // color: ColorConstant.primary_color,
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 10)
                          ]),
                      child: widget.ProfileScreenMove == true
                          ? GestureDetector(
                              onTap: () {
                                BlocProvider.of<GetGuestAllPostCubit>(context)
                                    .LikeBlog(context, "${User_ID}",
                                        "${widget.saveAllBlogModelData?.object?[widget.index ?? 0].uid}");
                                if (widget.saveAllBlogModelData
                                        ?.object?[widget.index ?? 0].isLiked ==
                                    false) {
                                  widget
                                      .saveAllBlogModelData
                                      ?.object?[widget.index ?? 0]
                                      .isLiked = true;
                                  /*   widget
                                                            .saveAllBlogModelData
                                                            ?.object?[widget.index ?? 0]
                                                            .likeCount = (widget
                                                                    .saveAllBlogModelData
                                                                    ?.object?[
                                                                        widget.index ?? 0]
                                                                    .likeCount ??
                                                                0) +
                                                            1; */
                                } else {
                                  widget
                                      .saveAllBlogModelData
                                      ?.object?[widget.index ?? 0]
                                      .isLiked = false;
                                  /*   widget
                                                            .saveAllBlogModelData
                                                            ?.object?[widget.index ?? 0]
                                                            .likeCount = (widget
                                                                    .saveAllBlogModelData
                                                                    ?.object?[
                                                                        widget.index ?? 0]
                                                                    .likeCount ??
                                                                0) -
                                                            1; */
                                }
                                setState(() {});
                              },
                              child: widget
                                          .saveAllBlogModelData
                                          ?.object?[widget.index ?? 0]
                                          .isLiked ==
                                      false
                                  ? Icon(Icons.favorite_border)
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                            )
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<GetGuestAllPostCubit>(
                                            context)
                                        .LikeBlog(context, "${User_ID}",
                                            "${widget.getallBlogModel1?.object?[widget.index ?? 0].uid}");
                                    if (widget
                                            .getallBlogModel1
                                            ?.object?[widget.index ?? 0]
                                            .isLiked ==
                                        false) {
                                      widget
                                          .getallBlogModel1
                                          ?.object?[widget.index ?? 0]
                                          .isLiked = true;
                                      widget
                                          .getallBlogModel1
                                          ?.object?[widget.index ?? 0]
                                          .likeCount = (widget
                                                  .getallBlogModel1
                                                  ?.object?[widget.index ?? 0]
                                                  .likeCount ??
                                              0) +
                                          1;
                                    } else {
                                      widget
                                          .getallBlogModel1
                                          ?.object?[widget.index ?? 0]
                                          .isLiked = false;
                                      widget
                                          .getallBlogModel1
                                          ?.object?[widget.index ?? 0]
                                          .likeCount = (widget
                                                  .getallBlogModel1
                                                  ?.object?[widget.index ?? 0]
                                                  .likeCount ??
                                              0) -
                                          1;
                                    }
                                    setState(() {});
                                  },
                                  child: widget
                                              .getallBlogModel1
                                              ?.object?[widget.index ?? 0]
                                              .isLiked ==
                                          false
                                      ? Icon(Icons.favorite_border)
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                ),
                                widget
                                            .getallBlogModel1
                                            ?.object?[widget.index ?? 0]
                                            .likeCount ==
                                        0
                                    ? SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          print("User_id -- ${User_ID}");
                                          print(
                                              "blog UUid -- ${widget.getallBlogModel1?.object?[widget.index ?? 0].uid}");
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return BlogLikeListScreen(
                                                BlogUid:
                                                    "${widget.getallBlogModel1?.object?[widget.index ?? 0].uid}",
                                                user_id: User_ID,
                                              );
                                            },
                                          ));
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Text(
                                            "${widget.getallBlogModel1?.object?[widget.index ?? 0].likeCount == null ? 0 : widget.getallBlogModel1?.object?[widget.index ?? 0].likeCount}",
                                            style: TextStyle(
                                                fontFamily: "outfit",
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                    ),
                    Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                // color: ColorConstant.primary_color,
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 10)
                          ]),
                      child: widget.ProfileScreenMove == true
                          ? GestureDetector(
                              onTap: () async {
                                print("opne comment sheet inList =   blogs");
                                BlocProvider.of<BlogcommentCubit>(context)
                                    .BlogcommentAPI(
                                        context,
                                        widget
                                                .saveAllBlogModelData
                                                ?.object?[widget.index ?? 0]
                                                .uid ??
                                            "");

                                _settingModalBottomSheetBlog(
                                    context, widget.index, _width);
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      ImageConstant.meesage,
                                      height: 18,
                                      width: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    print(
                                        "opne comment sheet inList =   blogs");
                                    BlocProvider.of<BlogcommentCubit>(context)
                                        .BlogcommentAPI(
                                            context,
                                            widget
                                                    .getallBlogModel1
                                                    ?.object?[widget.index ?? 0]
                                                    .uid ??
                                                "");

                                    _settingModalBottomSheetBlog(
                                        context, widget.index, _width);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        ImageConstant.meesage,
                                        height: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                    "${widget.getallBlogModel1?.object?[widget.index ?? 0].commentCount == null ? 0 : widget.getallBlogModel1?.object?[widget.index ?? 0].commentCount}"),
                              ],
                            ),
                    ),
                    Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                // color: ColorConstant.primary_color,
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 10)
                          ]),
                      child: widget.ProfileScreenMove == true
                          ? GestureDetector(
                              onTap: () {
                                print("Save Blogs");

                                BlocProvider.of<GetGuestAllPostCubit>(context)
                                    .SaveBlog(context, "${User_ID}",
                                        "${widget.saveAllBlogModelData?.object?[widget.index ?? 0].uid}");
                                if (widget.saveAllBlogModelData
                                        ?.object?[widget.index ?? 0].isSaved ==
                                    false) {
                                  widget
                                      .saveAllBlogModelData
                                      ?.object?[widget.index ?? 0]
                                      .isSaved = true;
                                } else {
                                  widget
                                      .saveAllBlogModelData
                                      ?.object?[widget.index ?? 0]
                                      .isSaved = false;
                                }
                                setState(() {});
                              },
                              child: Center(
                                child: Image.asset(
                                  widget
                                              .saveAllBlogModelData
                                              ?.object?[widget.index ?? 0]
                                              .isSaved ==
                                          false
                                      ? ImageConstant.savePin
                                      : ImageConstant.Savefill,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                print("Save Blogs");

                                BlocProvider.of<GetGuestAllPostCubit>(context)
                                    .SaveBlog(context, "${User_ID}",
                                        "${widget.getallBlogModel1?.object?[widget.index ?? 0].uid}");
                                if (widget.getallBlogModel1
                                        ?.object?[widget.index ?? 0].isSaved ==
                                    false) {
                                  widget
                                      .getallBlogModel1
                                      ?.object?[widget.index ?? 0]
                                      .isSaved = true;
                                } else {
                                  widget
                                      .getallBlogModel1
                                      ?.object?[widget.index ?? 0]
                                      .isSaved = false;
                                }
                                setState(() {});
                              },
                              child: Center(
                                child: Image.asset(
                                  widget
                                              .getallBlogModel1
                                              ?.object?[widget.index ?? 0]
                                              .isSaved ==
                                          false
                                      ? ImageConstant.savePin
                                      : ImageConstant.Savefill,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ) 
        );
  }

  similerblogs() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height / 3.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        width: _width / 2.35,
                        child: CustomImageView(
                          imagePath: ImageConstant.blogimage,
                          fit: BoxFit.fill,
                          radius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Baluran Wild The",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Savvanah",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("27th june 2020  10:47 PM",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 10,
                              fontWeight: FontWeight.w100)),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        maxRadius: 2,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("12.3K Views",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 10,
                              fontWeight: FontWeight.w100)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        ImageConstant.like_image,
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        ImageConstant.arrowleftimage,
                        height: 30,
                        color: Colors.black,
                      ),
                      SizedBox(width: _width / 4.8),
                      Image.asset(
                        ImageConstant.setting_save,
                        height: 20,
                        color: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _settingModalBottomSheetBlog(context, index, _width) {
    showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            isDismissible: true,
            showDragHandle: true,
            enableDrag: true,
            constraints: BoxConstraints.tight(Size.infinite),
            context: context,
            builder: (BuildContext bc) {
              return BlogCommentBottomSheet(
                blogUid: widget.ProfileScreenMove == true
                    ? (widget
                        .saveAllBlogModelData?.object?[widget.index ?? 0].uid)
                    : widget.getallBlogModel1?.object?[widget.index ?? 0].uid,
                isFoollinng: "",
                // AllGuestPostRoomData?.object?.content?[index].isFollowing,
              );
            })
        .then((value) => BlocProvider.of<GetGuestAllPostCubit>(context)
            .GetallBlog(context, User_ID ?? ""));
    ;
  }
}
