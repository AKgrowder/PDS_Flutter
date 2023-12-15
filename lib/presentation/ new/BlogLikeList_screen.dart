// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/BlogComment_BLoc/BlogComment_cubit.dart';
import '../../API/Bloc/BlogComment_BLoc/BlogComment_state.dart';
import '../../API/Model/BlogComment_Model/BlogLikeList_model.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';

class BlogLikeListScreen extends StatefulWidget {
  String? BlogUid;
  String? user_id;
  BlogLikeListScreen({Key? key, this.BlogUid, this.user_id}) : super(key: key);

  @override
  State<BlogLikeListScreen> createState() => _BlogLikeListScreenState();
}

class _BlogLikeListScreenState extends State<BlogLikeListScreen> {
  BlogLikeListModel? blogLikeListModel;
  String? User_ID;
  getLoginUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    setState(() {});
  }

  @override
  void initState() {
    getLoginUserData();
    BlocProvider.of<BlogcommentCubit>(context)
        .BlogLikeList(context, "${widget.BlogUid}", widget.user_id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            "Post Likes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: BlocConsumer<BlogcommentCubit, BlogCommentState>(
            listener: (context, state) async {
          if (state is BlogCommentErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is BlogCommentLoadingState) {
            Center(
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
          if (state is BlogLikelistLoadedState) {
            blogLikeListModel = state.blogLikeListModel;
            print("${state.blogLikeListModel.message}");
          }
          if (state is PostLikeBlogLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.likePost.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            BlocProvider.of<BlogcommentCubit>(context).BlogLikeList(
                context, "${widget.BlogUid}", widget.user_id.toString());
          }
        }, builder: (context, state) {
          print(
              "blogLikeListModel  length -- ${blogLikeListModel?.object?.length}");
          return blogLikeListModel?.object?.length == 0 ||
                  blogLikeListModel?.object?.isEmpty == true
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
              : ListView.separated(
                  itemCount: blogLikeListModel?.object?.length ?? 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 70,
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfileScreen(
                                User_ID:
                                    "${blogLikeListModel?.object?[index].userUid}",
                                isFollowing:
                                    "${blogLikeListModel?.object?[index].isFollowing}",
                              );
                            }));
                          },
                          child: blogLikeListModel?.object?[index].profilePic !=
                                      null ||
                                  blogLikeListModel
                                          ?.object?[index].profilePic !=
                                      ""
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${blogLikeListModel?.object?[index].profilePic}"),
                                  backgroundColor: Colors.white,
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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "${blogLikeListModel?.object?[index].userName}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "outfit",
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   customFormat(
                            //       parsedDateTime),
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //     fontFamily: "outfit",
                            //   ),
                            // ),
                          ],
                        ),
                        trailing: User_ID ==
                                blogLikeListModel?.object?[index].userUid
                            ? SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  BlocProvider.of<BlogcommentCubit>(context)
                                      .followWIngMethod(
                                          blogLikeListModel
                                              ?.object?[index].userUid,
                                          context);
                                },
                                child: Container(
                                  height: 25,
                                  alignment: Alignment.center,
                                  width: 65,
                                  margin: EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                      color: Color(0xffED1C25),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: blogLikeListModel
                                              ?.object?[index].isFollowing ==
                                          'FOLLOW'
                                      ? Text(
                                          'Follow',
                                          style: TextStyle(
                                              fontFamily: "outfit",
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      : blogLikeListModel?.object?[index]
                                                  .isFollowing ==
                                              'REQUESTED'
                                          ? Text(
                                              'Requested',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              'Following ',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                ),
                              ),
                      ),
                    );
                  });
        }));
  }

  followFunction({String? apiName, int? index}) async {
    await BlocProvider.of<BlogcommentCubit>(context).followWIngMethod(
        blogLikeListModel?.object?[index ?? 0].userUid, context);
    if (blogLikeListModel?.object?[index ?? 0].isFollowing == 'FOLLOW') {
      for (int i = 0; i < (blogLikeListModel?.object?.length ?? 0); i++) {
        print("i-${i}");
        if (blogLikeListModel?.object?[index ?? 0].userUid ==
            blogLikeListModel?.object?[i].userUid) {
          blogLikeListModel?.object?[i].isFollowing = 'REQUESTED';
          print("check data-${blogLikeListModel?.object?[i].isFollowing}");
        }
      }
    } else {
      for (int i = 0; i < (blogLikeListModel?.object?.length ?? 0); i++) {
        if (blogLikeListModel?.object?[index ?? 0].userUid ==
            blogLikeListModel?.object?[i].userUid) {
          blogLikeListModel?.object?[i].isFollowing = 'FOLLOW';
        }
      }
    }
  }
}
