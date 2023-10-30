import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_state.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comments_screen.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Model/HashTage_Model/HashTagView_model.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../widgets/custom_image_view.dart';
import '../register_create_account_screen/register_create_account_screen.dart';

class HashTagViewScreen extends StatefulWidget {
  String? title;
  HashTagViewScreen({Key? key, this.title}) : super(key: key);

  @override
  State<HashTagViewScreen> createState() => _HashTagViewScreenState();
}

HashtagViewDataModel? hashTagViewData;
DateTime? parsedDateTime;
String? uuid;
int indexx = 0;
List<PageController> _pageControllers = [];
List<int> _currentPages = [];

class _HashTagViewScreenState extends State<HashTagViewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get_UserToken();
    BlocProvider.of<HashTagCubit>(context)
        .HashTagViewDataAPI(context, widget.title.toString());
  }

  Get_UserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uuid = prefs.getString(PreferencesKey.loginUserID);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              )),
          title: Row(
            children: [
              Image.asset(
                ImageConstant.hashTagimg,
                height: 45,
                width: 45,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${widget.title}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        body: BlocConsumer<HashTagCubit, HashTagState>(
          listener: (context, state) {
            if (state is HashTagErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is HashTagViewDataLoadedState) {
              hashTagViewData = state.HashTagViewData;
              print("HashTagViewDataLoadedState${hashTagViewData}");
            }
          },
          builder: (context, state) {
            if (state is HashTagLoadingState) {
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
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 20),
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: hashTagViewData?.object?.posts?.length,
                itemBuilder: (context, index) {
                  hashTagViewData?.object?.posts?[index].postData
                      ?.forEach((element) {
                    _pageControllers.add(PageController());
                    _currentPages.add(0);
                  });
                  parsedDateTime = DateTime.parse(
                      '${hashTagViewData?.object?.posts?[index].createdAt ?? ""}');
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        // margin: EdgeInsets.all(10),
                        height: (hashTagViewData
                                    ?.object?.posts?[index].postData?.isEmpty ??
                                false)
                            ? 180
                            : 400,
                        width: _width,
                        decoration: ShapeDecoration(
                          // color: Colors.green,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              child: ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    if (uuid == null) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterCreateAccountScreen()));
                                    } else {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ProfileScreen(
                                            User_ID:
                                                "${hashTagViewData?.object?.posts?[index].userUid}",
                                            isFollowing: hashTagViewData?.object
                                                ?.posts?[index].isFollowing);
                                      }));
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: hashTagViewData
                                                ?.object
                                                ?.posts?[index]
                                                .userProfilePic !=
                                            null
                                        ? NetworkImage(
                                            "${hashTagViewData?.object?.posts?[index].userProfilePic}")
                                        : NetworkImage(
                                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"),
                                    radius: 25,
                                  ),
                                ),
                                title: Text(
                                  "${hashTagViewData?.object?.posts?[index].postUserName}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  customFormat(parsedDateTime!),
                                  style: TextStyle(
                                    color: Color(0xFF8F8F8F),
                                    fontSize: 12,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: uuid ==
                                        hashTagViewData
                                            ?.object?.posts?[index].userUid
                                    ? GestureDetector(
                                        onTapDown: (TapDownDetails details) {
                                          delete_dilog_menu(
                                            details.globalPosition,
                                            context,
                                          );
                                        },
                                        child: Icon(
                                          Icons.more_vert_rounded,
                                        ))
                                    : GestureDetector(
                                        onTap: () async {
                                          await soicalFunation(
                                              apiName: 'Follow', index: index);
                                        },
                                        child: Container(
                                          height: 25,
                                          alignment: Alignment.center,
                                          width: 65,
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              color: Color(0xffED1C25),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: hashTagViewData
                                                      ?.object
                                                      ?.posts?[index]
                                                      .isFollowing ==
                                                  'FOLLOW'
                                              ? Text(
                                                  'Follow',
                                                  style: TextStyle(
                                                      fontFamily: "outfit",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              : hashTagViewData
                                                          ?.object
                                                          ?.posts?[index]
                                                          .isFollowing ==
                                                      'REQUESTED'
                                                  ? Text(
                                                      'Requested',
                                                      style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    )
                                                  : Text(
                                                      'Following ',
                                                      style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                        ),
                                      ),
                              ),
                            ),
                            hashTagViewData
                                        ?.object?.posts?[index].description !=
                                    null
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: HashTagText(
                                        text:
                                            "${hashTagViewData?.object?.posts?[index].description}",
                                        decoratedStyle: TextStyle(
                                            fontFamily: "outfit",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.HasTagColor),
                                        basicStyle: TextStyle(
                                            fontFamily: "outfit",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        onTap: (text) {
                                          print(text);
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            hashTagViewData
                                        ?.object?.posts?[index].postDataType ==
                                    null
                                ? SizedBox()
                                : hashTagViewData?.object?.posts?[index]
                                            .postData?.length ==
                                        1
                                    ? (hashTagViewData?.object?.posts?[index]
                                                .postDataType ==
                                            "IMAGE"
                                        ? Container(
                                            height: 230,
                                            width: _width,
                                            margin: EdgeInsets.only(
                                                left: 16, top: 15, right: 16),
                                            child: Center(
                                                child: CustomImageView(
                                              url:
                                                  "${hashTagViewData?.object?.posts?[index].postData?[0]}",
                                            )),
                                          )
                                        : hashTagViewData?.object?.posts?[index]
                                                    .postDataType ==
                                                "ATTACHMENT"
                                            ? (hashTagViewData
                                                        ?.object
                                                        ?.posts?[index]
                                                        .postData
                                                        ?.isNotEmpty ==
                                                    true)
                                                ? Container(
                                                    height: 230,
                                                    width: _width,
                                                    child: DocumentViewScreen1(
                                                      path: hashTagViewData
                                                          ?.object
                                                          ?.posts?[index]
                                                          .postData?[0]
                                                          .toString(),
                                                    ))
                                                : SizedBox()
                                            : SizedBox())
                                    : Column(
                                        children: [
                                          Stack(
                                            children: [
                                              if ((hashTagViewData
                                                      ?.object
                                                      ?.posts?[index]
                                                      .postData
                                                      ?.isNotEmpty ==
                                                  true))
                                                SizedBox(
                                                  height: 230,
                                                  child: PageView.builder(
                                                    onPageChanged: (page) {
                                                      setState(() {
                                                        _currentPages[index] =
                                                            page;
                                                      });
                                                    },
                                                    controller:
                                                        _pageControllers[index],
                                                    itemCount: hashTagViewData
                                                        ?.object
                                                        ?.posts?[index]
                                                        .postData
                                                        ?.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index1) {
                                                      if (hashTagViewData
                                                              ?.object
                                                              ?.posts?[index]
                                                              .postDataType ==
                                                          "IMAGE") {
                                                        return Container(
                                                          width: _width,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 16,
                                                                  top: 15,
                                                                  right: 16),
                                                          child: Center(
                                                              child:
                                                                  CustomImageView(
                                                            url:
                                                                "${hashTagViewData?.object?.posts?[index].postData?[index1]}",
                                                          )),
                                                        );
                                                      } else if (hashTagViewData
                                                              ?.object
                                                              ?.posts?[index]
                                                              .postDataType ==
                                                          "ATTACHMENT") {
                                                        return Container(
                                                            // height: 100,
                                                            width: _width,
                                                            child:
                                                                DocumentViewScreen1(
                                                              path: hashTagViewData
                                                                  ?.object
                                                                  ?.posts?[
                                                                      index]
                                                                  .postData?[
                                                                      index1]
                                                                  .toString(),
                                                            ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              (hashTagViewData
                                                          ?.object
                                                          ?.posts?[index]
                                                          .postData
                                                          ?.isNotEmpty ==
                                                      true)
                                                  ? Positioned(
                                                      bottom: 5,
                                                      left: 0,
                                                      right: 0,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0),
                                                        child: Container(
                                                          height: 20,
                                                          child: DotsIndicator(
                                                            dotsCount: hashTagViewData
                                                                    ?.object
                                                                    ?.posts?[
                                                                        index]
                                                                    .postData
                                                                    ?.length ??
                                                                0,
                                                            position:
                                                                _currentPages[
                                                                        index]
                                                                    .toDouble(),
                                                            decorator:
                                                                DotsDecorator(
                                                              size: const Size(
                                                                  10.0, 7.0),
                                                              activeSize:
                                                                  const Size(
                                                                      10.0,
                                                                      10.0),
                                                              spacing: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      2),
                                                              activeColor: Color(
                                                                  0xffED1C25),
                                                              color: Color(
                                                                  0xff6A6A6A),
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                  : SizedBox()
                                            ],
                                          ),
                                        ],
                                      ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await soicalFunation(
                                          apiName: 'like_post', index: index);
                                    },
                                    child: hashTagViewData?.object
                                                ?.posts?[index].isLiked !=
                                            true
                                        ? Image.asset(
                                            ImageConstant.likewithout,
                                            height: 20,
                                          )
                                        : Image.asset(
                                            ImageConstant.like,
                                            height: 20,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return ShowAllPostLike(
                                              "${hashTagViewData?.object?.posts?[index].postUid}");
                                        },
                                      ));
                                    },
                                    child: Text(
                                      "${hashTagViewData?.object?.posts?[index].likedCount}",
                                      style: TextStyle(
                                          fontFamily: "outfit", fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CommentsScreen(
                                          image: hashTagViewData?.object
                                              ?.posts?[index].userProfilePic,
                                          userName: hashTagViewData?.object
                                              ?.posts?[index].postUserName,
                                          description: hashTagViewData?.object
                                              ?.posts?[index].description,
                                          PostUID:
                                              '${hashTagViewData?.object?.posts?[index].postUid}',
                                          date: hashTagViewData?.object
                                                  ?.posts?[index].createdAt ??
                                              "",
                                        );
                                      })).then((value) =>
                                          BlocProvider.of<HashTagCubit>(context)
                                              .HashTagViewDataAPI(context,
                                                  widget.title.toString()));
                                    },
                                    child: Image.asset(
                                      ImageConstant.meesage,
                                      height: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${hashTagViewData?.object?.posts?[index].commentCount}",
                                    style: TextStyle(
                                        fontFamily: "outfit", fontSize: 14),
                                  ),
                                  // SizedBox(
                                  //   width: 18,
                                  // ),
                                  // Image.asset(
                                  //   ImageConstant.vector2,
                                  //   height: 12,
                                  // ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  // Text(
                                  //   '1335',
                                  //   style: TextStyle(
                                  //       fontFamily: "outfit", fontSize: 14),
                                  // ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      await soicalFunation(
                                          apiName: 'savedata', index: index);
                                    },
                                    child: Image.asset(
                                      hashTagViewData?.object?.posts?[index]
                                                  .isSaved ==
                                              false
                                          ? ImageConstant.savePin
                                          : ImageConstant.Savefill,
                                      height: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
  }

  String customFormat(DateTime date) {
    String day = date.day.toString();
    // String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$time';
    return formattedDate;
  }

  soicalFunation({String? apiName, int? index}) async {
    print("fghdfghdfgh");
    if (uuid == null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } else if (apiName == 'Follow') {
      print("dfhsdfhsdfhsdgf");
      await BlocProvider.of<HashTagCubit>(context).followWIngMethod(
          hashTagViewData?.object?.posts?[index ?? 0].userUid, context);
      if (hashTagViewData?.object?.posts?[index ?? 0].isFollowing == 'FOLLOW') {
        hashTagViewData?.object?.posts?[index ?? 0].isFollowing = 'REQUESTED';
      } else {
        hashTagViewData?.object?.posts?[index ?? 0].isFollowing = 'FOLLOW';
      }
    } else if (apiName == 'like_post') {
      await BlocProvider.of<HashTagCubit>(context).like_post(
          hashTagViewData?.object?.posts?[index ?? 0].postUid, context);
      print("isLiked-->${hashTagViewData?.object?.posts?[index ?? 0].isLiked}");
      if (hashTagViewData?.object?.posts?[index ?? 0].isLiked == true) {
        hashTagViewData?.object?.posts?[index ?? 0].isLiked = false;
        int a = hashTagViewData?.object?.posts?[index ?? 0].likedCount ?? 0;
        int b = 1;
        hashTagViewData?.object?.posts?[index ?? 0].likedCount = a - b;
      } else {
        hashTagViewData?.object?.posts?[index ?? 0].isLiked = true;
        hashTagViewData?.object?.posts?[index ?? 0].likedCount;
        int a = hashTagViewData?.object?.posts?[index ?? 0].likedCount ?? 0;
        int b = 1;
        hashTagViewData?.object?.posts?[index ?? 0].likedCount = a + b;
      }
    } else if (apiName == 'savedata') {
      await BlocProvider.of<HashTagCubit>(context).savedData(
          hashTagViewData?.object?.posts?[index ?? 0].postUid, context);

      if (hashTagViewData?.object?.posts?[index ?? 0].isSaved == true) {
        hashTagViewData?.object?.posts?[index ?? 0].isSaved = false;
      } else {
        hashTagViewData?.object?.posts?[index ?? 0].isSaved = true;
      }
    } else if (apiName == 'Deletepost') {
      await BlocProvider.of<HashTagCubit>(context).DeletePost(
          '${hashTagViewData?.object?.posts?[index ?? 0].postUid}', context);
      hashTagViewData?.object?.posts?.removeAt(index ?? 0);
    }
  }

  void delete_dilog_menu(
    Offset position,
    BuildContext context,
  ) async {
    List<String> ankur = [
      "Delete Post",
    ];
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final selectedOption = await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        position: RelativeRect.fromRect(
          position & const Size(40, 40),
          Offset.zero & overlay.size,
        ),
        items: List.generate(
            ankur.length,
            (index) => PopupMenuItem(
                enabled: true,
                onTap: () {
                  setState(() {
                    indexx = index;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    Deletedilog(
                        hashTagViewData?.object?.posts?[index].postUid ?? "",
                        index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: indexx == index
                            ? Color(0xffED1C25)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    width: 130,
                    height: 40,
                    child: Center(
                      child: Text(
                        ankur[index],
                        style: TextStyle(
                            color:
                                indexx == index ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ))));
  }

  Deletedilog(String PostUID, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // title: const Text("Create Expert"),
        content: Container(
          height: 80,
          child: Column(
            children: [
              Text("Are You Sure You Want To delete This Post."),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await soicalFunation(apiName: 'Deletepost', index: index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      // color: Colors.green,
                      child: Text(
                        "Yas",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      // color: Colors.green,
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.blue),
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
}
